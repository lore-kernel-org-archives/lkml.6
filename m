Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E19EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214D214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D214D214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeIQS6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:58:05 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:57557 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728373AbeIQS6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:58:05 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAAnjx52rJ9bo6+lCg--.114S2;
        Mon, 17 Sep 2018 21:30:34 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 05/16] perf/x86: Add Hygon Dhyana support to PMU infrastructure
Date:   Mon, 17 Sep 2018 21:30:28 +0800
Message-Id: <9d93ed54a975f33ef7247e0967960f4ce5d3d990.1537182523.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAAnjx52rJ9bo6+lCg--.114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfAr15Cw4fWF18Zr4kXrb_yoWrAr1fpr
        WqyFs3tr92g3ZxXa45JrykWrWUZFykKayF93y5G34xJF4Uu343Xr4Ikw1rta98GryfAryF
        qa18ur48WayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
        AIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG1v3UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU architecture for Hygon Dhyana CPU is similar to the AMD Family
17h one. To support Hygon Dhyana PMU, call amd_pmu_init() to share
AMD PMU initialization flow, and change the PMU name to "HYGON".

The Hygon Dhyana CPU supports both legacy and extension PMC MSRs(perf
counter registers and event selection registers), so add Hygon Dhyana
support in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/amd/core.c             |  4 ++++
 arch/x86/events/amd/uncore.c           | 20 +++++++++++++-------
 arch/x86/events/core.c                 |  4 ++++
 arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..7d2d7c8 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,10 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		pr_cont("Fam18h ");
+		/* Using default amd_get_event_constraints. */
+		break;
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..c7d745b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -507,17 +507,19 @@ static int __init amd_uncore_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17) {
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
 		/*
-		 * For F17h, the Northbridge counters are repurposed as Data
-		 * Fabric counters. Also, L3 counters are supported too. The PMUs
-		 * are exported based on  family as either L2 or L3 and NB or DF.
+		 * For F17h or F18h, the Northbridge counters are
+		 * repurposed as Data Fabric counters. Also, L3
+		 * counters are supported too. The PMUs are exported
+		 * based on family as either L2 or L3 and NB or DF.
 		 */
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
@@ -547,7 +549,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
-		pr_info("AMD NB counters detected\n");
+		pr_info("%s NB counters detected\n",
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
+				"HYGON" : "AMD");
 		ret = 0;
 	}
 
@@ -561,7 +565,9 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_llc;
 
-		pr_info("AMD LLC counters detected\n");
+		pr_info("%s LLC counters detected\n",
+			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?
+				"HYGON" : "AMD");
 		ret = 0;
 	}
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c..9c562f5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1776,6 +1776,10 @@ static int __init init_hw_perf_events(void)
 	case X86_VENDOR_AMD:
 		err = amd_pmu_init();
 		break;
+	case X86_VENDOR_HYGON:
+		err = amd_pmu_init();
+		x86_pmu.name = "HYGON";
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083..9556930 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -46,6 +46,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the performance counter register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
@@ -74,6 +75,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the event selection register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
-- 
2.7.4

