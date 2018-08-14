Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DAEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41A21733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F41A21733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbeHNURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:17:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388383AbeHNURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A02A840B;
        Tue, 14 Aug 2018 17:29:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 30/97] x86/bugs: Move the l1tf function and define pr_fmt properly
Date:   Tue, 14 Aug 2018 19:16:42 +0200
Message-Id: <20180814171434.331402013@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 56563f53d3066afa9e63d6c997bf67e76a8b05c0 upstream

The pr_warn in l1tf_select_mitigation would have used the prior pr_fmt
which was defined as "Spectre V2 : ".

Move the function to be past SSBD and also define the pr_fmt.

Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   55 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -209,32 +209,6 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
-static void __init l1tf_select_mitigation(void)
-{
-	u64 half_pa;
-
-	if (!boot_cpu_has_bug(X86_BUG_L1TF))
-		return;
-
-#if CONFIG_PGTABLE_LEVELS == 2
-	pr_warn("Kernel not compiled for PAE. No mitigation for L1TF\n");
-	return;
-#endif
-
-	/*
-	 * This is extremely unlikely to happen because almost all
-	 * systems have far more MAX_PA/2 than RAM can be fit into
-	 * DIMM slots.
-	 */
-	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
-	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
-		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
-		return;
-	}
-
-	setup_force_cpu_cap(X86_FEATURE_L1TF_PTEINV);
-}
-
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -660,6 +634,35 @@ void x86_spec_ctrl_setup_ap(void)
 		x86_amd_ssb_disable();
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"L1TF: " fmt
+static void __init l1tf_select_mitigation(void)
+{
+	u64 half_pa;
+
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return;
+
+#if CONFIG_PGTABLE_LEVELS == 2
+	pr_warn("Kernel not compiled for PAE. No mitigation for L1TF\n");
+	return;
+#endif
+
+	/*
+	 * This is extremely unlikely to happen because almost all
+	 * systems have far more MAX_PA/2 than RAM can be fit into
+	 * DIMM slots.
+	 */
+	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
+	if (e820__mapped_any(half_pa, ULLONG_MAX - half_pa, E820_TYPE_RAM)) {
+		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
+		return;
+	}
+
+	setup_force_cpu_cap(X86_FEATURE_L1TF_PTEINV);
+}
+#undef pr_fmt
+
 #ifdef CONFIG_SYSFS
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,


