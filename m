Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeB0Q7Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:59:25 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53717 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbeB0Q7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:59:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04421;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0SybBtBx_1519750750;
Subject: Re: [PATCH 3/4 v2] fs: proc: use down_read_killable() in
 environ_read()
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
 <1519691151-101999-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180227071536.GA5234@avx2>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <140f613b-0214-97bb-9823-0abac394e331@linux.alibaba.com>
Date: Tue, 27 Feb 2018 08:59:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180227071536.GA5234@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/18 11:15 PM, Alexey Dobriyan wrote:
> On Tue, Feb 27, 2018 at 08:25:50AM +0800, Yang Shi wrote:
>> Like reading /proc/*/cmdline, it is possible to be blocked for long time
>> when reading /proc/*/environ when manipulating large mapping at the mean
>> time. The environ reading process will be waiting for mmap_sem become
>> available for a long time then it may cause the reading task hung.
>>
>> Convert down_read() and access_remote_vm() to killable version.
>>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Ehh, bloody tags.

I mean fix reading /proc/*/environ part.

> I didn't suggest _killable() variants, they're quite ugly because API
> multiplies. access_remote_vm() could be converted to down_read_killable().

There might be other places that need non-killable access_remote_vm(), 
like patch 4/4.

And, it sounds keeping access_remote_vm() semantic intact may prevent 
from confusion. The most people may get used to assume 
access_remote_vm() behaves like access_process_vm() except not inc mm 
reference count.

Thanks,
Yang

>
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -933,7 +933,9 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>>   	if (!mmget_not_zero(mm))
>>   		goto free;
>>   
>> -	down_read(&mm->mmap_sem);
>> +	ret = down_read_killable(&mm->mmap_sem);
>> +	if (ret)
>> +		goto out_mmput;
>>   	env_start = mm->env_start;
>>   	env_end = mm->env_end;
>>   	up_read(&mm->mmap_sem);
>> @@ -950,7 +952,8 @@ static ssize_t environ_read(struct file *file, char __user *buf,
>>   		max_len = min_t(size_t, PAGE_SIZE, count);
>>   		this_len = min(max_len, this_len);
>>   
>> -		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
>> +		retval = access_remote_vm_killable(mm, (env_start + src),
>> +						page, this_len, 0);
