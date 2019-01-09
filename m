Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7242FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4395B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfAIX4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:56:21 -0500
Received: from foss.arm.com ([217.140.101.70]:53358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfAIXzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:55:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E675315BF;
        Wed,  9 Jan 2019 15:55:54 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AD533F5AF;
        Wed,  9 Jan 2019 15:55:54 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 4/7] arm64: add sysfs vulnerability show for meltdown
Date:   Wed,  9 Jan 2019 17:55:41 -0600
Message-Id: <20190109235544.2992426-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the mitigation status if active, otherwise
assume the cpu is safe unless it doesn't have CSV3
and isn't in our whitelist.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ab784d7a0083..ef7bbc49ef78 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -944,8 +944,12 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+/* default value is invalid until unmap_kernel_at_el0() runs */
+static bool __meltdown_safe = true;
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
+extern uint arm64_requested_vuln_attrs;
 
 static bool is_cpu_meltdown_safe(void)
 {
@@ -972,6 +976,14 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 {
 	char const *str = "command line option";
 
+	bool meltdown_safe = is_cpu_meltdown_safe() ||
+		has_cpuid_feature(entry, scope);
+
+	if (!meltdown_safe)
+		__meltdown_safe = false;
+
+	arm64_requested_vuln_attrs |= VULN_MELTDOWN;
+
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
 	 * ThunderX leads to apparent I-cache corruption of kernel text, which
@@ -993,11 +1005,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	if (is_cpu_meltdown_safe())
-		return false;
-
-	/* Defer to CPU feature registers */
-	return !has_cpuid_feature(entry, scope);
+	return !meltdown_safe;
 }
 
 static void
@@ -2065,3 +2073,17 @@ static int __init enable_mrs_emulation(void)
 }
 
 core_initcall(enable_mrs_emulation);
+
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	if (arm64_kernel_unmapped_at_el0())
+		return sprintf(buf, "Mitigation: KPTI\n");
+
+	if (__meltdown_safe)
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+#endif
-- 
2.17.2

