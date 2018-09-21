Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA5ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FC921479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FC921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbeIUMJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:09:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:32150 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389205AbeIUMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:09:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74799022"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:21:37 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 10/12][v4] x86-32, hibernate: Switch to relocated restore code during resume on 32bit system
Date:   Fri, 21 Sep 2018 14:28:22 +0800
Message-Id: <c573824cf57dda457d62188885457f0a9d18c44c.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

On 64bit system, code should be executed in a safe page
during page restoring, as the page where instruction is
running during resume might be scribbled and causes issues.

Although on 32 bit, we only suspend resuming by same kernel
that did the suspend, we'd like to remove that restriction
in the future.

Porting corresponding code from
64bit system: Allocate a safe page, and copy the restore
code to it, then jump to the safe page to run the code.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate.c        | 2 --
 arch/x86/power/hibernate_32.c     | 4 ++++
 arch/x86/power/hibernate_asm_32.S | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 4935b8139229..7383cb67ffd7 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -212,7 +212,6 @@ int arch_hibernation_header_restore(void *addr)
 	return 0;
 }
 
-#ifdef CONFIG_X86_64
 int relocate_restore_code(void)
 {
 	pgd_t *pgd;
@@ -251,4 +250,3 @@ int relocate_restore_code(void)
 	__flush_tlb_all();
 	return 0;
 }
-#endif
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index a44bdada4e4e..a9861095fbb8 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -158,6 +158,10 @@ asmlinkage int swsusp_arch_resume(void)
 
 	temp_pgt = __pa(resume_pg_dir);
 
+	error = relocate_restore_code();
+	if (error)
+		return error;
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6b2b94937113..e9adda6b6b02 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -39,6 +39,13 @@ ENTRY(restore_image)
 	movl	restore_cr3, %ebp
 
 	movl	mmu_cr4_features, %ecx
+
+	/* jump to relocated restore code */
+	movl	relocated_restore_code, %eax
+	jmpl	*%eax
+
+/* code below has been relocated to a safe page */
+ENTRY(core_restore_code)
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
-- 
2.17.1

