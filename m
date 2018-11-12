Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCBC214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCBC214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeKLNMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:41 -0500
Received: from shell.v3.sk ([90.176.6.54]:59686 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbeKLNMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 901FFC6A34;
        Mon, 12 Nov 2018 04:21:30 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v5vkDEIy6beg; Mon, 12 Nov 2018 04:21:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3CE1FC6A2C;
        Mon, 12 Nov 2018 04:20:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mu-1YG6p01PQ; Mon, 12 Nov 2018 04:20:44 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D1EE7C6A36;
        Mon, 12 Nov 2018 04:20:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 15/18] ARM: mmp: add a pxa-usb-phy device
Date:   Mon, 12 Nov 2018 04:20:24 +0100
Message-Id: <20181112032027.653931-16-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to replace the USB PHY initialization code (pxa_usb_phy_init(),
pxa_usb_phy_deinit()) with a proper PHY driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c | 21 +++++++++++++++++++++
 arch/arm/mach-mmp/pxa910.h  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 0fca63c80e1a..822b8be042b9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -240,6 +240,27 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
 #if IS_ENABLED(CONFIG_USB_SUPPORT)
 static u64 __maybe_unused usb_dma_mask =3D ~(u32)0;
=20
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+struct resource pxa168_usb_phy_resources[] =3D {
+	[0] =3D {
+		.start	=3D PXA168_U2O_PHYBASE,
+		.end	=3D PXA168_U2O_PHYBASE + USB_PHY_RANGE,
+		.flags	=3D IORESOURCE_MEM,
+	},
+};
+
+struct platform_device pxa168_device_usb_phy =3D {
+	.name		=3D "pxa-usb-phy",
+	.id		=3D -1,
+	.resource	=3D pxa168_usb_phy_resources,
+	.num_resources	=3D ARRAY_SIZE(pxa168_usb_phy_resources),
+	.dev		=3D  {
+		.dma_mask	=3D &usb_dma_mask,
+		.coherent_dma_mask =3D 0xffffffff,
+	}
+};
+#endif /* CONFIG_PHY_PXA_USB */
+
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 struct resource pxa168_u2o_resources[] =3D {
 	/* regbase */
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 42009c349eae..2dfe38e4acc1 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -22,6 +22,7 @@ extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
+extern struct platform_device pxa168_device_usb_phy;
 extern struct platform_device pxa168_device_u2o;
 extern struct platform_device pxa168_device_u2ootg;
 extern struct platform_device pxa168_device_u2oehci;
--=20
2.19.1

