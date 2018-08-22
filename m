Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A23C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E2208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E2208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeHWAKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:15 -0400
Received: from shell.v3.sk ([90.176.6.54]:53369 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeHWAKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9BF8DB5B0C;
        Wed, 22 Aug 2018 22:43:47 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q-FMXQYLJ8vd; Wed, 22 Aug 2018 22:43:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3F0D7B5B93;
        Wed, 22 Aug 2018 22:43:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0GrIrrwdIdF8; Wed, 22 Aug 2018 22:43:14 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 89A9FB5B8B;
        Wed, 22 Aug 2018 22:43:13 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/14] USB: phy-mv-usb: use phy-pxa-usb
Date:   Wed, 22 Aug 2018 22:43:02 +0200
Message-Id: <20180822204307.13251-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a proper PHY driver, instead of hooks to a board support package.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c  |  11 +---
 drivers/usb/phy/phy-mv-usb.c | 123 ++++++++++++++++-------------------
 drivers/usb/phy/phy-mv-usb.h |   8 ++-
 3 files changed, 62 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 822b8be042b9..eb9b3c34e90a 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -325,21 +325,12 @@ struct platform_device pxa168_device_u2oehci = {
 
 #if IS_ENABLED(CONFIG_USB_MV_OTG)
 struct resource pxa168_u2ootg_resources[] = {
-	/* regbase */
 	[0] = {
-		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
+		.start	= PXA168_U2O_REGBASE,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
 	},
-	/* phybase */
 	[1] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
 		.start	= IRQ_PXA168_USB1,
 		.end	= IRQ_PXA168_USB1,
 		.flags	= IORESOURCE_IRQ,
diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index cfd9add10bf4..0f67c5b65fe9 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -50,7 +50,7 @@ static char *state_string[] = {
 
 static int mv_otg_set_vbus(struct usb_otg *otg, bool on)
 {
-	struct mv_otg *mvotg = container_of(otg->usb_phy, struct mv_otg, phy);
+	struct mv_otg *mvotg = container_of(otg->usb_phy, struct mv_otg, usb_phy);
 	if (mvotg->pdata->set_vbus == NULL)
 		return -ENODEV;
 
@@ -193,7 +193,7 @@ static void mv_otg_init_irq(struct mv_otg *mvotg)
 static void mv_otg_start_host(struct mv_otg *mvotg, int on)
 {
 #ifdef CONFIG_USB
-	struct usb_otg *otg = mvotg->phy.otg;
+	struct usb_otg *otg = mvotg->usb_phy.otg;
 	struct usb_hcd *hcd;
 
 	if (!otg->host)
@@ -214,12 +214,12 @@ static void mv_otg_start_host(struct mv_otg *mvotg, int on)
 
 static void mv_otg_start_periphrals(struct mv_otg *mvotg, int on)
 {
-	struct usb_otg *otg = mvotg->phy.otg;
+	struct usb_otg *otg = mvotg->usb_phy.otg;
 
 	if (!otg->gadget)
 		return;
 
-	dev_info(mvotg->phy.dev, "gadget %s\n", on ? "on" : "off");
+	dev_info(mvotg->usb_phy.dev, "gadget %s\n", on ? "on" : "off");
 
 	if (on)
 		usb_gadget_vbus_connect(otg->gadget);
@@ -247,14 +247,11 @@ static int mv_otg_enable_internal(struct mv_otg *mvotg)
 	dev_dbg(&mvotg->pdev->dev, "otg enabled\n");
 
 	otg_clock_enable(mvotg);
-	if (mvotg->pdata->phy_init) {
-		retval = mvotg->pdata->phy_init(mvotg->phy_regs);
-		if (retval) {
-			dev_err(&mvotg->pdev->dev,
-				"init phy error %d\n", retval);
-			otg_clock_disable(mvotg);
-			return retval;
-		}
+	retval = phy_init(mvotg->phy);
+	if (retval) {
+		dev_err(&mvotg->pdev->dev, "init phy error %d\n", retval);
+		otg_clock_disable(mvotg);
+		return retval;
 	}
 	mvotg->active = 1;
 
@@ -274,8 +271,7 @@ static void mv_otg_disable_internal(struct mv_otg *mvotg)
 {
 	if (mvotg->active) {
 		dev_dbg(&mvotg->pdev->dev, "otg disabled\n");
-		if (mvotg->pdata->phy_deinit)
-			mvotg->pdata->phy_deinit(mvotg->phy_regs);
+		phy_exit(mvotg->phy);
 		otg_clock_disable(mvotg);
 		mvotg->active = 0;
 	}
@@ -329,68 +325,68 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
 static void mv_otg_update_state(struct mv_otg *mvotg)
 {
 	struct mv_otg_ctrl *otg_ctrl = &mvotg->otg_ctrl;
-	int old_state = mvotg->phy.otg->state;
+	int old_state = mvotg->usb_phy.otg->state;
 
 	switch (old_state) {
 	case OTG_STATE_UNDEFINED:
-		mvotg->phy.otg->state = OTG_STATE_B_IDLE;
+		mvotg->usb_phy.otg->state = OTG_STATE_B_IDLE;
 		/* FALL THROUGH */
 	case OTG_STATE_B_IDLE:
 		if (otg_ctrl->id == 0)
-			mvotg->phy.otg->state = OTG_STATE_A_IDLE;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_IDLE;
 		else if (otg_ctrl->b_sess_vld)
-			mvotg->phy.otg->state = OTG_STATE_B_PERIPHERAL;
+			mvotg->usb_phy.otg->state = OTG_STATE_B_PERIPHERAL;
 		break;
 	case OTG_STATE_B_PERIPHERAL:
 		if (!otg_ctrl->b_sess_vld || otg_ctrl->id == 0)
-			mvotg->phy.otg->state = OTG_STATE_B_IDLE;
+			mvotg->usb_phy.otg->state = OTG_STATE_B_IDLE;
 		break;
 	case OTG_STATE_A_IDLE:
 		if (otg_ctrl->id)
-			mvotg->phy.otg->state = OTG_STATE_B_IDLE;
+			mvotg->usb_phy.otg->state = OTG_STATE_B_IDLE;
 		else if (!(otg_ctrl->a_bus_drop) &&
 			 (otg_ctrl->a_bus_req || otg_ctrl->a_srp_det))
-			mvotg->phy.otg->state = OTG_STATE_A_WAIT_VRISE;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_WAIT_VRISE;
 		break;
 	case OTG_STATE_A_WAIT_VRISE:
 		if (otg_ctrl->a_vbus_vld)
-			mvotg->phy.otg->state = OTG_STATE_A_WAIT_BCON;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_WAIT_BCON;
 		break;
 	case OTG_STATE_A_WAIT_BCON:
 		if (otg_ctrl->id || otg_ctrl->a_bus_drop
 		    || otg_ctrl->a_wait_bcon_timeout) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout = 0;
-			mvotg->phy.otg->state = OTG_STATE_A_WAIT_VFALL;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_WAIT_VFALL;
 			otg_ctrl->a_bus_req = 0;
 		} else if (!otg_ctrl->a_vbus_vld) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout = 0;
-			mvotg->phy.otg->state = OTG_STATE_A_VBUS_ERR;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_VBUS_ERR;
 		} else if (otg_ctrl->b_conn) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout = 0;
-			mvotg->phy.otg->state = OTG_STATE_A_HOST;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_HOST;
 		}
 		break;
 	case OTG_STATE_A_HOST:
 		if (otg_ctrl->id || !otg_ctrl->b_conn
 		    || otg_ctrl->a_bus_drop)
-			mvotg->phy.otg->state = OTG_STATE_A_WAIT_BCON;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_WAIT_BCON;
 		else if (!otg_ctrl->a_vbus_vld)
-			mvotg->phy.otg->state = OTG_STATE_A_VBUS_ERR;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_VBUS_ERR;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
 		if (otg_ctrl->id
 		    || (!otg_ctrl->b_conn && otg_ctrl->a_sess_vld)
 		    || otg_ctrl->a_bus_req)
-			mvotg->phy.otg->state = OTG_STATE_A_IDLE;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_IDLE;
 		break;
 	case OTG_STATE_A_VBUS_ERR:
 		if (otg_ctrl->id || otg_ctrl->a_clr_err
 		    || otg_ctrl->a_bus_drop) {
 			otg_ctrl->a_clr_err = 0;
-			mvotg->phy.otg->state = OTG_STATE_A_WAIT_VFALL;
+			mvotg->usb_phy.otg->state = OTG_STATE_A_WAIT_VFALL;
 		}
 		break;
 	default:
@@ -409,8 +405,8 @@ static void mv_otg_work(struct work_struct *work)
 
 run:
 	/* work queue is single thread, or we need spin_lock to protect */
-	phy = &mvotg->phy;
-	otg = mvotg->phy.otg;
+	phy = &mvotg->usb_phy;
+	otg = mvotg->usb_phy.otg;
 	old_state = otg->state;
 
 	if (!mvotg->active)
@@ -419,24 +415,24 @@ static void mv_otg_work(struct work_struct *work)
 	mv_otg_update_inputs(mvotg);
 	mv_otg_update_state(mvotg);
 
-	if (old_state != mvotg->phy.otg->state) {
+	if (old_state != mvotg->usb_phy.otg->state) {
 		dev_info(&mvotg->pdev->dev, "change from state %s to %s\n",
 			 state_string[old_state],
-			 state_string[mvotg->phy.otg->state]);
+			 state_string[mvotg->usb_phy.otg->state]);
 
-		switch (mvotg->phy.otg->state) {
+		switch (mvotg->usb_phy.otg->state) {
 		case OTG_STATE_B_IDLE:
 			otg->default_a = 0;
 			if (old_state == OTG_STATE_B_PERIPHERAL)
 				mv_otg_start_periphrals(mvotg, 0);
 			mv_otg_reset(mvotg);
 			mv_otg_disable(mvotg);
-			usb_phy_set_event(&mvotg->phy, USB_EVENT_NONE);
+			usb_phy_set_event(&mvotg->usb_phy, USB_EVENT_NONE);
 			break;
 		case OTG_STATE_B_PERIPHERAL:
 			mv_otg_enable(mvotg);
 			mv_otg_start_periphrals(mvotg, 1);
-			usb_phy_set_event(&mvotg->phy, USB_EVENT_ENUMERATED);
+			usb_phy_set_event(&mvotg->usb_phy, USB_EVENT_ENUMERATED);
 			break;
 		case OTG_STATE_A_IDLE:
 			otg->default_a = 1;
@@ -536,8 +532,8 @@ a_bus_req_store(struct device *dev, struct device_attribute *attr,
 		return -1;
 
 	/* We will use this interface to change to A device */
-	if (mvotg->phy.otg->state != OTG_STATE_B_IDLE
-	    && mvotg->phy.otg->state != OTG_STATE_A_IDLE)
+	if (mvotg->usb_phy.otg->state != OTG_STATE_B_IDLE
+	    && mvotg->usb_phy.otg->state != OTG_STATE_A_IDLE)
 		return -1;
 
 	/* The clock may disabled and we need to set irq for ID detected */
@@ -566,7 +562,7 @@ a_clr_err_store(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
 {
 	struct mv_otg *mvotg = dev_get_drvdata(dev);
-	if (!mvotg->phy.otg->default_a)
+	if (!mvotg->usb_phy.otg->default_a)
 		return -1;
 
 	if (count > 2)
@@ -602,7 +598,7 @@ a_bus_drop_store(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct mv_otg *mvotg = dev_get_drvdata(dev);
-	if (!mvotg->phy.otg->default_a)
+	if (!mvotg->usb_phy.otg->default_a)
 		return -1;
 
 	if (count > 2)
@@ -656,7 +652,7 @@ static int mv_otg_remove(struct platform_device *pdev)
 
 	mv_otg_disable(mvotg);
 
-	usb_remove_phy(&mvotg->phy);
+	usb_remove_phy(&mvotg->usb_phy);
 
 	return 0;
 }
@@ -687,6 +683,10 @@ static int mv_otg_probe(struct platform_device *pdev)
 	mvotg->pdev = pdev;
 	mvotg->pdata = pdata;
 
+	mvotg->phy = devm_phy_get(&pdev->dev, "usb");
+	if (IS_ERR(mvotg->phy))
+		return PTR_ERR(mvotg->phy);
+
 	mvotg->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mvotg->clk))
 		return PTR_ERR(mvotg->clk);
@@ -701,12 +701,12 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	/* OTG common part */
 	mvotg->pdev = pdev;
-	mvotg->phy.dev = &pdev->dev;
-	mvotg->phy.otg = otg;
-	mvotg->phy.label = driver_name;
+	mvotg->usb_phy.dev = &pdev->dev;
+	mvotg->usb_phy.otg = otg;
+	mvotg->usb_phy.label = driver_name;
 
 	otg->state = OTG_STATE_UNDEFINED;
-	otg->usb_phy = &mvotg->phy;
+	otg->usb_phy = &mvotg->usb_phy;
 	otg->set_host = mv_otg_set_host;
 	otg->set_peripheral = mv_otg_set_peripheral;
 	otg->set_vbus = mv_otg_set_vbus;
@@ -715,36 +715,23 @@ static int mv_otg_probe(struct platform_device *pdev)
 		timer_setup(&mvotg->otg_ctrl.timer[i],
 			    mv_otg_timer_await_bcon, 0);
 
-	r = platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		retval = -ENODEV;
-		goto err_destroy_workqueue;
-	}
-
-	mvotg->phy_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (mvotg->phy_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		retval = -EFAULT;
-		goto err_destroy_workqueue;
-	}
-
-	r = platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(mvotg->pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		retval = -ENODEV;
 		goto err_destroy_workqueue;
 	}
 
-	mvotg->cap_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (mvotg->cap_regs == NULL) {
+	mvotg->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (mvotg->base == NULL) {
 		dev_err(&pdev->dev, "failed to map I/O memory\n");
 		retval = -EFAULT;
 		goto err_destroy_workqueue;
 	}
 
+	mvotg->cap_regs =
+		(void __iomem *) ((unsigned long)mvotg->base + U2x_CAPREGS_OFFSET);
+
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
 	if (retval) {
@@ -804,7 +791,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	retval = usb_add_phy(&mvotg->phy, USB_PHY_TYPE_USB2);
+	retval = usb_add_phy(&mvotg->usb_phy, USB_PHY_TYPE_USB2);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "can't register transceiver, %d\n",
 			retval);
@@ -831,7 +818,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	return 0;
 
 err_remove_phy:
-	usb_remove_phy(&mvotg->phy);
+	usb_remove_phy(&mvotg->usb_phy);
 err_disable_clk:
 	mv_otg_disable_internal(mvotg);
 err_destroy_workqueue:
@@ -846,10 +833,10 @@ static int mv_otg_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct mv_otg *mvotg = platform_get_drvdata(pdev);
 
-	if (mvotg->phy.otg->state != OTG_STATE_B_IDLE) {
+	if (mvotg->usb_phy.otg->state != OTG_STATE_B_IDLE) {
 		dev_info(&pdev->dev,
 			 "OTG state is not B_IDLE, it is %d!\n",
-			 mvotg->phy.otg->state);
+			 mvotg->usb_phy.otg->state);
 		return -EAGAIN;
 	}
 
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 96701a1229ad..9b7bc6d958a8 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
@@ -8,6 +8,9 @@
 
 #include <linux/types.h>
 
+/* registers */
+#define U2x_CAPREGS_OFFSET       0x100
+
 /* Command Register Bit Masks */
 #define USBCMD_RUN_STOP			(0x00000001)
 #define USBCMD_CTRL_RESET		(0x00000002)
@@ -132,11 +135,11 @@ struct mv_otg_regs {
 };
 
 struct mv_otg {
-	struct usb_phy phy;
+	struct usb_phy usb_phy;
 	struct mv_otg_ctrl otg_ctrl;
 
 	/* base address */
-	void __iomem *phy_regs;
+	void __iomem *base;
 	void __iomem *cap_regs;
 	struct mv_otg_regs __iomem *op_regs;
 
@@ -155,6 +158,7 @@ struct mv_otg {
 	unsigned int active;
 	unsigned int clock_gating;
 	struct clk *clk;
+	struct phy *phy;
 };
 
 #endif
-- 
2.17.1

