Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeC0Si2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:38:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47870 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750926AbeC0Si0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:38:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T-Btkg2_1522175895;
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Michal Hocko <mhocko@kernel.org>
Cc: adobriyan@gmail.com, willy@infradead.org, mguzik@redhat.com,
        gorcunov@openvz.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180327062939.GV5652@dhcp22.suse.cz>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <95a107ac-5e5b-92d7-dbde-2e961d85de28@linux.alibaba.com>
Date: Tue, 27 Mar 2018 14:38:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180327062939.GV5652@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/18 2:29 AM, Michal Hocko wrote:
> On Tue 27-03-18 02:20:39, Yang Shi wrote:
> [...]
> The patch looks reasonable to me. Maybe it would be better to be more
> explicit about the purpose of the patch. As others noticed, this alone
> wouldn't solve the mmap_sem contention issues. I _think_ that if you
> were more explicit about the mmap_sem abuse it would trigger less
> questions.

Yes, sure.

>
> I have just one more question. Now that you are touching this area,
> would you be willing to remove the following ugliness?
>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index f2289de..17bddd2 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -1959,7 +1959,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>>   			return error;
>>   	}
>>   
>> -	down_write(&mm->mmap_sem);
>> +	down_read(&mm->mmap_sem);
> Why do we need to hold mmap_sem here and call find_vma, when only
> PR_SET_MM_ENV_END: is consuming it? I guess we can replace it wit the
> new lock and take the mmap_sem only for PR_SET_MM_ENV_END.

Actually, I didn't think of why. It looks prctl_set_mm() checks if vma 
does exist when it tries to set stack_start, argv_* and env_*, btw not 
only env_end.

Cyrill may be able to give us some hint since C/R is the main user of 
this API.

Yang

>
> Thanks!
