Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE0C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CBC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfAUIEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:04:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42444 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfAUID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A00411A03B5;
        Mon, 21 Jan 2019 04:18:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86D0D1A00C2;
        Mon, 21 Jan 2019 04:18:37 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C5E1402FF;
        Mon, 21 Jan 2019 11:18:30 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jerry.huang@nxp.com,
        ran.wang_1@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] usb :fsl: Change string format for errata property
Date:   Mon, 21 Jan 2019 11:13:04 +0800
Message-Id: <20190121031304.31161-6-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190121031304.31161-1-yinbo.zhu@nxp.com>
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikhil Badola <nikhil.badola@freescale.com>

Remove USB errata checking code from driver. Applicability of erratum
is retrieved by reading corresponding property in device tree.
This property is written during device tree fixup.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/ehci-fsl.c      |    7 +------
 drivers/usb/host/fsl-mph-dr-of.c |    9 ++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6884130..c71680e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -310,14 +310,9 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 			return -EINVAL;
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
-		unsigned int chip, rev, svr;
-
-		svr = mfspr(SPRN_SVR);
-		chip = svr >> 16;
-		rev = (svr >> 4) & 0xf;
 
 		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1 chips */
-		if ((rev == 1) && (chip >= 0x8050) && (chip <= 0x8055))
+		if (pdata->has_fsl_erratum_14 == 1)
 			ehci->has_fsl_port_bug = 1;
 
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 7e07701..ae8f60f 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,11 +224,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 		of_property_read_bool(np, "fsl,usb-erratum-a005275");
 	pdata->has_fsl_erratum_a005697 =
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
-
-	if (of_get_property(np, "fsl,erratum_a006918", NULL))
-		pdata->has_fsl_erratum_a006918 = 1;
-	else
-		pdata->has_fsl_erratum_a006918 = 0;
+	pdata->has_fsl_erratum_a006918 =
+		of_property_read_bool(np, "fsl,usb_erratum-a006918");
+	pdata->has_fsl_erratum_14 =
+		of_property_read_bool(np, "fsl,usb_erratum-14");
 
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
-- 
1.7.1

