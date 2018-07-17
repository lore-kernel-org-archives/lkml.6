Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A83ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F0A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F0A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeGQVoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:44:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64705 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeGQVoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:44:14 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6HL9THe032845;
        Wed, 18 Jul 2018 06:09:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Wed, 18 Jul 2018 06:09:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6HL9TWA032841
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Jul 2018 06:09:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
Date:   Wed, 18 Jul 2018 06:09:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should be dropped from linux-next because it is incorrectly
using MMF_UNSTABLE.

On 2018/06/22 6:35, David Rientjes wrote:
> diff --git a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3059,25 +3059,28 @@ void exit_mmap(struct mm_struct *mm)
>  	if (unlikely(mm_is_oom_victim(mm))) {
>  		/*
>  		 * Manually reap the mm to free as much memory as possible.
> -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -		 * this mm from further consideration.  Taking mm->mmap_sem for
> -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> -		 * reaper will not run on this mm again after mmap_sem is
> -		 * dropped.
> -		 *
>  		 * Nothing can be holding mm->mmap_sem here and the above call
>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>  		 * __oom_reap_task_mm() will not block.
> -		 *
> -		 * This needs to be done before calling munlock_vma_pages_all(),
> -		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> -		 * reliably test it.
>  		 */
>  		mutex_lock(&oom_lock);
>  		__oom_reap_task_mm(mm);
>  		mutex_unlock(&oom_lock);
>  
> -		set_bit(MMF_OOM_SKIP, &mm->flags);
> +		/*
> +		 * Now, set MMF_UNSTABLE to avoid racing with the oom reaper.
> +		 * This needs to be done before calling munlock_vma_pages_all(),
> +		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> +		 * reliably test for it.  If the oom reaper races with
> +		 * munlock_vma_pages_all(), this can result in a kernel oops if
> +		 * a pmd is zapped, for example, after follow_page_mask() has
> +		 * checked pmd_none().
> +		 *
> +		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
> +		 * guarantee that the oom reaper will not run on this mm again
> +		 * after mmap_sem is dropped.
> +		 */
> +		set_bit(MMF_UNSTABLE, &mm->flags);

Since MMF_UNSTABLE is set by __oom_reap_task_mm() from exit_mmap() before start reaping
(because the purpose of MMF_UNSTABLE is to "tell all users of get_user/copy_from_user
etc... that the content is no longer stable"), it cannot be used for a flag for indicating
that the OOM reaper can't work on the mm anymore.

If the oom_lock serialization is removed, the OOM reaper will give up after (by default)
1 second even if current thread is immediately after set_bit(MMF_UNSTABLE, &mm->flags) from
__oom_reap_task_mm() from exit_mmap(). Thus, this patch and the other patch which removes
oom_lock serialization should be dropped.

>  		down_write(&mm->mmap_sem);
>  		up_write(&mm->mmap_sem);
>  	}

> @@ -637,25 +649,57 @@ static int oom_reaper(void *unused)
>  	return 0;
>  }
>  
> +/*
> + * Millisecs to wait for an oom mm to free memory before selecting another
> + * victim.
> + */
> +static u64 oom_free_timeout_ms = 1000;
>  static void wake_oom_reaper(struct task_struct *tsk)
>  {
> -	/* tsk is already queued? */
> -	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
> +	/*
> +	 * Set the reap timeout; if it's already set, the mm is enqueued and
> +	 * this tsk can be ignored.
> +	 */
> +	if (cmpxchg(&tsk->signal->oom_mm->oom_free_expire, 0UL,
> +			jiffies + msecs_to_jiffies(oom_free_timeout_ms)))
>  		return;

"expire" must not be 0 in order to avoid double list_add(). See
https://lore.kernel.org/lkml/201807130620.w6D6KiAJ093010@www262.sakura.ne.jp/T/#u .

>  
>  	get_task_struct(tsk);
>  
>  	spin_lock(&oom_reaper_lock);
> -	tsk->oom_reaper_list = oom_reaper_list;
> -	oom_reaper_list = tsk;
> +	list_add(&tsk->oom_reap_list, &oom_reaper_list);
>  	spin_unlock(&oom_reaper_lock);
>  	trace_wake_reaper(tsk->pid);
>  	wake_up(&oom_reaper_wait);
>  }

