Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D456EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5E02145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5E02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeK3SLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:11:40 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:42463 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbeK3SLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:11:40 -0500
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Nov 2018 16:03:19 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD2D64413C47;
        Fri, 30 Nov 2018 16:03:19 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] phy: renesas: rcar-gen3-usb2: follow the hardware manual procedure
Date:   Fri, 30 Nov 2018 16:00:57 +0900
Message-Id: <1543561257-27594-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies rcar_gen3_init_otg() procedure to follow Figure
73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on linux-phy.git / latest next branch
(commit id = 9b28b23a7a12cb07536da93100a907f772f00fea)

Changes from v1:
 - Just write value to registers instead of read-modify-write functions
   (rcar_gen3_set_linectrl() and rcar_gen3_control_otg_irq().

Also, this is the first email I send after changing the email server
to avoid using quoted-printable encoding.

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index d0f412c..0a34782 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -307,16 +307,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	/* Should not use functions of read-modify-write a register */
+	val = readl(usb2_base + USB2_LINECTRL1);
+	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
+	      USB2_LINECTRL1_DMRPD_EN | USB2_LINECTRL1_DM_RPD;
+	writel(val, usb2_base + USB2_LINECTRL1);
+
 	val = readl(usb2_base + USB2_VBCTRL);
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
-	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
-	rcar_gen3_control_otg_irq(ch, 1);
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
-	val = readl(usb2_base + USB2_LINECTRL1);
-	rcar_gen3_set_linectrl(ch, 0, 0);
-	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
-	       usb2_base + USB2_LINECTRL1);
+
+	msleep(20);
+
+	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
+	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
 
 	rcar_gen3_device_recognition(ch);
 }
-- 
1.9.1

