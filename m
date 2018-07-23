Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E5FECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB74420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB74420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbeGWLd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:33:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56450 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388056AbeGWLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:33:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC93520002E;
        Mon, 23 Jul 2018 12:32:54 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7971020008A;
        Mon, 23 Jul 2018 12:32:54 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id E07C740C72;
        Mon, 23 Jul 2018 03:32:53 -0700 (MST)
Received: from mega.am.freescale.net ([10.192.208.232])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6NAWluB028031;
        Mon, 23 Jul 2018 03:32:51 -0700
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: [PATCH v6 2/4] usb: dwc3: Enable undefined length INCR burst type
Date:   Mon, 23 Jul 2018 18:32:37 +0800
Message-Id: <1532341959-3478-2-git-send-email-pengbo.mu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the undefined length INCR burst type and set INCRx.
Different platform may has the different burst size type.
In order to get best performance, we need to tune the burst
size to one special value, instead of the default value.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v6:
 - rename 'dwc3_set_soc_bus_cfg' to 'dwc3_set_incr_burst_type'
 - modify the codes according to the definition of GSBUSCFG0
 - change variables from global to local
 - add the judgment of 'ntype <= 0'
Changes in v5:
 - no change
Changes in v4:
 - Modify the codes according to the definition of this property.
Changes in v3:
 - add new property for INCR burst in usb node to reset GSBUSCFG0.
Changes in v2:
 - split patch
 - create one new function to handle soc bus configuration register.
---
 drivers/usb/dwc3/core.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  3 ++
 2 files changed, 97 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..21e4931 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -778,6 +778,98 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
+/* set global incr burst type configuration registers */
+static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	/* incrx_mode : for INCR burst type. */
+	bool incrx_mode;
+	/* incrx_size : for size of INCRX burst. */
+	u32 incrx_size;
+	u32 *vals;
+	u32 cfg;
+	int ntype;
+	int ret;
+	int i;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	ntype = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", NULL, 0);
+	if (ntype <= 0)
+		return;
+
+	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+	if (!vals) {
+		dev_err(dev, "Error to get memory\n");
+		return;
+	}
+
+	/* Get INCR burst type, and parse it */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+	if (ret) {
+		dev_err(dev, "Error to get property\n");
+		return;
+	}
+
+	incrx_size = *vals;
+
+	if (ntype > 1) {
+		/* INCRX (undefined length) burst mode */
+		incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		for (i = 1; i < ntype; i++) {
+			if (vals[i] > incrx_size)
+				incrx_size = vals[i];
+		}
+	} else {
+		/* INCRX burst mode */
+		incrx_mode = INCRX_BURST_MODE;
+	}
+
+	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+	if (incrx_mode)
+		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+	switch (incrx_size) {
+	case 256:
+		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+		break;
+	case 128:
+		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+		break;
+	case 64:
+		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+		break;
+	case 32:
+		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+		break;
+	case 16:
+		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+		break;
+	case 8:
+		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+		break;
+	case 4:
+		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+		break;
+	case 1:
+		break;
+	default:
+		dev_err(dev, "Invalid property\n");
+		break;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -840,6 +932,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	dwc3_set_incr_burst_type(dwc);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 213b939..5f14fb7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1168,6 +1168,9 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
+#define INCRX_BURST_MODE 0
+#define INCRX_UNDEF_LENGTH_BURST_MODE 1
+
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
-- 
2.7.4

