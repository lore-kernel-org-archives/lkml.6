Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04A0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEB62084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEB62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH1ToN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:44:13 -0400
Received: from foss.arm.com ([217.140.101.70]:40936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1ToM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:44:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 015C11682;
        Tue, 28 Aug 2018 08:51:56 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E42403F557;
        Tue, 28 Aug 2018 08:51:53 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in boot process
Date:   Tue, 28 Aug 2018 16:51:13 +0100
Message-Id: <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently alternatives are applied very late in the boot process (and
a long time after we enable scheduling). Some alternative sequences,
such as those that alter the way CPU context is stored, must be applied
much earlier in the boot sequence.

Introduce apply_boot_alternatives() to allow some alternatives to be
applied immediately after we detect the CPU features of the boot CPU.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry@arm.com: rename to fit new cpufeature framework better,
			 apply BOOT_SCOPE feature early in boot]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/alternative.h |  3 +--
 arch/arm64/include/asm/cpufeature.h  |  2 ++
 arch/arm64/kernel/alternative.c      | 28 +++++++++++++++++++++++++---
 arch/arm64/kernel/cpufeature.c       |  5 +++++
 arch/arm64/kernel/smp.c              |  7 +++++++
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec..17f4554 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -14,8 +14,6 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-extern int alternatives_applied;
-
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
 	s32 alt_offset;		/* offset to replacement instruction */
@@ -27,6 +25,7 @@ struct alt_instr {
 typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
+void __init apply_boot_alternatives(void);
 void __init apply_alternatives_all(void);
 
 #ifdef CONFIG_MODULES
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1..e6c030a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -357,6 +357,8 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+extern unsigned long boot_capabilities;
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b5d6039..70c2604 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -145,7 +145,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region, bool is_module)
+static void __apply_alternatives(void *alt_region,  bool is_module,
+				 unsigned long feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -155,6 +156,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;
 
+		if ((BIT(alt->cpufeature) & feature_mask) == 0)
+			continue;
+
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
 		    !cpus_have_cap(alt->cpufeature))
@@ -213,7 +217,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(alternatives_applied);
-		__apply_alternatives(&region, false);
+		__apply_alternatives(&region, false, ~boot_capabilities);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(alternatives_applied, 1);
 	}
@@ -227,6 +231,24 @@ void __init apply_alternatives_all(void)
 	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
 }
 
+/*
+ * This is called very early in the boot process (directly after we run
+ * a feature detect on the boot CPU). No need to worry about other CPUs
+ * here.
+ */
+void __init apply_boot_alternatives(void)
+{
+	struct alt_region region = {
+		.begin	= (struct alt_instr *)__alt_instructions,
+		.end	= (struct alt_instr *)__alt_instructions_end,
+	};
+
+	/* If called on non-boot cpu things could go wrong */
+	WARN_ON(smp_processor_id() != 0);
+
+	__apply_alternatives(&region, false, boot_capabilities);
+}
+
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length)
 {
@@ -235,6 +257,6 @@ void apply_alternatives_module(void *start, size_t length)
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region, true);
+	__apply_alternatives(&region, true, -1);
 }
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3bc1c8b..0d1e41e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -52,6 +52,8 @@
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
 
+unsigned long boot_capabilities;
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 		if (!cpus_have_cap(caps->capability) && caps->desc)
 			pr_info("%s %s\n", info, caps->desc);
 		cpus_set_cap(caps->capability);
+
+		if (caps->type & SCOPE_BOOT_CPU)
+			__set_bit(caps->capability, &boot_capabilities);
 	}
 }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 25fcd22..22c9a0a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -414,6 +414,13 @@ void __init smp_prepare_boot_cpu(void)
 	 */
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
+
+	/*
+	 * We now know enough about the boot CPU to apply the
+	 * alternatives that cannot wait until interrupt handling
+	 * and/or scheduling is enabled.
+	 */
+	apply_boot_alternatives();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
1.9.1

