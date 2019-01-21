Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6888C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B491820823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfAUIER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:04:17 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42440 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfAUID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 533BC1A03A0;
        Mon, 21 Jan 2019 04:18:39 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3801A1A0394;
        Mon, 21 Jan 2019 04:18:34 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AFB78402B5;
        Mon, 21 Jan 2019 11:18:27 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jerry.huang@nxp.com,
        ran.wang_1@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] usb: host: Stops USB controller init if PLL fails to lock
Date:   Mon, 21 Jan 2019 11:13:01 +0800
Message-Id: <20190121031304.31161-3-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121031304.31161-1-yinbo.zhu@nxp.com>
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

USB erratum-A006918 workaround tries to start internal PHY inside
uboot (when PLL fails to lock). However, if the workaround also
fails, then USB initialization is also stopped inside Linux.
Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
node in device-tree. Presence of this node in device-tree is
used to stop USB controller initialization in Linux

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/ehci-fsl.c      |    5 +++++
 drivers/usb/host/fsl-mph-dr-of.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index a28ec1e..6884130 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -224,6 +224,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		portsc |= PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+		if (pdata->has_fsl_erratum_a006918) {
+			pr_warn("fsl-ehci: USB PHY clock invalid\n");
+			return -EINVAL;
+		}
+
 	case FSL_USB2_PHY_UTMI_DUAL:
 		/* PHY_CLK_VALID bit is de-featured from all controller
 		 * versions below 2.4 and is to be checked only for
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 677f9d5..7e07701 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -225,6 +225,11 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 	pdata->has_fsl_erratum_a005697 =
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
 
+	if (of_get_property(np, "fsl,erratum_a006918", NULL))
+		pdata->has_fsl_erratum_a006918 = 1;
+	else
+		pdata->has_fsl_erratum_a006918 = 0;
+
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
 	 * by reading property in device tree
-- 
1.7.1

