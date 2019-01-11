Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FDA20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UnUEhIAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbfAKRdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:33:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45782 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfAKRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:33:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BHWpGv076099;
        Fri, 11 Jan 2019 11:32:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547227971;
        bh=GdhUaANntoGb1FL6dm1uVIPpxUarourxBC/ByEk9nrA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UnUEhIArTZvQ74FPVEvSwaLAzHsYWBHCIzDY2y2g+q8DZgJMU7v7mvXe8cRFtBHa3
         6ezKLrSE1+Rr3CxPlRvSkNZSm2y5JtfoZR2eDqwFj+3uEZVvEitXMebTyclE+ZECsA
         64XRDJWdqLDX92iz3K2NbuYcSnoUr1vNTtWe+Czc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BHWp9O104322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:32:51 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 11:32:51 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 11:32:50 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BHWoh2011021;
        Fri, 11 Jan 2019 11:32:51 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.88.224])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BHWoU03643;
        Fri, 11 Jan 2019 11:32:50 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <b29396@freescale.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 2/4] can: m_can: Migrate the m_can code to use the framework
Date:   Fri, 11 Jan 2019 11:32:34 -0600
Message-ID: <20190111173236.14329-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190111173236.14329-1-dmurphy@ti.com>
References: <20190111173236.14329-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate the m_can code to use the m_can_platform framework
code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/Kconfig          |  12 +
 drivers/net/can/m_can/Makefile         |   4 +-
 drivers/net/can/m_can/m_can.c          | 759 ++++++++++++-------------
 drivers/net/can/m_can/m_can_platform.h |   2 +-
 4 files changed, 372 insertions(+), 405 deletions(-)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 04f20dd39007..b1a9358b7660 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -1,5 +1,17 @@
 config CAN_M_CAN
+	tristate "Bosch M_CAN support"
+	---help---
+	  Say Y here if you want to support for Bosch M_CAN controller.
+
+config CAN_M_CAN_CORE
+	depends on CAN_M_CAN
+	tristate "Bosch M_CAN Core support"
+	---help---
+	  Say Y here if you want to support for Bosch M_CAN controller.
+
+config CAN_M_CAN_PLATFORM
 	depends on HAS_IOMEM
+	depends on CAN_M_CAN_CORE
 	tristate "Bosch M_CAN devices"
 	---help---
 	  Say Y here if you want to support for Bosch M_CAN controller.
diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
index 8bbd7f24f5be..04f36947ac3b 100644
--- a/drivers/net/can/m_can/Makefile
+++ b/drivers/net/can/m_can/Makefile
@@ -2,4 +2,6 @@
 #  Makefile for the Bosch M_CAN controller driver.
 #
 
-obj-$(CONFIG_CAN_M_CAN) += m_can.o
+obj-$(CONFIG_CAN_M_CAN_CORE) += m_can.o
+obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
+obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f817b28582e9..9481d21637cd 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -28,87 +28,14 @@
 #include <linux/can/dev.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "m_can_platform.h"
+
 /* napi related */
 #define M_CAN_NAPI_WEIGHT	64
 
 /* message ram configuration data length */
 #define MRAM_CFG_LEN	8
 
