Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB4C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B330820871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B330820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeKLNMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:51 -0500
Received: from shell.v3.sk ([90.176.6.54]:59717 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbeKLNMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E7E0C6A2B;
        Mon, 12 Nov 2018 04:21:38 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PVXWGAwv_t7r; Mon, 12 Nov 2018 04:21:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6B1E5C6A2F;
        Mon, 12 Nov 2018 04:20:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yB4Oi2-F2oTk; Mon, 12 Nov 2018 04:20:48 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id AD298C6A39;
        Mon, 12 Nov 2018 04:20:40 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 18/18] USB: gadget: mv-udc: use phy-pxa-usb
Date:   Mon, 12 Nov 2018 04:20:27 +0100
Message-Id: <20181112032027.653931-19-lkundrak@v3.sk>
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
---
 arch/arm/mach-mmp/devices.c          | 11 +-------
 drivers/usb/gadget/udc/mv_udc.h      |  7 ++++-
 drivers/usb/gadget/udc/mv_udc_core.c | 38 ++++++++--------------------
 3 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index eb9b3c34e90a..d925be9f14a9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -263,21 +263,12 @@ struct platform_device pxa168_device_usb_phy =3D {
=20
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 struct resource pxa168_u2o_resources[] =3D {
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
diff --git a/drivers/usb/gadget/udc/mv_udc.h b/drivers/usb/gadget/udc/mv_=
udc.h
index b3f759c0962c..6f04f432964d 100644
--- a/drivers/usb/gadget/udc/mv_udc.h
+++ b/drivers/usb/gadget/udc/mv_udc.h
@@ -6,6 +6,9 @@
 #ifndef __MV_UDC_H
 #define __MV_UDC_H
=20
+/* registers */
+#define U2x_CAPREGS_OFFSET	0x100
+
 #define VUSBHS_MAX_PORTS	8
=20
 #define DQH_ALIGNMENT		2048
@@ -174,9 +177,9 @@ struct mv_udc {
 	struct platform_device		*dev;
 	int				irq;
=20
+	void __iomem                    *base;
 	struct mv_cap_regs __iomem	*cap_regs;
 	struct mv_op_regs __iomem	*op_regs;
-	void __iomem                    *phy_regs;
 	unsigned int			max_eps;
 	struct mv_dqh			*ep_dqh;
 	size_t				ep_dqh_size;
@@ -219,6 +222,8 @@ struct mv_udc {
=20
 	/* some SOC has mutiple clock sources for USB*/
 	struct clk      *clk;
+
+	struct phy	*phy;
 };
=20
 /* endpoint data structure */
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/ud=
c/mv_udc_core.c
index cafde053788b..35b0bde2d46f 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -1069,14 +1069,11 @@ static int mv_udc_enable_internal(struct mv_udc *=
udc)
 	if (retval)
 		return retval;
=20
-	if (udc->pdata->phy_init) {
-		retval =3D udc->pdata->phy_init(udc->phy_regs);
-		if (retval) {
-			dev_err(&udc->dev->dev,
-				"init phy error %d\n", retval);
-			udc_clock_disable(udc);
-			return retval;
-		}
+	retval =3D phy_init(udc->phy);
+	if (retval) {
+		dev_err(&udc->dev->dev, "init phy error %d\n", retval);
+		udc_clock_disable(udc);
+		return retval;
 	}
 	udc->active =3D 1;
=20
@@ -1095,8 +1092,7 @@ static void mv_udc_disable_internal(struct mv_udc *=
udc)
 {
 	if (udc->active) {
 		dev_dbg(&udc->dev->dev, "disable udc\n");
-		if (udc->pdata->phy_deinit)
-			udc->pdata->phy_deinit(udc->phy_regs);
+		phy_exit(udc->phy);
 		udc_clock_disable(udc);
 		udc->active =3D 0;
 	}
@@ -2147,30 +2143,16 @@ static int mv_udc_probe(struct platform_device *p=
dev)
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
=20
-	r =3D platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs")=
;
+	r =3D platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
 	if (r =3D=3D NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		return -ENODEV;
 	}
=20
-	udc->cap_regs =3D (struct mv_cap_regs __iomem *)
-		devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (udc->cap_regs =3D=3D NULL) {
-		dev_err(&pdev->dev, "failed to map I/O memory\n");
-		return -EBUSY;
-	}
-
-	r =3D platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs")=
;
-	if (r =3D=3D NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		return -ENODEV;
-	}
+	udc->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
=20
-	udc->phy_regs =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (udc->phy_regs =3D=3D NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		return -EBUSY;
-	}
+	udc->cap_regs =3D
+		(void __iomem *) ((unsigned long)udc->base + U2x_CAPREGS_OFFSET);
=20
 	/* we will acces controller register, so enable the clk */
 	retval =3D mv_udc_enable_internal(udc);
--=20
2.19.1

