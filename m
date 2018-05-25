Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965891AbeEYJuI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:50:08 -0400
Received: from foss.arm.com ([217.140.101.70]:57430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965853AbeEYJuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:06 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 04/26] arm64: alternative: Apply alternatives early in boot process
Date: Fri, 25 May 2018 10:49:10 +0100
Message-Id: <1527241772-48007-5-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/alternative.h |  3 +--
 arch/arm64/include/asm/cpufeature.h  |  2 ++
 arch/arm64/kernel/alternative.c      | 30 +++++++++++++++++++++++++++---
 arch/arm64/kernel/cpufeature.c       |  5 +++++
 arch/arm64/kernel/smp.c              |  7 +++++++
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index a91933b..9fc938f 100644
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
 void apply_alternatives(void *start, size_t length);
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 09b0f2a..19efe4e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -359,6 +359,8 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+extern unsigned long boot_capabilities;
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4..3f540ff 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -122,7 +122,8 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }
 
-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+static void __apply_alternatives(void *alt_region,  bool use_linear_alias,
+				 unsigned long feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -132,6 +133,9 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;
 
+		if ((BIT(alt->cpufeature) & feature_mask) == 0)
+			continue;
+
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
 		    !cpus_have_cap(alt->cpufeature))
@@ -178,7 +182,9 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(alternatives_applied);
-		__apply_alternatives(&region, true);
+
+		__apply_alternatives(&region, true, ~boot_capabilities);
+
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(alternatives_applied, 1);
 	}
@@ -192,6 +198,24 @@ void __init apply_alternatives_all(void)
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
+	__apply_alternatives(&region, true, boot_capabilities);
+}
+
 void apply_alternatives(void *start, size_t length)
 {
 	struct alt_region region = {
@@ -199,5 +223,5 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region, false);
+	__apply_alternatives(&region, false, -1);
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a3a5585d..7a4f602 100644
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
@@ -1370,6 +1372,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 		if (!cpus_have_cap(caps->capability) && caps->desc)
 			pr_info("%s %s\n", info, caps->desc);
 		cpus_set_cap(caps->capability);
+
+		if (scope_mask & SCOPE_BOOT_CPU)
+			__set_bit(caps->capability, &boot_capabilities);
 	}
 }
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f3e2e3a..b7fb909 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -410,6 +410,13 @@ void __init smp_prepare_boot_cpu(void)
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
