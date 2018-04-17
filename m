Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeDQVa1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:30:27 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54224 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbeDQV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:24 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 01/13] soc: ti: K2G: enhancement to support QMSS in K2G NAVSS
Date: Tue, 17 Apr 2018 17:30:30 -0400
Message-ID: <1524000642-23944-2-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Navigator Subsystem (NAVSS) available on K2G SoC has a cut down
version of QMSS with less number of queues, internal linking ram
with lesser number of buffers etc.  It doesn't have status and
explicit push register space as in QMSS available on other K2 SoCs.
So define reg indices specific to QMSS on K2G. This patch introduces
"ti,66ak2g-navss-qm" compatibility to identify QMSS on K2G NAVSS
and to customize the dts handling code. Per Device manual,
descriptors with index less than or equal to regions0_size is in region 0
in the case of K2 QMSS where as for QMSS on K2G, descriptors with index
less than regions0_size is in region 0. So update the size accordingly in
the regions0_size bits of the linking ram size 0 register.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |  9 ++-
 drivers/soc/ti/knav_qmss.h                         |  6 ++
 drivers/soc/ti/knav_qmss_queue.c                   | 90 ++++++++++++++++------
 3 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
index 77cd42c..b025770 100644
--- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
@@ -17,7 +17,8 @@ pool management.
 
 
 Required properties:
-- compatible	: Must be "ti,keystone-navigator-qmss";
+- compatible	: Must be "ti,keystone-navigator-qmss".
+		: Must be "ti,66ak2g-navss-qm" for QMSS on K2G SoC.
 - clocks	: phandle to the reference clock for this device.
 - queue-range	: <start number> total range of queue numbers for the device.
 - linkram0	: <address size> for internal link ram, where size is the total
@@ -39,6 +40,12 @@ Required properties:
 			  - Descriptor memory setup region.
 			  - Queue Management/Queue Proxy region for queue Push.
 			  - Queue Management/Queue Proxy region for queue Pop.
+
+For QMSS on K2G SoC, following QM reg indexes are used in that order
+			  - Queue Peek region.
+			  - Queue configuration region.
+			  - Queue Management/Queue Proxy region for queue Push/Pop.
+
 - queue-pools	: child node classifying the queue ranges into pools.
 		  Queue ranges are grouped into 3 type of pools:
 		  - qpend	    : pool of qpend(interruptible) queues
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 905b974..56866ba4 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -292,6 +292,11 @@ struct knav_queue {
 	struct list_head		list;
 };
 
