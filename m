Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeEPBLH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 21:11:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeEPBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 21:11:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1154B60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=hpuranik@codeaurora.org
From: Hemanth Puranik <hpuranik@codeaurora.org>
To: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timur Tabi <timur@codeaurora.org>,
        Hemanth Puranik <hpuranik@codeaurora.org>
Subject: [PATCH] net: qcom/emac: Encapsulate sgmii ops under one structure
Date: Wed, 16 May 2018 06:40:53 +0530
Message-Id: <1526433053-16308-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces ops structure for sgmii, This by ensures that
we do not need dummy functions in case of emulation platforms.

Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c   |   5 +-
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 128 ++++++++++++++----------
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.h |  32 +++---
 drivers/net/ethernet/qualcomm/emac/emac.c       |   9 +-
 4 files changed, 103 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index d5a32b7..092718a 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -920,14 +920,13 @@ static void emac_mac_rx_descs_refill(struct emac_adapter *adpt,
 static void emac_adjust_link(struct net_device *netdev)
 {
 	struct emac_adapter *adpt = netdev_priv(netdev);
-	struct emac_sgmii *sgmii = &adpt->phy;
 	struct phy_device *phydev = netdev->phydev;
 
 	if (phydev->link) {
 		emac_mac_start(adpt);
-		sgmii->link_up(adpt);
+		emac_sgmii_link_change(adpt, true);
 	} else {
-		sgmii->link_down(adpt);
+		emac_sgmii_link_change(adpt, false);
 		emac_mac_stop(adpt);
 	}
 
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e8ab512..562420b 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -53,6 +53,46 @@
 
 #define SERDES_START_WAIT_TIMES			100
 
+int emac_sgmii_init(struct emac_adapter *adpt)
+{
+	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->init))
+		return 0;
+
+	return adpt->phy.sgmii_ops->init(adpt);
+}
+
+int emac_sgmii_open(struct emac_adapter *adpt)
+{
+	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->open))
+		return 0;
+
+	return adpt->phy.sgmii_ops->open(adpt);
+}
+
+void emac_sgmii_close(struct emac_adapter *adpt)
+{
+	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->close))
+		return;
+
+	adpt->phy.sgmii_ops->close(adpt);
+}
+
+int emac_sgmii_link_change(struct emac_adapter *adpt, bool link_state)
+{
+	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->link_change))
+		return 0;
+
+	return adpt->phy.sgmii_ops->link_change(adpt, link_state);
+}
+
+void emac_sgmii_reset(struct emac_adapter *adpt)
+{
+	if (!(adpt->phy.sgmii_ops && adpt->phy.sgmii_ops->reset))
+		return;
+
+	adpt->phy.sgmii_ops->reset(adpt);
+}
+
 /* Initialize the SGMII link between the internal and external PHYs. */
 static void emac_sgmii_link_init(struct emac_adapter *adpt)
 {
@@ -163,21 +203,21 @@ static void emac_sgmii_reset_prepare(struct emac_adapter *adpt)
 	msleep(50);
 }
 
-void emac_sgmii_reset(struct emac_adapter *adpt)
+static void emac_sgmii_common_reset(struct emac_adapter *adpt)
 {
 	int ret;
 
 	emac_sgmii_reset_prepare(adpt);
 	emac_sgmii_link_init(adpt);
 
-	ret = adpt->phy.initialize(adpt);
+	ret = emac_sgmii_init(adpt);
 	if (ret)
 		netdev_err(adpt->netdev,
 			   "could not reinitialize internal PHY (error=%i)\n",
 			   ret);
 }
 
-static int emac_sgmii_open(struct emac_adapter *adpt)
+static int emac_sgmii_common_open(struct emac_adapter *adpt)
 {
 	struct emac_sgmii *sgmii = &adpt->phy;
 	int ret;
@@ -201,43 +241,53 @@ static int emac_sgmii_open(struct emac_adapter *adpt)
 	return 0;
 }
 
-static int emac_sgmii_close(struct emac_adapter *adpt)
+static void emac_sgmii_common_close(struct emac_adapter *adpt)
 {
 	struct emac_sgmii *sgmii = &adpt->phy;
 
 	/* Make sure interrupts are disabled */
 	writel(0, sgmii->base + EMAC_SGMII_PHY_INTERRUPT_MASK);
 	free_irq(sgmii->irq, adpt);
-
-	return 0;
 }
 
 /* The error interrupts are only valid after the link is up */
