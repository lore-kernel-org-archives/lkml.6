Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64920C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D3C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfAaO7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:59:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732949AbfAaO7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:59:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1E4315AD;
        Thu, 31 Jan 2019 06:59:51 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1F3F3F59C;
        Thu, 31 Jan 2019 06:59:49 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v10 15/25] arm64: alternative: Apply alternatives early in boot process
Date:   Thu, 31 Jan 2019 14:58:53 +0000
Message-Id: <1548946743-38979-16-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/alternative.h |  1 +
 arch/arm64/include/asm/cpufeature.h  |  4 ++++
 arch/arm64/kernel/alternative.c      | 43 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c       |  6 +++++
 arch/arm64/kernel/smp.c              |  7 ++++++
 5 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 9806a23..b9f8d78 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -25,6 +25,7 @@ struct alt_instr {
 typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
+void __init apply_boot_alternatives(void);
 void __init apply_alternatives_all(void);
 bool alternative_is_applied(u16 cpufeature);
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89c3f31..e505e1f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -391,6 +391,10 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+/* ARM64 CAPS + alternative_cb */
+#define ARM64_NPATCHABLE (ARM64_NCAPS + 1)
+extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
+
 #define for_each_available_cap(cap)		\
 	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
 
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index c947d22..a9b4677 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -155,7 +155,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region, bool is_module)
+static void __apply_alternatives(void *alt_region,  bool is_module,
+				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -165,6 +166,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;
 
+		if (!test_bit(alt->cpufeature, feature_mask))
+			continue;
+
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
 		    !cpus_have_cap(alt->cpufeature))
@@ -203,8 +207,11 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		__flush_icache_all();
 		isb();
 
-		/* We applied all that was available */
-		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
+		/* Ignore ARM64_CB bit from feature mask */
+		bitmap_or(applied_alternatives, applied_alternatives,
+			  feature_mask, ARM64_NCAPS);
+		bitmap_and(applied_alternatives, applied_alternatives,
+			   cpu_hwcaps, ARM64_NCAPS);
 	}
 }
 
@@ -225,8 +232,13 @@ static int __apply_alternatives_multi_stop(void *unused)
 			cpu_relax();
 		isb();
 	} else {
+		DECLARE_BITMAP(remaining_capabilities, ARM64_NPATCHABLE);
+
+		bitmap_complement(remaining_capabilities, boot_capabilities,
+				  ARM64_NPATCHABLE);
+
 		BUG_ON(all_alternatives_applied);
-		__apply_alternatives(&region, false);
+		__apply_alternatives(&region, false, remaining_capabilities);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(all_alternatives_applied, 1);
 	}
@@ -240,6 +252,24 @@ void __init apply_alternatives_all(void)
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
+	__apply_alternatives(&region, false, &boot_capabilities[0]);
+}
+
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length)
 {
@@ -247,7 +277,10 @@ void apply_alternatives_module(void *start, size_t length)
 		.begin	= start,
 		.end	= start + length,
 	};
+	DECLARE_BITMAP(all_capabilities, ARM64_NPATCHABLE);
+
+	bitmap_fill(all_capabilities, ARM64_NPATCHABLE);
 
-	__apply_alternatives(&region, true);
+	__apply_alternatives(&region, true, &all_capabilities[0]);
 }
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d607ea3..b530fb24 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -54,6 +54,9 @@
 EXPORT_SYMBOL(cpu_hwcaps);
 static struct arm64_cpu_capabilities const __ro_after_init *cpu_hwcaps_ptrs[ARM64_NCAPS];
 
+/* Need also bit for ARM64_CB_PATCH */
+DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -1677,6 +1680,9 @@ static void update_cpu_capabilities(u16 scope_mask)
 		if (caps->desc)
 			pr_info("detected: %s\n", caps->desc);
 		cpus_set_cap(caps->capability);
+
+		if ((scope_mask & SCOPE_BOOT_CPU) && (caps->type & SCOPE_BOOT_CPU))
+			set_bit(caps->capability, boot_capabilities);
 	}
 }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..a944edd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -419,6 +419,13 @@ void __init smp_prepare_boot_cpu(void)
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

