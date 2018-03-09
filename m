Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872320-1520610570-2-10307460887727401364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520610569; b=ejamfCGWD332HlDFJFRDpAfjXcSNii+b4o5acfD8VCI2yeY
    LqR7+VSaFMV42gqnaaQQ97eD5sYaNcnTG4K6loeIwx8n+Yu3IwMM2xJcrKe5KpX0
    KGDp6Wffv6Z3obDoLz/2NaUWNQw77KbA2+eSbJ12OmlH8n+hSqNNbjGMpxvODdUK
    exj+9oX57Kjs2O5R53JmaSdLbmpstuZMGH2By4ITrmtVtpR6cxRIMFbm+jmjD9my
    rFGgnj4Ku/6JhDCv4BRi0qKVVpVC+P2/bPuQ+jZjxqk2GgmJ3M6xaXlVVYFsjyn5
    t7PLD/+d812WASqGTGADokVASiYyRyDImYY39JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :subject:to:cc:date:sender:list-id; s=arctest; t=1520610569; bh=
    RD7hqeU6GU1Jly5psf88sRuUAsdtJM+g18SycxOM33w=; b=l0N1UAhzAAZpWuYm
    fnPWr65nXo8RK+sWMNZ+umAQZE6A7WBFtfT1oeA2itlhew+UoWJeM/NVUQVD/V6V
    iWU9ucB43xtTkP38eMmDavWvlNTHZWiRIIkqLoqSSjjwF03yHyaF3m68GdzouJ6e
    6JWIIpV7mMpDp4O24nl+jGH6G8sID5R1NWFAn5hl+i4RXjzqIPkVcar5fxHmj9YR
    /jRWrevDe2yC/xt0mfhlVcq9Z7vuGgSrSZjtjDiT5WEr4rTaH47JyJq2pdUmpdU5
    TZQMuUYvGisUDPAh0KF5yMtLysdVe7S2NNGQhavIMF8NhBli+9iL8tZzutWWvnGi
    CIH+gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=c-s.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=c-s.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeCIPtM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:49:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49550 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932084AbeCIPtH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 10:49:07 -0500
Message-Id: <2506aa6efe6f3ddf4c8158e708afbb62fb7fff17.1520468013.git.christophe.leroy@c-s.fr>
In-Reply-To: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 4/4] powerpc/mm/slice: Fix hugepage allocation at hint
 address on 8xx
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  9 Mar 2018 16:49:05 +0100 (CET)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream aa0ab02ba992eb956934b21373e0138211486ddd

On the 8xx, the page size is set in the PMD entry and applies to
all pages of the page table pointed by the said PMD entry.

When an app has some regular pages allocated (e.g. see below) and tries
to mmap() a huge page at a hint address covered by the same PMD entry,
the kernel accepts the hint allthough the 8xx cannot handle different
page sizes in the same PMD entry.

10000000-10001000 r-xp 00000000 00:0f 2597 /root/malloc
10010000-10011000 rwxp 00000000 00:0f 2597 /root/malloc

