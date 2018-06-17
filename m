Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C71C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60B20874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBPvXdTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeFQIqM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:46:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36200 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:46:04 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so6211991pgd.3;
        Sun, 17 Jun 2018 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IwWRMwOt7qqK7+lJV/6/lqkPFFIu3ez0NwVdXdsbVZ8=;
        b=GBPvXdTHlLPVF1I9eNlWMkCDpEOL25fGNrFuhhF7aCj/Gu6zDiN8heL4nu+nBet39E
         RVMpQjkuz/n8NgUZzg/T5dH/E1Ti4/Ld89puEFV5bbmBOVvafjl/C06KBZw3nu28Lv8p
         p07Qfwzkq+fcHAFclBmIB4zugxUQxvAXq4TnWzU6nujohkgkrnIEpbFp/VMJ9qtL4m+d
         rvQzTAMvB+LNl3T1TuuoV3R/veML6XZZ3andwBT6Rrmh7zzt2/gvGIk9BAg/L9KGLfSj
         KYzi0MKFe1AP/oTwVIjR/0pd/2ZaTEveoZbdri724rLtOMCNP3/lfNiOPoEk3Z8+/jnH
         h9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IwWRMwOt7qqK7+lJV/6/lqkPFFIu3ez0NwVdXdsbVZ8=;
        b=ukQv+yr4O770ZtiaOGLEJwe5Nk1enWQt2ueS5fkZXksdKMrwMoxz+Y05B8HN+n3/hj
         KWZKjK3r5y4+4+lqOws4K4F0JkiB99y23+XWVGFL+74m/Fy1tFIcK97HpPoB0t9SpT4s
         bq5OfC9Yjp6Lp7XJt0TzH2Iy0Lo/VpALLXJw266dx/AVFONhPmx9MEYw1DWPIyfUoFhv
         w21jAe75dDgbodo+X+ZRk1rIRJTrmnWAvQJ1yeB8arJU+sWC8OtC4wKiKsKEx6kJwh1H
         SD6HqL0rB7p17s+ulenF53CPmCJuvfoB/+BbNuskqZqihsM+Od4o7PgxS7Ohyxmhw+Zt
         9ysQ==
X-Gm-Message-State: APt69E3Vzhb/OO4cFM+2/Phd39dQ/5dwU8ZTE1T2cof/3K04AlH/wkux
        EuW1Rw5OsdTDLA1S4vnEthE=
X-Google-Smtp-Source: ADUXVKK8IdMP8K32/fBUWe8Q+GLx20Y/UxgX0TQu4gCMTzNK9DLk2dBG/IB4NiKU1Athj6oyKlFF+g==
X-Received: by 2002:a63:41c1:: with SMTP id o184-v6mr7426433pga.323.1529225163197;
        Sun, 17 Jun 2018 01:46:03 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2402:3a80:d03:83b1:5cd5:68e3:b6e6:9f4a])
        by smtp.gmail.com with ESMTPSA id x124-v6sm15662590pgb.53.2018.06.17.01.45.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 01:46:01 -0700 (PDT)
Date:   Sun, 17 Jun 2018 14:18:10 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, rth@twiddle.net, tony.luck@intel.com,
        mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, rkuo@codeaurora.org,
        geert@linux-m68k.org, monstr@monstr.eu, jhogan@kernel.org,
        lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org,
        benh@kernel.crashing.org, palmer@sifive.com,
        ysato@users.sourceforge.jp, davem@davemloft.net, richard@nod.at,
        gxt@pku.edu.cn, tglx@linutronix.de, hpa@zytor.com,
        alexander.levin@verizon.com, akpm@linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH v2] mm: convert return type of handle_mm_fault() caller to
 vm_fault_t
Message-ID: <20180617084810.GA6730@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

