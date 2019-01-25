Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E68C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4189218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfAYSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:07:36 -0500
Received: from foss.arm.com ([217.140.101.70]:51888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfAYSHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:07:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E219EBD;
        Fri, 25 Jan 2019 10:07:33 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B65B33F5AF;
        Fri, 25 Jan 2019 10:07:32 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 11/12] arm64: add sysfs vulnerability show for speculative store bypass
Date:   Fri, 25 Jan 2019 12:07:10 -0600
Message-Id: <20190125180711.1970973-12-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125180711.1970973-1-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return status based on ssbd_state and the arm64 SSBS feature. If
the mitigation is disabled, or the firmware isn't responding then
return the expected machine state based on a new blacklist of known
vulnerable cores.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index caedf268c972..e9ae8e5fd7e1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -265,6 +265,7 @@ static int detect_harden_bp_fw(void)
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
 int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
+static bool __ssb_safe = true;
 
 static const struct ssbd_options {
 	const char	*str;
@@ -362,10 +363,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 {
 	struct arm_smccc_res res;
 	bool required = true;
+	bool is_vul;
 	s32 val;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
+	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
+
+	if (is_vul)
+		__ssb_safe = false;
+
 	if (this_cpu_has_cap(ARM64_SSBS)) {
 		required = false;
 		goto out_printmsg;
@@ -399,6 +406,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		return false;
 
+	/* machines with mixed mitigation requirements must not return this */
 	case SMCCC_RET_NOT_REQUIRED:
 		pr_info_once("%s mitigation not required\n", entry->desc);
 		ssbd_state = ARM64_SSBD_MITIGATED;
@@ -454,6 +462,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 	return required;
 }
 
+/* known vulnerable cores */
+static const struct midr_range arm64_ssb_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+	{},
+};
+
 static void __maybe_unused
 cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
@@ -743,6 +761,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_SSBD,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = has_ssbd_mitigation,
+		.midr_range_list = arm64_ssb_cpus,
 	},
 #ifdef CONFIG_ARM64_ERRATUM_1188873
 	{
@@ -784,4 +803,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Vulnerable\n");
 }
 
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	/*
+	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
+	 *  for hetrogenous machines, and that if SSBS is supported its
+	 *  supported by all cores.
+	 */
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_MITIGATED:
+		return sprintf(buf, "Not affected\n");
+
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		if (cpus_have_cap(ARM64_SSBS))
+			return sprintf(buf, "Not affected\n");
+		return sprintf(buf,
+			"Mitigation: Speculative Store Bypass disabled\n");
+	}
+
+	if (__ssb_safe)
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+
 #endif
-- 
2.17.2

