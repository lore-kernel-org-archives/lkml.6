Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EF620897
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EF620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeH0NLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:11:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:47246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeH0NLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:11:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 02:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="252205555"
Received: from kookoo32-optiplex-9020.sh.intel.com ([10.239.37.4])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2018 02:25:43 -0700
From:   Gu Zhimin <kookoo.gu@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Yu Chen <yu.c.chen@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhimin Gu <kookoo.gu@intel.com>
Subject: [PATCH 3/3] x86, hibernate: Backport several fixes from 64bits to 32bits hibernation
Date:   Mon, 27 Aug 2018 17:42:28 +0800
Message-Id: <1b8f643f548521adc11cc314c01af5d4ce708638.1535361949.git.kookoo.gu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1535361949.git.kookoo.gu@intel.com>
References: <cover.1535361949.git.kookoo.gu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Currently there are mainly three bugs in 32bits system when doing
hibernation:
1. The page copy code is not running in safe page, which might
   cause hang during resume.
2. There's no text mapping for the final jump address
   of the original kernel, which might cause the system jumping
   into illegal address and causes system hang during resume.
3. The restore kernel switches to its own kernel page table(swapper_pg_dir)
   rather than the original kernel page table after all the pages
   been copied back, which might cause invalid virtual-physical
   mapping issue during resume.

To solve these problems:

1. Copy the code core_restore_code to a safe page, to avoid the instruction
   code be overwritten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address, so that
   after all the pages have been copied back, the system could jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits
system.

Acked-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
---
 arch/x86/Kconfig                  |  2 +-
 arch/x86/include/asm/suspend_32.h |  4 +++
 arch/x86/power/hibernate.c        |  2 --
 arch/x86/power/hibernate_32.c     | 54 ++++++++++++++++++++++++++++++++++++---
 arch/x86/power/hibernate_asm_32.S | 49 ++++++++++++++++++++++++++++-------
 5 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5ff296..d1c3c9d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 8be6afb..fdbd9d7 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -32,4 +32,8 @@ struct saved_context {
 	unsigned long return_address;
 } __attribute__((packed));
 
+/* routines for saving/restoring kernel state */
+extern char core_restore_code[];
+extern char restore_registers[];
+
 #endif /* _ASM_X86_SUSPEND_32_H */
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 6f91f7b..d3ef08d 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -63,7 +63,6 @@ int pfn_is_nosave(unsigned long pfn)
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
 
-#ifdef CONFIG_X86_64
 static int relocate_restore_code(void)
 {
 	pgd_t *pgd;
@@ -252,4 +251,3 @@ int arch_hibernation_header_restore(void *addr)
 
 	return 0;
 }
-#endif
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index 7922e11..d0a41ed 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -8,9 +8,6 @@
 
 #include "hibernate.c"
 
-/* Pointer to the temporary resume page tables */
-pgd_t *resume_pg_dir;
-
 /* The following three functions are based on the analogous code in
  * arch/x86/mm/init_32.c
  */
@@ -135,20 +132,69 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
-asmlinkage int swsusp_arch_resume(void)
+static int set_up_temporary_text_mapping(pgd_t *pgd_base)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_base + pgd_index(restore_jump_address);
+
+	pmd = resume_one_md_table_init(pgd);
+	if (!pmd)
+		return -ENOMEM;
+
+	if (boot_cpu_has(X86_FEATURE_PSE)) {
+		set_pmd(pmd + pmd_index(restore_jump_address),
+		__pmd((jump_address_phys & PMD_MASK) | pgprot_val(PAGE_KERNEL_LARGE_EXEC)));
+	} else {
+		pte = resume_one_page_table_init(pmd);
+		if (!pte)
+			return -ENOMEM;
+		set_pte(pte + pte_index(restore_jump_address),
+		__pte((jump_address_phys & PAGE_MASK) | pgprot_val(PAGE_KERNEL_EXEC)));
+	}
+
+	return 0;
+}
+
+/* Set up the temporary kernel text and direct mapping. */
+static int set_up_temporary_mappings(void)
 {
 	int error;
+	pgd_t *resume_pg_dir;
 
 	resume_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
 	if (!resume_pg_dir)
 		return -ENOMEM;
 
 	resume_init_first_level_page_table(resume_pg_dir);
+	error = set_up_temporary_text_mapping(resume_pg_dir);
+	if (error)
+		return error;
+
 	error = resume_physical_mapping_init(resume_pg_dir);
 	if (error)
 		return error;
 
+	temp_pgt = __pa(resume_pg_dir);
+
+	return 0;
+}
+
+asmlinkage int swsusp_arch_resume(void)
+{
+	int error;
+
 	/* We have got enough memory and from now on we cannot recover */
+	error = set_up_temporary_mappings();
+	if (error)
+		return error;
+
+	error = relocate_restore_code();
+	if (error)
+		return error;
+
 	restore_image();
 	return 0;
 }
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6e56815..a53b4a4 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -24,21 +24,40 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	/* save cr3 */
+	movl	%cr3, %eax
+	movl	%eax, restore_cr3
+
 	call swsusp_save
 	ret
+ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
-	movl	mmu_cr4_features, %ecx
-	movl	resume_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
+	/* prepare to jump to the image kernel */
+	movl	restore_jump_address, %ebx
+	movl	restore_cr3, %ebp
+
+	movl	mmu_cr4_features, %edx
+
+	/* jump to relocated restore code */
+	movl	relocated_restore_code, %eax
+	jmpl	*%eax
+
+	/* code below has been relocated to a safe page */
+ENTRY(core_restore_code)
+	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
+	/* flush TLB */
+	movl	%edx, %ecx
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
 	andl	$~(X86_CR4_PGE), %ecx
 	movl	%ecx, %cr4;  # turn off PGE
 	movl	%cr3, %eax;  # flush TLB
 	movl	%eax, %cr3
+	movl	%edx, %cr4;  # turn PGE back on
 1:
+	/* prepare to copy image data to their original locations */
 	movl	restore_pblist, %edx
 	.p2align 4,,7
 
@@ -49,7 +68,7 @@ copy_loop:
 	movl	pbe_address(%edx), %esi
 	movl	pbe_orig_address(%edx), %edi
 
-	movl	$1024, %ecx
+	movl	$(PAGE_SIZE >> 2), %ecx
 	rep
 	movsl
 
@@ -58,13 +77,22 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+	jmpl	*%ebx
+	.align PAGE_SIZE
+
+ENTRY(restore_registers)
 	/* go back to the original page tables */
-	movl	$swapper_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
-	movl	%eax, %cr3
-	movl	mmu_cr4_features, %ecx
+	movl	%ebp, %cr3
+
+	/* flush TLB */
+	movl	mmu_cr4_features, %edx
+	movl	%edx, %ecx
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
-	movl	%ecx, %cr4;  # turn PGE back on
+	andl	$~(X86_CR4_PGE), %ecx
+	movl	%ecx, %cr4;  # turn off PGE
+	movl	%cr3, %ecx;  # flush TLB
+	movl	%ecx, %cr3;
+	movl	%edx, %cr4;  # turn PGE back on
 1:
 
 	movl saved_context_esp, %esp
@@ -82,4 +110,7 @@ done:
 
 	xorl	%eax, %eax
 
+	movl	%eax, in_suspend
+
 	ret
+ENDPROC(restore_registers)
-- 
2.7.4