In this patch all the caller of handle_mm_fault()
are changed to return vm_fault_t type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Fixed kbuild error

 arch/alpha/mm/fault.c                     |  3 ++-
 arch/arc/mm/fault.c                       |  4 +++-
 arch/arm/mm/fault.c                       |  7 ++++---
 arch/arm64/mm/fault.c                     |  6 +++---
 arch/hexagon/mm/vm_fault.c                |  2 +-
 arch/ia64/mm/fault.c                      |  2 +-
 arch/m68k/mm/fault.c                      |  4 ++--
 arch/microblaze/mm/fault.c                |  2 +-
 arch/mips/mm/fault.c                      |  2 +-
 arch/nds32/mm/fault.c                     |  2 +-
 arch/nios2/mm/fault.c                     |  2 +-
 arch/openrisc/mm/fault.c                  |  2 +-
 arch/parisc/mm/fault.c                    |  2 +-
 arch/powerpc/include/asm/copro.h          |  4 +++-
 arch/powerpc/mm/copro_fault.c             |  2 +-
 arch/powerpc/mm/fault.c                   |  7 ++++---
 arch/powerpc/platforms/cell/spufs/fault.c |  2 +-
 arch/riscv/mm/fault.c                     |  3 ++-
 arch/s390/mm/fault.c                      | 13 ++++++++-----
 arch/sh/mm/fault.c                        |  4 ++--
 arch/sparc/mm/fault_32.c                  |  3 ++-
 arch/sparc/mm/fault_64.c                  |  3 ++-
 arch/um/kernel/trap.c                     |  2 +-
 arch/unicore32/mm/fault.c                 |  9 +++++----
 arch/x86/mm/fault.c                       |  5 +++--
 arch/xtensa/mm/fault.c                    |  2 +-
 drivers/iommu/amd_iommu_v2.c              |  2 +-
 drivers/iommu/intel-svm.c                 |  4 +++-
 drivers/misc/cxl/fault.c                  |  2 +-
 drivers/misc/ocxl/link.c                  |  3 ++-
 mm/hmm.c                                  |  8 ++++----
 mm/ksm.c                                  |  2 +-
 32 files changed, 69 insertions(+), 51 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index cd3c572..2a979ee 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -87,7 +87,8 @@
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 	const struct exception_table_entry *fixup;
-	int fault, si_code = SEGV_MAPERR;
+	int si_code = SEGV_MAPERR;
+	vm_fault_t fault;
 	siginfo_t info;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index a0b7bd6..3a18d33 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
+#include <linux/mm_types.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu.h>
 
@@ -66,7 +67,8 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	siginfo_t info;
-	int fault, ret;
+	int ret;
+	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index b75eada..758abcb 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -219,12 +219,12 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 	return vma->vm_flags & mask ? false : true;
 }
 
-static int __kprobes
+static vm_fault_t __kprobes
 __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		unsigned int flags, struct task_struct *tsk)
 {
 	struct vm_area_struct *vma;
-	int fault;
+	vm_fault_t fault;
 
 	vma = find_vma(mm, addr);
 	fault = VM_FAULT_BADMAP;
@@ -259,7 +259,8 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault, sig, code;
+	int sig, code;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	if (notify_page_fault(regs, fsr))
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2af3dd8..8da263b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -371,12 +371,12 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
-static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
+static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags,
 			   struct task_struct *tsk)
 {
 	struct vm_area_struct *vma;
-	int fault;
+	vm_fault_t fault;
 
 	vma = find_vma(mm, addr);
 	fault = VM_FAULT_BADMAP;
@@ -419,7 +419,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct siginfo si;
-	int fault, major = 0;
+	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 3eec33c..5d1de6c 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -52,7 +52,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	int si_code = SEGV_MAPERR;
-	int fault;
+	vm_fault_t fault;
 	const struct exception_table_entry *fixup;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index dfdc152..e085d89 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -87,7 +87,7 @@ static inline int notify_page_fault(struct pt_regs *regs, int trap)
 	struct mm_struct *mm = current->mm;
 	struct siginfo si;
 	unsigned long mask;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 03253c4..1fc7ac0 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -73,7 +73,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct * vma;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	pr_debug("do page fault:\nregs->sr=%#x, regs->pc=%#lx, address=%#lx, %ld, %p\n",
@@ -139,7 +139,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 	fault = handle_mm_fault(vma, address, flags);
-	pr_debug("handle_mm_fault returns %d\n", fault);
+	pr_debug("handle_mm_fault returns %x\n", fault);
 
 	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
 		return 0;
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index f91b30f..92a8682 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -91,7 +91,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	siginfo_t info;
 	int code = SEGV_MAPERR;
 	int is_write = error_code & ESR_S;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	regs->ear = address;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 4f8f5bf..0bc5030 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -43,7 +43,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	struct mm_struct *mm = tsk->mm;
 	const int field = sizeof(unsigned long) * 2;
 	siginfo_t info;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 10);
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 3a246fb..96796d3 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -73,7 +73,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	siginfo_t info;
-	int fault;
+	vm_fault_t fault;
 	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index b804dd0..24fd84c 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -47,7 +47,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	int code = SEGV_MAPERR;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	cause >>= 2;
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index d0021df..21e8f16 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -53,7 +53,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	siginfo_t info;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	tsk = current;
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index e247edb..ff9e634 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -262,7 +262,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	unsigned long acc_type;
-	int fault = 0;
+	vm_fault_t fault = 0;
 	unsigned int flags;
 
 	if (faulthandler_disabled())
diff --git a/arch/powerpc/include/asm/copro.h b/arch/powerpc/include/asm/copro.h
index ce216df..48616fe 100644
--- a/arch/powerpc/include/asm/copro.h
+++ b/arch/powerpc/include/asm/copro.h
@@ -10,13 +10,15 @@
 #ifndef _ASM_POWERPC_COPRO_H
 #define _ASM_POWERPC_COPRO_H
 
+#include <linux/mm_types.h>
+
 struct copro_slb
 {
 	u64 esid, vsid;
 };
 
 int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
-			  unsigned long dsisr, unsigned *flt);
+			  unsigned long dsisr, vm_fault_t *flt);
 
 int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb);
 
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 7d0945b..c8da352 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -34,7 +34,7 @@
  * to handle fortunately.
  */
 int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
