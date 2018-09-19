Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38108C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF7720880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF7720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeISNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:08:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:8163 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeISNIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:08:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 00:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91367381"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 00:31:41 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 03/12][RFC v3] x86-32/asm/power: Create stack frames in hibernate_asm_32.S
Date:   Wed, 19 Sep 2018 15:38:25 +0800
Message-Id: <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Backport
Commit ef0f3ed5a4ac (x86/asm/power: Create stack frames
in hibernate_asm_64.S)
and
Commit 4ce827b4cc58 (x86/power/64: Fix hibernation return
address corruption)

And also prepare for relocated code and jump address
mapping.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/suspend_32.h | 4 ++++
 arch/x86/power/hibernate_asm_32.S | 9 +++++++++
 2 files changed, 13 insertions(+)

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
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6e56815e13a0..671d38d0d931 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -12,6 +12,7 @@
 #include <asm/page_types.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/frame.h>
 
 .text
 
@@ -24,8 +25,11 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	FRAME_BEGIN
 	call swsusp_save
+	FRAME_END
 	ret
+ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
 	movl	mmu_cr4_features, %ecx
@@ -58,6 +62,10 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+
+	/* code below belongs to the image kernel */
+	.align PAGE_SIZE
+ENTRY(restore_registers)
 	/* go back to the original page tables */
 	movl	$swapper_pg_dir, %eax
 	subl	$__PAGE_OFFSET, %eax
@@ -83,3 +91,4 @@ done:
 	xorl	%eax, %eax
 
 	ret
+ENDPROC(restore_registers)
-- 
2.17.1

