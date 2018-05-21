Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeEULiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:38:24 -0400
Received: from foss.arm.com ([217.140.101.70]:47610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752855AbeEULfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:35:50 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, christoffer.dall@arm.com, james.morse@arm.com,
        joelaf@google.com, joel.opensrc@gmail.com, daniel.thompson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v3 5/6] arm64: Detect current view of GIC priorities
Date: Mon, 21 May 2018 12:35:14 +0100
Message-Id: <1526902515-13769-6-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values non secure EL1 needs to use for PMR and RPR registers depends on
the value of SCR_EL3.FIQ.

The values non secure EL1 sees from the distributor and redistributor
depend on whether security is enabled for the GIC or not.

Figure out what values we are dealing with to know if the values we use for
PMR and RPR match the priority values that have been configured in the
distributor and redistributors.

Also, add firmware requirements related to SCR_EL3.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt |  5 +++
 arch/arm64/include/asm/sysreg.h |  1 +
 drivers/irqchip/irq-gic-v3.c    | 99 ++++++++++++++++++++++++++++++-----------
 3 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8d0df62..e387938 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -188,6 +188,11 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.

+  - SCR_EL3.FIQ must have the same value across all CPUs the kernel is
+    executing on.
+  - The value of SCR_EL3.FIQ must be the same as the one present at boot
+    time whenever the kernel is executing.
+
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
     ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178..fb8320a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -322,6 +322,7 @@
 #define SYS_ICC_SRE_EL1			sys_reg(3, 0, 12, 12, 5)
 #define SYS_ICC_IGRPEN0_EL1		sys_reg(3, 0, 12, 12, 6)
 #define SYS_ICC_IGRPEN1_EL1		sys_reg(3, 0, 12, 12, 7)
+#define SYS_ICC_RPR_EL1			sys_reg(3, 0, 12, 11, 3)

 #define SYS_CONTEXTIDR_EL1		sys_reg(3, 0, 13, 0, 1)
 #define SYS_TPIDR_EL1			sys_reg(3, 0, 13, 0, 4)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 82cfacf..3c44918 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -63,6 +63,30 @@ struct gic_chip_data {
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * The behaviours of RPR and PMR registers differ depending on the value of
+ * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
+ * distributor and redistributors depends on whether security is enabled in the
+ * GIC.
+ *
+ * When security is enabled, non-secure priority values from the (re)distributor
+ * are presented to the GIC CPUIF as follow:
+ *     (GIC_(R)DIST_PRI[irq] >> 1) | 0x80;
+ *
+ * If SCR_EL3.FIQ == 1, the values writen to/read from PMR and RPR at non-secure
+ * EL1 are subject to a similar operation thus matching the priorities presented
+ * from the (re)distributor when security is enabled.
+ *
+ * see GICv3/GICv4 Architecture Specification (IHI0069D):
+ * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
+ *   priorities.
+ * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
+ *   interrupt.
+ */
+DEFINE_STATIC_KEY_FALSE(have_non_secure_prio_view);
+#endif
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);

@@ -531,28 +555,26 @@ static void gic_update_vlpi_properties(void)
 		!gic_data.rdists.has_direct_lpi ? "no " : "");
 }

-static void gic_cpu_sys_reg_init(void)
+/* Check whether it's single security state view */
+static inline bool gic_dist_security_disabled(void)
 {
-	int i, cpu = smp_processor_id();
-	u64 mpidr = cpu_logical_map(cpu);
-	u64 need_rss = MPIDR_RS(mpidr);
-	bool group0;
-	u32 val, pribits;
+	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+}

-	/*
-	 * Need to check that the SRE bit has actually been set. If
-	 * not, it means that SRE is disabled at EL2. We're going to
-	 * die painfully, and there is nothing we can do about it.
-	 *
-	 * Kindly inform the luser.
-	 */
-	if (!gic_enable_sre())
-		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
+static inline u32 gic_get_cpu_pri_bits(void)
+{
+	u32 pribits;

 	pribits = gic_read_ctlr();
 	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
 	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	pribits++;
+
+	return pribits + 1;
+}
+
+static inline bool gic_cpu_has_group0(void)
+{
+	u32 pmr_val;

 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -565,13 +587,41 @@ static void gic_cpu_sys_reg_init(void)
 	 * becomes 0x80. Reading it back returns 0, indicating that
 	 * we're don't have access to Group0.
 	 */
-	write_gicreg(BIT(8 - pribits), ICC_PMR_EL1);
-	val = read_gicreg(ICC_PMR_EL1);
-	group0 = val != 0;
+	write_gicreg(BIT(8 - gic_get_cpu_pri_bits()), ICC_PMR_EL1);
+	pmr_val = read_gicreg(ICC_PMR_EL1);
+
+	return pmr_val != 0;
+}
+
+static void gic_cpu_sys_reg_init(void)
+{
+	int i, cpu = smp_processor_id();
+	u64 mpidr = cpu_logical_map(cpu);
+	u64 need_rss = MPIDR_RS(mpidr);
+	bool group0;
+	u32 pribits;
+
+	/*
+	 * Need to check that the SRE bit has actually been set. If
+	 * not, it means that SRE is disabled at EL2. We're going to
+	 * die painfully, and there is nothing we can do about it.
+	 *
+	 * Kindly inform the luser.
+	 */
+	if (!gic_enable_sre())
+		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
+
+	pribits = gic_get_cpu_pri_bits();
+
+	group0 = gic_cpu_has_group0();

 #ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	/* Set priority mask register */
 	write_gicreg(ICC_PMR_EL1_UNMASKED, ICC_PMR_EL1);
+#else
+	if (static_branch_likely(&have_non_secure_prio_view) && group0)
+		/* Mismatch configuration with boot CPU */
+		WARN_ON(group0 && !gic_dist_security_disabled());
 #endif

 	/*
@@ -825,12 +875,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif

 #ifdef CONFIG_CPU_PM
-/* Check whether it's single security state view */
-static bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
-
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
@@ -1130,6 +1174,11 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_cpu_init();
 	gic_cpu_pm_init();

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	if (!gic_cpu_has_group0() || gic_dist_security_disabled())
+		static_branch_enable(&have_non_secure_prio_view);
+#endif
+
 	return 0;

 out_free:
--
1.9.1