-/* registers definition */
-enum m_can_reg {
-	M_CAN_CREL	= 0x0,
-	M_CAN_ENDN	= 0x4,
-	M_CAN_CUST	= 0x8,
-	M_CAN_DBTP	= 0xc,
-	M_CAN_TEST	= 0x10,
-	M_CAN_RWD	= 0x14,
-	M_CAN_CCCR	= 0x18,
-	M_CAN_NBTP	= 0x1c,
-	M_CAN_TSCC	= 0x20,
-	M_CAN_TSCV	= 0x24,
-	M_CAN_TOCC	= 0x28,
-	M_CAN_TOCV	= 0x2c,
-	M_CAN_ECR	= 0x40,
-	M_CAN_PSR	= 0x44,
-/* TDCR Register only available for version >=3.1.x */
-	M_CAN_TDCR	= 0x48,
-	M_CAN_IR	= 0x50,
-	M_CAN_IE	= 0x54,
-	M_CAN_ILS	= 0x58,
-	M_CAN_ILE	= 0x5c,
-	M_CAN_GFC	= 0x80,
-	M_CAN_SIDFC	= 0x84,
-	M_CAN_XIDFC	= 0x88,
-	M_CAN_XIDAM	= 0x90,
-	M_CAN_HPMS	= 0x94,
-	M_CAN_NDAT1	= 0x98,
-	M_CAN_NDAT2	= 0x9c,
-	M_CAN_RXF0C	= 0xa0,
-	M_CAN_RXF0S	= 0xa4,
-	M_CAN_RXF0A	= 0xa8,
-	M_CAN_RXBC	= 0xac,
-	M_CAN_RXF1C	= 0xb0,
-	M_CAN_RXF1S	= 0xb4,
-	M_CAN_RXF1A	= 0xb8,
-	M_CAN_RXESC	= 0xbc,
-	M_CAN_TXBC	= 0xc0,
-	M_CAN_TXFQS	= 0xc4,
-	M_CAN_TXESC	= 0xc8,
-	M_CAN_TXBRP	= 0xcc,
-	M_CAN_TXBAR	= 0xd0,
-	M_CAN_TXBCR	= 0xd4,
-	M_CAN_TXBTO	= 0xd8,
-	M_CAN_TXBCF	= 0xdc,
-	M_CAN_TXBTIE	= 0xe0,
-	M_CAN_TXBCIE	= 0xe4,
-	M_CAN_TXEFC	= 0xf0,
-	M_CAN_TXEFS	= 0xf4,
-	M_CAN_TXEFA	= 0xf8,
-};
-
-/* m_can lec values */
-enum m_can_lec_type {
-	LEC_NO_ERROR = 0,
-	LEC_STUFF_ERROR,
-	LEC_FORM_ERROR,
-	LEC_ACK_ERROR,
-	LEC_BIT1_ERROR,
-	LEC_BIT0_ERROR,
-	LEC_CRC_ERROR,
-	LEC_UNUSED,
-};
-
-enum m_can_mram_cfg {
-	MRAM_SIDF = 0,
-	MRAM_XIDF,
-	MRAM_RXF0,
-	MRAM_RXF1,
-	MRAM_RXB,
-	MRAM_TXE,
-	MRAM_TXB,
-	MRAM_CFG_NUM,
-};
-
 /* Core Release Register (CREL) */
 #define CREL_REL_SHIFT		28
 #define CREL_REL_MASK		(0xF << CREL_REL_SHIFT)
@@ -343,72 +270,82 @@ enum m_can_mram_cfg {
 #define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
 
 /* Tx event FIFO Element */
-/* E1 */
 #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
 #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
 
-/* address offset and element number for each FIFO/Buffer in the Message RAM */
-struct mram_cfg {
-	u16 off;
-	u8  num;
-};
+static u32 m_can_read(struct m_can_classdev *priv, enum m_can_reg reg)
+{
+	u32 ret = -EINVAL;
 
-/* m_can private data structure */
-struct m_can_priv {
-	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
-	struct net_device *dev;
-	struct device *device;
-	struct clk *hclk;
-	struct clk *cclk;
-	void __iomem *base;
-	u32 irqstatus;
-	int version;
-
-	/* message ram configuration */
-	void __iomem *mram_base;
-	struct mram_cfg mcfg[MRAM_CFG_NUM];
-};
+	if (priv->read_reg)
+		ret = priv->read_reg(priv, reg);
 
-static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
+	return ret;
+}
+
+static int m_can_write(struct m_can_classdev *priv,
+		       enum m_can_reg reg, u32 val)
 {
-	return readl(priv->base + reg);
+	int ret = -EINVAL;
+
+	if (priv->write_reg)
+		ret = priv->write_reg(priv, reg, val);
+
+	return ret;
 }
 
-static inline void m_can_write(const struct m_can_priv *priv,
-			       enum m_can_reg reg, u32 val)
+static u32 m_can_fifo_read(struct m_can_classdev *priv,
+			   u32 fgi, unsigned int offset)
 {
-	writel(val, priv->base + reg);
+	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE + offset;
+	u32 ret = -EINVAL;
+
+	if (priv->read_fifo)
+		ret = priv->read_fifo(priv, addr_offset);
+
+	return ret;
 }
 
-static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
-				  u32 fgi, unsigned int offset)
+static u32 m_can_fifo_write(struct m_can_classdev *priv,
+			    u32 fpi, unsigned int offset, u32 val)
 {
-	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
-		     fgi * RXF0_ELEMENT_SIZE + offset);
+	u32 addr_offset =  priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE + offset;
+	u32 ret = -EINVAL;
+
+	if (priv->write_fifo)
+		ret = priv->write_fifo(priv, addr_offset, val);
+
+	return ret;
 }
 
-static inline void m_can_fifo_write(const struct m_can_priv *priv,
-				    u32 fpi, unsigned int offset, u32 val)
+static u32 m_can_fifo_write_no_off(struct m_can_classdev *priv,
+				   u32 fpi, u32 val)
 {
-	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
-	       fpi * TXB_ELEMENT_SIZE + offset);
+	u32 ret = -EINVAL;
+
+	if (priv->write_fifo)
+		ret = priv->write_fifo(priv, fpi, val);
+
+	return ret;
 }
 
