Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDCFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506DE20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506DE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeIMS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:57:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeIMS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:57:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F542CFE;
        Thu, 13 Sep 2018 13:48:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 101/115] usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init during suspend/resume
Date:   Thu, 13 Sep 2018 15:32:01 +0200
Message-Id: <20180913131829.600470586@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 98112041bcca164676367e261c8c1073ef70cb51 upstream.

In order for ULPI PHYs to work, dwc3_phy_setup() and dwc3_ulpi_init()
must be doene before dwc3_core_get_phy().

commit 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
broke this.

The other issue is that dwc3_core_get_phy() and dwc3_ulpi_init() should
be called only once during the life cycle of the driver. However,
as dwc3_core_init() is called during system suspend/resume it will
result in multiple calls to dwc3_core_get_phy() and dwc3_ulpi_init()
which is wrong.

Fix this by moving dwc3_ulpi_init() out of dwc3_phy_setup()
into dwc3_core_ulpi_init(). Use a flag 'ulpi_ready' to ensure that
dwc3_core_ulpi_init() is called only once from dwc3_core_init().

Use another flag 'phys_ready' to call dwc3_core_get_phy() only once from
dwc3_core_init().

Fixes: 541768b08a40 ("usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys")
Fixes: f54edb539c11 ("usb: dwc3: core: initialize ULPI before trying to get the PHY")
Cc: linux-stable <stable@vger.kernel.org> # >= v4.13
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   47 ++++++++++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h |    5 +++++
 2 files changed, 41 insertions(+), 11 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -511,6 +511,22 @@ static void dwc3_cache_hwparams(struct d
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
 }
 
+static int dwc3_core_ulpi_init(struct dwc3 *dwc)
+{
+	int intf;
+	int ret = 0;
+
+	intf = DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3);
+
+	if (intf == DWC3_GHWPARAMS3_HSPHY_IFC_ULPI ||
+	    (intf == DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI &&
+	     dwc->hsphy_interface &&
+	     !strncmp(dwc->hsphy_interface, "ulpi", 4)))
+		ret = dwc3_ulpi_init(dwc);
+
+	return ret;
+}
+
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -522,7 +538,6 @@ static void dwc3_cache_hwparams(struct d
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
-	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -593,9 +608,6 @@ static int dwc3_phy_setup(struct dwc3 *d
 		}
 		/* FALLTHROUGH */
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		ret = dwc3_ulpi_init(dwc);
-		if (ret)
-			return ret;
 		/* FALLTHROUGH */
 	default:
 		break;
@@ -752,6 +764,7 @@ static void dwc3_core_setup_global_contr
 }
 
 static int dwc3_core_get_phy(struct dwc3 *dwc);
+static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
@@ -783,17 +796,27 @@ static int dwc3_core_init(struct dwc3 *d
 			dwc->maximum_speed = USB_SPEED_HIGH;
 	}
 
-	ret = dwc3_core_get_phy(dwc);
+	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
 
-	ret = dwc3_core_soft_reset(dwc);
-	if (ret)
-		goto err0;
+	if (!dwc->ulpi_ready) {
+		ret = dwc3_core_ulpi_init(dwc);
+		if (ret)
+			goto err0;
+		dwc->ulpi_ready = true;
+	}
 
-	ret = dwc3_phy_setup(dwc);
+	if (!dwc->phys_ready) {
+		ret = dwc3_core_get_phy(dwc);
+		if (ret)
+			goto err0a;
+		dwc->phys_ready = true;
+	}
+
+	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0;
+		goto err0a;
 
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
@@ -866,6 +889,9 @@ err1:
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+err0a:
+	dwc3_ulpi_exit(dwc);
+
 err0:
 	return ret;
 }
@@ -1256,7 +1282,6 @@ err4:
 
 err3:
 	dwc3_free_event_buffers(dwc);
-	dwc3_ulpi_exit(dwc);
 
 err2:
 	pm_runtime_allow(&pdev->dev);
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -805,7 +805,9 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
+ * @ulpi_ready: flag to indicate that ULPI is initialized
  * @isoch_delay: wValue from Set Isochronous Delay request;
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
@@ -903,7 +905,10 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	bool			phys_ready;
+
 	struct ulpi		*ulpi;
+	bool			ulpi_ready;
 
 	void __iomem		*regs;
 	size_t			regs_size;


