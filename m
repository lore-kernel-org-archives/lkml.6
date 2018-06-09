Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xCSEGcnWG1tjIwAAmS7hNA
	; Sat, 09 Jun 2018 13:32:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4BFB608BF; Sat,  9 Jun 2018 13:32:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62EEC6032D;
	Sat,  9 Jun 2018 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62EEC6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeFINc2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:32:28 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:44126 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753259AbeFINaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:30:21 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowABnnbmo1Btbt0ZEBA--.874S2;
        Sat, 09 Jun 2018 21:22:54 +0800 (CST)
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 04/11] x86/perf: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:22:42 +0800
Message-Id: <1528550562-28261-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowABnnbmo1Btbt0ZEBA--.874S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy8Cw4fGFW3ArWfAF4fKrg_yoW5GF1Upr
        yDJrs5tr93Wwn2qasxKFWxXr4UAFykKFsYg3yUGw17Ar4Uuw15Xr4Ikw1Fya98Gwn5XFyr
        ta10vr4UXa4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUw18BUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the AMD performance events support to Hygon
Family 18h CPU:
- Add Hygon Family 18h support in amd_core_pmu_init() and
  amd_uncore_init().
- Rename x86_pmu.name from "AMD" to "HYGON" on Hygon platforms.
- Add Hygon support in PMU init codes in init_hw_perf_events().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/amd/core.c   | 10 ++++++++++
 arch/x86/events/amd/uncore.c |  7 ++++---
 arch/x86/events/core.c       |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..59c7b57 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,13 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		pr_cont("Fam18h ");
+		/*
+		 * In family 18h, there are no event constraints in the PMC hardware.
+		 * We fallback to using default amd_get_event_constraints.
+		 */
+		break;
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
@@ -702,6 +709,9 @@ __init int amd_pmu_init(void)
 
 	x86_pmu = amd_pmu;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		x86_pmu.name = "HYGON";
+
 	ret = amd_core_pmu_init();
 	if (ret)
 		return ret;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f5cbbba..f8b0890 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -524,15 +524,16 @@ static int __init amd_uncore_init(void)
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
+		 * For F17h and F18h, the Northbridge counters are repurposed as Data
 		 * Fabric counters. Also, L3 counters are supported too. The PMUs
 		 * are exported based on  family as either L2 or L3 and NB or DF.
 		 */
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 45b2b1c..60efd9b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1773,6 +1773,7 @@ static int __init init_hw_perf_events(void)
 	case X86_VENDOR_INTEL:
 		err = intel_pmu_init();
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		err = amd_pmu_init();
 		break;
-- 
2.7.4