-static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
-				      u32 fgi,
-				      u32 offset) {
-	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
-			fgi * TXE_ELEMENT_SIZE + offset);
+static u32 m_can_txe_fifo_read(struct m_can_classdev *priv, u32 fgi, u32 offset)
+{
+	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE + offset;
+	u32 ret = -EINVAL;
+
+	if (priv->read_fifo)
+		ret = priv->read_fifo(priv, addr_offset);
+
+	return ret;
 }
 
-static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
+static inline bool m_can_tx_fifo_full(struct m_can_classdev *priv)
 {
-		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
+	return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
 }
 
-static inline void m_can_config_endisable(const struct m_can_priv *priv,
-					  bool enable)
+void m_can_config_endisable(struct m_can_classdev *priv, bool enable)
 {
 	u32 cccr = m_can_read(priv, M_CAN_CCCR);
 	u32 timeout = 10;
@@ -433,7 +370,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 
 	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
 		if (timeout == 0) {
-			netdev_warn(priv->dev, "Failed to init module\n");
+			netdev_warn(priv->net, "Failed to init module\n");
 			return;
 		}
 		timeout--;
@@ -441,13 +378,13 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 	}
 }
 
-static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
+static inline void m_can_enable_all_interrupts(struct m_can_classdev *priv)
 {
 	/* Only interrupt line 0 is used in this driver */
 	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
 }
 
-static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
+static inline void m_can_disable_all_interrupts(struct m_can_classdev *priv)
 {
 	m_can_write(priv, M_CAN_ILE, 0x0);
 }
@@ -455,7 +392,7 @@ static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
 static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 {
 	struct net_device_stats *stats = &dev->stats;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
@@ -512,7 +449,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	u32 pkts = 0;
 	u32 rxfs;
 
@@ -565,7 +502,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 static int m_can_handle_lec_err(struct net_device *dev,
 				enum m_can_lec_type lec_type)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
@@ -622,7 +559,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 static int __m_can_get_berr_counter(const struct net_device *dev,
 				    struct can_berr_counter *bec)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	unsigned int ecr;
 
 	ecr = m_can_read(priv, M_CAN_ECR);
@@ -632,28 +569,32 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
 	return 0;
 }
 
-static int m_can_clk_start(struct m_can_priv *priv)
+static int m_can_clk_start(struct m_can_classdev *priv)
 {
 	int err;
 
-	err = pm_runtime_get_sync(priv->device);
+	if (priv->pm_clock_support == 0)
+		return 0;
+
+	err = pm_runtime_get_sync(priv->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(priv->device);
+		pm_runtime_put_noidle(priv->dev);
 		return err;
 	}
 
 	return 0;
 }
 
-static void m_can_clk_stop(struct m_can_priv *priv)
+static void m_can_clk_stop(struct m_can_classdev *priv)
 {
-	pm_runtime_put_sync(priv->device);
+	if (priv->pm_clock_support)
+		pm_runtime_put_sync(priv->dev);
 }
 
 static int m_can_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int err;
 
 	err = m_can_clk_start(priv);
@@ -670,7 +611,7 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 static int m_can_handle_state_change(struct net_device *dev,
 				     enum can_state new_state)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
