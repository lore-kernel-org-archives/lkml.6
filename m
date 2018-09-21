Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE26ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838E2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3838E2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbeIUMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:09:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:36448 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbeIUMJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:09:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74799032"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:21:46 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 11/12][v4] x86-32, hibernate: Set up temporary text mapping for 32bit system
Date:   Fri, 21 Sep 2018 14:28:32 +0800
Message-Id: <05908fe04f02898ba36def9b3cf1cd72fb4750a6.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Set up the temporary text mapping for the final jump address
so that the system could jump to the right address after all
the pages have been copied back to their original address -
otherwise the final mapping for the jump address is invalid.

Analogous changes were made for 64-bit in:
Commit 65c0554b73c9 ('x86/power/64: Fix kernel text mapping
corruption during image restoration')

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate.c        |  4 ----
 arch/x86/power/hibernate_32.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_asm_32.S |  3 +++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 7383cb67ffd7..bcddf09b5aa3 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -157,10 +157,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
 	rdr->magic = RESTORE_MAGIC;
-#ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
-#endif
 
 	/*
 	 * The restore code fixes up CR3 and CR4 in the following sequence:
@@ -198,10 +196,8 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
-#endif
 	restore_cr3 = rdr->cr3;
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index a9861095fbb8..15695e30f982 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -143,6 +143,32 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
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
@@ -152,6 +178,11 @@ asmlinkage int swsusp_arch_resume(void)
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
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index e9adda6b6b02..01f653fae7bd 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -36,6 +36,8 @@ ENTRY(swsusp_arch_suspend)
 ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
+	/* prepare to jump to the image kernel */
+	movl	restore_jump_address, %ebx
 	movl	restore_cr3, %ebp
 
 	movl	mmu_cr4_features, %ecx
@@ -74,6 +76,7 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+	jmpl	*%ebx
 
 	/* code below belongs to the image kernel */
 	.align PAGE_SIZE
-- 
2.17.1

