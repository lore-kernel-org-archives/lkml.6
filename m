Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfBLC5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfBLC5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:57:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D1B380F6B;
        Tue, 12 Feb 2019 02:57:31 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94787600C6;
        Tue, 12 Feb 2019 02:57:20 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v2 04/26] mm: allow VM_FAULT_RETRY for multiple times
Date:   Tue, 12 Feb 2019 10:56:10 +0800
Message-Id: <20190212025632.28946-5-peterx@redhat.com>
In-Reply-To: <20190212025632.28946-1-peterx@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 12 Feb 2019 02:57:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea comes from a discussion between Linus and Andrea [1].

Before this patch we only allow a page fault to retry once.  We
achieved this by clearing the FAULT_FLAG_ALLOW_RETRY flag when doing
handle_mm_fault() the second time.  This was majorly used to avoid
unexpected starvation of the system by looping over forever to handle
the page fault on a single page.  However that should hardly happen,
and after all for each code path to return a VM_FAULT_RETRY we'll
first wait for a condition (during which time we should possibly yield
the cpu) to happen before VM_FAULT_RETRY is really returned.

This patch removes the restriction by keeping the
FAULT_FLAG_ALLOW_RETRY flag when we receive VM_FAULT_RETRY.  It means
that the page fault handler now can retry the page fault for multiple
times if necessary without the need to generate another page fault
event. Meanwhile we still keep the FAULT_FLAG_TRIED flag so page fault
handler can still identify whether a page fault is the first attempt
or not.  One example is in __lock_page_or_retry(), now we'll drop the
mmap_sem only in the first attempt of page fault and we'll keep it in
follow up retries, so old locking behavior will be retained.

GUP code is not touched yet and will be covered in follow up patch.

This will be a nice enhancement for current code [2] at the same time
a supporting material for the future userfaultfd-writeprotect work,
since in that work there will always be an explicit userfault
writeprotect retry for protected pages, and if that cannot resolve the
page fault (e.g., when userfaultfd-writeprotect is used in conjunction
with swapped pages) then we'll possibly need a 3rd retry of the page
fault.  It might also benefit other potential users who will have
similar requirement like userfault write-protection.

Please read the thread below for more information.

[1] https://lkml.org/lkml/2017/11/2/833
[2] https://lkml.org/lkml/2018/12/30/64

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c      | 2 +-
 arch/arc/mm/fault.c        | 1 -
 arch/arm/mm/fault.c        | 3 ---
 arch/arm64/mm/fault.c      | 5 -----
 arch/hexagon/mm/vm_fault.c | 1 -
 arch/ia64/mm/fault.c       | 1 -
 arch/m68k/mm/fault.c       | 3 ---
 arch/microblaze/mm/fault.c | 1 -
 arch/mips/mm/fault.c       | 1 -
 arch/nds32/mm/fault.c      | 1 -
 arch/nios2/mm/fault.c      | 3 ---
 arch/openrisc/mm/fault.c   | 1 -
 arch/parisc/mm/fault.c     | 2 --
 arch/powerpc/mm/fault.c    | 5 -----
 arch/riscv/mm/fault.c      | 5 -----
 arch/s390/mm/fault.c       | 5 +----
 arch/sh/mm/fault.c         | 1 -
 arch/sparc/mm/fault_32.c   | 1 -
 arch/sparc/mm/fault_64.c   | 1 -
 arch/um/kernel/trap.c      | 1 -
 arch/unicore32/mm/fault.c  | 6 +-----
 arch/x86/mm/fault.c        | 1 -
 arch/xtensa/mm/fault.c     | 1 -
 mm/filemap.c               | 2 +-
 24 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 46e5e420ad2a..deae82bb83c1 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -169,7 +169,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			flags |= FAULT_FLAG_TRIED;
 
 			 /* No need to up_read(&mm->mmap_sem) as we would
 			 * have already released it in __lock_page_or_retry
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index dc5f1b8859d2..664e18a8749f 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -167,7 +167,6 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 			}
 
 			if (fault & VM_FAULT_RETRY) {
-				flags &= ~FAULT_FLAG_ALLOW_RETRY;
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
 			}
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index c41c021bbe40..7910b4b5205d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -342,9 +342,6 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 					regs, addr);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			* of starvation. */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a38ff8c49a66..d1d3c98f9ffb 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -523,12 +523,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			return 0;
 		}
 
