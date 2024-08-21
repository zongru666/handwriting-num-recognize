
%Fisher������д����ʶ��%�򻯴���
%��ʱ2��30��
 %            *********Fisher()ʵ��************
load('mnist_test.mat')
load('mnist_train.mat')
%function  [Rchar]=Fisher(lett)  %Fisher����
 %ѵ�����������ݼ�����
 step=1 %��1��
 %������������һ����y�е�����
 a=1;
 b(1)=0;
 for n=1:9
    while (y(a,1)<=(n-1))
          a=a+1;
    end;
    b(n+1)=a-1;
 end;
 %b(10)=60000;
 
 step=step+1 %��2��
 %ͨ������ƴ�ӣ�������������Ϊ����
 for n=1:60000
	imagecell{n}=reshape(X(n,:),[28 28])';     %1*60000��28*28�ľ���(���Ͻǵ�'ת��) 
 end;

 step=step+1 %��3��
 %����ͼƬ��ȥ�����ֵ����ܣ�
 for j=1:60000
     imagecell{j}(all(imagecell{j}==0,2),:)=[];  %��ȫ0��ÿһ��ȥ��
     imagecell{j}(:,all(imagecell{j}==0,1))=[];  %��ȫ0��ÿһ��ȥ��
	 imagecell2{j}=imresize(imagecell{j},[10 10]); %����Ϊ10*10�ľ���
	 imagecell3{j}=reshape(imagecell2{j}',[1 100]); %������ת�ú�תΪ������
 end

 step=step+1 %��4��
 %�����к��ÿ�������������ࣨÿ��ֻȡ5000��������
 for j=1:10
     for i=1:5000
         num{j}(i,:)=imagecell3{i+b(j)}; %ÿһ��Ϊһ������
     end
end

step=step+1 %��5��
%ԭ�����ռ�
%�������ֵ����meani
for i=1:10
    meani{i}=mean(num{i});
end

step=step+1 %��6��
%��������ɢ�Ⱦ���Si
for j=1:10
    Si{j}=0;  %����������ɢ��
    for i=1:5000    
	    Si{j}=Si{j}+(num{j}(i,:)-meani{j})'*(num{j}(i,:)-meani{j});  %�ۼ�
    end
end

step=step+1 %��7��
%%����10��ֱ����������ʶ��Ƚ�
%�����������������ɢ�ȡ������ɢ��(45�����)
Sw=cell(10,10);
Sb=cell(10,10);
for i=1:9
    for j=i+1:10
        Sw{i,j}=Si{i}+Si{j};   %��������ɢ��
        Sb{i,j}=(meani{i}-meani{j})'*(meani{i}-meani{j});   %�����ɢ��
    end
end

%*******************************************
%***********���Լ��������ݼ�����************
%******************************************* 
 step=step+1 %��8��
 %������������һ����Ty�е�����
 Ta=1;
 Tb(1)=0;
 for Tn=1:9
    while (Ty(Ta,1)<=(Tn-1))
          Ta=Ta+1;
    end;
    Tb(Tn+1)=Ta-1;
 end;
 %b(10)=10000;
 
 step=step+1 %��9��
 %ͨ������ƴ�ӣ�������������Ϊ����
 for Tn=1:10000
	Timagecell{Tn}=reshape(TX(Tn,:),[28 28])';     %1*60000��28*28�ľ���(���Ͻǵ�'ת��) 
 end;

 step=step+1 %��10��
 %����ͼƬ��ȥ�����ֵ����ܣ�
 for Tj=1:10000
     Timagecell{Tj}(all(Timagecell{Tj}==0,2),:)=[];  %��ȫ0��ÿһ��ȥ��
     Timagecell{Tj}(:,all(Timagecell{Tj}==0,1))=[];  %��ȫ0��ÿһ��ȥ��
	 Timagecell2{Tj}=imresize(Timagecell{Tj},[10 10]); %����Ϊ10*10�ľ���
	 Timagecell3{Tj}=reshape(Timagecell2{Tj}',[1 100]); %������ת�ú�תΪ������
 end
 
 step=step+1 %��11��
 %�����к��ÿ�������������ࣨÿ��ֻȡ500��������
 for Tm=1:10
     for Ti=1:500
     Tnum{Tm}(Ti,:)=Timagecell3{Ti+Tb(Tm)}; %ÿһ��Ϊһ����������
	 end
 end

 step=step+1 %��12��
%�б����
for p=1:10
    %����ĳһ��500������
    for Tk=1:500
        %���������б����ֵ���б���������ͶӰ����
        W=cell(10,10);
        Gx=cell(10,10);
        for i=1:9
            for j=i+1:10
                Sw{i,j}=Sw{i,j}+0.0001*eye(100);       %������������ɢ�Ⱦ���
                W{i,j}=inv(Sw{i,j})*(meani{i}-meani{j})';     %����ͶӰ����
                Gx{i,j}=(W{i,j}')*(Tnum{p}(Tk,:)-0.5*(meani{i}+meani{j}))';
     	    end
	    end

        count=1;
        k=0;
        for i=count:9   %�ӵ�1�࿪ʼ�����Ƚ�
            for j=(count+1):10
                if Gx{i,j}<0      %������i�࣬��תΪ�ӵ�i+1�࿪ʼ�Ƚ�
                   if count==9        %�Ѿ�ȷ������8����9����ֹͣ�������±Ƚϣ�count���ټ�1��
                      char=10;
                   else
                       count=count+1;     %תΪ��i+1��
                       k=0;
                       break;
                   end
                else
                    char=count;    %����ǰ�����Ÿ�ֵ������char
                    k=k+1;     % �����ж��Ĵ���
                end
            end
            if k==10-count      %���ж���������ѭ��
               break;
            end
        end
    Tchar(Tk) = char-1;    %ʶ����
    end

    %����ʶ�����
    Tcount=0;
    for Tt=1:500
        if Tchar(Tt)==p-1
           Tcount=Tcount+1;
	    end
    end
    Tc(p)=Tcount;  %���ÿ��ʶ����ȷ�ĸ���
end

step=step+1 %��13��
%��ʶ���ʣ�92.26%��
rate=Tc/500; %ÿ�����ֵ�ʶ����
%�ܵ�ʶ����
answer=sum(Tc,2)/5000;  %�ܵ�ʶ����=�ܵ���ȷʶ�����/�ܵĲ�����������
for i=1:10
    fprintf(num2str(i-1));  %��ʾ���
    fprintf('����������õ���ʶ������%d\n',rate(i));  %��ʾ�����ʶ����
end
fprintf('ÿ��500������5000�������������õ���ʶ������%d\n',answer);

%end