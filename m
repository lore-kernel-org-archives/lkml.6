Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C61ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD18620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD18620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeGUDiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:38:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15925 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeGUDiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:38:22 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6L2lBTS025139;
        Sat, 21 Jul 2018 11:47:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Sat, 21 Jul 2018 11:47:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6L2l63G025094
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 21 Jul 2018 11:47:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com>
 <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com>
 <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp>
Date:   Sat, 21 Jul 2018 11:47:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/21 7:13, David Rientjes wrote:
>>>  		mutex_lock(&oom_lock);
>>>  		__oom_reap_task_mm(mm);
>>>  		mutex_unlock(&oom_lock);
>>
>> I don't like holding oom_lock for full teardown of an mm, for an OOM victim's mm
>> might have multiple TB memory which could take long time.
>>
> 
> This patch does not involve deltas for oom_lock here, it can certainly be 
> changed on top of this patch.  I'm not attempting to address any oom_lock 
> issue here.  It should pose no roadblock for you.

You can't apply "[patch v4] mm, oom: fix unnecessary killing of additional processes"
because Michal's patch which removes oom_lock serialization was added to -mm tree.

> 
> I only propose this patch now since it fixes millions of processes being 
> oom killed unnecessarily, it was in -mm before a NACK for the most trivial 
> fixes that have now been squashed into it, and is actually tested.
> 

But I still refuse your patch because you do not test my approach.

>>
>>> -#define MAX_OOM_REAP_RETRIES 10
>>>  static void oom_reap_task(struct task_struct *tsk)
>>>  {
>>> -	int attempts = 0;
>>>  	struct mm_struct *mm = tsk->signal->oom_mm;
>>>  
>>> -	/* Retry the down_read_trylock(mmap_sem) a few times */
>>> -	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
>>> -		schedule_timeout_idle(HZ/10);
>>> +	/*
>>> +	 * If this mm has either been fully unmapped, or the oom reaper has
>>> +	 * given up on it, nothing left to do except drop the refcount.
>>> +	 */
>>> +	if (test_bit(MMF_OOM_SKIP, &mm->flags))
>>> +		goto drop;
>>>  
>>> -	if (attempts <= MAX_OOM_REAP_RETRIES ||
>>> -	    test_bit(MMF_OOM_SKIP, &mm->flags))
>>> -		goto done;
>>> +	/*
>>> +	 * If this mm has already been reaped, doing so again will not likely
>>> +	 * free additional memory.
>>> +	 */
>>> +	if (!test_bit(MMF_UNSTABLE, &mm->flags))
>>> +		oom_reap_task_mm(tsk, mm);
>>
>> This is still wrong. If preempted immediately after set_bit(MMF_UNSTABLE, &mm->flags) from
>> __oom_reap_task_mm() from exit_mmap(), oom_reap_task() can give up before reclaiming any memory.
> 
> If there is a single thread holding onto the mm and has reached 
> exit_mmap() and is in the process of starting oom reaping itself, there's 
> no advantage to the oom reaper trying to oom reap it.

You might worry about situations where __oom_reap_task_mm() is a no-op.
But that is not always true. There is no point with emitting

  pr_info("oom_reaper: unable to reap pid:%d (%s)\n", ...);
  debug_show_all_locks();

noise and doing

  set_bit(MMF_OOM_SKIP, &mm->flags);

because exit_mmap() will not release oom_lock until __oom_reap_task_mm()
completes. That is, except extra noise, there is no difference with
current behavior which sets set_bit(MMF_OOM_SKIP, &mm->flags) after
returning from __oom_reap_task_mm().

>                                                        The thread in 
> exit_mmap() will take care of it, __oom_reap_task_mm() does not block and 
> oom_free_timeout_ms allows for enough time for that memory freeing to 
> occur.  The oom reaper will not set MMF_OOM_SKIP until the timeout has 
> expired.

Again, there is no point with emitting the noise.
And, the oom_lock serialization will be removed before your patch.

> 
> As I said before, you could make a case for extending the timeout once 
> MMF_UNSTABLE has been set.  It practice, we haven't encountered a case 
> where that matters.  But that's trivial to do if you would prefer.
> 

Again, I don't think that
"[patch v4] mm, oom: fix unnecessary killing of additional processes" can be
merged.



On 2018/07/21 7:19, David Rientjes wrote:
> On Sat, 21 Jul 2018, Tetsuo Handa wrote:
> 
>> Why [PATCH 2/2] in https://marc.info/?l=linux-mm&m=153119509215026&w=4 does not
>> solve your problem?
>>
> 
> Such an invasive patch, and completely rewrites the oom reaper.  I now 
> fully understand your frustration with the cgroup aware oom killer being 
> merged into -mm without any roadmap to actually being merged.  I agree 
> with you that it should be dropped, not sure why it has not been since 
> there is no active review on the proposed patchset from four months ago, 
> posted twice, that fixes the issues with it, or those patches being merged 
> so the damn thing can actually make progress.
> 

I'm not frustrated with the cgroup aware oom killer. I'm frustrated with
the fact that you keep ignoring my approach as "such an invasive patch"
without actually testing it.

At least, you can test up to my [PATCH 1/2] whether the cgroup aware oom killer
can be rebased on top of Michal's patches and my [PATCH 1/2].

