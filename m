Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeBEBbi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752803AbeBEB33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:29 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 55/64] arch/riscv: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:45 +0100
Message-Id: <20180205012754.23615-56-dbueso@wotan.suse.de>
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
 arch/riscv/kernel/vdso.c |  5 +++--
 arch/riscv/mm/fault.c    | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 582cb153eb24..4bbb6e0425df 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -69,10 +69,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_len;
 	int ret;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	vdso_len = (vdso_pages + 1) << PAGE_SHIFT;
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	vdso_base = get_unmapped_area(NULL, 0, vdso_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
 		ret = vdso_base;
@@ -94,7 +95,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 		mm->context.vdso = NULL;
 
 end:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return ret;
 }
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 75d15e73ba39..6f78080e987c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -79,7 +79,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 retry:
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_vma(mm, addr);
 	if (unlikely(!vma))
 		goto bad_area;
@@ -170,7 +170,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return;
 
 	/*
@@ -178,7 +178,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * Fix it, but check if it's kernel or user first.
 	 */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		do_trap(regs, SIGSEGV, code, addr, tsk);
@@ -206,14 +206,14 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * (which will retry the fault, or kill us if we got oom-killed).
 	 */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
-- 
2.13.6
