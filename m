Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9B208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeHWAKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:01 -0400
Received: from shell.v3.sk ([90.176.6.54]:53284 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeHWAKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CC3FAB5BAF;
        Wed, 22 Aug 2018 22:43:33 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Re3kFEHfsQWd; Wed, 22 Aug 2018 22:43:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AFC54B5B98;
        Wed, 22 Aug 2018 22:43:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jNXVU1hubUyr; Wed, 22 Aug 2018 22:43:12 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BB0FCB5B8C;
        Wed, 22 Aug 2018 22:43:11 +0200 (CEST)
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
Subject: [PATCH 04/14] ARM: mmp: add a pxa-usb-phy device
Date:   Wed, 22 Aug 2018 22:42:57 +0200
Message-Id: <20180822204307.13251-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
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
index 671c7a09ab3d..d162fabd38e7 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -240,6 +240,27 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
 #if IS_ENABLED(CONFIG_USB_SUPPORT)
 static u64 __maybe_unused usb_dma_mask = ~(u32)0;
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+struct resource pxa168_usb_phy_resources[] = {
+	[0] = {
+		.start	= PXA168_U2O_PHYBASE,
+		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device pxa168_device_usb_phy = {
+	.name		= "pxa-usb-phy",
+	.id		= -1,
+	.resource	= pxa168_usb_phy_resources,
+	.num_resources	= ARRAY_SIZE(pxa168_usb_phy_resources),
+	.dev		=  {
+		.dma_mask	= &usb_dma_mask,
+		.coherent_dma_mask = 0xffffffff,
+	}
+};
+#endif /* CONFIG_PHY_PXA_USB */
+
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 struct resource pxa168_u2o_resources[] = {
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
-- 
2.17.1

