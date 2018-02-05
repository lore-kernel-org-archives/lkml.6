Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeBEBiR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:38:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44091 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752714AbeBEB2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:35 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 39/64] arch/m68k: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:29 +0100
Message-Id: <20180205012754.23615-40-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This becomes quite straightforward with the mmrange in place.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/m68k/kernel/sys_m68k.c | 18 +++++++++++-------
 arch/m68k/mm/fault.c        |  8 ++++----
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 27e10af5153a..d151bd19385c 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -378,6 +378,7 @@ asmlinkage int
 sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 {
 	int ret = -EINVAL;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if (scope < FLUSH_SCOPE_LINE || scope > FLUSH_SCOPE_ALL ||
 	    cache & ~FLUSH_CACHE_BOTH)
@@ -399,7 +400,7 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		 * Verify that the specified address region actually belongs
 		 * to this process.
 		 */
-		down_read(&current->mm->mmap_sem);
+		mm_read_lock(current->mm, &mmrange);
 		vma = find_vma(current->mm, addr);
 		if (!vma || addr < vma->vm_start || addr + len > vma->vm_end)
 			goto out_unlock;
@@ -450,7 +451,7 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 	    }
 	}
 out_unlock:
-	up_read(&current->mm->mmap_sem);
+	mm_read_unlock(current->mm, &mmrange);
 out:
 	return ret;
 }
@@ -461,6 +462,8 @@ asmlinkage int
 sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 		      unsigned long __user * mem)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
+
 	/* This was borrowed from ARM's implementation.  */
 	for (;;) {
 		struct mm_struct *mm = current->mm;
@@ -470,7 +473,7 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 		spinlock_t *ptl;
 		unsigned long mem_value;
 
-		down_read(&mm->mmap_sem);
+		mm_read_lock(mm, &mmrange);
 		pgd = pgd_offset(mm, (unsigned long)mem);
 		if (!pgd_present(*pgd))
 			goto bad_access;
@@ -493,11 +496,11 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 			__put_user(newval, mem);
 
 		pte_unmap_unlock(pte, ptl);
-		up_read(&mm->mmap_sem);
+		mm_read_unlock(mm, &mmrange);
 		return mem_value;
 
 	      bad_access:
-		up_read(&mm->mmap_sem);
+		mm_read_unlock(mm, &mmrange);
 		/* This is not necessarily a bad access, we can get here if
 		   a memory we're trying to write to should be copied-on-write.
 		   Make the kernel do the necessary page stuff, then re-iterate.
@@ -536,14 +539,15 @@ sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long mem_value;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	mem_value = *mem;
 	if (mem_value == oldval)
 		*mem = newval;
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return mem_value;
 }
 
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index ec32a193726f..426d22924852 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -90,7 +90,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -181,7 +181,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return 0;
 
 /*
@@ -189,7 +189,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
@@ -218,6 +218,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	current->thread.faddr = address;
 
 send_sig:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return send_fault_sig(regs);
 }
-- 
2.13.6