@@ -744,25 +685,22 @@ static int m_can_handle_state_change(struct net_device *dev,
 
 static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 
-	if ((psr & PSR_EW) &&
-	    (priv->can.state != CAN_STATE_ERROR_WARNING)) {
+	if ((psr & PSR_EW) && priv->can.state != CAN_STATE_ERROR_WARNING) {
 		netdev_dbg(dev, "entered error warning state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_WARNING);
 	}
 
-	if ((psr & PSR_EP) &&
-	    (priv->can.state != CAN_STATE_ERROR_PASSIVE)) {
+	if ((psr & PSR_EP) && priv->can.state != CAN_STATE_ERROR_PASSIVE) {
 		netdev_dbg(dev, "entered error passive state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_PASSIVE);
 	}
 
-	if ((psr & PSR_BO) &&
-	    (priv->can.state != CAN_STATE_BUS_OFF)) {
+	if ((psr & PSR_BO) && priv->can.state != CAN_STATE_BUS_OFF) {
 		netdev_dbg(dev, "entered error bus off state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_BUS_OFF);
@@ -797,7 +735,7 @@ static inline bool is_lec_err(u32 psr)
 static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 				   u32 psr)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 
 	if (irqstatus & IR_RF0L)
@@ -814,10 +752,9 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 	return work_done;
 }
 
-static int m_can_poll(struct napi_struct *napi, int quota)
+static int m_can_rx_handler(struct net_device *dev, int quota)
 {
-	struct net_device *dev = napi->dev;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	int work_done = 0;
 	u32 irqstatus, psr;
 
@@ -834,13 +771,35 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 
 	if (irqstatus & IR_RF0N)
 		work_done += m_can_do_rx_poll(dev, (quota - work_done));
+end:
+	return work_done;
+}
+
+static int m_can_rx(struct net_device *dev)
+{
+	struct m_can_classdev *priv = netdev_priv(dev);
 
+	m_can_rx_handler(dev, 1);
+	m_can_enable_all_interrupts(priv);
+
+	if (priv->clr_dev_interrupts)
+		priv->clr_dev_interrupts(priv);
+
+	return 0;
+}
+
+static int m_can_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	struct m_can_classdev *priv = netdev_priv(dev);
+	int work_done = 0;
+
+	work_done = m_can_rx_handler(dev, quota);
 	if (work_done < quota) {
 		napi_complete_done(napi, work_done);
 		m_can_enable_all_interrupts(priv);
 	}
 
-end:
 	return work_done;
 }
 
@@ -852,7 +811,7 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	int i = 0;
 	unsigned int msg_mark;
 
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 
 	/* read tx event fifo status */
@@ -885,7 +844,7 @@ static void m_can_echo_tx_event(struct net_device *dev)
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	u32 ir;
 
@@ -905,7 +864,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
 		priv->irqstatus = ir;
 		m_can_disable_all_interrupts(priv);
-		napi_schedule(&priv->napi);
+		if (!priv->is_peripherial)
+			napi_schedule(&priv->napi);
+		else
+			m_can_rx(dev);
 	}
 
 	if (priv->version == 30) {
@@ -980,7 +942,7 @@ static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
 
 static int m_can_set_bittiming(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u16 brp, sjw, tseg1, tseg2;
@@ -1053,7 +1015,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  */
 static void m_can_chip_config(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	u32 cccr, test;
 
 	m_can_config_endisable(priv, true);
@@ -1165,7 +1127,7 @@ static void m_can_chip_config(struct net_device *dev)
 
 static void m_can_start(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	/* basic m_can configuration */
 	m_can_chip_config(dev);
@@ -1194,20 +1156,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
  * else it returns the release and step coded as:
  * return value = 10 * <release> + 1 * <step>
  */
-static int m_can_check_core_release(void __iomem *m_can_base)
+static int m_can_check_core_release(struct m_can_classdev *priv)
 {
 	u32 crel_reg;
 	u8 rel;
 	u8 step;
 	int res;
-	struct m_can_priv temp_priv = {
-		.base = m_can_base
-	};
 
 	/* Read Core Release Version and split into version number
 	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
 	 */
-	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
+	crel_reg = m_can_read(priv, M_CAN_CREL);
 	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
 	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
 
@@ -1225,18 +1184,22 @@ static int m_can_check_core_release(void __iomem *m_can_base)
 /* Selectable Non ISO support only in version 3.2.x
  * This function checks if the bit is writable.
  */
-static bool m_can_niso_supported(const struct m_can_priv *priv)
+static bool m_can_niso_supported(struct m_can_classdev *priv)
 {
-	u32 cccr_reg, cccr_poll;
-	int niso_timeout;
+	u32 cccr_reg, cccr_poll = 0;
+	int niso_timeout = -ETIMEDOUT;
+	int i;
 
 	m_can_config_endisable(priv, true);
 	cccr_reg = m_can_read(priv, M_CAN_CCCR);
 	cccr_reg |= CCCR_NISO;
 	m_can_write(priv, M_CAN_CCCR, cccr_reg);
 
-	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
-					  (cccr_poll == cccr_reg), 0, 10);
+	for (i = 0; i <= 10; i++) {
+		cccr_poll = m_can_read(priv, M_CAN_CCCR);
+		if (cccr_poll == cccr_reg)
+			niso_timeout = 0;
+	}
 
 	/* Clear NISO */
 	cccr_reg &= ~(CCCR_NISO);
@@ -1248,112 +1211,100 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
 	return !niso_timeout;
 }
 
-static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
-			   void __iomem *addr)
+static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
 {
-	struct m_can_priv *priv;
+	struct net_device *dev = m_can_dev->net;
 	int m_can_version;
 
-	m_can_version = m_can_check_core_release(addr);
+	m_can_version = m_can_check_core_release(m_can_dev);
 	/* return if unsupported version */
 	if (!m_can_version) {
-		dev_err(&pdev->dev, "Unsupported version number: %2d",
+		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
 			m_can_version);
 		return -EINVAL;
 	}
 
-	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
+	if (!m_can_dev->is_peripherial)
+		netif_napi_add(dev, &m_can_dev->napi,
+			       m_can_poll, M_CAN_NAPI_WEIGHT);
 
 	/* Shared properties of all M_CAN versions */
-	priv->version = m_can_version;
-	priv->dev = dev;
-	priv->base = addr;
-	priv->can.do_set_mode = m_can_set_mode;
-	priv->can.do_get_berr_counter = m_can_get_berr_counter;
+	m_can_dev->version = m_can_version;
+	m_can_dev->can.do_set_mode = m_can_set_mode;
+	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
 
 	/* Set M_CAN supported operations */
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING |
 					CAN_CTRLMODE_FD;
 
 	/* Set properties depending on M_CAN version */
-	switch (priv->version) {
+	switch (m_can_dev->version) {
 	case 30:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		priv->can.bittiming_const = &m_can_bittiming_const_30X;
-		priv->can.data_bittiming_const =
+		if (m_can_dev->bit_timing)
+			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
+		else
+			m_can_dev->can.bittiming_const =
+				&m_can_bittiming_const_30X;
+		if (m_can_dev->data_timing)
+			m_can_dev->can.data_bittiming_const =
+				m_can_dev->data_timing;
+		else
+			m_can_dev->can.data_bittiming_const =
 				&m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
 		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-		priv->can.bittiming_const = &m_can_bittiming_const_31X;
-		priv->can.data_bittiming_const =
+		if (m_can_dev->bit_timing)
+			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
+		else
+			m_can_dev->can.bittiming_const =
+				&m_can_bittiming_const_31X;
+		if (m_can_dev->data_timing)
+			m_can_dev->can.data_bittiming_const =
+				m_can_dev->data_timing;
+		else
+			m_can_dev->can.data_bittiming_const =
 				&m_can_data_bittiming_const_31X;
 		break;
 	case 32:
-		priv->can.bittiming_const = &m_can_bittiming_const_31X;
-		priv->can.data_bittiming_const =
+		if (m_can_dev->bit_timing)
+			m_can_dev->can.bittiming_const = m_can_dev->bit_timing;
+		else
+			m_can_dev->can.bittiming_const =
+				&m_can_bittiming_const_31X;
+
+		if (m_can_dev->data_timing)
+			m_can_dev->can.data_bittiming_const =
+				m_can_dev->data_timing;
+		else
+			m_can_dev->can.data_bittiming_const =
 				&m_can_data_bittiming_const_31X;
-		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
+
+		m_can_dev->can.ctrlmode_supported |=
+						(m_can_niso_supported(m_can_dev)
 						? CAN_CTRLMODE_FD_NON_ISO
 						: 0);
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported version number: %2d",
-			priv->version);
+		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
+			m_can_dev->version);
 		return -EINVAL;
 	}
 
-	return 0;
-}
-
-static int m_can_open(struct net_device *dev)
-{
-	struct m_can_priv *priv = netdev_priv(dev);
-	int err;
-
-	err = m_can_clk_start(priv);
-	if (err)
-		return err;
-
-	/* open the can device */
-	err = open_candev(dev);
-	if (err) {
-		netdev_err(dev, "failed to open can device\n");
-		goto exit_disable_clks;
-	}
-
-	/* register interrupt handler */
-	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
-			  dev);
-	if (err < 0) {
-		netdev_err(dev, "failed to request interrupt\n");
-		goto exit_irq_fail;
-	}
-
-	/* start the m_can controller */
-	m_can_start(dev);
-
-	can_led_event(dev, CAN_LED_EVENT_OPEN);
-	napi_enable(&priv->napi);
-	netif_start_queue(dev);
+	if (m_can_dev->device_init)
+		m_can_dev->device_init(m_can_dev);
 
 	return 0;
-
-exit_irq_fail:
-	close_candev(dev);
-exit_disable_clks:
-	m_can_clk_stop(priv);
-	return err;
 }
 
 static void m_can_stop(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(priv);
@@ -1364,13 +1315,16 @@ static void m_can_stop(struct net_device *dev)
 
 static int m_can_close(struct net_device *dev)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	if (!priv->is_peripherial)
+		napi_disable(&priv->napi);
 	m_can_stop(dev);
 	m_can_clk_stop(priv);
 	free_irq(dev->irq, dev);
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
 	close_candev(dev);
 	can_led_event(dev, CAN_LED_EVENT_STOP);
 
@@ -1379,7 +1333,7 @@ static int m_can_close(struct net_device *dev)
 
 static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
+	struct m_can_classdev *priv = netdev_priv(dev);
 	/*get wrap around for loopback skb index */
 	unsigned int wrap = priv->can.echo_skb_max;
 	int next_idx;
@@ -1391,18 +1345,17 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 	return !!priv->can.echo_skb[next_idx];
 }
 
-static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
-				    struct net_device *dev)
+static void m_can_tx_work_handler(struct work_struct *ws)
 {
-	struct m_can_priv *priv = netdev_priv(dev);
-	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct m_can_classdev *priv = container_of(ws, struct m_can_classdev,
+						tx_work);
+	struct canfd_frame *cf = (struct canfd_frame *)priv->skb->data;
+	struct net_device *dev = priv->net;
+	struct sk_buff *skb = priv->skb;
 	u32 id, cccr, fdflags;
 	int i;
 	int putidx;
 
-	if (can_dropped_invalid_skb(dev, skb))
-		return NETDEV_TX_OK;
-
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -1431,7 +1384,8 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		can_put_echo_skb(skb, dev, 0);
 
 		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-			cccr = m_can_read(priv, M_CAN_CCCR);
+			/*cccr = m_can_read(priv, M_CAN_CCCR);*/
+			cccr = 0;
 			cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
 			if (can_is_canfd_skb(skb)) {
 				if (cf->flags & CANFD_BRS)
@@ -1457,7 +1411,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 			netif_stop_queue(dev);
 			netdev_warn(dev,
 				    "TX queue active although FIFO is full.");
-			return NETDEV_TX_BUSY;
+			return;
 		}
 
 		/* get put index for frame */
@@ -1502,10 +1456,83 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 			    m_can_next_echo_skb_occupied(dev, putidx))
 				netif_stop_queue(dev);
 	}
+}
+
+static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct m_can_classdev *priv = netdev_priv(dev);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_BUSY;
+
+	netif_stop_queue(dev);
+	priv->skb = skb;
+	queue_work(priv->wq, &priv->tx_work);
 
 	return NETDEV_TX_OK;
 }
 
+static int m_can_open(struct net_device *dev)
+{
+	struct m_can_classdev *priv = netdev_priv(dev);
+	int err;
+
+	err = m_can_clk_start(priv);
+	if (err)
+		return err;
+
+	/* open the can device */
+	err = open_candev(dev);
+	if (err) {
+		netdev_err(dev, "failed to open can device\n");
+		goto exit_disable_clks;
+	}
+
+	priv->wq = alloc_workqueue("mcan_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+				   0);
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto out_wq_fail;
+	}
+
+	INIT_WORK(&priv->tx_work, m_can_tx_work_handler);
+
+	/* register interrupt handler */
+	if (priv->is_peripherial)
+		err = request_threaded_irq(dev->irq, NULL, m_can_isr,
+					   IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+					   dev->name, dev);
+	else
+		err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
+				  dev);
+
+	if (err < 0) {
+		netdev_err(dev, "failed to request interrupt\n");
+		goto exit_irq_fail;
+	}
+
+	/* start the m_can controller */
+	m_can_start(dev);
+
+	can_led_event(dev, CAN_LED_EVENT_OPEN);
+
+	if (!priv->is_peripherial)
+		napi_enable(&priv->napi);
+
+	netif_start_queue(dev);
+
+	return 0;
+
+exit_irq_fail:
+	destroy_workqueue(priv->wq);
+out_wq_fail:
+	close_candev(dev);
+exit_disable_clks:
+	m_can_clk_stop(priv);
+	return err;
+}
+
 static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_open = m_can_open,
 	.ndo_stop = m_can_close,
