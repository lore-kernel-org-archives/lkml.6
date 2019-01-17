Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AEC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfAQHQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:16:39 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:27976 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730397AbfAQHQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:16:38 -0500
X-UUID: f6ac689411404888b3cfbb695288c5b1-20190117
X-UUID: f6ac689411404888b3cfbb695288c5b1-20190117
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1057325393; Thu, 17 Jan 2019 15:16:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 15:16:23 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 15:16:23 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Min Guo <min.guo@mediatek.com>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb controller
Date:   Thu, 17 Jan 2019 15:15:48 +0800
Message-ID: <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

This adds support for MediaTek musb controller in
host, peripheral and otg mode.
There are some quirk of MediaTek musb controller, such as:
 -W1C interrupt status registers
 -Private data toggle registers
 -No dedicated DMA interrupt line

Signed-off-by: Min Guo <min.guo@mediatek.com>
Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
---
 drivers/usb/musb/Kconfig     |   8 +-
 drivers/usb/musb/Makefile    |   1 +
 drivers/usb/musb/mediatek.c  | 624 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |  64 ++++-
 drivers/usb/musb/musb_core.h |   9 +
 drivers/usb/musb/musb_dma.h  |   9 +
 drivers/usb/musb/musb_host.c |  46 +---
 drivers/usb/musb/musb_io.h   |   6 +
 drivers/usb/musb/musbhsdma.c |  57 ++--
 9 files changed, 766 insertions(+), 58 deletions(-)
 create mode 100644 drivers/usb/musb/mediatek.c

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index ad08895..b72b7c1 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -115,6 +115,12 @@ config USB_MUSB_JZ4740
 	depends on USB_MUSB_GADGET
 	depends on USB_OTG_BLACKLIST_HUB
 
+config USB_MUSB_MEDIATEK
+	tristate "MediaTek platforms"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on NOP_USB_XCEIV
+	depends on GENERIC_PHY
+
 config USB_MUSB_AM335X_CHILD
 	tristate
 
@@ -141,7 +147,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS
+	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_MEDIATEK
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 3a88c79..63d82d0 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_USB_MUSB_DA8XX)			+= da8xx.o
 obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
 obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
+obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= mediatek.o
 
 
 obj-$(CONFIG_USB_MUSB_AM335X_CHILD)		+= musb_am335x.o
diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
new file mode 100644
index 0000000..65cafa6
--- /dev/null
+++ b/drivers/usb/musb/mediatek.c
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author:
+ *  Min Guo <min.guo@mediatek.com>
+ *  Yonglong Wu <yonglong.wu@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/usb_phy_generic.h>
+#include "musb_core.h"
+#include "musb_dma.h"
+
+#define USB_L1INTS	0x00a0
+#define USB_L1INTM	0x00a4
+#define MTK_MUSB_TXFUNCADDR	0x0480
+
+/* MediaTek controller toggle enable and status reg */
+#define MUSB_RXTOG		0x80
+#define MUSB_RXTOGEN		0x82
+#define MUSB_TXTOG		0x84
+#define MUSB_TXTOGEN		0x86
+
+#define TX_INT_STATUS		BIT(0)
+#define RX_INT_STATUS		BIT(1)
+#define USBCOM_INT_STATUS		BIT(2)
+#define DMA_INT_STATUS		BIT(3)
+
+#define DMA_INTR_STATUS_MSK		GENMASK(7, 0)
+#define DMA_INTR_UNMASK_SET_MSK	GENMASK(31, 24)
+
+enum mtk_vbus_id_state {
+	MTK_ID_FLOAT = 1,
+	MTK_ID_GROUND,
+	MTK_VBUS_OFF,
+	MTK_VBUS_VALID,
+};
+
+struct mtk_glue {
+	struct device *dev;
+	struct musb *musb;
+	struct platform_device *musb_pdev;
+	struct platform_device *usb_phy;
+	struct phy *phy;
+	struct usb_phy *xceiv;
+	enum phy_mode phy_mode;
+	struct clk *main;
+	struct clk *mcu;
+	struct clk *univpll;
+	struct regulator *vbus;
+	struct extcon_dev *edev;
+	struct notifier_block vbus_nb;
+	struct notifier_block id_nb;
+};
+
+static int mtk_musb_clks_get(struct mtk_glue *glue)
+{
+	struct device *dev = glue->dev;
+
+	glue->main = devm_clk_get(dev, "main");
+	if (IS_ERR(glue->main)) {
+		dev_err(dev, "fail to get main clock\n");
+		return PTR_ERR(glue->main);
+	}
+
+	glue->mcu = devm_clk_get(dev, "mcu");
+	if (IS_ERR(glue->mcu)) {
+		dev_err(dev, "fail to get mcu clock\n");
+		return PTR_ERR(glue->mcu);
+	}
+
+	glue->univpll = devm_clk_get(dev, "univpll");
+	if (IS_ERR(glue->univpll)) {
+		dev_err(dev, "fail to get univpll clock\n");
+		return PTR_ERR(glue->univpll);
+	}
+
+	return 0;
+}
+
+static int mtk_musb_clks_enable(struct mtk_glue *glue)
+{
+	int ret;
+
+	ret = clk_prepare_enable(glue->main);
+	if (ret) {
+		dev_err(glue->dev, "failed to enable main clock\n");
+		goto err_main_clk;
+	}
+
+	ret = clk_prepare_enable(glue->mcu);
+	if (ret) {
+		dev_err(glue->dev, "failed to enable mcu clock\n");
+		goto err_mcu_clk;
+	}
+
+	ret = clk_prepare_enable(glue->univpll);
+	if (ret) {
+		dev_err(glue->dev, "failed to enable univpll clock\n");
+		goto err_univpll_clk;
+	}
+
+	return 0;
+
+err_univpll_clk:
+	clk_disable_unprepare(glue->mcu);
+err_mcu_clk:
+	clk_disable_unprepare(glue->main);
+err_main_clk:
+	return ret;
+}
+
+static void mtk_musb_clks_disable(struct mtk_glue *glue)
+{
+	clk_disable_unprepare(glue->univpll);
+	clk_disable_unprepare(glue->mcu);
+	clk_disable_unprepare(glue->main);
+}
+
+static void mtk_musb_set_vbus(struct musb *musb, int is_on)
+{
+	struct device *dev = musb->controller;
+	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
+	int ret;
+
+	/* vbus is optional */
+	if (!glue->vbus)
+		return;
+
+	dev_dbg(musb->controller, "%s, is_on=%d\r\n", __func__, is_on);
+	if (is_on) {
+		ret = regulator_enable(glue->vbus);
+		if (ret) {
+			dev_err(glue->dev, "fail to enable vbus regulator\n");
+			return;
+		}
+	} else {
+		regulator_disable(glue->vbus);
+	}
+}
+
+/*
+ * switch to host: -> MTK_VBUS_OFF --> MTK_ID_GROUND
+ * switch to device: -> MTK_ID_FLOAT --> MTK_VBUS_VALID
+ */
+static void mtk_musb_set_mailbox(struct mtk_glue *glue,
+				 enum mtk_vbus_id_state status)
+{
+	struct musb *musb = glue->musb;
+	u8 devctl = 0;
+
+	dev_dbg(glue->dev, "mailbox state(%d)\n", status);
+	switch (status) {
+	case MTK_ID_GROUND:
+		phy_power_on(glue->phy);
+		devctl = readb(musb->mregs + MUSB_DEVCTL);
+		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
+		mtk_musb_set_vbus(musb, 1);
+		glue->phy_mode = PHY_MODE_USB_HOST;
+		phy_set_mode(glue->phy, glue->phy_mode);
+		devctl |= MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+		MUSB_HST_MODE(musb);
+		break;
+	/*
+	 * MTK_ID_FLOAT process is the same as MTK_VBUS_VALID
+	 * except that turn off VBUS
+	 */
+	case MTK_ID_FLOAT:
+		mtk_musb_set_vbus(musb, 0);
+		/* fall through */
+	case MTK_VBUS_OFF:
+		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		devctl &= ~MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+		phy_power_off(glue->phy);
+		break;
+	case MTK_VBUS_VALID:
+		phy_power_on(glue->phy);
+		glue->phy_mode = PHY_MODE_USB_DEVICE;
+		phy_set_mode(glue->phy, glue->phy_mode);
+		MUSB_DEV_MODE(musb);
+		break;
+	default:
+		dev_err(glue->dev, "invalid state\n");
+	}
+}
+
+static int mtk_musb_id_notifier(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct mtk_glue *glue = container_of(nb, struct mtk_glue, id_nb);
+
+	if (event)
+		mtk_musb_set_mailbox(glue, MTK_ID_GROUND);
+	else
+		mtk_musb_set_mailbox(glue, MTK_ID_FLOAT);
+
+	return NOTIFY_DONE;
+}
+
+static int mtk_musb_vbus_notifier(struct notifier_block *nb,
+				  unsigned long event, void *ptr)
+{
+	struct mtk_glue *glue = container_of(nb, struct mtk_glue, vbus_nb);
+
+	if (event)
+		mtk_musb_set_mailbox(glue, MTK_VBUS_VALID);
+	else
+		mtk_musb_set_mailbox(glue, MTK_VBUS_OFF);
+
+	return NOTIFY_DONE;
+}
+
+static void mtk_otg_switch_init(struct mtk_glue *glue)
+{
+	int ret;
+
+	/* extcon is optional */
+	if (!glue->edev)
+		return;
+
+	glue->vbus_nb.notifier_call = mtk_musb_vbus_notifier;
+	ret = devm_extcon_register_notifier(glue->dev, glue->edev, EXTCON_USB,
+					    &glue->vbus_nb);
+	if (ret < 0)
+		dev_err(glue->dev, "failed to register notifier for USB\n");
+
+	glue->id_nb.notifier_call = mtk_musb_id_notifier;
+	ret = devm_extcon_register_notifier(glue->dev, glue->edev,
+					    EXTCON_USB_HOST, &glue->id_nb);
+	if (ret < 0)
+		dev_err(glue->dev, "failed to register notifier for USB-HOST\n");
+
+	dev_dbg(glue->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
+		extcon_get_state(glue->edev, EXTCON_USB),
+		extcon_get_state(glue->edev, EXTCON_USB_HOST));
+
+	/* default as host, switch to device mode if needed */
+	if (extcon_get_state(glue->edev, EXTCON_USB_HOST) == false)
+		mtk_musb_set_mailbox(glue, MTK_ID_FLOAT);
+	if (extcon_get_state(glue->edev, EXTCON_USB) == true)
+		mtk_musb_set_mailbox(glue, MTK_VBUS_VALID);
+}
+
+static irqreturn_t generic_interrupt(int irq, void *__hci)
+{
+	unsigned long flags;
+	irqreturn_t retval = IRQ_NONE;
+	struct musb *musb = __hci;
+
+	spin_lock_irqsave(&musb->lock, flags);
+	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB) &
+	    musb_readb(musb->mregs, MUSB_INTRUSBE);
+	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX)
+	    & musb_readw(musb->mregs, MUSB_INTRTXE);
+	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX)
+	    & musb_readw(musb->mregs, MUSB_INTRRXE);
+	/* MediaTek controller interrupt status is W1C */
+	musb_clearw(musb->mregs, MUSB_INTRRX);
+	musb_clearw(musb->mregs, MUSB_INTRTX);
+	musb_clearb(musb->mregs, MUSB_INTRUSB);
+
+	if (musb->int_usb || musb->int_tx || musb->int_rx)
+		retval = musb_interrupt(musb);
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+
+	return retval;
+}
+
+static irqreturn_t mtk_musb_interrupt(int irq, void *dev_id)
+{
+	irqreturn_t retval = IRQ_NONE;
+	struct musb *musb = (struct musb *)dev_id;
+	u32 l1_ints;
+
+	l1_ints = musb_readl(musb->mregs, USB_L1INTS) &
+			musb_readl(musb->mregs, USB_L1INTM);
+
+	if (l1_ints & (TX_INT_STATUS | RX_INT_STATUS | USBCOM_INT_STATUS))
+		retval = generic_interrupt(irq, musb);
+
+#if defined(CONFIG_USB_INVENTRA_DMA)
+	if (l1_ints & DMA_INT_STATUS)
+		retval = dma_controller_irq(irq, musb->dma_controller);
+#endif
+	return retval;
+}
+
+static u32 mtk_musb_busctl_offset(u8 epnum, u16 offset)
+{
+	return MTK_MUSB_TXFUNCADDR + offset + 8 * epnum;
+}
+
+static u8 mtk_musb_clearb(void __iomem *addr, unsigned int offset)
+{
+	u8 data;
+
+	/* W1C */
+	data = musb_readb(addr, offset);
+	musb_writeb(addr, offset, data);
+	return musb_readb(addr, offset);
+}
+
+static u16 mtk_musb_clearw(void __iomem *addr, unsigned int offset)
+{
+	u16 data;
+
+	/* W1C */
+	data = musb_readw(addr, offset);
+	musb_writew(addr, offset, data);
+	return musb_readw(addr, offset);
+}
+
+static int mtk_musb_init(struct musb *musb)
+{
+	struct device *dev = musb->controller;
+	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
+	int ret;
+
+	glue->musb = musb;
+	musb->phy = glue->phy;
+	musb->xceiv = glue->xceiv;
+	musb->is_host = false;
+	musb->isr = mtk_musb_interrupt;
+	ret = phy_init(glue->phy);
+	if (ret)
+		return ret;
+
+	ret = phy_power_on(glue->phy);
+	if (ret) {
+		phy_exit(glue->phy);
+		return ret;
+	}
+
+	phy_set_mode(glue->phy, glue->phy_mode);
+
+#if defined(CONFIG_USB_INVENTRA_DMA)
+	musb_writel(musb->mregs, MUSB_HSDMA_INTR,
+		    DMA_INTR_STATUS_MSK | DMA_INTR_UNMASK_SET_MSK);
+#endif
+	musb_writel(musb->mregs, USB_L1INTM, TX_INT_STATUS | RX_INT_STATUS |
+		    USBCOM_INT_STATUS | DMA_INT_STATUS);
+	return 0;
+}
+
+static u16 mtk_musb_get_toggle(struct musb_qh *qh, int is_out)
+{
+	struct musb *musb = qh->hw_ep->musb;
+	u8 epnum = qh->hw_ep->epnum;
+	u16 toggle;
+
+	if (is_out)
+		toggle = musb_readw(musb->mregs, MUSB_TXTOG);
+	else
+		toggle = musb_readw(musb->mregs, MUSB_RXTOG);
+
+	return toggle & (1 << epnum);
+}
+
+static u16 mtk_musb_set_toggle(struct musb_qh *qh, int is_out, struct urb *urb)
+{
+	struct musb *musb = qh->hw_ep->musb;
+	u8 epnum = qh->hw_ep->epnum;
+	u16 toggle;
+
+	toggle = usb_gettoggle(urb->dev, qh->epnum, is_out);
+
+	if (is_out) {
+		musb_writew(musb->mregs, MUSB_TXTOGEN, (1 << epnum));
+		musb_writew(musb->mregs, MUSB_TXTOG, (toggle << epnum));
+	} else {
+		musb_writew(musb->mregs, MUSB_RXTOGEN, (1 << epnum));
+		musb_writew(musb->mregs, MUSB_RXTOG, (toggle << epnum));
+	}
+
+	return 0;
+}
+
+static int mtk_musb_set_mode(struct musb *musb, u8 mode)
+{
+	struct device *dev = musb->controller;
+	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
+	enum phy_mode new_mode;
+
+	switch (mode) {
+	case MUSB_HOST:
+		new_mode = PHY_MODE_USB_HOST;
+		mtk_musb_set_vbus(musb, 1);
+		break;
+	case MUSB_PERIPHERAL:
+		new_mode = PHY_MODE_USB_DEVICE;
+		break;
+	case MUSB_OTG:
+		new_mode = PHY_MODE_USB_HOST;
+		break;
+	default:
+		dev_err(musb->controller->parent,
+			"Error requested mode not supported by this kernel\n");
+		return -EINVAL;
+	}
+	if (glue->phy_mode == new_mode)
+		return 0;
+
+	mtk_musb_set_mailbox(glue, MTK_ID_GROUND);
+	return 0;
+}
+
+static int mtk_musb_exit(struct musb *musb)
+{
+	struct device *dev = musb->controller;
+	struct mtk_glue *glue = dev_get_drvdata(dev->parent);
+
+	phy_power_off(glue->phy);
+	phy_exit(glue->phy);
+	mtk_musb_clks_disable(glue);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return 0;
+}
+
+static const struct musb_platform_ops mtk_musb_ops = {
+	.quirks = MUSB_DMA_INVENTRA,
+	.init = mtk_musb_init,
+	.get_toggle = mtk_musb_get_toggle,
+	.set_toggle = mtk_musb_set_toggle,
+	.exit = mtk_musb_exit,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init = musbhs_dma_controller_create_noirq,
+	.dma_exit = musbhs_dma_controller_destroy,
+#endif
+	.clearb = mtk_musb_clearb,
+	.clearw = mtk_musb_clearw,
+	.busctl_offset = mtk_musb_busctl_offset,
+	.set_mode = mtk_musb_set_mode,
+	.set_vbus = mtk_musb_set_vbus,
+};
+
+#define MTK_MUSB_MAX_EP_NUM	8
+#define MTK_MUSB_RAM_BITS	11
+
+static struct musb_fifo_cfg mtk_musb_mode_cfg[] = {
+	{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 4, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 4, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 5, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 5, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 6, .style = FIFO_TX, .maxpacket = 1024, },
+	{ .hw_ep_num = 6, .style = FIFO_RX, .maxpacket = 1024, },
+	{ .hw_ep_num = 7, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 7, .style = FIFO_RX, .maxpacket = 64, },
+};
+
+static const struct musb_hdrc_config mtk_musb_hdrc_config = {
+	.fifo_cfg = mtk_musb_mode_cfg,
+	.fifo_cfg_size = ARRAY_SIZE(mtk_musb_mode_cfg),
+	.multipoint = true,
+	.dyn_fifo = true,
+	.num_eps = MTK_MUSB_MAX_EP_NUM,
+	.ram_bits = MTK_MUSB_RAM_BITS,
+};
+
+static const struct platform_device_info mtk_dev_info = {
+	.name = "musb-hdrc",
+	.id = PLATFORM_DEVID_AUTO,
+	.dma_mask = DMA_BIT_MASK(32),
+};
+
+static int mtk_musb_probe(struct platform_device *pdev)
+{
+	struct musb_hdrc_platform_data *pdata;
+	struct mtk_glue *glue;
+	struct platform_device_info pinfo;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret = -ENOMEM;
+
+	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
+	if (!glue)
+		return -ENOMEM;
+
+	glue->dev = dev;
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	ret = mtk_musb_clks_get(glue);
+	if (ret)
+		return ret;
+
+	glue->vbus = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(glue->vbus)) {
+		dev_err(dev, "fail to get vbus\n");
+		return PTR_ERR(glue->vbus);
+	}
+
+	pdata->config = &mtk_musb_hdrc_config;
+	pdata->platform_ops = &mtk_musb_ops;
+	if (of_property_read_bool(np, "extcon")) {
+		glue->edev = extcon_get_edev_by_phandle(dev, 0);
+		if (IS_ERR(glue->edev)) {
+			dev_err(dev, "fail to get extcon\n");
+			return PTR_ERR(glue->edev);
+		}
+	}
+
+	pdata->mode = usb_get_dr_mode(dev);
+	switch (pdata->mode) {
+	case USB_DR_MODE_HOST:
+		glue->phy_mode = PHY_MODE_USB_HOST;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		glue->phy_mode = PHY_MODE_USB_DEVICE;
+		break;
+	default:
+		pdata->mode = USB_DR_MODE_OTG;
+		/* FALL THROUGH */
+	case USB_DR_MODE_OTG:
+		glue->phy_mode = PHY_MODE_USB_OTG;
+		break;
+	}
+
+	glue->phy = devm_of_phy_get_by_index(dev, np, 0);
+	if (IS_ERR(glue->phy)) {
+		dev_err(dev, "fail to getting phy %ld\n",
+			PTR_ERR(glue->phy));
+		return PTR_ERR(glue->phy);
+	}
+
+	glue->usb_phy = usb_phy_generic_register();
+	if (IS_ERR(glue->usb_phy)) {
+		dev_err(dev, "fail to registering usb-phy %ld\n",
+			PTR_ERR(glue->usb_phy));
+		return PTR_ERR(glue->usb_phy);
+	}
+
+	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (IS_ERR(glue->xceiv)) {
+		dev_err(dev, "fail to getting usb-phy %d\n", ret);
+		ret = PTR_ERR(glue->xceiv);
+		goto err_unregister_usb_phy;
+	}
+
+	platform_set_drvdata(pdev, glue);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	ret = mtk_musb_clks_enable(glue);
+	if (ret)
+		goto err_enable_clk;
+
+	pinfo = mtk_dev_info;
+	pinfo.parent = dev;
+	pinfo.res = pdev->resource;
+	pinfo.num_res = pdev->num_resources;
+	pinfo.data = pdata;
+	pinfo.size_data = sizeof(*pdata);
+
+	glue->musb_pdev = platform_device_register_full(&pinfo);
+	if (IS_ERR(glue->musb_pdev)) {
+		ret = PTR_ERR(glue->musb_pdev);
+		dev_err(dev, "failed to register musb device: %d\n", ret);
+		goto err_device_register;
+	}
+
+	if (pdata->mode == USB_DR_MODE_OTG)
+		mtk_otg_switch_init(glue);
+
+	return 0;
+
+err_device_register:
+	mtk_musb_clks_disable(glue);
+err_enable_clk:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+err_unregister_usb_phy:
+	usb_phy_generic_unregister(glue->usb_phy);
+	return ret;
+}
+
+static int mtk_musb_remove(struct platform_device *pdev)
+{
+	struct mtk_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *usb_phy = glue->usb_phy;
+
+	platform_device_unregister(glue->musb_pdev);
+	usb_phy_generic_unregister(usb_phy);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mtk_musb_match[] = {
+	{.compatible = "mediatek,mtk-musb",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_musb_match);
+#endif
+
+static struct platform_driver mtk_musb_driver = {
+	.probe = mtk_musb_probe,
+	.remove = mtk_musb_remove,
+	.driver = {
+		   .name = "musb-mtk",
+		   .of_match_table = of_match_ptr(mtk_musb_match),
+	},
+};
+
+module_platform_driver(mtk_musb_driver);
+
+MODULE_DESCRIPTION("MediaTek MUSB Glue Layer");
+MODULE_AUTHOR("Min Guo <min.guo@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index d7a417b..5ef8848 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -274,6 +274,38 @@ static void musb_default_writew(void __iomem *addr, unsigned offset, u16 data)
 	__raw_writew(data, addr + offset);
 }
 
+static u16 musb_default_get_toggle(struct musb_qh *qh, int is_out)
+{
+	void __iomem *epio = qh->hw_ep->regs;
+	u16 csr;
+
+	if (is_out)
+		csr = musb_readw(epio, MUSB_TXCSR) & MUSB_TXCSR_H_DATATOGGLE;
+	else
+		csr = musb_readw(epio, MUSB_RXCSR) & MUSB_RXCSR_H_DATATOGGLE;
+
+	return csr;
+}
+
+static u16 musb_default_set_toggle(struct musb_qh *qh, int is_out,
+				   struct urb *urb)
+{
+	u16 csr;
+	u16 toggle;
+
+	toggle = usb_gettoggle(urb->dev, qh->epnum, is_out);
+
+	if (is_out)
+		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
+				| MUSB_TXCSR_H_DATATOGGLE)
+				: MUSB_TXCSR_CLRDATATOG;
+	else
+		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
+				| MUSB_RXCSR_H_DATATOGGLE) : 0;
+
+	return csr;
+}
+
 /*
  * Load an endpoint's FIFO
  */
