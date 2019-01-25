Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C5C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B688C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfAYSHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:07:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51880 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfAYSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:07:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 630BE1713;
        Fri, 25 Jan 2019 10:07:32 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBF513F5AF;
        Fri, 25 Jan 2019 10:07:31 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 10/12] arm64: add sysfs vulnerability show for spectre v2
Date:   Fri, 25 Jan 2019 12:07:09 -0600
Message-Id: <20190125180711.1970973-11-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125180711.1970973-1-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to track whether all the cores in the machine are
vulnerable, and whether all the vulnerable cores have been
mitigated.

Once we have that information we can add the sysfs stub and
provide an accurate view of what is known about the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 024c83ffff99..caedf268c972 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -497,6 +497,10 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_RANGE_LIST(midr_list)
 
+/* Track overall mitigation state. We are only mitigated if all cores are ok */
+static bool __hardenbp_enab = true;
+static bool __spectrev2_safe = true;
+
 /*
  * List of CPUs that do not need any Spectre-v2 mitigation at all.
  */
@@ -507,6 +511,10 @@ static const struct midr_range spectre_v2_safe_list[] = {
 	{ /* sentinel */ }
 };
 
+/*
+ * Track overall bp hardening for all heterogeneous cores in the machine.
+ * We are only considered "safe" if all booted cores are known safe.
+ */
 static bool __maybe_unused
 check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -528,12 +536,19 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
 	if (!need_wa)
 		return false;
 
-	if (need_wa < 0)
+	__spectrev2_safe = false;
+
+	if (need_wa < 0) {
 		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
+		__hardenbp_enab = false;
+	}
 
 	/* forced off */
-	if (__nospectre_v2)
+	if (__nospectre_v2) {
+		pr_info_once("spectrev2 mitigation disabled by command line option\n");
+		__hardenbp_enab = false;
 		return false;
+	}
 
 	return (need_wa > 0);
 }
@@ -757,4 +772,16 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	if (__spectrev2_safe)
+		return sprintf(buf, "Not affected\n");
+
+	if (__hardenbp_enab)
+		return sprintf(buf, "Mitigation: Branch predictor hardening\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+
 #endif
-- 
2.17.2