@@ -1521,21 +1548,7 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
-static void m_can_init_ram(struct m_can_priv *priv)
-{
-	int end, i, start;
-
-	/* initialize the entire Message RAM in use to avoid possible
-	 * ECC/parity checksum errors when reading an uninitialized buffer
-	 */
-	start = priv->mcfg[MRAM_SIDF].off;
-	end = priv->mcfg[MRAM_TXB].off +
-		priv->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
-	for (i = start; i < end; i += 4)
-		writel(0x0, priv->mram_base + i);
-}
-
-static void m_can_of_parse_mram(struct m_can_priv *priv,
+static void m_can_of_parse_mram(struct m_can_classdev *priv,
 				const u32 *mram_config_vals)
 {
 	priv->mcfg[MRAM_SIDF].off = mram_config_vals[0];
@@ -1562,9 +1575,8 @@ static void m_can_of_parse_mram(struct m_can_priv *priv,
 	priv->mcfg[MRAM_TXB].num = mram_config_vals[7] &
 			(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
 
-	dev_dbg(priv->device,
-		"mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
-		priv->mram_base,
+	dev_dbg(priv->dev,
+		"sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
 		priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
 		priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
 		priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
@@ -1572,63 +1584,55 @@ static void m_can_of_parse_mram(struct m_can_priv *priv,
 		priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
 		priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
 		priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
-
-	m_can_init_ram(priv);
 }
 
-static int m_can_plat_probe(struct platform_device *pdev)
+void m_can_init_ram(struct m_can_classdev *priv)
 {
-	struct net_device *dev;
-	struct m_can_priv *priv;
-	struct resource *res;
-	void __iomem *addr;
-	void __iomem *mram_addr;
-	struct clk *hclk, *cclk;
-	int irq, ret;
-	struct device_node *np;
-	u32 mram_config_vals[MRAM_CFG_LEN];
-	u32 tx_fifo_size;
-
-	np = pdev->dev.of_node;
+	int end, i, start;
 
-	hclk = devm_clk_get(&pdev->dev, "hclk");
-	cclk = devm_clk_get(&pdev->dev, "cclk");
+	/* initialize the entire Message RAM in use to avoid possible
+	 * ECC/parity checksum errors when reading an uninitialized buffer
+	 */
+	start = priv->mcfg[MRAM_SIDF].off;
+	end = priv->mcfg[MRAM_TXB].off +
+		priv->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
 
-	if (IS_ERR(hclk) || IS_ERR(cclk)) {
-		dev_err(&pdev->dev, "no clock found\n");
-		ret = -ENODEV;
-		goto failed_ret;
-	}
+	for (i = start; i < end; i += 4)
+		m_can_fifo_write_no_off(priv, i, 0x0);
+}
+EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
-	addr = devm_ioremap_resource(&pdev->dev, res);
-	irq = platform_get_irq_byname(pdev, "int0");
+int m_can_core_get_clocks(struct m_can_classdev *m_can_dev)
+{
+	int ret = 0;
 
-	if (IS_ERR(addr) || irq < 0) {
-		ret = -EINVAL;
-		goto failed_ret;
-	}
+	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
+	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
 
-	/* message ram could be shared */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
-	if (!res) {
+	if (IS_ERR(m_can_dev->cclk)) {
+		dev_err(m_can_dev->dev, "no clock found\n");
 		ret = -ENODEV;
-		goto failed_ret;
 	}
 
-	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!mram_addr) {
-		ret = -ENOMEM;
-		goto failed_ret;
-	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(m_can_core_get_clocks);
 
-	/* get message ram configuration */
-	ret = of_property_read_u32_array(np, "bosch,mram-cfg",
-					 mram_config_vals,
-					 sizeof(mram_config_vals) / 4);
+struct m_can_classdev *m_can_core_allocate_dev(struct device *dev)
+{
+	struct m_can_classdev *class_dev = NULL;
+	u32 mram_config_vals[MRAM_CFG_LEN];
+	struct net_device *net_dev;
+	u32 tx_fifo_size;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(dev_fwnode(dev),
+					     "bosch,mram-cfg",
+					     mram_config_vals,
+					     sizeof(mram_config_vals) / 4);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
-		goto failed_ret;
+		dev_err(dev, "Could not get Message RAM configuration.");
+		goto out;
 	}
 
 	/* Get TX FIFO size
@@ -1637,69 +1641,77 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	tx_fifo_size = mram_config_vals[7];
 
 	/* allocate the m_can device */
-	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto failed_ret;
+	net_dev = alloc_candev(sizeof(*class_dev), tx_fifo_size);
+	if (!net_dev) {
+		dev_err(dev, "Failed to allocate CAN device");
+		goto out;
 	}
 
-	priv = netdev_priv(dev);
-	dev->irq = irq;
-	priv->device = &pdev->dev;
-	priv->hclk = hclk;
-	priv->cclk = cclk;
-	priv->can.clock.freq = clk_get_rate(cclk);
-	priv->mram_base = mram_addr;
+	class_dev = netdev_priv(net_dev);
+	if (!class_dev) {
+		dev_err(dev, "Failed to init netdev private");
+		goto out;
+	}
 
-	platform_set_drvdata(pdev, dev);
-	SET_NETDEV_DEV(dev, &pdev->dev);
+	class_dev->net = net_dev;
+	class_dev->dev = dev;
+	SET_NETDEV_DEV(net_dev, dev);
 
-	/* Enable clocks. Necessary to read Core Release in order to determine
-	 * M_CAN version
-	 */
-	pm_runtime_enable(&pdev->dev);
-	ret = m_can_clk_start(priv);
-	if (ret)
-		goto pm_runtime_fail;
+	m_can_of_parse_mram(class_dev, mram_config_vals);
+out:
+	return class_dev;
+}
+EXPORT_SYMBOL_GPL(m_can_core_allocate_dev);
+
+int m_can_core_register(struct m_can_classdev *m_can_dev)
+{
+	int ret;
+
+	if (m_can_dev->pm_clock_support) {
+		pm_runtime_enable(m_can_dev->dev);
+		ret = m_can_clk_start(m_can_dev);
+		if (ret)
+			goto pm_runtime_fail;
+	}
 
-	ret = m_can_dev_setup(pdev, dev, addr);
+	ret = m_can_dev_setup(m_can_dev);
 	if (ret)
 		goto clk_disable;
 
-	ret = register_m_can_dev(dev);
+	ret = register_m_can_dev(m_can_dev->net);
 	if (ret) {
-		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
-			KBUILD_MODNAME, ret);
+		dev_err(m_can_dev->dev, "registering %s failed (err=%d)\n",
+			m_can_dev->net->name, ret);
 		goto clk_disable;
 	}
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
-	devm_can_led_init(dev);
+	devm_can_led_init(m_can_dev->net);
 
-	of_can_transceiver(dev);
+	of_can_transceiver(m_can_dev->net);
 
-	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
-		 KBUILD_MODNAME, dev->irq, priv->version);
+	dev_info(m_can_dev->dev, "%s device registered (irq=%d, version=%d)\n",
+		 KBUILD_MODNAME, m_can_dev->net->irq, m_can_dev->version);
 
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
 	 */
 clk_disable:
-	m_can_clk_stop(priv);
+	m_can_clk_stop(m_can_dev);
 pm_runtime_fail:
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		free_candev(dev);
+		if (m_can_dev->pm_clock_support)
+			pm_runtime_disable(m_can_dev->dev);
+		free_candev(m_can_dev->net);
 	}
-failed_ret:
+
 	return ret;
 }
+EXPORT_SYMBOL_GPL(m_can_core_register);
 
-static __maybe_unused int m_can_suspend(struct device *dev)
+int m_can_core_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
@@ -1714,11 +1726,12 @@ static __maybe_unused int m_can_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(m_can_core_suspend);
 
-static __maybe_unused int m_can_resume(struct device *dev)
+int m_can_core_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -1739,78 +1752,18 @@ static __maybe_unused int m_can_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(m_can_core_resume);
 
-static void unregister_m_can_dev(struct net_device *dev)
-{
-	unregister_candev(dev);
-}
-
-static int m_can_plat_remove(struct platform_device *pdev)
-{
-	struct net_device *dev = platform_get_drvdata(pdev);
-
-	unregister_m_can_dev(dev);
-
-	pm_runtime_disable(&pdev->dev);
-
-	platform_set_drvdata(pdev, NULL);
-
-	free_candev(dev);
-
-	return 0;
-}
-
-static int __maybe_unused m_can_runtime_suspend(struct device *dev)
+void m_can_core_unregister(struct m_can_classdev *m_can_dev)
 {
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
+	unregister_candev(m_can_dev->net);
 
-	clk_disable_unprepare(priv->cclk);
-	clk_disable_unprepare(priv->hclk);
+	if (m_can_dev->pm_clock_support)
+		pm_runtime_disable(m_can_dev->dev);
 
-	return 0;
+	free_candev(m_can_dev->net);
 }
-
-static int __maybe_unused m_can_runtime_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct m_can_priv *priv = netdev_priv(ndev);
-	int err;
-
-	err = clk_prepare_enable(priv->hclk);
-	if (err)
-		return err;
-
-	err = clk_prepare_enable(priv->cclk);
-	if (err)
-		clk_disable_unprepare(priv->hclk);
-
-	return err;
-}
-
-static const struct dev_pm_ops m_can_pmops = {
-	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
-			   m_can_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
-};
-
-static const struct of_device_id m_can_of_table[] = {
-	{ .compatible = "bosch,m_can", .data = NULL },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, m_can_of_table);
-
-static struct platform_driver m_can_plat_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-		.of_match_table = m_can_of_table,
-		.pm     = &m_can_pmops,
-	},
-	.probe = m_can_plat_probe,
-	.remove = m_can_plat_remove,
-};
-
-module_platform_driver(m_can_plat_driver);
+EXPORT_SYMBOL_GPL(m_can_core_unregister);
 
 MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/can/m_can/m_can_platform.h b/drivers/net/can/m_can/m_can_platform.h
index 97e90dd79613..c3dd301756ba 100644
--- a/drivers/net/can/m_can/m_can_platform.h
+++ b/drivers/net/can/m_can/m_can_platform.h
@@ -156,7 +156,7 @@ int m_can_core_register(struct m_can_classdev *m_can_dev);
 void m_can_core_unregister(struct m_can_classdev *m_can_dev);
 int m_can_core_get_clocks(struct m_can_classdev *m_can_dev);
 void m_can_init_ram(struct m_can_classdev *priv);
-void m_can_config_endisable(const struct m_can_classdev *priv, bool enable);
+void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
 int m_can_core_suspend(struct device *dev);
 int m_can_core_resume(struct device *dev);
-- 
2.20.1.98.gecbdaf0899

