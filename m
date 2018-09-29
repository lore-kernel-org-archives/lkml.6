Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B2C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7A9206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7A9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeI3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51550 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gv-Cb; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006p4-7I; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.341086513@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 003/131] x86/bugs: Concentrate bug reporting into a
 separate function
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

commit d1059518b4789cabe34bb4b714d07e6089c82ca1 upstream.

Those SysFS functions have a similar preamble, as such make common
code to handle them.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: s/X86_FEATURE_PTI/X86_FEATURE_KAISER/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 46 ++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -352,30 +352,48 @@ retpoline_auto:
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+
+ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
+			char *buf, unsigned int bug)
 {
-	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (!boot_cpu_has_bug(bug))
 		return sprintf(buf, "Not affected\n");
-	if (boot_cpu_has(X86_FEATURE_KAISER))
-		return sprintf(buf, "Mitigation: PTI\n");
+
+	switch (bug) {
+	case X86_BUG_CPU_MELTDOWN:
+		if (boot_cpu_has(X86_FEATURE_KAISER))
+			return sprintf(buf, "Mitigation: PTI\n");
+
+		break;
+
+	case X86_BUG_SPECTRE_V1:
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
+	case X86_BUG_SPECTRE_V2:
+		return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			       spectre_v2_module_string());
+
+	default:
+		break;
+	}
+
 	return sprintf(buf, "Vulnerable\n");
 }
 
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_CPU_MELTDOWN);
+}
+
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
-		return sprintf(buf, "Not affected\n");
-	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V1);
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		return sprintf(buf, "Not affected\n");
-
-	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
-		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-		       spectre_v2_module_string());
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V2);
 }
 #endif

