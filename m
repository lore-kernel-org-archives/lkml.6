Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeEULio (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:38:44 -0400
Received: from foss.arm.com ([217.140.101.70]:47562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbeEULfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:42 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 2/6] arm64: alternative: Apply alternatives early in boot process
Date: Mon, 21 May 2018 12:35:11 +0100
Message-Id: <1526902515-13769-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
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

Since alternatives are now applied at different times, provide function
to check whether alternatives are applied per feature.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry@arm.com: rename to fit new cpufeature framework better,
			 apply BOOT_SCOPE feature early in boot,
			 add per feature alternative checking]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/alternative.h |  5 +++--
 arch/arm64/include/asm/cpufeature.h  |  2 ++
 arch/arm64/kernel/alternative.c      | 39 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/cpufeature.c       |  7 ++++++-
 arch/arm64/kernel/smp.c              |  7 +++++++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index a91933b..36b0703 100644
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
@@ -27,9 +25,12 @@ struct alt_instr {
 typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);

+void __init apply_boot_alternatives(void);
 void __init apply_alternatives_all(void);
 void apply_alternatives(void *start, size_t length);

+bool feature_alternatives_applied(u16 cpufeature);
+
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
 	" .if " __stringify(cb) " == 0\n"				      \
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
index 5c4bce4..29885eb 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -34,6 +34,8 @@

 int alternatives_applied;

+DECLARE_BITMAP(alternatives_status, ARM64_NCAPS);
+
 struct alt_region {
 	struct alt_instr *begin;
 	struct alt_instr *end;
@@ -122,7 +124,8 @@ static void patch_alternative(struct alt_instr *alt,
 	}
 }

-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+static void __apply_alternatives(void *alt_region,  bool use_linear_alias,
+				 unsigned long feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -132,6 +135,9 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 	for (alt = region->begin; alt < region->end; alt++) {
 		int nr_inst;

+		if ((BIT(alt->cpufeature) & feature_mask) == 0)
+			continue;
+
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
 		    !cpus_have_cap(alt->cpufeature))
@@ -142,6 +148,8 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 		else
 			BUG_ON(alt->alt_len != alt->orig_len);

+		__set_bit(alt->cpufeature, alternatives_status);
+
 		pr_info_once("patching kernel code\n");

 		origptr = ALT_ORIG_PTR(alt);
@@ -178,7 +186,9 @@ static int __apply_alternatives_multi_stop(void *unused)
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
@@ -192,6 +202,24 @@ void __init apply_alternatives_all(void)
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
@@ -199,5 +227,10 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};

-	__apply_alternatives(&region, false);
+	__apply_alternatives(&region, false, -1);
+}
+
+bool feature_alternatives_applied(u16 cpufeature)
+{
+	return test_bit(cpufeature, alternatives_status);
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e03e897..021ae87 100644
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
@@ -1021,7 +1023,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
 	 * do anything here.
 	 */
-	if (!alternatives_applied)
+	if (!feature_alternatives_applied(ARM64_HAS_VIRT_HOST_EXTN))
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
 #endif
@@ -1346,6 +1348,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
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
