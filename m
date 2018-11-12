Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF22C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1720871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B1720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeKLNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:52 -0500
Received: from shell.v3.sk ([90.176.6.54]:59725 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbeKLNMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8A240C6A26;
        Mon, 12 Nov 2018 04:21:41 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mh_t0RkeHD2U; Mon, 12 Nov 2018 04:21:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4E634C6A23;
        Mon, 12 Nov 2018 04:20:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZxZiu81VbiYS; Mon, 12 Nov 2018 04:20:47 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 67167C6A38;
        Mon, 12 Nov 2018 04:20:40 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 17/18] USB: phy-mv-usb: use phy-pxa-usb
Date:   Mon, 12 Nov 2018 04:20:26 +0100
Message-Id: <20181112032027.653931-18-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a proper PHY driver, instead of hooks to a board support package.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-mmp/devices.c  |  11 +---
 drivers/usb/phy/phy-mv-usb.c | 123 ++++++++++++++++-------------------
 drivers/usb/phy/phy-mv-usb.h |   8 ++-
 3 files changed, 62 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 822b8be042b9..eb9b3c34e90a 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -325,21 +325,12 @@ struct platform_device pxa168_device_u2oehci =3D {
=20
 #if IS_ENABLED(CONFIG_USB_MV_OTG)
 struct resource pxa168_u2ootg_resources[] =3D {
-	/* regbase */
 	[0] =3D {
-		.start	=3D PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
+		.start	=3D PXA168_U2O_REGBASE,
 		.end	=3D PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	=3D IORESOURCE_MEM,
-		.name	=3D "capregs",
 	},
-	/* phybase */
 	[1] =3D {
-		.start	=3D PXA168_U2O_PHYBASE,
-		.end	=3D PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	=3D IORESOURCE_MEM,
-		.name	=3D "phyregs",
-	},
-	[2] =3D {
 		.start	=3D IRQ_PXA168_USB1,
 		.end	=3D IRQ_PXA168_USB1,
 		.flags	=3D IORESOURCE_IRQ,
diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index cfd9add10bf4..0f67c5b65fe9 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -50,7 +50,7 @@ static char *state_string[] =3D {
=20
 static int mv_otg_set_vbus(struct usb_otg *otg, bool on)
 {
-	struct mv_otg *mvotg =3D container_of(otg->usb_phy, struct mv_otg, phy)=
;
+	struct mv_otg *mvotg =3D container_of(otg->usb_phy, struct mv_otg, usb_=
phy);
 	if (mvotg->pdata->set_vbus =3D=3D NULL)
 		return -ENODEV;
=20
@@ -193,7 +193,7 @@ static void mv_otg_init_irq(struct mv_otg *mvotg)
 static void mv_otg_start_host(struct mv_otg *mvotg, int on)
 {
 #ifdef CONFIG_USB
-	struct usb_otg *otg =3D mvotg->phy.otg;
+	struct usb_otg *otg =3D mvotg->usb_phy.otg;
 	struct usb_hcd *hcd;
=20
 	if (!otg->host)
@@ -214,12 +214,12 @@ static void mv_otg_start_host(struct mv_otg *mvotg,=
 int on)
=20
 static void mv_otg_start_periphrals(struct mv_otg *mvotg, int on)
 {
-	struct usb_otg *otg =3D mvotg->phy.otg;
+	struct usb_otg *otg =3D mvotg->usb_phy.otg;
=20
 	if (!otg->gadget)
 		return;
=20
-	dev_info(mvotg->phy.dev, "gadget %s\n", on ? "on" : "off");
+	dev_info(mvotg->usb_phy.dev, "gadget %s\n", on ? "on" : "off");
=20
 	if (on)
 		usb_gadget_vbus_connect(otg->gadget);
@@ -247,14 +247,11 @@ static int mv_otg_enable_internal(struct mv_otg *mv=
otg)
 	dev_dbg(&mvotg->pdev->dev, "otg enabled\n");
=20
 	otg_clock_enable(mvotg);
-	if (mvotg->pdata->phy_init) {
-		retval =3D mvotg->pdata->phy_init(mvotg->phy_regs);
-		if (retval) {
-			dev_err(&mvotg->pdev->dev,
-				"init phy error %d\n", retval);
-			otg_clock_disable(mvotg);
-			return retval;
-		}
+	retval =3D phy_init(mvotg->phy);
+	if (retval) {
+		dev_err(&mvotg->pdev->dev, "init phy error %d\n", retval);
+		otg_clock_disable(mvotg);
+		return retval;
 	}
 	mvotg->active =3D 1;
=20
@@ -274,8 +271,7 @@ static void mv_otg_disable_internal(struct mv_otg *mv=
otg)
 {
 	if (mvotg->active) {
 		dev_dbg(&mvotg->pdev->dev, "otg disabled\n");
-		if (mvotg->pdata->phy_deinit)
-			mvotg->pdata->phy_deinit(mvotg->phy_regs);
+		phy_exit(mvotg->phy);
 		otg_clock_disable(mvotg);
 		mvotg->active =3D 0;
 	}
@@ -329,68 +325,68 @@ static void mv_otg_update_inputs(struct mv_otg *mvo=
tg)
 static void mv_otg_update_state(struct mv_otg *mvotg)
 {
 	struct mv_otg_ctrl *otg_ctrl =3D &mvotg->otg_ctrl;
-	int old_state =3D mvotg->phy.otg->state;
+	int old_state =3D mvotg->usb_phy.otg->state;
=20
 	switch (old_state) {
 	case OTG_STATE_UNDEFINED:
-		mvotg->phy.otg->state =3D OTG_STATE_B_IDLE;
+		mvotg->usb_phy.otg->state =3D OTG_STATE_B_IDLE;
 		/* FALL THROUGH */
 	case OTG_STATE_B_IDLE:
 		if (otg_ctrl->id =3D=3D 0)
-			mvotg->phy.otg->state =3D OTG_STATE_A_IDLE;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_IDLE;
 		else if (otg_ctrl->b_sess_vld)
-			mvotg->phy.otg->state =3D OTG_STATE_B_PERIPHERAL;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_B_PERIPHERAL;
 		break;
 	case OTG_STATE_B_PERIPHERAL:
 		if (!otg_ctrl->b_sess_vld || otg_ctrl->id =3D=3D 0)
-			mvotg->phy.otg->state =3D OTG_STATE_B_IDLE;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_B_IDLE;
 		break;
 	case OTG_STATE_A_IDLE:
 		if (otg_ctrl->id)
-			mvotg->phy.otg->state =3D OTG_STATE_B_IDLE;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_B_IDLE;
 		else if (!(otg_ctrl->a_bus_drop) &&
 			 (otg_ctrl->a_bus_req || otg_ctrl->a_srp_det))
-			mvotg->phy.otg->state =3D OTG_STATE_A_WAIT_VRISE;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_WAIT_VRISE;
 		break;
 	case OTG_STATE_A_WAIT_VRISE:
 		if (otg_ctrl->a_vbus_vld)
-			mvotg->phy.otg->state =3D OTG_STATE_A_WAIT_BCON;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_WAIT_BCON;
 		break;
 	case OTG_STATE_A_WAIT_BCON:
 		if (otg_ctrl->id || otg_ctrl->a_bus_drop
 		    || otg_ctrl->a_wait_bcon_timeout) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout =3D 0;
-			mvotg->phy.otg->state =3D OTG_STATE_A_WAIT_VFALL;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_WAIT_VFALL;
 			otg_ctrl->a_bus_req =3D 0;
 		} else if (!otg_ctrl->a_vbus_vld) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout =3D 0;
-			mvotg->phy.otg->state =3D OTG_STATE_A_VBUS_ERR;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_VBUS_ERR;
 		} else if (otg_ctrl->b_conn) {
 			mv_otg_cancel_timer(mvotg, A_WAIT_BCON_TIMER);
 			mvotg->otg_ctrl.a_wait_bcon_timeout =3D 0;
-			mvotg->phy.otg->state =3D OTG_STATE_A_HOST;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_HOST;
 		}
 		break;
 	case OTG_STATE_A_HOST:
 		if (otg_ctrl->id || !otg_ctrl->b_conn
 		    || otg_ctrl->a_bus_drop)
-			mvotg->phy.otg->state =3D OTG_STATE_A_WAIT_BCON;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_WAIT_BCON;
 		else if (!otg_ctrl->a_vbus_vld)
-			mvotg->phy.otg->state =3D OTG_STATE_A_VBUS_ERR;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_VBUS_ERR;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
 		if (otg_ctrl->id
 		    || (!otg_ctrl->b_conn && otg_ctrl->a_sess_vld)
 		    || otg_ctrl->a_bus_req)
-			mvotg->phy.otg->state =3D OTG_STATE_A_IDLE;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_IDLE;
 		break;
 	case OTG_STATE_A_VBUS_ERR:
 		if (otg_ctrl->id || otg_ctrl->a_clr_err
 		    || otg_ctrl->a_bus_drop) {
 			otg_ctrl->a_clr_err =3D 0;
-			mvotg->phy.otg->state =3D OTG_STATE_A_WAIT_VFALL;
+			mvotg->usb_phy.otg->state =3D OTG_STATE_A_WAIT_VFALL;
 		}
 		break;
 	default:
@@ -409,8 +405,8 @@ static void mv_otg_work(struct work_struct *work)
=20
 run:
 	/* work queue is single thread, or we need spin_lock to protect */
-	phy =3D &mvotg->phy;
-	otg =3D mvotg->phy.otg;
+	phy =3D &mvotg->usb_phy;
+	otg =3D mvotg->usb_phy.otg;
 	old_state =3D otg->state;
=20
 	if (!mvotg->active)
@@ -419,24 +415,24 @@ static void mv_otg_work(struct work_struct *work)
 	mv_otg_update_inputs(mvotg);
 	mv_otg_update_state(mvotg);
=20
-	if (old_state !=3D mvotg->phy.otg->state) {
+	if (old_state !=3D mvotg->usb_phy.otg->state) {
 		dev_info(&mvotg->pdev->dev, "change from state %s to %s\n",
 			 state_string[old_state],
-			 state_string[mvotg->phy.otg->state]);
+			 state_string[mvotg->usb_phy.otg->state]);
=20
-		switch (mvotg->phy.otg->state) {
+		switch (mvotg->usb_phy.otg->state) {
 		case OTG_STATE_B_IDLE:
 			otg->default_a =3D 0;
 			if (old_state =3D=3D OTG_STATE_B_PERIPHERAL)
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
 			otg->default_a =3D 1;
@@ -536,8 +532,8 @@ a_bus_req_store(struct device *dev, struct device_att=
ribute *attr,
 		return -1;
=20
 	/* We will use this interface to change to A device */
-	if (mvotg->phy.otg->state !=3D OTG_STATE_B_IDLE
-	    && mvotg->phy.otg->state !=3D OTG_STATE_A_IDLE)
+	if (mvotg->usb_phy.otg->state !=3D OTG_STATE_B_IDLE
+	    && mvotg->usb_phy.otg->state !=3D OTG_STATE_A_IDLE)
 		return -1;
=20
 	/* The clock may disabled and we need to set irq for ID detected */
@@ -566,7 +562,7 @@ a_clr_err_store(struct device *dev, struct device_att=
ribute *attr,
 	      const char *buf, size_t count)
 {
 	struct mv_otg *mvotg =3D dev_get_drvdata(dev);
-	if (!mvotg->phy.otg->default_a)
+	if (!mvotg->usb_phy.otg->default_a)
 		return -1;
=20
 	if (count > 2)
@@ -602,7 +598,7 @@ a_bus_drop_store(struct device *dev, struct device_at=
tribute *attr,
 	       const char *buf, size_t count)
 {
 	struct mv_otg *mvotg =3D dev_get_drvdata(dev);
-	if (!mvotg->phy.otg->default_a)
+	if (!mvotg->usb_phy.otg->default_a)
 		return -1;
=20
 	if (count > 2)
@@ -656,7 +652,7 @@ static int mv_otg_remove(struct platform_device *pdev=
)
=20
 	mv_otg_disable(mvotg);
=20
-	usb_remove_phy(&mvotg->phy);
+	usb_remove_phy(&mvotg->usb_phy);
=20
 	return 0;
 }
@@ -687,6 +683,10 @@ static int mv_otg_probe(struct platform_device *pdev=
)
 	mvotg->pdev =3D pdev;
 	mvotg->pdata =3D pdata;
=20
+	mvotg->phy =3D devm_phy_get(&pdev->dev, "usb");
+	if (IS_ERR(mvotg->phy))
+		return PTR_ERR(mvotg->phy);
+
 	mvotg->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mvotg->clk))
 		return PTR_ERR(mvotg->clk);
@@ -701,12 +701,12 @@ static int mv_otg_probe(struct platform_device *pde=
v)
=20
 	/* OTG common part */
 	mvotg->pdev =3D pdev;
-	mvotg->phy.dev =3D &pdev->dev;
-	mvotg->phy.otg =3D otg;
-	mvotg->phy.label =3D driver_name;
+	mvotg->usb_phy.dev =3D &pdev->dev;
+	mvotg->usb_phy.otg =3D otg;
+	mvotg->usb_phy.label =3D driver_name;
=20
 	otg->state =3D OTG_STATE_UNDEFINED;
-	otg->usb_phy =3D &mvotg->phy;
+	otg->usb_phy =3D &mvotg->usb_phy;
 	otg->set_host =3D mv_otg_set_host;
 	otg->set_peripheral =3D mv_otg_set_peripheral;
 	otg->set_vbus =3D mv_otg_set_vbus;
@@ -715,36 +715,23 @@ static int mv_otg_probe(struct platform_device *pde=
v)
 		timer_setup(&mvotg->otg_ctrl.timer[i],
 			    mv_otg_timer_await_bcon, 0);
=20
-	r =3D platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "phyregs");
-	if (r =3D=3D NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		retval =3D -ENODEV;
-		goto err_destroy_workqueue;
-	}
-
-	mvotg->phy_regs =3D devm_ioremap(&pdev->dev, r->start, resource_size(r)=
);
-	if (mvotg->phy_regs =3D=3D NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		retval =3D -EFAULT;
-		goto err_destroy_workqueue;
-	}
-
-	r =3D platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "capregs");
+	r =3D platform_get_resource(mvotg->pdev, IORESOURCE_MEM, 0);
 	if (r =3D=3D NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		retval =3D -ENODEV;
 		goto err_destroy_workqueue;
 	}
=20
-	mvotg->cap_regs =3D devm_ioremap(&pdev->dev, r->start, resource_size(r)=
);
-	if (mvotg->cap_regs =3D=3D NULL) {
+	mvotg->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (mvotg->base =3D=3D NULL) {
 		dev_err(&pdev->dev, "failed to map I/O memory\n");
 		retval =3D -EFAULT;
 		goto err_destroy_workqueue;
 	}
=20
+	mvotg->cap_regs =3D
+		(void __iomem *) ((unsigned long)mvotg->base + U2x_CAPREGS_OFFSET);
+
 	/* we will acces controller register, so enable the udc controller */
 	retval =3D mv_otg_enable_internal(mvotg);
 	if (retval) {
@@ -804,7 +791,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
=20
-	retval =3D usb_add_phy(&mvotg->phy, USB_PHY_TYPE_USB2);
+	retval =3D usb_add_phy(&mvotg->usb_phy, USB_PHY_TYPE_USB2);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "can't register transceiver, %d\n",
 			retval);
@@ -831,7 +818,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	return 0;
=20
 err_remove_phy:
-	usb_remove_phy(&mvotg->phy);
+	usb_remove_phy(&mvotg->usb_phy);
 err_disable_clk:
 	mv_otg_disable_internal(mvotg);
 err_destroy_workqueue:
@@ -846,10 +833,10 @@ static int mv_otg_suspend(struct platform_device *p=
dev, pm_message_t state)
 {
 	struct mv_otg *mvotg =3D platform_get_drvdata(pdev);
=20
-	if (mvotg->phy.otg->state !=3D OTG_STATE_B_IDLE) {
+	if (mvotg->usb_phy.otg->state !=3D OTG_STATE_B_IDLE) {
 		dev_info(&pdev->dev,
 			 "OTG state is not B_IDLE, it is %d!\n",
-			 mvotg->phy.otg->state);
+			 mvotg->usb_phy.otg->state);
 		return -EAGAIN;
 	}
=20
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 96701a1229ad..9b7bc6d958a8 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
@@ -8,6 +8,9 @@
=20
 #include <linux/types.h>
=20
+/* registers */
+#define U2x_CAPREGS_OFFSET       0x100
+
 /* Command Register Bit Masks */
 #define USBCMD_RUN_STOP			(0x00000001)
 #define USBCMD_CTRL_RESET		(0x00000002)
@@ -132,11 +135,11 @@ struct mv_otg_regs {
 };
=20
 struct mv_otg {
-	struct usb_phy phy;
+	struct usb_phy usb_phy;
 	struct mv_otg_ctrl otg_ctrl;
=20
 	/* base address */
-	void __iomem *phy_regs;
+	void __iomem *base;
 	void __iomem *cap_regs;
 	struct mv_otg_regs __iomem *op_regs;
=20
@@ -155,6 +158,7 @@ struct mv_otg {
 	unsigned int active;
 	unsigned int clock_gating;
 	struct clk *clk;
+	struct phy *phy;
 };
=20
 #endif
--=20
2.19.1

