Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeDTMkv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:40:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:40:49 -0400
Date: Fri, 20 Apr 2018 14:40:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
Message-ID: <20180420124044.GA17484@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1804171545460.53786@chino.kir.corp.google.com>
 <201804180057.w3I0vieV034949@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
 <20180419063556.GK17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
 <20180420082349.GW17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420082349.GW17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-04-18 10:23:49, Michal Hocko wrote:
> On Thu 19-04-18 12:34:53, David Rientjes wrote:
[...]
> > I understand the concern, but it's the difference between the victim 
> > getting stuck in exit_mmap() and actually taking a long time to free its 
> > memory in exit_mmap().  I don't have evidence of the former.
> 
> I do not really want to repeat myself. The primary purpose of the oom
> reaper is to provide a _guarantee_ of the forward progress. I do not
> care whether there is any evidences. All I know that lock_page has
> plethora of different dependencies and we cannot clearly state this is
> safe so we _must not_ depend on it when setting MMF_OOM_SKIP.
> 
> The way how the oom path was fragile and lockup prone based on
> optimistic assumptions shouldn't be repeated.
> 
> That being said, I haven't heard any actual technical argument about why
> locking the munmap path is a wrong thing to do while the MMF_OOM_SKIP
> dependency on the page_lock really concerns me so
> 
> Nacked-by: Michal Hocko <mhocko@suse.com>
> 
> If you want to keep the current locking protocol then you really have to
> make sure that the oom reaper will set MMF_OOM_SKIP when racing with
> exit_mmap.

So here is my suggestion for the fix.

>From 37ab85d619f508ceaf829e57648a3d986c6d8bfc Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 20 Apr 2018 13:53:08 +0200
Subject: [PATCH] oom: mm, oom: fix concurrent munlock and oom reaper unmap

David has noticed that our current assumption that the oom reaper can
race with exit_mmap is not correct. munlock_vma_pages_all() depends on
clearing VM_LOCKED from vm_flags before actually doing the munlock to
determine if any other vmas are locking the same memory, the check for
VM_LOCKED in the oom reaper is racy.

This is especially noticeable on architectures such as powerpc where
clearing a huge pmd requires serialize_against_pte_lookup().  If the pmd
is zapped by the oom reaper during follow_page_mask() after the check for
pmd_none() is bypassed, this ends up deferencing a NULL ptl.

Fix this by taking the exclusive mmap_sem in exit_mmap while tearing
down the address space. Once that is done MMF_OOM_SKIP is set so that
__oom_reap_task_mm can back off if it manages to take the read lock
finally.

Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/mmap.c     | 36 ++++++++++++++++++------------------
 mm/oom_kill.c |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index faf85699f1a1..216efa6d9f61 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3004,10 +3004,21 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
+	bool locked = false;
 
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
+	/*
+	 * The mm is not accessible for anybody except for the oom reaper
+	 * which cannot race with munlocking so make sure we exclude the
+	 * two.
+	 */
+	if (unlikely(mm_is_oom_victim(mm))) {
+		down_write(&mm->mmap_sem);
+		locked = true;
+	}
+
 	if (mm->locked_vm) {
 		vma = mm->mmap;
 		while (vma) {
@@ -3021,7 +3032,7 @@ void exit_mmap(struct mm_struct *mm)
 
 	vma = mm->mmap;
 	if (!vma)	/* Can happen if dup_mmap() received an OOM */
-		return;
+		goto out_unlock;
 
 	lru_add_drain();
 	flush_cache_mm(mm);
@@ -3030,23 +3041,6 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 
-	if (unlikely(mm_is_oom_victim(mm))) {
-		/*
-		 * Wait for oom_reap_task() to stop working on this
-		 * mm. Because MMF_OOM_SKIP is already set before
-		 * calling down_read(), oom_reap_task() will not run
-		 * on this "mm" post up_write().
-		 *
-		 * mm_is_oom_victim() cannot be set from under us
-		 * either because victim->mm is already set to NULL
-		 * under task_lock before calling mmput and oom_mm is
-		 * set not NULL by the OOM killer only if victim->mm
-		 * is found not NULL while holding the task_lock.
-		 */
-		set_bit(MMF_OOM_SKIP, &mm->flags);
-		down_write(&mm->mmap_sem);
-		up_write(&mm->mmap_sem);
-	}
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
 
@@ -3060,6 +3054,12 @@ void exit_mmap(struct mm_struct *mm)
 		vma = remove_vma(vma);
 	}
 	vm_unacct_memory(nr_accounted);
+
+out_unlock:
+	if (unlikely(locked)) {
+		set_bit(MMF_OOM_SKIP, &mm->flags);
+		up_write(&mm->mmap_sem);
+	}
 }
 
 /* Insert vm structure into process list sorted by address
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index dfd370526909..94d26ef2c3c7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -524,7 +524,7 @@ static bool __oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
 	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
 	 * under mmap_sem for reading because it serializes against the
-	 * down_write();up_write() cycle in exit_mmap().
+	 * exit_mmap().
 	 */
 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
 		up_read(&mm->mmap_sem);
-- 
2.16.3

-- 
Michal Hocko
SUSE Labs
