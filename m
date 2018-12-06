Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1569A2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1569A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLFXoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:44:32 -0500
Received: from foss.arm.com ([217.140.101.70]:35906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbeLFXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:44:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1255915AD;
        Thu,  6 Dec 2018 15:44:31 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 851EA3F5AF;
        Thu,  6 Dec 2018 15:44:30 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
Date:   Thu,  6 Dec 2018 17:44:04 -0600
Message-Id: <20181206234408.1287689-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206234408.1287689-1-jeremy.linton@arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple state machine which will track whether
all the online cores in a machine are vulnerable.

Once that is done we have a fairly authoritative view
of the machine vulnerability, which allows us to make a
judgment about machine safety if it hasn't been mitigated.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 242898395f68..bea9adfef7fa 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -905,6 +905,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN } __meltdown_safe = A64_MELT_UNSET;
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
@@ -928,6 +930,15 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 {
 	char const *str = "command line option";
 
+	bool meltdown_safe = is_cpu_meltdown_safe() ||
+		has_cpuid_feature(entry, scope);
+
+	/* Only safe if all booted cores are known safe */
+	if (meltdown_safe && __meltdown_safe == A64_MELT_UNSET)
+		__meltdown_safe = A64_MELT_SAFE;
+	else if (!meltdown_safe)
+		__meltdown_safe = A64_MELT_UNKN;
+
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
 	 * ThunderX leads to apparent I-cache corruption of kernel text, which
@@ -949,11 +960,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
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
@@ -1920,3 +1927,17 @@ static int __init enable_mrs_emulation(void)
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
+	if (__meltdown_safe == A64_MELT_SAFE)
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Unknown\n");
+}
+#endif
-- 
2.17.2

