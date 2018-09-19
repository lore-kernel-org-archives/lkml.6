Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E94720880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E94720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeISNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:13:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:42047 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeISNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:13:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 00:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91368443"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 00:36:27 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 10/12][RFC v3] x86-32, hibernate: Switch to relocated restore code during resume on 32bit system
Date:   Wed, 19 Sep 2018 15:43:12 +0800
Message-Id: <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Code should be executed in a safe page during page
restoring, as the page where instruction is running
during resume might be scribbled and causes issues.

Backport the code from 64 bit system to fix this bug.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 4 ++++
 arch/x86/power/hibernate_asm_32.S | 7 +++++++
 2 files changed, 11 insertions(+)

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

