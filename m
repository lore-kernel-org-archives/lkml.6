Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeBRRdR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:33:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeBRRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:33:15 -0500
Date: Sun, 18 Feb 2018 18:33:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.16
Message-ID: <alpine.DEB.2.21.1802181831010.1549@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A small set of updates mostly for irq chip drivers:

  - A MIPS GIC fix for spurious, masked interrupts
  - A fix for a subtle IPI bug in GICv3
  - Do not probe GICv3 ITSs that are marked as disabled
  - Multi-MSI support for GICv2m
  - Various small cleanups

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Jaedon Shin (1):
      irqchip/bcm: Remove hashed address printing

Marc Zyngier (1):
      irqchip/gic-v2m: Add PCI Multi-MSI support

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Matt Redfearn (1):
      irqchip/mips-gic: Avoid spuriously handling masked interrupts

Shanker Donthineni (1):
      irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()

Stephen Boyd (1):
      irqchip/gic-v3: Ignore disabled ITS nodes


 drivers/irqchip/irq-bcm7038-l1.c                   |  3 --
 drivers/irqchip/irq-bcm7120-l2.c                   |  3 --
 drivers/irqchip/irq-brcmstb-l2.c                   |  3 --
 drivers/irqchip/irq-gic-v2m.c                      | 46 +++++++++++-----------
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |  2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      |  2 +
 drivers/irqchip/irq-gic-v3-its.c                   |  2 +
 drivers/irqchip/irq-gic-v3.c                       |  4 +-
 drivers/irqchip/irq-mips-gic.c                     |  2 -
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  2 +
 kernel/irq/irqdomain.c                             | 18 ++-------
 11 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 55cfb986225b..faf734ff4cf3 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -339,9 +339,6 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
-	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
-		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
-
 	return 0;
 
 out_unmap:
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640eba418..8968e5e93fcb 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,9 +318,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
-	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
-			intc_name, data->map_base[0], data->num_parent_irqs);
-
 	return 0;
 
 out_free_domain:
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 691d20eb0bec..0e65f609352e 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -262,9 +262,6 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
-	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
-			base, parent_irq);
-
 	return 0;
 
 out_free_domain:
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 993a8426a453..1ff38aff9f29 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -94,7 +94,7 @@ static struct irq_chip gicv2m_msi_irq_chip = {
 
 static struct msi_domain_info gicv2m_msi_domain_info = {
 	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX),
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &gicv2m_msi_irq_chip,
 };
 
@@ -155,18 +155,12 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
-static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq)
+static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
+			       int nr_irqs)
 {
-	int pos;
-
-	pos = hwirq - v2m->spi_start;
-	if (pos < 0 || pos >= v2m->nr_spis) {
-		pr_err("Failed to teardown msi. Invalid hwirq %d\n", hwirq);
-		return;
-	}
-
 	spin_lock(&v2m_lock);
-	__clear_bit(pos, v2m->bm);
+	bitmap_release_region(v2m->bm, hwirq - v2m->spi_start,
+			      get_count_order(nr_irqs));
 	spin_unlock(&v2m_lock);
 }
 
@@ -174,13 +168,13 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
 	struct v2m_data *v2m = NULL, *tmp;
-	int hwirq, offset, err = 0;
+	int hwirq, offset, i, err = 0;
 
 	spin_lock(&v2m_lock);
 	list_for_each_entry(tmp, &v2m_nodes, entry) {
-		offset = find_first_zero_bit(tmp->bm, tmp->nr_spis);
-		if (offset < tmp->nr_spis) {
-			__set_bit(offset, tmp->bm);
+		offset = bitmap_find_free_region(tmp->bm, tmp->nr_spis,
+						 get_count_order(nr_irqs));
+		if (offset >= 0) {
 			v2m = tmp;
 			break;
 		}
@@ -192,16 +186,21 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = v2m->spi_start + offset;
 
-	err = gicv2m_irq_gic_domain_alloc(domain, virq, hwirq);
-	if (err) {
-		gicv2m_unalloc_msi(v2m, hwirq);
-		return err;
-	}
+	for (i = 0; i < nr_irqs; i++) {
+		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto fail;
 
-	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-				      &gicv2m_irq_chip, v2m);
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &gicv2m_irq_chip, v2m);
+	}
 
 	return 0;
+
+fail:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	gicv2m_unalloc_msi(v2m, hwirq, get_count_order(nr_irqs));
+	return err;
 }
 
 static void gicv2m_irq_domain_free(struct irq_domain *domain,
@@ -210,8 +209,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *domain,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(d);
 
-	BUG_ON(nr_irqs != 1);
-	gicv2m_unalloc_msi(v2m, d->hwirq);
+	gicv2m_unalloc_msi(v2m, d->hwirq, nr_irqs);
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 14a8c0a7e095..25a98de5cfb2 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -132,6 +132,8 @@ static int __init its_pci_of_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 833a90fe33ae..8881a053c173 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -154,6 +154,8 @@ static void __init its_pmsi_of_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..1d3056f53747 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3314,6 +3314,8 @@ static int __init its_of_probe(struct device_node *node)
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%pOF: no msi-controller property, ITS ignored\n",
 				np);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a57c0fbbd34a..d99cc07903ec 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -673,7 +673,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	       MPIDR_TO_SGI_RS(cluster_id)		|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
 
-	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
+	pr_devel("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
 	gic_write_sgi1r(val);
 }
 
@@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ef92a4d2038e..d32268cc1174 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -424,8 +424,6 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	gic_clear_pcpu_masks(intr);
-	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	spin_unlock_irqrestore(&gic_lock, flags);
 
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 5064d5ddf581..fc2013aade51 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -73,6 +73,8 @@ static int __init its_fsl_mc_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e6a9c36470ee..82b8b18ee1eb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1726,25 +1726,14 @@ static int irq_domain_debug_show(struct seq_file *m, void *p)
 	irq_domain_debug_show_one(m, d, 0);
 	return 0;
 }
-
-static int irq_domain_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, irq_domain_debug_show, inode->i_private);
-}
-
-static const struct file_operations dfs_domain_ops = {
-	.open		= irq_domain_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(irq_domain_debug);
 
 static void debugfs_add_domain_dir(struct irq_domain *d)
 {
 	if (!d->name || !domain_dir || d->debugfs_file)
 		return;
 	d->debugfs_file = debugfs_create_file(d->name, 0444, domain_dir, d,
-					      &dfs_domain_ops);
+					      &irq_domain_debug_fops);
 }
 
 static void debugfs_remove_domain_dir(struct irq_domain *d)
@@ -1760,7 +1749,8 @@ void __init irq_domain_debugfs_init(struct dentry *root)
 	if (!domain_dir)
 		return;
 
-	debugfs_create_file("default", 0444, domain_dir, NULL, &dfs_domain_ops);
+	debugfs_create_file("default", 0444, domain_dir, NULL,
+			    &irq_domain_debug_fops);
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(d, &irq_domain_list, link)
 		debugfs_add_domain_dir(d);
