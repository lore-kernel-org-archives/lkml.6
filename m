Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DDC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6650A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+XtNOe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6650A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbeJICDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140F220645;
        Mon,  8 Oct 2018 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024626;
        bh=fKgrg47nqV9ju/tm9gxkpmeYvVftyyoyOxaf6rKmnos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+XtNOe8rj2g1Si2yPuE79J/Fx7AJS/wFIhEhaN25lwx8rSf4qw3iulOet+pfPs81
         kjzEAjbBZ3DQ/v6AQ11+EReZ6u76jRTB8hRmG7j8UENIsRR9t7N9YDW17URrHyC7Oh
         LMDKjaLPdacWBQs4UV/xMFtDT0FrPjcxFyoPrFqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 101/168] usb: host: xhci-plat: Iterate over parent nodes for finding quirks
Date:   Mon,  8 Oct 2018 20:31:21 +0200
Message-Id: <20181008175623.900468568@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

[ Upstream commit 222471f7640d9771a993218d825d84825adc805d ]

In xhci_plat_probe() both sysdev and pdev->dev are being used
for finding quirks. There are some drivers(like dwc3 host.c)
which adds quirks(like usb3-lpm-capable) into pdev and the logic
present in xhci_plat_probe() checks for quirks in either sysdev
or pdev for finding the quirks. Because of this logic, some of
the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
host.c driver is getting missed).This patch fixes this by iterating
over all the available parents for finding the quirks. In this way
all the quirks which are present in child or parent are correctly
updated.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-plat.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platfo
 {
 	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev;
+	struct device		*sysdev, *tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -272,19 +272,24 @@ static int xhci_plat_probe(struct platfo
 		goto disable_clk;
 	}
 
-	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
-		xhci->quirks |= XHCI_HW_LPM_DISABLE;
+	/* imod_interval is the interrupt moderation value in nanoseconds. */
+	xhci->imod_interval = 40000;
 
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
-		xhci->quirks |= XHCI_LPM_SUPPORT;
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
 
-	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
-		xhci->quirks |= XHCI_BROKEN_PORT_PED;
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |= XHCI_HW_LPM_DISABLE;
 
-	/* imod_interval is the interrupt moderation value in nanoseconds. */
-	xhci->imod_interval = 40000;
-	device_property_read_u32(sysdev, "imod-interval-ns",
-				 &xhci->imod_interval);
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |= XHCI_LPM_SUPPORT;
+
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |= XHCI_BROKEN_PORT_PED;
+
+		device_property_read_u32(tmpdev, "imod-interval-ns",
+					 &xhci->imod_interval);
+	}
 
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {


