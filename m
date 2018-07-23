Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7645ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BD320880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BD320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbeGWNrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:31 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CECEDC7A;
        Mon, 23 Jul 2018 12:44:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 050/107] x86/bugs: Concentrate bug reporting into a separate function
Date:   Mon, 23 Jul 2018 14:41:44 +0200
Message-Id: <20180723122415.469938978@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit d1059518b4789cabe34bb4b714d07e6089c82ca1 upstream

Those SysFS functions have a similar preamble, as such make common
code to handle them.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/bugs.c |   46 +++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -314,30 +314,48 @@ retpoline_auto:
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


