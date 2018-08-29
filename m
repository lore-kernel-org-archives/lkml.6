Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5FD2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5FD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeH2Qk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:40:57 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:48127 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727590AbeH2Qk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:40:57 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAAXHpILlYZbBov_BA--.10S2;
        Wed, 29 Aug 2018 20:44:00 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 05/16] x86/pmu: enable Hygon support to PMU infrastructure
Date:   Wed, 29 Aug 2018 20:43:54 +0800
Message-Id: <dcd5b900e26e3175e4cafded91ec28e53c79adf8.1535459013.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAAXHpILlYZbBov_BA--.10S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48XFy5GF18Jr45GFyxGrg_yoWrGryxpr
        ZrArs5tr97uasrX3s8trWkXrWUZFykKayFgw45K34xAF15Z3s8Xr4Ikw1rtay5Wr95CFyr
        tw18uw48X3ykAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUo9NVDUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon PMU arch is similar to AMD Family 17h. To support Hygon PMU, the
initialization flow for it just call amd_pmu_init() and change PMU name
to "HYGON". To share AMD's flow, add code check for Hygon family ID 18h
to run the code path of AMD family 17h in core/uncore functions.

Also it returns the bit offset of the performance counter register and
event selection register for Hygon CPU in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/amd/core.c             |  6 ++++++
 arch/x86/events/amd/uncore.c           | 15 ++++++++++-----
 arch/x86/events/core.c                 |  4 ++++
 arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..6c13c9d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,12 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			pr_cont("Fam18h ");
+			/* Using default amd_get_event_constraints. */
+			break;
+		}
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..9f2eb43 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -507,17 +507,22 @@ static int __init amd_uncore_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	     boot_cpu_data.x86 == 0x17) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+	     boot_cpu_data.x86 == 0x18)) {
 		/*
-		 * For F17h, the Northbridge counters are repurposed as Data
-		 * Fabric counters. Also, L3 counters are supported too. The PMUs
-		 * are exported based on  family as either L2 or L3 and NB or DF.
+		 * For AMD F17h or Hygon F18h, the Northbridge counters are
+		 * repurposed as DataFabric counters. Also, L3 counters
+		 * are supported too. The PMUs are exported based on
+		 * family as either L2 or L3 and NB or DF.
 		 */
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f..93e026b 100644
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

