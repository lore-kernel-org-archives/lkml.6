Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91441ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55139208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55139208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeGMOlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729982AbeGMOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 350E0AD9C;
        Fri, 13 Jul 2018 14:26:13 +0000 (UTC)
Date:   Fri, 13 Jul 2018 16:26:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
Message-ID: <20180713142612.GD19960@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-07-18 14:34:00, David Rientjes wrote:
[...]
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 0fe4087d5151..e6328cef090f 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -488,9 +488,11 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>  	 * Tell all users of get_user/copy_from_user etc... that the content
>  	 * is no longer stable. No barriers really needed because unmapping
>  	 * should imply barriers already and the reader would hit a page fault
> -	 * if it stumbled over a reaped memory.
> +	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
> +	 * reaping as already occurred so nothing left to do.
>  	 */
> -	set_bit(MMF_UNSTABLE, &mm->flags);
> +	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
> +		return;

This could lead to pre mature oom victim selection
oom_reaper			exiting victim
oom_reap_task			exit_mmap
  __oom_reap_task_mm		  __oom_reap_task_mm
				    test_and_set_bit(MMF_UNSTABLE) # wins the race
  test_and_set_bit(MMF_UNSTABLE)
set_bit(MMF_OOM_SKIP) # new victim can be selected now.

Besides that, why should we back off in the first place. We can
race the two without any problems AFAICS. We already do have proper
synchronization between the two due to mmap_sem and MMF_OOM_SKIP.

diff --git a/mm/mmap.c b/mm/mmap.c
index fc41c0543d7f..4642964f7741 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3073,9 +3073,7 @@ void exit_mmap(struct mm_struct *mm)
 		 * which clears VM_LOCKED, otherwise the oom reaper cannot
 		 * reliably test it.
 		 */
-		mutex_lock(&oom_lock);
 		__oom_reap_task_mm(mm);
-		mutex_unlock(&oom_lock);
 
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 		down_write(&mm->mmap_sem);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 32e6f7becb40..f11108af122d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -529,28 +529,9 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 
 static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 {
-	bool ret = true;
-
-	/*
-	 * We have to make sure to not race with the victim exit path
-	 * and cause premature new oom victim selection:
-	 * oom_reap_task_mm		exit_mm
-	 *   mmget_not_zero
-	 *				  mmput
-	 *				    atomic_dec_and_test
-	 *				  exit_oom_victim
-	 *				[...]
-	 *				out_of_memory
-	 *				  select_bad_process
-	 *				    # no TIF_MEMDIE task selects new victim
-	 *  unmap_page_range # frees some memory
-	 */
-	mutex_lock(&oom_lock);
-
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		ret = false;
 		trace_skip_task_reaping(tsk->pid);
-		goto unlock_oom;
+		return false;
 	}
 
 	/*
@@ -562,7 +543,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	if (mm_has_blockable_invalidate_notifiers(mm)) {
 		up_read(&mm->mmap_sem);
 		schedule_timeout_idle(HZ);
-		goto unlock_oom;
+		return true;
 	}
 
 	/*
@@ -589,9 +570,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	up_read(&mm->mmap_sem);
 
 	trace_finish_task_reaping(tsk->pid);
-unlock_oom:
-	mutex_unlock(&oom_lock);
-	return ret;
+	return true;
 }
 
 #define MAX_OOM_REAP_RETRIES 10
-- 
Michal Hocko
SUSE Labs
