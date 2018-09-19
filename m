Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD067ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8078C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8078C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeISNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:13:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:42047 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731055AbeISNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:13:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 00:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91368456"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 00:36:36 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 11/12][RFC v3] x86-32, hibernate: Set up temporary text mapping for 32bit system
Date:   Wed, 19 Sep 2018 15:43:22 +0800
Message-Id: <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Set up the temporary text mapping for the final jump address
so that the system could jump to the right address after all
the pages have been copied back to their original address.

Back-port from 64bit system.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_asm_32.S |  3 +++
 2 files changed, 34 insertions(+)

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