-static int emac_sgmii_link_up(struct emac_adapter *adpt)
+static int emac_sgmii_common_link_change(struct emac_adapter *adpt, bool linkup)
 {
 	struct emac_sgmii *sgmii = &adpt->phy;
 	int ret;
 
-	/* Clear and enable interrupts */
-	ret = emac_sgmii_irq_clear(adpt, 0xff);
-	if (ret)
-		return ret;
+	if (linkup) {
+		/* Clear and enable interrupts */
+		ret = emac_sgmii_irq_clear(adpt, 0xff);
+		if (ret)
+			return ret;
 
-	writel(SGMII_ISR_MASK, sgmii->base + EMAC_SGMII_PHY_INTERRUPT_MASK);
+		writel(SGMII_ISR_MASK,
+		       sgmii->base + EMAC_SGMII_PHY_INTERRUPT_MASK);
+	} else {
+		/* Disable interrupts */
+		writel(0, sgmii->base + EMAC_SGMII_PHY_INTERRUPT_MASK);
+		synchronize_irq(sgmii->irq);
+	}
 
 	return 0;
 }
 
-static int emac_sgmii_link_down(struct emac_adapter *adpt)
-{
-	struct emac_sgmii *sgmii = &adpt->phy;
-
-	/* Disable interrupts */
-	writel(0, sgmii->base + EMAC_SGMII_PHY_INTERRUPT_MASK);
-	synchronize_irq(sgmii->irq);
+static struct sgmii_ops qdf2432_ops = {
+	.init = emac_sgmii_init_qdf2432,
+	.open = emac_sgmii_common_open,
+	.close = emac_sgmii_common_close,
+	.link_change = emac_sgmii_common_link_change,
+	.reset = emac_sgmii_common_reset,
+};
 
-	return 0;
-}
+static struct sgmii_ops qdf2400_ops = {
+	.init = emac_sgmii_init_qdf2400,
+	.open = emac_sgmii_common_open,
+	.close = emac_sgmii_common_close,
+	.link_change = emac_sgmii_common_link_change,
+	.reset = emac_sgmii_common_reset,
+};
 
 static int emac_sgmii_acpi_match(struct device *dev, void *data)
 {
@@ -249,7 +299,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 		{}
 	};
 	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
-	emac_sgmii_function *initialize = data;
+	struct sgmii_ops **ops = data;
 
 	if (id) {
 		acpi_handle handle = ACPI_HANDLE(dev);
@@ -270,10 +320,10 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 
 		switch (hrv) {
 		case 1:
-			*initialize = emac_sgmii_init_qdf2432;
+			*ops = &qdf2432_ops;
 			return 1;
 		case 2:
-			*initialize = emac_sgmii_init_qdf2400;
+			*ops = &qdf2400_ops;
 			return 1;
 		}
 	}
@@ -294,14 +344,6 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 	{}
 };
 
-/* Dummy function for systems without an internal PHY. This avoids having
- * to check for NULL pointers before calling the functions.
- */
-static int emac_sgmii_dummy(struct emac_adapter *adpt)
-{
-	return 0;
-}
-
 int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 {
 	struct platform_device *sgmii_pdev = NULL;
@@ -312,22 +354,11 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	if (has_acpi_companion(&pdev->dev)) {
 		struct device *dev;
 
-		dev = device_find_child(&pdev->dev, &phy->initialize,
+		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
 					emac_sgmii_acpi_match);
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");
-			/* There is typically no internal PHY on emulation
-			 * systems, so if we can't find the node, assume
-			 * we are on an emulation system and stub-out
-			 * support for the internal PHY.  These systems only
-			 * use ACPI.
-			 */
-			phy->open = emac_sgmii_dummy;
-			phy->close = emac_sgmii_dummy;
-			phy->link_up = emac_sgmii_dummy;
-			phy->link_down = emac_sgmii_dummy;
-
 			return 0;
 		}
 
@@ -355,14 +386,9 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 			goto error_put_device;
 		}
 
-		phy->initialize = (emac_sgmii_function)match->data;
+		phy->sgmii_ops->init = match->data;
 	}
 
