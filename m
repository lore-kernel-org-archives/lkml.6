Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8026320843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8026320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeGMGeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:34:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61143 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGMGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:34:04 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6D6KjIJ093016;
        Fri, 13 Jul 2018 15:20:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Fri, 13 Jul 2018 15:20:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6D6Kiq4093011;
        Fri, 13 Jul 2018 15:20:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w6D6KiAJ093010;
        Fri, 13 Jul 2018 15:20:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807130620.w6D6KiAJ093010@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch -mm] mm, oom: remove =?ISO-2022-JP?B?b29tX2xvY2sgZnJvbSBleGl0?=
 =?ISO-2022-JP?B?X21tYXA=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Fri, 13 Jul 2018 15:20:44 +0900
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What a simplified description of oom_lock...

Positive effects

(1) Serialize "setting TIF_MEMDIE and calling __thaw_task()/atomic_inc() from
    mark_oom_victim()" and "setting oom_killer_disabled = true from
    oom_killer_disable()".

(2) Serialize all printk() messages from out_of_memory().

(3) Prevent from selecting new OOM victim when there is an !MMF_OOM_SKIP mm
    which current thread should wait for.

(4) Mutex blocking_notifier_call_chain() from out_of_memory() because some of
    callbacks might not be thread-safe and/or serialized call might release
    more memory than needed.

Negative effects

(A) Threads which called mutex_lock(&oom_lock) before calling out_of_memory()
    are blocked waiting for "__oom_reap_task_mm() from exit_mmap()" and/or
    "__oom_reap_task_mm() from oom_reap_task_mm()".

(B) Threads which do not call out_of_memory() because mutex_trylock(&oom_lock)
    failed continue consuming CPU resources pointlessly.

Regarding (A), we can reduce the range oom_lock serializes from
"__oom_reap_task_mm()" to "setting MMF_OOM_SKIP", for oom_lock is useful for (3).
Therefore, we can apply below change on top of your patch. But I don't like
sharing MMF_UNSBALE for two purposes (reason is explained below).

Regarding (B), we can do direct OOM reaping (like my proposal does).

---
 kernel/fork.c |  5 +++++
 mm/mmap.c     | 21 +++++++++------------
 mm/oom_kill.c | 57 ++++++++++++++++++++++-----------------------------------
 3 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6747298..f37d481 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -984,6 +984,11 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	if (unlikely(mm_is_oom_victim(mm))) {
+		mutex_lock(&oom_lock);
+		set_bit(MMF_OOM_SKIP, &mm->flags);
+		mutex_unlock(&oom_lock);
+	}
 	mmdrop(mm);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 7f918eb..203061f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3075,19 +3075,17 @@ void exit_mmap(struct mm_struct *mm)
 		__oom_reap_task_mm(mm);
 
 		/*
-		 * Now, set MMF_UNSTABLE to avoid racing with the oom reaper.
-		 * This needs to be done before calling munlock_vma_pages_all(),
-		 * which clears VM_LOCKED, otherwise the oom reaper cannot
-		 * reliably test for it.  If the oom reaper races with
-		 * munlock_vma_pages_all(), this can result in a kernel oops if
-		 * a pmd is zapped, for example, after follow_page_mask() has
-		 * checked pmd_none().
+		 * Wait for the oom reaper to complete. This needs to be done
+		 * before calling munlock_vma_pages_all(), which clears
+		 * VM_LOCKED, otherwise the oom reaper cannot reliably test for
+		 * it. If the oom reaper races with munlock_vma_pages_all(),
+		 * this can result in a kernel oops if a pmd is zapped, for
+		 * example, after follow_page_mask() has checked pmd_none().
 		 *
-		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
-		 * guarantee that the oom reaper will not run on this mm again
-		 * after mmap_sem is dropped.
+		 * Taking mm->mmap_sem for write will guarantee that the oom
+		 * reaper will not run on this mm again after mmap_sem is
+		 * dropped.
 		 */
-		set_bit(MMF_UNSTABLE, &mm->flags);
 		down_write(&mm->mmap_sem);
 		up_write(&mm->mmap_sem);
 	}
