Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDEFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21B921736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21B921736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeHNUWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:22:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:22:24 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D671E9F;
        Tue, 14 Aug 2018 17:34:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 018/104] phy: phy-mtk-tphy: use auto instead of force to bypass utmi signals
Date:   Tue, 14 Aug 2018 19:16:32 +0200
Message-Id: <20180814171516.385584062@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 00c0092c5f62147b7d85f0c6f1cf245a0a1ff3b6 upstream.

When system is running, if usb2 phy is forced to bypass utmi signals,
all PLL will be turned off, and it can't detect device connection
anymore, so replace force mode with auto mode which can bypass utmi
signals automatically if no device attached for normal flow.
But keep the force mode to fix RX sensitivity degradation issue.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/mediatek/phy-mtk-tphy.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -438,9 +438,9 @@ static void u2_phy_instance_init(struct
 	u32 index = instance->index;
 	u32 tmp;
 
-	/* switch to USB function. (system register, force ip into usb mode) */
+	/* switch to USB function, and enable usb pll */
 	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~P2C_FORCE_UART_EN;
+	tmp &= ~(P2C_FORCE_UART_EN | P2C_FORCE_SUSPENDM);
 	tmp |= P2C_RG_XCVRSEL_VAL(1) | P2C_RG_DATAIN_VAL(0);
 	writel(tmp, com + U3P_U2PHYDTM0);
 
@@ -500,10 +500,8 @@ static void u2_phy_instance_power_on(str
 	u32 index = instance->index;
 	u32 tmp;
 
-	/* (force_suspendm=0) (let suspendm=1, enable usb 480MHz pll) */
 	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~(P2C_FORCE_SUSPENDM | P2C_RG_XCVRSEL);
-	tmp &= ~(P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
+	tmp &= ~(P2C_RG_XCVRSEL | P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
 	writel(tmp, com + U3P_U2PHYDTM0);
 
 	/* OTG Enable */
@@ -538,7 +536,6 @@ static void u2_phy_instance_power_off(st
 
 	tmp = readl(com + U3P_U2PHYDTM0);
 	tmp &= ~(P2C_RG_XCVRSEL | P2C_RG_DATAIN);
-	tmp |= P2C_FORCE_SUSPENDM;
 	writel(tmp, com + U3P_U2PHYDTM0);
 
 	/* OTG Disable */
@@ -546,18 +543,16 @@ static void u2_phy_instance_power_off(st
 	tmp &= ~PA6_RG_U2_OTG_VBUSCMP_EN;
 	writel(tmp, com + U3P_USBPHYACR6);
 
-	/* let suspendm=0, set utmi into analog power down */
-	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~P2C_RG_SUSPENDM;
-	writel(tmp, com + U3P_U2PHYDTM0);
-	udelay(1);
-
 	tmp = readl(com + U3P_U2PHYDTM1);
 	tmp &= ~(P2C_RG_VBUSVALID | P2C_RG_AVALID);
 	tmp |= P2C_RG_SESSEND;
 	writel(tmp, com + U3P_U2PHYDTM1);
 
 	if (tphy->pdata->avoid_rx_sen_degradation && index) {
+		tmp = readl(com + U3P_U2PHYDTM0);
+		tmp &= ~(P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
+		writel(tmp, com + U3P_U2PHYDTM0);
+
 		tmp = readl(com + U3D_U2PHYDCR0);
 		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
 		writel(tmp, com + U3D_U2PHYDCR0);


