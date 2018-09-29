Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF17C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB420880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CB420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeI3E1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:27:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51685 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728302AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gs-O3; Sat, 29 Sep 2018 22:48:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006xc-3l; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.17469208@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 109/131] x86/bugs: Move the l1tf function and define
 pr_fmt properly
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 56563f53d3066afa9e63d6c997bf67e76a8b05c0 upstream.

The pr_warn in l1tf_select_mitigation would have used the prior pr_fmt
which was defined as "Spectre V2 : ".

Move the function to be past SSBD and also define the pr_fmt.

Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -270,32 +270,6 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
-static void __init l1tf_select_mitigation(void)
-{
-	u64 half_pa;
-
-	if (!boot_cpu_has_bug(X86_BUG_L1TF))
-		return;
-
-#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
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
-	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
-		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
-		return;
-	}
-
-	setup_force_cpu_cap(X86_FEATURE_L1TF_PTEINV);
-}
-
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -721,6 +695,35 @@ void x86_spec_ctrl_setup_ap(void)
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
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
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
+	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
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

