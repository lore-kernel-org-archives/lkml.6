Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E856C20893
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E856C20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeGWO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:29:39 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:52155 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388190AbeGWO3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:37 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_5sl1lVbkm7cEA--.63S12;
        Mon, 23 Jul 2018 21:21:26 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 10/17] x86/events: enable Hygon support to PMU infrastructure
Date:   Mon, 23 Jul 2018 21:20:30 +0800
Message-Id: <1532352037-7151-11-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
X-CM-TRANSID: qwCowAD3_5sl1lVbkm7cEA--.63S12
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UCFyUZr1kJw1DCFyDWrg_yoW5Jw43pr
        9rArs3tr97WasIq3s8try8Wr4UZFykGF4Fg3y8Gw17AF4UZw15Xr4Ikw1Fya98Jas5Ja4f
        ta109r4UXFyqvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWx
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5hX
        o3UUUUU==
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

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/amd/core.c   |  4 ++++
 arch/x86/events/amd/uncore.c | 12 +++++++-----
 arch/x86/events/core.c       |  4 ++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..d2b29bf 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,10 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		pr_cont("Fam18h ");
+		/* Fallback to using default amd_get_event_constraints. */
+		break;
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..92ea280 100644
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
-- 
2.7.4

