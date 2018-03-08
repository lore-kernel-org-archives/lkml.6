Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeCHEve (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:51:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934059AbeCHEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:51:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7698C6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] mm: oom: Fix race condition between oom_badness and
 do_exit of task
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1520427454-22813-1-git-send-email-gkohli@codeaurora.org>
 <alpine.DEB.2.20.1803071254410.165297@chino.kir.corp.google.com>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <22ebd655-ece4-37e5-5a98-e9750cb20665@codeaurora.org>
Date: Thu, 8 Mar 2018 10:21:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803071254410.165297@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2018 2:26 AM, David Rientjes wrote:

> On Wed, 7 Mar 2018, Gaurav Kohli wrote:
>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 6fd9773..5f4cc4b 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -114,9 +114,11 @@ struct task_struct *find_lock_task_mm(struct task_struct *p)
>>   
>>   	for_each_thread(p, t) {
>>   		task_lock(t);
>> +		get_task_struct(t);
>>   		if (likely(t->mm))
>>   			goto found;
>>   		task_unlock(t);
>> +		put_task_struct(t);
>>   	}
>>   	t = NULL;
>>   found:
> We hold rcu_read_lock() here, so perhaps only do get_task_struct() before
> doing rcu_read_unlock() and we have a non-NULL t?

Here rcu_read_lock will not help, as our task may change due to below algo:

for_each_thread(p, t) {
  		task_lock(t);
+		get_task_struct(t);
  		if (likely(t->mm))
  			goto found;
  		task_unlock(t);
+		put_task_struct(t)


So only we can increase usage counter here only at the current task.

I have seen you new patch, that seems valid to me and it will resolve our issue.
Thanks for support.

Regards

Gaurav

>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
