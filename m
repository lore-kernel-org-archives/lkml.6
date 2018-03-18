Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeCRKtz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 06:49:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58344 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCRKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 06:49:54 -0400
Date: Sun, 18 Mar 2018 11:49:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq fixes for 4.16
Message-ID: <alpine.DEB.2.21.1803181144430.1509@nanos.tec.linutronix.de>
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

Three fixes for irq chip drivers:

  - Make sure the allocations in the GIC-V3 ITS driver are large enough to
    accomodate the interrupt space

  - Fix a misplaced __iomem annotation which causes a splat of 26 sparse warnings

  - Remove an unused function in the IMX GPCV2 driver which causes build warnings

Thanks,

	tglx

------------------>
Ard Biesheuvel (1):
      irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Fabio Estevam (1):
      irqchip/irq-imx-gpcv2: Remove unused function

Robin Murphy (1):
      irqchip/gic-v3-its: Fix misplaced __iomem annotations


 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++-------
 drivers/irqchip/irq-imx-gpcv2.c  | 14 --------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f53747..2cbb19cddbf8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1412,7 +1412,7 @@ static struct irq_chip its_irq_chip = {
  * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
  */
 #define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 #define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static unsigned long *lpi_bitmap;
@@ -2119,11 +2119,10 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
-	 * At least one bit of EventID is being used, hence a minimum
-	 * of two entries. No, the architecture doesn't let you
-	 * express an ITT with a single entry.
+	 * We allocate at least one chunk worth of LPIs bet device,
+	 * and thus that many ITEs. The device may require less though.
 	 */
-	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
+	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
@@ -2495,7 +2494,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 
 static void its_vpe_schedule(struct its_vpe *vpe)
 {
-	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u64 val;
 
 	/* Schedule the VPE */
@@ -2527,7 +2526,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
-	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
 	u64 val;
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 675eda5ff2b8..4760307ab43f 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -28,20 +28,6 @@ struct gpcv2_irqchip_data {
 
 static struct gpcv2_irqchip_data *imx_gpcv2_instance;
 
-/*
- * Interface for the low level wakeup code.
- */
-u32 imx_gpcv2_get_wakeup_source(u32 **sources)
-{
-	if (!imx_gpcv2_instance)
-		return 0;
-
-	if (sources)
-		*sources = imx_gpcv2_instance->wakeup_sources;
-
-	return IMR_NUM;
-}
-
 static int gpcv2_wakeup_source_save(void)
 {
 	struct gpcv2_irqchip_data *cd;