@@ -370,12 +402,18 @@ static void musb_default_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
 EXPORT_SYMBOL_GPL(musb_writeb);
 
+u8 (*musb_clearb)(void __iomem *addr, unsigned int offset);
+EXPORT_SYMBOL_GPL(musb_clearb);
+
 u16 (*musb_readw)(void __iomem *addr, unsigned offset);
 EXPORT_SYMBOL_GPL(musb_readw);
 
 void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
 EXPORT_SYMBOL_GPL(musb_writew);
 
+u16 (*musb_clearw)(void __iomem *addr, unsigned int offset);
+EXPORT_SYMBOL_GPL(musb_clearw);
+
 u32 musb_readl(void __iomem *addr, unsigned offset)
 {
 	u32 data = __raw_readl(addr + offset);
@@ -1015,7 +1053,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 static void musb_disable_interrupts(struct musb *musb)
 {
 	void __iomem	*mbase = musb->mregs;
-	u16	temp;
 
 	/* disable interrupts */
 	musb_writeb(mbase, MUSB_INTRUSBE, 0);
@@ -1025,9 +1062,9 @@ static void musb_disable_interrupts(struct musb *musb)
 	musb_writew(mbase, MUSB_INTRRXE, 0);
 
 	/*  flush pending interrupts */
-	temp = musb_readb(mbase, MUSB_INTRUSB);
-	temp = musb_readw(mbase, MUSB_INTRTX);
-	temp = musb_readw(mbase, MUSB_INTRRX);
+	musb_clearb(mbase, MUSB_INTRUSB);
+	musb_clearw(mbase, MUSB_INTRTX);
+	musb_clearw(mbase, MUSB_INTRRX);
 }
 
 static void musb_enable_interrupts(struct musb *musb)
@@ -2252,10 +2289,19 @@ static void musb_deassert_reset(struct work_struct *work)
 		musb_readb = musb->ops->readb;
 	if (musb->ops->writeb)
 		musb_writeb = musb->ops->writeb;
+	if (musb->ops->clearb)
+		musb_clearb = musb->ops->clearb;
+	else
+		musb_clearb = musb_readb;
+
 	if (musb->ops->readw)
 		musb_readw = musb->ops->readw;
 	if (musb->ops->writew)
 		musb_writew = musb->ops->writew;
+	if (musb->ops->clearw)
+		musb_clearw = musb->ops->clearw;
+	else
+		musb_clearw = musb_readw;
 
 #ifndef CONFIG_MUSB_PIO_ONLY
 	if (!musb->ops->dma_init || !musb->ops->dma_exit) {
@@ -2277,6 +2323,16 @@ static void musb_deassert_reset(struct work_struct *work)
 	else
 		musb->io.write_fifo = musb_default_write_fifo;
 
+	if (musb->ops->get_toggle)
+		musb->io.get_toggle = musb->ops->get_toggle;
+	else
+		musb->io.get_toggle = musb_default_get_toggle;
+
+	if (musb->ops->set_toggle)
+		musb->io.set_toggle = musb->ops->set_toggle;
+	else
+		musb->io.set_toggle = musb_default_set_toggle;
+
 	if (!musb->xceiv->io_ops) {
 		musb->xceiv->io_dev = musb->controller;
 		musb->xceiv->io_priv = musb->mregs;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index daf5422..0d9a35f 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -27,6 +27,7 @@
 struct musb;
 struct musb_hw_ep;
 struct musb_ep;
+struct musb_qh;
 
 /* Helper defines for struct musb->hwvers */
 #define MUSB_HWVERS_MAJOR(x)	((x >> 10) & 0x1f)
@@ -119,10 +120,14 @@ enum musb_g_ep0_state {
  * @fifo_offset: returns the fifo offset
  * @readb:	read 8 bits
  * @writeb:	write 8 bits
+ * @clearb:	could be clear-on-readb or W1C
  * @readw:	read 16 bits
  * @writew:	write 16 bits
+ * @clearw:	could be clear-on-readw or W1C
  * @read_fifo:	reads the fifo
  * @write_fifo:	writes to fifo
+ * @get_toggle:	platform specific get toggle function
+ * @set_toggle:	platform specific set toggle function
  * @dma_init:	platform specific dma init function
  * @dma_exit:	platform specific dma exit function
  * @init:	turns on clocks, sets up platform-specific registers, etc
@@ -163,10 +168,14 @@ struct musb_platform_ops {
 	u32	(*busctl_offset)(u8 epnum, u16 offset);
 	u8	(*readb)(void __iomem *addr, unsigned offset);
 	void	(*writeb)(void __iomem *addr, unsigned offset, u8 data);
+	u8	(*clearb)(void __iomem *addr, unsigned int offset);
 	u16	(*readw)(void __iomem *addr, unsigned offset);
 	void	(*writew)(void __iomem *addr, unsigned offset, u16 data);
+	u16	(*clearw)(void __iomem *addr, unsigned int offset);
 	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
+	u16	(*get_toggle)(struct musb_qh *qh, int is_out);
+	u16	(*set_toggle)(struct musb_qh *qh, int is_out, struct urb *urb);
 	struct dma_controller *
 		(*dma_init) (struct musb *musb, void __iomem *base);
 	void	(*dma_exit)(struct dma_controller *c);
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 8f60271..05103ea 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -35,6 +35,12 @@
  *    whether shared with the Inventra core or separate.
  */
 
+#define MUSB_HSDMA_BASE		0x200
+#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
+#define MUSB_HSDMA_CONTROL		0x4
+#define MUSB_HSDMA_ADDRESS		0x8
+#define MUSB_HSDMA_COUNT		0xc
+
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
 #ifdef CONFIG_MUSB_PIO_ONLY
@@ -191,6 +197,9 @@ static inline void musb_dma_controller_destroy(struct dma_controller *d) { }
 extern struct dma_controller *
 musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
 extern void musbhs_dma_controller_destroy(struct dma_controller *c);
+extern struct dma_controller *
+musbhs_dma_controller_create_noirq(struct musb *musb, void __iomem *base);
+extern irqreturn_t dma_controller_irq(int irq, void *private_data);
 
 extern struct dma_controller *
 tusb_dma_controller_create(struct musb *musb, void __iomem *base);
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b59ce9a..b97fbf9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -286,26 +286,6 @@ static void musb_giveback(struct musb *musb, struct urb *urb, int status)
 	spin_lock(&musb->lock);
 }
 
-/* For bulk/interrupt endpoints only */
-static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
-				    struct urb *urb)
-{
-	void __iomem		*epio = qh->hw_ep->regs;
-	u16			csr;
-
-	/*
-	 * FIXME: the current Mentor DMA code seems to have
-	 * problems getting toggle correct.
-	 */
-
-	if (is_in)
-		csr = musb_readw(epio, MUSB_RXCSR) & MUSB_RXCSR_H_DATATOGGLE;
-	else
-		csr = musb_readw(epio, MUSB_TXCSR) & MUSB_TXCSR_H_DATATOGGLE;
-
-	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
-}
-
 /*
  * Advance this hardware endpoint's queue, completing the specified URB and
  * advancing to either the next URB queued to that qh, or else invalidating
@@ -320,6 +300,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	struct musb_hw_ep	*ep = qh->hw_ep;
 	int			ready = qh->is_ready;
 	int			status;
+	u16			toggle;
 
 	status = (urb->status == -EINPROGRESS) ? 0 : urb->status;
 
@@ -327,7 +308,8 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	switch (qh->type) {
 	case USB_ENDPOINT_XFER_BULK:
 	case USB_ENDPOINT_XFER_INT:
-		musb_save_toggle(qh, is_in, urb);
+		toggle = musb->io.get_toggle(qh, !is_in);
+		usb_settoggle(urb->dev, qh->epnum, !is_in, toggle ? 1 : 0);
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		if (status == 0 && urb->error_count)
@@ -772,13 +754,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					);
 			csr |= MUSB_TXCSR_MODE;
 
-			if (!hw_ep->tx_double_buffered) {
-				if (usb_gettoggle(urb->dev, qh->epnum, 1))
-					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
-						| MUSB_TXCSR_H_DATATOGGLE;
-				else
-					csr |= MUSB_TXCSR_CLRDATATOG;
-			}
+			if (!hw_ep->tx_double_buffered)
+				csr |= musb->io.set_toggle(qh, is_out, urb);
 
 			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
@@ -860,17 +837,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 	/* IN/receive */
 	} else {
-		u16	csr;
+		u16 csr = 0;
 
 		if (hw_ep->rx_reinit) {
 			musb_rx_reinit(musb, qh, epnum);
+			csr |= musb->io.set_toggle(qh, is_out, urb);
 
-			/* init new state: toggle and NYET, maybe DMA later */
-			if (usb_gettoggle(urb->dev, qh->epnum, 0))
-				csr = MUSB_RXCSR_H_WR_DATATOGGLE
-					| MUSB_RXCSR_H_DATATOGGLE;
-			else
-				csr = 0;
 			if (qh->type == USB_ENDPOINT_XFER_INT)
 				csr |= MUSB_RXCSR_DISNYET;
 
@@ -933,6 +905,7 @@ static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep,
 	void __iomem		*epio = ep->regs;
 	struct musb_qh		*cur_qh, *next_qh;
 	u16			rx_csr, tx_csr;
+	u16			toggle;
 
 	musb_ep_select(mbase, ep->epnum);
 	if (is_in) {
@@ -970,7 +943,8 @@ static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep,
 			urb->actual_length += dma->actual_len;
 			dma->actual_len = 0L;
 		}
-		musb_save_toggle(cur_qh, is_in, urb);
+		toggle = musb->io.get_toggle(cur_qh, !is_in);
+		usb_settoggle(urb->dev, cur_qh->epnum, !is_in, toggle ? 1 : 0);
 
 		if (is_in) {
 			/* move cur_qh to end of queue */
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 34ea2a4..7200596 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -22,6 +22,8 @@
  * @read_fifo:	platform specific function to read fifo
  * @write_fifo:	platform specific function to write fifo
  * @busctl_offset: platform specific function to get busctl offset
+ * @get_toggle: platform specific function to get toggle
+ * @set_toggle: platform specific function to set toggle
  */
 struct musb_io {
 	u32	(*ep_offset)(u8 epnum, u16 offset);
@@ -30,13 +32,17 @@ struct musb_io {
 	void	(*read_fifo)(struct musb_hw_ep *hw_ep, u16 len, u8 *buf);
 	void	(*write_fifo)(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf);
 	u32	(*busctl_offset)(u8 epnum, u16 offset);
+	u16	(*get_toggle)(struct musb_qh *qh, int is_out);
+	u16	(*set_toggle)(struct musb_qh *qh, int is_out, struct urb *urb);
 };
 
 /* Do not add new entries here, add them the struct musb_io instead */
 extern u8 (*musb_readb)(void __iomem *addr, unsigned offset);
 extern void (*musb_writeb)(void __iomem *addr, unsigned offset, u8 data);
+extern u8 (*musb_clearb)(void __iomem *addr, unsigned int offset);
 extern u16 (*musb_readw)(void __iomem *addr, unsigned offset);
 extern void (*musb_writew)(void __iomem *addr, unsigned offset, u16 data);
+extern u16 (*musb_clearw)(void __iomem *addr, unsigned int offset);
 extern u32 musb_readl(void __iomem *addr, unsigned offset);
 extern void musb_writel(void __iomem *addr, unsigned offset, u32 data);
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a688f7f..d97ab89 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -10,12 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include "musb_core.h"
-
-#define MUSB_HSDMA_BASE		0x200
-#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
-#define MUSB_HSDMA_CONTROL		0x4
-#define MUSB_HSDMA_ADDRESS		0x8
-#define MUSB_HSDMA_COUNT		0xc
+#include "musb_dma.h"
 
 #define MUSB_HSDMA_CHANNEL_OFFSET(_bchannel, _offset)		\
 		(MUSB_HSDMA_BASE + (_bchannel << 4) + _offset)
@@ -268,7 +263,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 	return 0;
 }
 
-static irqreturn_t dma_controller_irq(int irq, void *private_data)
+irqreturn_t dma_controller_irq(int irq, void *private_data)
 {
 	struct musb_dma_controller *controller = private_data;
 	struct musb *musb = controller->private_data;
@@ -291,6 +286,9 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 
+	/* clear pending interrupts by manual */
+	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
+
 	if (!int_hsdma) {
 		musb_dbg(musb, "spurious DMA irq");
 
@@ -382,6 +380,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(dma_controller_irq);
 
 void musbhs_dma_controller_destroy(struct dma_controller *c)
 {
@@ -397,18 +396,10 @@ void musbhs_dma_controller_destroy(struct dma_controller *c)
 }
 EXPORT_SYMBOL_GPL(musbhs_dma_controller_destroy);
 
-struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
-						    void __iomem *base)
+static struct musb_dma_controller *dma_controller_alloc(struct musb *musb,
+							void __iomem *base)
 {
 	struct musb_dma_controller *controller;
-	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq_byname(pdev, "dma");
-
-	if (irq <= 0) {
-		dev_err(dev, "No DMA interrupt line!\n");
-		return NULL;
-	}
 
 	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
 	if (!controller)
@@ -422,6 +413,25 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	controller->controller.channel_release = dma_channel_release;
 	controller->controller.channel_program = dma_channel_program;
 	controller->controller.channel_abort = dma_channel_abort;
+	return controller;
+}
+
+struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
+						    void __iomem *base)
+{
+	struct musb_dma_controller *controller;
+	struct device *dev = musb->controller;
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq = platform_get_irq_byname(pdev, "dma");
+
+	if (irq <= 0) {
+		dev_err(dev, "No DMA interrupt line!\n");
+		return NULL;
+	}
+
+	controller = dma_controller_alloc(musb, base);
+	if (!controller)
+		return NULL;
 
 	if (request_irq(irq, dma_controller_irq, 0,
 			dev_name(musb->controller), &controller->controller)) {
@@ -436,3 +446,16 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	return &controller->controller;
 }
 EXPORT_SYMBOL_GPL(musbhs_dma_controller_create);
+
+struct dma_controller *musbhs_dma_controller_create_noirq(struct musb *musb,
+							  void __iomem *base)
+{
+	struct musb_dma_controller *controller;
+
+	controller = dma_controller_alloc(musb, base);
+	if (!controller)
+		return NULL;
+
+	return &controller->controller;
+}
+EXPORT_SYMBOL_GPL(musbhs_dma_controller_create_noirq);
-- 
1.9.1

