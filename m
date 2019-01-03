Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfACAuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:50:01 -0500
Received: from foss.arm.com ([217.140.101.70]:39806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbfACAtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:49:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC4E15AB;
        Wed,  2 Jan 2019 16:49:34 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C869B3F5AF;
        Wed,  2 Jan 2019 16:49:33 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 3/7] arm64: add sysfs vulnerability show for meltdown
Date:   Wed,  2 Jan 2019 18:49:17 -0600
Message-Id: <20190103004921.1928921-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103004921.1928921-1-jeremy.linton@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
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
 arch/arm64/kernel/cpufeature.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ab784d7a0083..1f64cbff8456 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -944,6 +944,9 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 	return has_cpuid_feature(entry, scope);
 }
 
+/* default value is invalid until unmap_kernel_at_el0() runs */
+static bool __meltdown_safe = true;
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
@@ -972,6 +975,12 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 {
 	char const *str = "command line option";
 
+	bool meltdown_safe = is_cpu_meltdown_safe() ||
+		has_cpuid_feature(entry, scope);
+
+	if (!meltdown_safe)
+		__meltdown_safe = false;
+
 	/*
 	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
 	 * ThunderX leads to apparent I-cache corruption of kernel text, which
@@ -993,11 +1002,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
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
@@ -2065,3 +2070,17 @@ static int __init enable_mrs_emulation(void)
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
+	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && __meltdown_safe)
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Unknown\n");
+}
+#endif
-- 
2.17.2