-		unsigned long dsisr, unsigned *flt)
+		unsigned long dsisr, vm_fault_t *flt)
 {
 	struct vm_area_struct *vma;
 	unsigned long is_write;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627..17cce1b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -159,7 +159,7 @@ static noinline int bad_access(struct pt_regs *regs, unsigned long address)
 }
 
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
-		     unsigned int fault)
+		     vm_fault_t fault)
 {
 	siginfo_t info;
 	unsigned int lsb = 0;
@@ -189,7 +189,8 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	return 0;
 }
 
-static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
+static int mm_fault_error(struct pt_regs *regs, unsigned long addr,
+				vm_fault_t fault)
 {
 	/*
 	 * Kernel page fault interrupted by SIGKILL. We have no reason to
@@ -402,7 +403,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
  	int is_exec = TRAP(regs) == 0x400;
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
-	int fault, major = 0;
+	vm_fault_t fault, major = 0;
 	bool store_update_sp = false;
 
 	if (notify_page_fault(regs))
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index 870c0a8..0195076 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -111,7 +111,7 @@ int spufs_handle_class1(struct spu_context *ctx)
 {
 	u64 ea, dsisr, access;
 	unsigned long flags;
-	unsigned flt = 0;
+	vm_fault_t flt = 0;
 	int ret;
 
 	/*
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 148c98c..88401d5 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -41,7 +41,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	struct mm_struct *mm;
 	unsigned long addr, cause;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
-	int fault, code = SEGV_MAPERR;
+	int code = SEGV_MAPERR;
+	vm_fault_t fault;
 
 	cause = regs->scause;
 	addr = regs->sbadaddr;
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 93faeca..8ea0855 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -350,7 +350,8 @@ static noinline int signal_return(struct pt_regs *regs)
 	return -EACCES;
 }
 
-static noinline void do_fault_error(struct pt_regs *regs, int access, int fault)
+static noinline void do_fault_error(struct pt_regs *regs, int access,
+					vm_fault_t fault)
 {
 	int si_code;
 
@@ -410,7 +411,7 @@ static noinline void do_fault_error(struct pt_regs *regs, int access, int fault)
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-static inline int do_exception(struct pt_regs *regs, int access)
+static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 {
 	struct gmap *gmap;
 	struct task_struct *tsk;
@@ -420,7 +421,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	unsigned long trans_exc_code;
 	unsigned long address;
 	unsigned int flags;
-	int fault;
+	vm_fault_t fault;
 
 	tsk = current;
 	/*
@@ -571,7 +572,8 @@ static inline int do_exception(struct pt_regs *regs, int access)
 void do_protection_exception(struct pt_regs *regs)
 {
 	unsigned long trans_exc_code;
-	int access, fault;
+	int access;
+	vm_fault_t fault;
 
 	trans_exc_code = regs->int_parm_long;
 	/*
@@ -606,7 +608,8 @@ void do_protection_exception(struct pt_regs *regs)
 
 void do_dat_exception(struct pt_regs *regs)
 {
-	int access, fault;
+	int access;
+	vm_fault_t fault;
 
 	access = VM_READ | VM_EXEC | VM_WRITE;
 	fault = do_exception(regs, access);
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 6fd1bf7..474bf14 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -320,7 +320,7 @@ static noinline int vmalloc_fault(unsigned long address)
 
 static noinline int
 mm_fault_error(struct pt_regs *regs, unsigned long error_code,
-	       unsigned long address, unsigned int fault)
+	       unsigned long address, vm_fault_t fault)
 {
 	/*
 	 * Pagefault was interrupted by SIGKILL. We have no reason to
@@ -403,7 +403,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	tsk = current;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a8103a8..1a44a4e 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -174,7 +174,8 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	unsigned int fixup;
 	unsigned long g2;
 	int from_user = !(regs->psr & PSR_PS);
-	int fault, code;
+	int code;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	if (text_fault)
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 41363f4..2078bfe 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -284,7 +284,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned int insn = 0;
-	int si_code, fault_code, fault;
+	int si_code, fault_code;
+	vm_fault_t fault;
 	unsigned long address, mm_rss;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index b2b02df..0afcd09 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -72,7 +72,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	}
 
 	do {
-		int fault;
+		vm_fault_t fault;
 
 		fault = handle_mm_fault(vma, address, flags);
 
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index bbefcc4..2982140 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -167,11 +167,11 @@ static inline bool access_error(unsigned int fsr, struct vm_area_struct *vma)
 	return vma->vm_flags & mask ? false : true;
 }
 
-static int __do_pf(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
-		unsigned int flags, struct task_struct *tsk)
+static vm_fault_t __do_pf(struct mm_struct *mm, unsigned long addr,
+		unsigned int fsr, unsigned int flags, struct task_struct *tsk)
 {
 	struct vm_area_struct *vma;
-	int fault;
+	vm_fault_t fault;
 
 	vma = find_vma(mm, addr);
 	fault = VM_FAULT_BADMAP;
@@ -208,7 +208,8 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault, sig, code;
+	int sig, code;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	tsk = current;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 73bd8c9..5171d60 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/prefetch.h>		/* prefetchw			*/
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
+#include <linux/mm_types.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1004,7 +1005,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 
 static noinline void
 mm_fault_error(struct pt_regs *regs, unsigned long error_code,
-	       unsigned long address, u32 *pkey, unsigned int fault)
+	       unsigned long address, u32 *pkey, vm_fault_t fault)
 {
 	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
 		no_context(regs, error_code, address, 0, 0);
@@ -1218,7 +1219,7 @@ static inline bool smap_violation(int error_code, struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault, major = 0;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	u32 pkey;
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 8b9b6f4..203fade 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -42,7 +42,7 @@ void do_page_fault(struct pt_regs *regs)
 	siginfo_t info;
 
 	int is_write, is_exec;
-	int fault;
+	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 	info.si_code = SEGV_MAPERR;
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 1d0b53a0..58da65d 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -508,7 +508,7 @@ static void do_fault(struct work_struct *work)
 {
 	struct fault *fault = container_of(work, struct fault, work);
 	struct vm_area_struct *vma;
-	int ret = VM_FAULT_ERROR;
+	vm_fault_t ret = VM_FAULT_ERROR;
 	unsigned int flags = 0;
 	struct mm_struct *mm;
 	u64 address;
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e8cd984..75189c0 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -24,6 +24,7 @@
 #include <linux/pci-ats.h>
 #include <linux/dmar.h>
 #include <linux/interrupt.h>
+#include <linux/mm_types.h>
 #include <asm/page.h>
 
 #define PASID_ENTRY_P		BIT_ULL(0)
@@ -594,7 +595,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		struct vm_area_struct *vma;
 		struct page_req_dsc *req;
 		struct qi_desc resp;
-		int ret, result;
+		int result;
+		vm_fault_t ret;
 		u64 address;
 
 		handled = 1;
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 70dbb6d..93ecc67 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -134,7 +134,7 @@ static int cxl_handle_segment_miss(struct cxl_context *ctx,
 
 int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 {
-	unsigned flt = 0;
+	vm_fault_t flt = 0;
 	int result;
 	unsigned long access, flags, inv_flags = 0;
 
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index f307905..4e155fb 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -2,6 +2,7 @@
 // Copyright 2017 IBM Corp.
 #include <linux/sched/mm.h>
 #include <linux/mutex.h>
+#include <linux/mm_types.h>
 #include <linux/mmu_context.h>
 #include <asm/copro.h>
 #include <asm/pnv-ocxl.h>
@@ -126,7 +127,7 @@ static void ack_irq(struct spa *spa, enum xsl_response r)
 
 static void xsl_fault_handler_bh(struct work_struct *fault_work)
 {
-	unsigned int flt = 0;
+	vm_fault_t flt = 0;
 	unsigned long access, flags, inv_flags = 0;
 	enum xsl_response r;
 	struct xsl_fault *fault = container_of(fault_work, struct xsl_fault,
diff --git a/mm/hmm.c b/mm/hmm.c
index 486dc39..d7919e5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -308,14 +308,14 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsigned long addr,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
-	int r;
+	vm_fault_t ret;
 
 	flags |= hmm_vma_walk->block ? 0 : FAULT_FLAG_ALLOW_RETRY;
 	flags |= write_fault ? FAULT_FLAG_WRITE : 0;
-	r = handle_mm_fault(vma, addr, flags);
-	if (r & VM_FAULT_RETRY)
+	ret = handle_mm_fault(vma, addr, flags);
+	if (ret & VM_FAULT_RETRY)
 		return -EBUSY;
-	if (r & VM_FAULT_ERROR) {
+	if (ret & VM_FAULT_ERROR) {
 		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
 	}
diff --git a/mm/ksm.c b/mm/ksm.c
index e3cbf9a..cb4e6ed 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -451,7 +451,7 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *page;
-	int ret = 0;
+	vm_fault_t ret = 0;
 
 	do {
 		cond_resched();
-- 
1.9.1

