Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F9C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9720823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfAUIEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:04:00 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42418 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfAUID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 162ED1A00B4;
        Mon, 21 Jan 2019 04:18:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F071B1A0098;
        Mon, 21 Jan 2019 04:18:31 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C4FD402CA;
        Mon, 21 Jan 2019 11:18:25 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jerry.huang@nxp.com,
        ran.wang_1@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] usb: fsl: Set USB_EN bit to select ULPI phy
Date:   Mon, 21 Jan 2019 11:12:59 +0800
Message-Id: <20190121031304.31161-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Set USB_EN bit to select ULPI phy for USB controller version 2.5

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/ehci-fsl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0a9fd20..71c4661 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -118,6 +118,12 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
 				CONTROL_REGISTER_W1C_MASK, 0x4);
 
+	/* Set USB_EN bit to select ULPI phy for USB controller version 2.5 */
+	if (pdata->controller_ver == FSL_USB_VER_2_5 &&
+		pdata->phy_mode == FSL_USB2_PHY_ULPI)
+		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
+
+
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
-- 
1.7.1

