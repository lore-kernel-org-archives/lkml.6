Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeCZVZC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:25:02 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:50392 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCZVWC (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:02 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/6] drivers/irqchip: Update supports_deactivate static key to modern api
Date: Mon, 26 Mar 2018 14:09:25 -0700
Message-Id: <20180326210929.5244-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in semantics -- key init is true; replace

static_key_slow_dec       with   static_branch_disable
static_key_true           with   static_branch_likely

The first is because we never actually do any couterpart incs,
thus there is really no reference counting semantics going on.
Use the more proper static_branch_disable() construct.

Also added a '_key' suffix to supports_deactivate, for better
self documentation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++----------
 drivers/irqchip/irq-gic.c    | 22 +++++++++++-----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 56c8de84a72b..e5d101418390 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -61,7 +61,7 @@ struct gic_chip_data {
 };
 
 static struct gic_chip_data gic_data __read_mostly;
-static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
+static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
@@ -354,7 +354,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 			int err;
 
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				gic_write_eoir(irqnr);
 			else
 				isb();
@@ -362,7 +362,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			err = handle_domain_irq(gic_data.domain, irqnr, regs);
 			if (err) {
 				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_key_true(&supports_deactivate)) {
+				if (static_branch_likely(&supports_deactivate_key)) {
 					if (irqnr < 8192)
 						gic_write_dir(irqnr);
 				} else {
@@ -373,7 +373,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		}
 		if (irqnr < 16) {
 			gic_write_eoir(irqnr);
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
 			/*
@@ -576,7 +576,7 @@ static void gic_cpu_sys_reg_init(void)
 	 */
 	gic_write_bpr1(0);
 
-	if (static_key_true(&supports_deactivate)) {
+	if (static_branch_likely(&supports_deactivate_key)) {
 		/* EOI drops priority only (mode 1) */
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop);
 	} else {
@@ -884,7 +884,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct irq_chip *chip = &gic_chip;
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
 
 	/* SGIs are private to the core kernel */
@@ -1075,9 +1075,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	int err;
 
 	if (!is_hyp_mode_available())
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
 	gic_data.fwnode = handle;
@@ -1312,7 +1312,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_of_setup_kvm_info(node);
 	return 0;
 
@@ -1614,7 +1614,7 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
 	return 0;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ac2e62d613d1..ced10c44b68a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -121,7 +121,7 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
 #define NR_GIC_CPU_IF 8
 static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
-static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
+static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
 static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
 
@@ -361,7 +361,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (likely(irqnr > 15 && irqnr < 1020)) {
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 			isb();
 			handle_domain_irq(gic->domain, irqnr, regs);
@@ -369,7 +369,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		}
 		if (irqnr < 16) {
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
 #ifdef CONFIG_SMP
 			/*
@@ -466,7 +466,7 @@ static void gic_cpu_if_up(struct gic_chip_data *gic)
 	u32 mode = 0;
 	int i;
 
-	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
+	if (gic == &gic_data[0] && static_branch_likely(&supports_deactivate_key))
 		mode = GIC_CPU_CTRL_EOImodeNS;
 
 	if (gic_check_gicv2(cpu_base))
@@ -1219,11 +1219,11 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 					  "irqchip/arm/gic:starting",
 					  gic_starting_cpu, NULL);
 		set_handle_irq(gic_handle_irq);
-		if (static_key_true(&supports_deactivate))
+		if (static_branch_likely(&supports_deactivate_key))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
 
-	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
+	if (static_branch_likely(&supports_deactivate_key) && gic == &gic_data[0]) {
 		name = kasprintf(GFP_KERNEL, "GICv2");
 		gic_init_chip(gic, NULL, name, true);
 	} else {
@@ -1250,7 +1250,7 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
-	static_key_slow_dec(&supports_deactivate);
+	static_branch_disable(&supports_deactivate_key);
 
 	gic = &gic_data[gic_nr];
 	gic->raw_dist_base = dist_base;
@@ -1430,7 +1430,7 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (ret)
 		return;
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_set_kvm_info(&gic_v2_kvm_info);
 }
 
@@ -1457,7 +1457,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	 * or the CPU interface is too small.
 	 */
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
 	ret = __gic_init_bases(gic, -1, &node->fwnode);
 	if (ret) {
@@ -1638,7 +1638,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	 * interface will always be the right size.
 	 */
 	if (!is_hyp_mode_available())
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
@@ -1663,7 +1663,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
 	return 0;
-- 
2.13.6
