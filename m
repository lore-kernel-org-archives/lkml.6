Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556BC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D1D24E8C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D1D24E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeFXKVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:21:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:21:21 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX290-0003W6-UG; Sun, 24 Jun 2018 12:21:19 +0200
Date:   Sun, 24 Jun 2018 12:21:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241208130.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A set of fixes mostly for the ARM/GIC world:

  - Fix the MSI affinity handling in the ls-scfg irq chip driver so it
    updates and uses the effective affinity mask correctly

  - Prevent binding LPIs to offline CPUs and respect the Cavium erratum
    which requires that LPIs which belong to an offline NUMA node are not
    bound to a CPU on a different NUMA node.

  - Free only the amount of allocated interrupts in the GIC-V2M driver
    instead of trying to free log2(nrirqs).

  - Prevent emitting SYNC and VSYNC targetting non existing interrupt
    collections in the GIC-V3 ITS driver

  - Ensure that the GIV-V3 interrupt redistributor is correctly
    reprogrammed on CPU hotplug

  - Remove a stale unused helper function.
    
Thanks,

	tglx

------------------>
John Garry (1):
      irqdesc: Delete irq_desc_get_msi_desc()

Marc Zyngier (6):
      genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug
      irqchip/ls-scfg-msi: Fix MSI affinity handling
      irqchip/gic-v2m: Fix SPI release on error path
      irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection
      irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection
      irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug

Yang Yingliang (1):
      irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node


 drivers/irqchip/irq-gic-v2m.c     |  2 +-
 drivers/irqchip/irq-gic-v3-its.c  | 62 +++++++++++++++++++++++++++++++--------
 drivers/irqchip/irq-ls-scfg-msi.c | 10 +++++--
 include/linux/irq.h               |  1 +
 include/linux/irqdesc.h           |  5 ----
 kernel/irq/debugfs.c              |  1 +
 6 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 0f52d44b3f69..f5fe0100f9ff 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -199,7 +199,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 fail:
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	gicv2m_unalloc_msi(v2m, hwirq, get_count_order(nr_irqs));
+	gicv2m_unalloc_msi(v2m, hwirq, nr_irqs);
 	return err;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5377d7e2afba..d7842d312d3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -182,6 +182,22 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 	return its->collections + its_dev->event_map.col_map[event];
 }
 
+static struct its_collection *valid_col(struct its_collection *col)
+{
+	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(0, 15)))
+		return NULL;
+
+	return col;
+}
+
+static struct its_vpe *valid_vpe(struct its_node *its, struct its_vpe *vpe)
+{
+	if (valid_col(its->collections + vpe->col_idx))
+		return vpe;
+
+	return NULL;
+}
+
 /*
  * ITS command descriptors - parameters to be encoded in a command
  * block.
@@ -439,7 +455,7 @@ static struct its_collection *its_build_mapti_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_movi_cmd(struct its_node *its,
@@ -458,7 +474,7 @@ static struct its_collection *its_build_movi_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_discard_cmd(struct its_node *its,
@@ -476,7 +492,7 @@ static struct its_collection *its_build_discard_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_inv_cmd(struct its_node *its,
@@ -494,7 +510,7 @@ static struct its_collection *its_build_inv_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_int_cmd(struct its_node *its,
@@ -512,7 +528,7 @@ static struct its_collection *its_build_int_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_clear_cmd(struct its_node *its,
@@ -530,7 +546,7 @@ static struct its_collection *its_build_clear_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return col;
+	return valid_col(col);
 }
 
 static struct its_collection *its_build_invall_cmd(struct its_node *its,
@@ -554,7 +570,7 @@ static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vinvall_cmd.vpe;
+	return valid_vpe(its, desc->its_vinvall_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
@@ -576,7 +592,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmapp_cmd.vpe;
+	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
@@ -599,7 +615,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmapti_cmd.vpe;
+	return valid_vpe(its, desc->its_vmapti_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
@@ -622,7 +638,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmovi_cmd.vpe;
+	return valid_vpe(its, desc->its_vmovi_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
@@ -640,7 +656,7 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmovp_cmd.vpe;
+	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
 }
 
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
@@ -1824,11 +1840,16 @@ static int its_alloc_tables(struct its_node *its)
 
 static int its_alloc_collections(struct its_node *its)
 {
+	int i;
+
 	its->collections = kcalloc(nr_cpu_ids, sizeof(*its->collections),
 				   GFP_KERNEL);
 	if (!its->collections)
 		return -ENOMEM;
 
+	for (i = 0; i < nr_cpu_ids; i++)
+		its->collections[i].target_address = ~0ULL;
+
 	return 0;
 }
 
@@ -2310,7 +2331,14 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first(cpu_mask);
+	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
+		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
+			return -EINVAL;
+
+		cpu = cpumask_first(cpu_online_mask);
+	}
+
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3399,6 +3427,16 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world. Detect this case
+	 * by checking the allocation of the pending table for the
+	 * current CPU.
+	 */
+	if (gic_data_rdist()->pend_page)
+		return 0;
+
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 1ec3bfe56693..c671b3212010 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -93,8 +93,12 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
 	msg->data = data->hwirq;
 
-	if (msi_affinity_flag)
-		msg->data |= cpumask_first(data->common->affinity);
+	if (msi_affinity_flag) {
+		const struct cpumask *mask;
+
+		mask = irq_data_get_effective_affinity_mask(data);
+		msg->data |= cpumask_first(mask);
+	}
 
 	iommu_dma_map_msi_msg(data->irq, msg);
 }
@@ -121,7 +125,7 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
 		return -EINVAL;
 	}
 
-	cpumask_copy(irq_data->common->affinity, mask);
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
 }
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4bd2f34947f4..201de12a9957 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -503,6 +503,7 @@ struct irq_chip {
  * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 25b33b664537..dd1e40ddac7d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -145,11 +145,6 @@ static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 	return desc->irq_common_data.handler_data;
 }
 
-static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
-{
-	return desc->irq_common_data.msi_desc;
-}
-
 /*
  * Architectures call this to let the generic IRQ layer
  * handle an interrupt.
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4dadeb3d6666..6f636136cccc 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -55,6 +55,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SKIP_SET_WAKE),
 	BIT_MASK_DESCR(IRQCHIP_ONESHOT_SAFE),
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
+	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 };
 
 static void