mmap(0x10080000, 524288, PROT_READ|PROT_WRITE,
     MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x10080000

This results the app remaining forever in do_page_fault()/hugetlb_fault()
and when interrupting that app, we get the following warning:

[162980.035629] WARNING: CPU: 0 PID: 2777 at arch/powerpc/mm/hugetlbpage.c:354 hugetlb_free_pgd_range+0xc8/0x1e4
[162980.035699] CPU: 0 PID: 2777 Comm: malloc Tainted: G W       4.14.6 #85
[162980.035744] task: c67e2c00 task.stack: c668e000
[162980.035783] NIP:  c000fe18 LR: c00e1eec CTR: c00f90c0
[162980.035830] REGS: c668fc20 TRAP: 0700   Tainted: G W        (4.14.6)
[162980.035854] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24044224 XER: 20000000
[162980.036003]
[162980.036003] GPR00: c00e1eec c668fcd0 c67e2c00 00000010 c6869410 10080000 00000000 77fb4000
[162980.036003] GPR08: ffff0001 0683c001 00000000 ffffff80 44028228 10018a34 00004008 418004fc
[162980.036003] GPR16: c668e000 00040100 c668e000 c06c0000 c668fe78 c668e000 c6835ba0 c668fd48
[162980.036003] GPR24: 00000000 73ffffff 74000000 00000001 77fb4000 100fffff 10100000 10100000
[162980.036743] NIP [c000fe18] hugetlb_free_pgd_range+0xc8/0x1e4
[162980.036839] LR [c00e1eec] free_pgtables+0x12c/0x150
[162980.036861] Call Trace:
[162980.036939] [c668fcd0] [c00f0774] unlink_anon_vmas+0x1c4/0x214 (unreliable)
[162980.037040] [c668fd10] [c00e1eec] free_pgtables+0x12c/0x150
[162980.037118] [c668fd40] [c00eabac] exit_mmap+0xe8/0x1b4
[162980.037210] [c668fda0] [c0019710] mmput.part.9+0x20/0xd8
[162980.037301] [c668fdb0] [c001ecb0] do_exit+0x1f0/0x93c
[162980.037386] [c668fe00] [c001f478] do_group_exit+0x40/0xcc
[162980.037479] [c668fe10] [c002a76c] get_signal+0x47c/0x614
[162980.037570] [c668fe70] [c0007840] do_signal+0x54/0x244
[162980.037654] [c668ff30] [c0007ae8] do_notify_resume+0x34/0x88
[162980.037744] [c668ff40] [c000dae8] do_user_signal+0x74/0xc4
[162980.037781] Instruction dump:
[162980.037821] 7fdff378 81370000 54a3463a 80890020 7d24182e 7c841a14 712a0004 4082ff94
[162980.038014] 2f890000 419e0010 712a0ff0 408200e0 <0fe00000> 54a9000a 7f984840 419d0094
[162980.038216] ---[ end trace c0ceeca8e7a5800a ]---
[162980.038754] BUG: non-zero nr_ptes on freeing mm: 1
[162985.363322] BUG: non-zero nr_ptes on freeing mm: -1

In order to fix this, this patch uses the address space "slices"
implemented for BOOK3S/64 and enhanced to support PPC32 by the
preceding patch.

This patch modifies the context.id on the 8xx to be in the range
[1:16] instead of [0:15] in order to identify context.id == 0 as
not initialised contexts as done on BOOK3S

This patch activates CONFIG_PPC_MM_SLICES when CONFIG_HUGETLB_PAGE is
selected for the 8xx

Alltough we could in theory have as many slices as PMD entries, the
current slices implementation limits the number of low slices to 16.
This limitation is not preventing us to fix the initial issue allthough
it is suboptimal. It will be cured in a subsequent patch.

Fixes: 4b91428699477 ("powerpc/8xx: Implement support of hugepages")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu-8xx.h     |  6 ++++++
 arch/powerpc/kernel/setup-common.c     |  2 ++
 arch/powerpc/mm/8xx_mmu.c              |  2 +-
 arch/powerpc/mm/hugetlbpage.c          |  2 ++
 arch/powerpc/mm/mmu_context_nohash.c   | 18 ++++++++++++++++--
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 6 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 5bb3dbede41a..1325e5b5f680 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -169,6 +169,12 @@ typedef struct {
 	unsigned int id;
 	unsigned int active;
 	unsigned long vdso_base;
+#ifdef CONFIG_PPC_MM_SLICES
+	u16 user_psize;		/* page size index */
+	u64 low_slices_psize;	/* page size encodings */
+	unsigned char high_slices_psize[0];
+	unsigned long addr_limit;
+#endif
 } mm_context_t;
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e3bc16d02b2..ddf62a690c23 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -899,6 +899,8 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_PPC_MM_SLICES
 #ifdef CONFIG_PPC64
 	init_mm.context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
+#elif defined(CONFIG_PPC_8xx)
+	init_mm.context.addr_limit = DEFAULT_MAP_WINDOW;
 #else
 #error	"context.addr_limit not initialized."
 #endif
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index f29212e40f40..0be77709446c 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -192,7 +192,7 @@ void set_context(unsigned long id, pgd_t *pgd)
 	mtspr(SPRN_M_TW, __pa(pgd) - offset);
 
 	/* Update context */
-	mtspr(SPRN_M_CASID, id);
+	mtspr(SPRN_M_CASID, id - 1);
 	/* sync */
 	mb();
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 1571a498a33f..4c9e5f9c7a44 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -552,9 +552,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
+#ifdef CONFIG_PPC_RADIX_MMU
 	if (radix_enabled())
 		return radix__hugetlb_get_unmapped_area(file, addr, len,
 						       pgoff, flags);
+#endif
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
 }
 #endif
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 4554d6527682..e2b28b3a512e 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -331,6 +331,20 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 {
 	pr_hard("initing context for mm @%p\n", mm);
 
+#ifdef	CONFIG_PPC_MM_SLICES
+	if (!mm->context.addr_limit)
+		mm->context.addr_limit = DEFAULT_MAP_WINDOW;
+
+	/*
+	 * We have MMU_NO_CONTEXT set to be ~0. Hence check
+	 * explicitly against context.id == 0. This ensures that we properly
+	 * initialize context slice details for newly allocated mm's (which will
+	 * have id == 0) and don't alter context slice inherited via fork (which
+	 * will have id != 0).
+	 */
+	if (mm->context.id == 0)
+		slice_set_user_psize(mm, mmu_virtual_psize);
+#endif
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
 	return 0;
@@ -428,8 +442,8 @@ void __init mmu_context_init(void)
 	 *      -- BenH
 	 */
 	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
-		first_context = 0;
-		last_context = 15;
+		first_context = 1;
+		last_context = 16;
 		no_selective_tlbil = true;
 	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
 		first_context = 1;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a78f255111f2..3ce376b42330 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -325,6 +325,7 @@ config PPC_BOOK3E_MMU
 config PPC_MM_SLICES
 	bool
 	default y if PPC_STD_MMU_64
+	default y if PPC_8xx && HUGETLB_PAGE
 	default n
 
 config PPC_HAVE_PMU_SUPPORT
-- 
2.13.3
