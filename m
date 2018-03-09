Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeCIMEr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:04:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeCIMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:04:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBC566038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] mm: oom: Fix race condition between oom_badness and
 do_exit of task
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, rientjes@google.com
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1520427454-22813-1-git-send-email-gkohli@codeaurora.org>
 <alpine.DEB.2.20.1803071254410.165297@chino.kir.corp.google.com>
 <22ebd655-ece4-37e5-5a98-e9750cb20665@codeaurora.org>
 <d73682f9-f214-64c4-ce09-fd1ff3ffe252@I-love.SAKURA.ne.jp>
 <14ba6c44-d444-bd0a-0bac-0c6851b19344@codeaurora.org>
 <201803091948.FBC21396.LHOMSFFOVFtQJO@I-love.SAKURA.ne.jp>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <c3b8dd2a-2636-2ce1-f7e7-c78a43608be1@codeaurora.org>
Date: Fri, 9 Mar 2018 17:34:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803091948.FBC21396.LHOMSFFOVFtQJO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2018 4:18 PM, Tetsuo Handa wrote:

> Kohli, Gaurav wrote:
>>> t->alloc_lock is still held when leaving find_lock_task_mm(), which means
>>> that t->mm != NULL. But nothing prevents t from setting t->mm = NULL at
>>> exit_mm() from do_exit() and calling exit_creds() from __put_task_struct(t)
>>> after task_unlock(t) is called. Seems difficult to trigger race window. Maybe
>>> something has preempted because oom_badness() becomes outside of RCU grace
>>> period upon leaving find_lock_task_mm() when called from proc_oom_score().
>> Hi Tetsuo,
>>
>> Yes it is not easy to reproduce seen twice till now and i agree with
>> your analysis. But David has already fixing this in different way,
>> So that also looks better to me:
>>
>> https://patchwork.kernel.org/patch/10265641/
>>
> Yes, I'm aware of that patch.
>
>> But if need to keep that code, So we have to bump up the task
>> reference that's only i can think of now.
> I don't think so, for I think it is safe to call
> has_capability_noaudit(p) with p->alloc_lock held.
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index f2e7dfb..4efcfb8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -222,7 +222,6 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>   	 */
>   	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
>   		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
> -	task_unlock(p);
>   
>   	/*
>   	 * Root processes get 3% bonus, just like the __vm_enough_memory()
> @@ -230,6 +229,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>   	 */
>   	if (has_capability_noaudit(p, CAP_SYS_ADMIN))
>   		points -= (points * 3) / 100;
> +	task_unlock(p);

Earlier i have thought the same to post this, but this may create 
problem if there are sleeping calls in

has_capability_noaudit ?

>   
>   	/* Normalize to oom_score_adj units */
>   	adj *= totalpages / 1000;
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