-	phy->open = emac_sgmii_open;
-	phy->close = emac_sgmii_close;
-	phy->link_up = emac_sgmii_link_up;
-	phy->link_down = emac_sgmii_link_down;
-
 	/* Base address is the first address */
 	res = platform_get_resource(sgmii_pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -386,7 +412,7 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 		}
 	}
 
-	ret = phy->initialize(adpt);
+	ret = emac_sgmii_init(adpt);
 	if (ret)
 		goto error;
 
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
index e7c0c3b..31ba21e 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.h
@@ -16,36 +16,44 @@
 struct emac_adapter;
 struct platform_device;
 
-typedef int (*emac_sgmii_function)(struct emac_adapter *adpt);
+/** emac_sgmii - internal emac phy
+ * @init initialization function
+ * @open called when the driver is opened
+ * @close called when the driver is closed
+ * @link_change called when the link state changes
+ */
+struct sgmii_ops {
+	int (*init)(struct emac_adapter *adpt);
+	int (*open)(struct emac_adapter *adpt);
+	void (*close)(struct emac_adapter *adpt);
+	int (*link_change)(struct emac_adapter *adpt, bool link_state);
+	void (*reset)(struct emac_adapter *adpt);
+};
 
 /** emac_sgmii - internal emac phy
  * @base base address
  * @digital per-lane digital block
  * @irq the interrupt number
  * @decode_error_count reference count of consecutive decode errors
- * @initialize initialization function
- * @open called when the driver is opened
- * @close called when the driver is closed
- * @link_up called when the link comes up
- * @link_down called when the link comes down
+ * @sgmii_ops sgmii ops
  */
 struct emac_sgmii {
 	void __iomem		*base;
 	void __iomem		*digital;
 	unsigned int		irq;
 	atomic_t		decode_error_count;
-	emac_sgmii_function	initialize;
-	emac_sgmii_function	open;
-	emac_sgmii_function	close;
-	emac_sgmii_function	link_up;
-	emac_sgmii_function	link_down;
+	struct	sgmii_ops	*sgmii_ops;
 };
 
 int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt);
-void emac_sgmii_reset(struct emac_adapter *adpt);
 
 int emac_sgmii_init_fsm9900(struct emac_adapter *adpt);
 int emac_sgmii_init_qdf2432(struct emac_adapter *adpt);
 int emac_sgmii_init_qdf2400(struct emac_adapter *adpt);
 
+int emac_sgmii_init(struct emac_adapter *adpt);
+int emac_sgmii_open(struct emac_adapter *adpt);
+void emac_sgmii_close(struct emac_adapter *adpt);
+int emac_sgmii_link_change(struct emac_adapter *adpt, bool link_state);
+void emac_sgmii_reset(struct emac_adapter *adpt);
 #endif
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 13235ba..2a0cbc5 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -253,7 +253,7 @@ static int emac_open(struct net_device *netdev)
 		return ret;
 	}
 
-	ret = adpt->phy.open(adpt);
+	ret = emac_sgmii_open(adpt);
 	if (ret) {
 		emac_mac_rx_tx_rings_free_all(adpt);
 		free_irq(irq->irq, irq);
@@ -264,7 +264,7 @@ static int emac_open(struct net_device *netdev)
 	if (ret) {
 		emac_mac_rx_tx_rings_free_all(adpt);
 		free_irq(irq->irq, irq);
-		adpt->phy.close(adpt);
+		emac_sgmii_close(adpt);
 		return ret;
 	}
 
@@ -278,7 +278,7 @@ static int emac_close(struct net_device *netdev)
 
 	mutex_lock(&adpt->reset_lock);
 
-	adpt->phy.close(adpt);
+	emac_sgmii_close(adpt);
 	emac_mac_down(adpt);
 	emac_mac_rx_tx_rings_free_all(adpt);
 
@@ -761,11 +761,10 @@ static void emac_shutdown(struct platform_device *pdev)
 {
 	struct net_device *netdev = dev_get_drvdata(&pdev->dev);
 	struct emac_adapter *adpt = netdev_priv(netdev);
-	struct emac_sgmii *sgmii = &adpt->phy;
 
 	if (netdev->flags & IFF_UP) {
 		/* Closing the SGMII turns off its interrupts */
-		sgmii->close(adpt);
+		emac_sgmii_close(adpt);
 
 		/* Resetting the MAC turns off all DMA and its interrupts */
 		emac_mac_reset(adpt);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