-		/*
-		 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
-		 * starvation.
-		 */
 		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
-			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			mm_flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index be10b441d9cc..576751597e77 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -115,7 +115,6 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 			else
 				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
-				flags &= ~FAULT_FLAG_ALLOW_RETRY;
 				flags |= FAULT_FLAG_TRIED;
 				goto retry;
 			}
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 62c2d39d2bed..9de95d39935e 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -189,7 +189,6 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			 /* No need to up_read(&mm->mmap_sem) as we would
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index d9808a807ab8..b1b2109e4ab4 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -162,9 +162,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			 * of starvation. */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 4fd2dbd0c5ca..05a4847ac0bf 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -236,7 +236,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 92374fd091d2..9953b5b571df 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -178,7 +178,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			tsk->min_flt++;
 		}
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 9f6e477b9e30..32259afc751a 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -242,7 +242,6 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 				      1, regs, addr);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/* No need to up_read(&mm->mmap_sem) as we would
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 5939434a31ae..9dd1c51acc22 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -158,9 +158,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			 * of starvation. */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 873ecb5d82d7..ff92c5674781 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -185,7 +185,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		else
 			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			 /* No need to up_read(&mm->mmap_sem) as we would
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 29422eec329d..7d3e96a9a7ab 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -327,8 +327,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-
 			/*
 			 * No need to up_read(&mm->mmap_sem) as we would
 			 * have already released it in __lock_page_or_retry
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index aaa853e6592f..becebfe67e32 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -585,11 +585,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(fault & VM_FAULT_RETRY)) {
 		/* We retry only once */
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			/*
-			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			 * of starvation.
-			 */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 			if (is_user && signal_pending(current))
 				return 0;
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 4fc8d746bec3..aad2c0557d2f 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -154,11 +154,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 				      1, regs, addr);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			/*
-			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			 * of starvation.
-			 */
-			flags &= ~(FAULT_FLAG_ALLOW_RETRY);
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index aba1dad1efcd..4e8c066964a9 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -513,10 +513,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 				fault = VM_FAULT_PFAULT;
 				goto out_up;
 			}
-			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			 * of starvation. */
-			flags &= ~(FAULT_FLAG_ALLOW_RETRY |
-				   FAULT_FLAG_RETRY_NOWAIT);
+			flags &= ~FAULT_FLAG_RETRY_NOWAIT;
 			flags |= FAULT_FLAG_TRIED;
 			down_read(&mm->mmap_sem);
 			goto retry;
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index baf5d73df40c..cd710e2d7c57 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -498,7 +498,6 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 				      regs, address);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a2c83104fe35..6735cd1c09b9 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -261,7 +261,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 				      1, regs, address);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/* No need to up_read(&mm->mmap_sem) as we would
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index cad71ec5c7b3..28d5b4d012c6 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -459,7 +459,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 				      1, regs, address);
 		}
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			/* No need to up_read(&mm->mmap_sem) as we would
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 09baf37b65b9..c63fc292aea0 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -99,7 +99,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			else
 				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
-				flags &= ~FAULT_FLAG_ALLOW_RETRY;
 				flags |= FAULT_FLAG_TRIED;
 
 				goto retry;
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 3611f19234a1..fdf577956f5f 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -260,12 +260,8 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			tsk->maj_flt++;
 		else
 			tsk->min_flt++;
-		if (fault & VM_FAULT_RETRY) {
-			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
-			* of starvation. */
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		if (fault & VM_FAULT_RETRY)
 			goto retry;
-		}
 	}
 
 	up_read(&mm->mmap_sem);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 248ff0a28ecd..71d68aa03e43 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1485,7 +1485,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 		/* Retry at most once */
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 			if (is_user && signal_pending(tsk))
 				return;
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 792dad5e2f12..7cd55f2d66c9 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -128,7 +128,6 @@ void do_page_fault(struct pt_regs *regs)
 		else
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
 
 			 /* No need to up_read(&mm->mmap_sem) as we would
diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323e883e..44942c78bb92 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1351,7 +1351,7 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+	if (!flags & FAULT_FLAG_TRIED) {
 		/*
 		 * CAUTION! In this case, mmap_sem is not released
 		 * even though return 0.
-- 
2.17.1

