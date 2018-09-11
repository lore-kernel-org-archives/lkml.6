Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43EDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B782086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B782086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeIKWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeIKWPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="262579658"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2018 10:14:56 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/4][v2] x86, hibernate: Backport several fixes from 64bits to 32bits hibernation
Date:   Wed, 12 Sep 2018 01:21:00 +0800
Message-Id: <6c1b31e24b78b0366c7ca9fa6ac75bdb463d8fc0.1536685746.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536685746.git.yu.c.chen@intel.com>
References: <cover.1536685746.git.yu.c.chen@intel.com>
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
   code been overwritten when image kernel pages are being copied.
2. Set up temporary text mapping for the image kernel's jump address,
   so that after all the pages have been copied back, the system could
   jump to this address.
3. Switch to the original kernel page table during resume.

Furthermore, MD5 hash check for e820 map is also backported from 64bits
system.

Acked-by: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
---
 arch/x86/Kconfig                  |  2 +-
 arch/x86/include/asm/suspend_32.h |  4 +++
 arch/x86/power/hibernate.c        |  2 --
 arch/x86/power/hibernate_32.c     | 37 +++++++++++++++++++++++
 arch/x86/power/hibernate_asm_32.S | 49 +++++++++++++++++++++++++------
 5 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..e8de5de1057f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 8be6afb58471..fdbd9d7b7bca 100644
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
index 6aeac4d3c9df..d719d156114b 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -69,7 +69,6 @@ int pfn_is_nosave(unsigned long pfn)
 	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
 }
 
-#ifdef CONFIG_X86_64
 static int relocate_restore_code(void)
 {
 	pgd_t *pgd;
@@ -262,4 +261,3 @@ int arch_hibernation_header_restore(void *addr)
 
 	return 0;
 }
-#endif
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index e0e7b9aea22a..d692700047bf 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -135,6 +135,32 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
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
 asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
@@ -144,10 +170,21 @@ asmlinkage int swsusp_arch_resume(void)
 		return -ENOMEM;
 
 	resume_init_first_level_page_table(resume_pg_dir);
+
+	error = set_up_temporary_text_mapping(resume_pg_dir);
+	if (error)
+		return error;
+
 	error = resume_physical_mapping_init(resume_pg_dir);
 	if (error)
 		return error;
 
+	temp_pgt = __pa(resume_pg_dir);
+
+	error = relocate_restore_code();
+	if (error)
+		return error;
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6e56815e13a0..a53b4a41e09a 100644
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
2.17.1