@@ -3115,7 +3113,6 @@ void exit_mmap(struct mm_struct *mm)
 	unmap_vmas(&tlb, vma, 0, -1);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
-	set_bit(MMF_OOM_SKIP, &mm->flags);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e6328ce..7ed4ed0 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -488,11 +488,9 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 	 * Tell all users of get_user/copy_from_user etc... that the content
 	 * is no longer stable. No barriers really needed because unmapping
 	 * should imply barriers already and the reader would hit a page fault
-	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
-	 * reaping as already occurred so nothing left to do.
+	 * if it stumbled over a reaped memory.
 	 */
-	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
-		return;
+	set_bit(MMF_UNSTABLE, &mm->flags);
 
 	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
 		if (!can_madv_dontneed_vma(vma))
@@ -524,25 +522,9 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 
 static void oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 {
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
 		trace_skip_task_reaping(tsk->pid);
-		goto out_oom;
+		return;
 	}
 
 	/*
@@ -555,10 +537,18 @@ static void oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 		goto out_mm;
 
 	/*
-	 * MMF_UNSTABLE is set by exit_mmap when the OOM reaper can't
-	 * work on the mm anymore. The check for MMF_UNSTABLE must run
-	 * under mmap_sem for reading because it serializes against the
-	 * down_write();up_write() cycle in exit_mmap().
+	 * MMF_UNSTABLE is set by the time exit_mmap() calls
+	 * munlock_vma_pages_all() in order to avoid race condition. The check
+	 * for MMF_UNSTABLE must run under mmap_sem for reading because it
+	 * serializes against the down_write();up_write() cycle in exit_mmap().
+	 *
+	 * However, since MMF_UNSTABLE is set by __oom_reap_task_mm() from
+	 * exit_mmap() before start reaping (because the purpose of
+	 * MMF_UNSTABLE is to "tell all users of get_user/copy_from_user etc...
+	 * that the content is no longer stable"), it cannot be used for a flag
+	 * for indicating that the OOM reaper can't work on the mm anymore.
+	 * The OOM reaper will give up after (by default) 1 second even if
+	 * exit_mmap() is doing __oom_reap_task_mm().
 	 */
 	if (test_bit(MMF_UNSTABLE, &mm->flags)) {
 		trace_skip_task_reaping(tsk->pid);
@@ -576,8 +566,6 @@ static void oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
 out_mm:
 	up_read(&mm->mmap_sem);
-out_oom:
-	mutex_unlock(&oom_lock);
 }
 
 static void oom_reap_task(struct task_struct *tsk)
@@ -591,12 +579,7 @@ static void oom_reap_task(struct task_struct *tsk)
 	if (test_bit(MMF_OOM_SKIP, &mm->flags))
 		goto drop;
 
-	/*
-	 * If this mm has already been reaped, doing so again will not likely
-	 * free additional memory.
-	 */
-	if (!test_bit(MMF_UNSTABLE, &mm->flags))
-		oom_reap_task_mm(tsk, mm);
+	oom_reap_task_mm(tsk, mm);
 
 	if (time_after_eq(jiffies, mm->oom_free_expire)) {
 		if (!test_bit(MMF_OOM_SKIP, &mm->flags)) {
@@ -658,12 +641,16 @@ static int oom_reaper(void *unused)
 static u64 oom_free_timeout_ms = 1000;
 static void wake_oom_reaper(struct task_struct *tsk)
 {
+	unsigned long expire = jiffies + msecs_to_jiffies(oom_free_timeout_ms);
+
+	/* expire must not be 0 in order to avoid double list_add(). */
+	if (!expire)
+		expire++;
 	/*
 	 * Set the reap timeout; if it's already set, the mm is enqueued and
 	 * this tsk can be ignored.
 	 */
-	if (cmpxchg(&tsk->signal->oom_mm->oom_free_expire, 0UL,
-			jiffies + msecs_to_jiffies(oom_free_timeout_ms)))
+	if (cmpxchg(&tsk->signal->oom_mm->oom_free_expire, 0UL, expire))
 		return;
 
 	get_task_struct(tsk);
-- 
1.8.3.1