+enum qmss_version {
+	QMSS,
+	QMSS_66AK2G,
+};
+
 struct knav_device {
 	struct device				*dev;
 	unsigned				base_id;
@@ -305,6 +310,7 @@ struct knav_device {
 	struct list_head			pools;
 	struct list_head			pdsps;
 	struct list_head			qmgrs;
+	enum qmss_version			version;
 };
 
 struct knav_range_ops {
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 77d6b5c..8526c8e 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -42,6 +42,15 @@
 #define KNAV_QUEUE_PUSH_REG_INDEX	4
 #define KNAV_QUEUE_POP_REG_INDEX	5
 
+/* Queue manager register indices in DTS for QMSS in K2G NAVSS.
+ * There are no status and vbusm push registers on this version
+ * of QMSS. Push registers are same as pop, So all indices above 1
+ * are to be re-defined
+ */
+#define KNAV_L_QUEUE_CONFIG_REG_INDEX	1
+#define KNAV_L_QUEUE_REGION_REG_INDEX	2
+#define KNAV_L_QUEUE_PUSH_REG_INDEX	3
+
 /* PDSP register indices in DTS */
 #define KNAV_QUEUE_PDSP_IRAM_REG_INDEX	0
 #define KNAV_QUEUE_PDSP_REGS_REG_INDEX	1
@@ -1169,8 +1178,12 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
 		dev_dbg(kdev->dev, "linkram0: dma:%pad, virt:%p, size:%x\n",
 			&block->dma, block->virt, block->size);
 		writel_relaxed((u32)block->dma, &qmgr->reg_config->link_ram_base0);
-		writel_relaxed(block->size, &qmgr->reg_config->link_ram_size0);
-
+		if (kdev->version == QMSS_66AK2G)
+			writel_relaxed(block->size,
+				       &qmgr->reg_config->link_ram_size0);
+		else
+			writel_relaxed(block->size - 1,
+				       &qmgr->reg_config->link_ram_size0);
 		block++;
 		if (!block->size)
 			continue;
@@ -1387,42 +1400,64 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 		qmgr->reg_peek =
 			knav_queue_map_reg(kdev, child,
 					   KNAV_QUEUE_PEEK_REG_INDEX);
-		qmgr->reg_status =
-			knav_queue_map_reg(kdev, child,
-					   KNAV_QUEUE_STATUS_REG_INDEX);
+
+		if (kdev->version == QMSS) {
+			qmgr->reg_status =
+				knav_queue_map_reg(kdev, child,
+						   KNAV_QUEUE_STATUS_REG_INDEX);
+		}
+
 		qmgr->reg_config =
 			knav_queue_map_reg(kdev, child,
+					   (kdev->version == QMSS_66AK2G) ?
+					   KNAV_L_QUEUE_CONFIG_REG_INDEX :
 					   KNAV_QUEUE_CONFIG_REG_INDEX);
 		qmgr->reg_region =
 			knav_queue_map_reg(kdev, child,
+					   (kdev->version == QMSS_66AK2G) ?
+					   KNAV_L_QUEUE_REGION_REG_INDEX :
 					   KNAV_QUEUE_REGION_REG_INDEX);
+
 		qmgr->reg_push =
 			knav_queue_map_reg(kdev, child,
-					   KNAV_QUEUE_PUSH_REG_INDEX);
-		qmgr->reg_pop =
-			knav_queue_map_reg(kdev, child,
-					   KNAV_QUEUE_POP_REG_INDEX);
+					   (kdev->version == QMSS_66AK2G) ?
+					    KNAV_L_QUEUE_PUSH_REG_INDEX :
+					    KNAV_QUEUE_PUSH_REG_INDEX);
+
+		if (kdev->version == QMSS) {
+			qmgr->reg_pop =
+				knav_queue_map_reg(kdev, child,
+						   KNAV_QUEUE_POP_REG_INDEX);
+		}
 
-		if (IS_ERR(qmgr->reg_peek) || IS_ERR(qmgr->reg_status) ||
+		if (IS_ERR(qmgr->reg_peek) ||
+		    ((kdev->version == QMSS) &&
+		    (IS_ERR(qmgr->reg_status) || IS_ERR(qmgr->reg_pop))) ||
 		    IS_ERR(qmgr->reg_config) || IS_ERR(qmgr->reg_region) ||
-		    IS_ERR(qmgr->reg_push) || IS_ERR(qmgr->reg_pop)) {
+		    IS_ERR(qmgr->reg_push)) {
 			dev_err(dev, "failed to map qmgr regs\n");
+			if (kdev->version == QMSS) {
+				if (!IS_ERR(qmgr->reg_status))
+					devm_iounmap(dev, qmgr->reg_status);
+				if (!IS_ERR(qmgr->reg_pop))
+					devm_iounmap(dev, qmgr->reg_pop);
+			}
 			if (!IS_ERR(qmgr->reg_peek))
 				devm_iounmap(dev, qmgr->reg_peek);
-			if (!IS_ERR(qmgr->reg_status))
-				devm_iounmap(dev, qmgr->reg_status);
 			if (!IS_ERR(qmgr->reg_config))
 				devm_iounmap(dev, qmgr->reg_config);
 			if (!IS_ERR(qmgr->reg_region))
 				devm_iounmap(dev, qmgr->reg_region);
 			if (!IS_ERR(qmgr->reg_push))
 				devm_iounmap(dev, qmgr->reg_push);
-			if (!IS_ERR(qmgr->reg_pop))
-				devm_iounmap(dev, qmgr->reg_pop);
 			devm_kfree(dev, qmgr);
 			continue;
 		}
 
+		/* Use same push register for pop as well */
+		if (kdev->version == QMSS_66AK2G)
+			qmgr->reg_pop = qmgr->reg_push;
+
 		list_add_tail(&qmgr->list, &kdev->qmgrs);
 		dev_info(dev, "added qmgr start queue %d, num of queues %d, reg_peek %p, reg_status %p, reg_config %p, reg_region %p, reg_push %p, reg_pop %p\n",
 			 qmgr->start_queue, qmgr->num_queues,
@@ -1681,10 +1716,24 @@ static int knav_queue_init_queues(struct knav_device *kdev)
 	return 0;
 }
 
+/* Match table for of_platform binding */
+static const struct of_device_id keystone_qmss_of_match[] = {
+	{
+		.compatible = "ti,keystone-navigator-qmss",
+	},
+	{
+		.compatible = "ti,66ak2g-navss-qm",
+		.data	= (void *)QMSS_66AK2G,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
+
 static int knav_queue_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
+	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	u32 temp[2];
 	int ret;
@@ -1700,6 +1749,10 @@ static int knav_queue_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	match = of_match_device(of_match_ptr(keystone_qmss_of_match), dev);
+	if (match && match->data)
+		kdev->version = QMSS_66AK2G;
+
 	platform_set_drvdata(pdev, kdev);
 	kdev->dev = dev;
 	INIT_LIST_HEAD(&kdev->queue_ranges);
@@ -1815,13 +1868,6 @@ static int knav_queue_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* Match table for of_platform binding */
-static struct of_device_id keystone_qmss_of_match[] = {
-	{ .compatible = "ti,keystone-navigator-qmss", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
-
 static struct platform_driver keystone_qmss_driver = {
 	.probe		= knav_queue_probe,
 	.remove		= knav_queue_remove,
-- 
1.9.1
