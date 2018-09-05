Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E902CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5920659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIEQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:10:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49825 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbeIEQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:10:25 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w85BYILl018453;
        Wed, 5 Sep 2018 13:40:27 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2macws8hmc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 13:40:27 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D940731;
        Wed,  5 Sep 2018 11:40:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A62622B83;
        Wed,  5 Sep 2018 11:40:26 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018
 13:40:26 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018 13:40:26 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 4/4] usb: dwc2: fix unbalanced use of external vbus-supply
Date:   Wed, 5 Sep 2018 13:40:05 +0200
Message-ID: <1536147605-26279-5-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
References: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

When using external vbus supply regulator, it should be enabled
synchronously with PWR bit in HPRT register. This also fixes
unbalanced use of this optional regulator (This can be reproduced
easily when unbinding the driver).

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/hcd.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e8a480e..8efbb45 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3558,6 +3558,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 	u32 port_status;
 	u32 speed;
 	u32 pcgctl;
+	u32 pwr;
 
 	switch (typereq) {
 	case ClearHubFeature:
@@ -3606,8 +3607,11 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dev_dbg(hsotg->dev,
 				"ClearPortFeature USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
+			pwr = hprt0 & HPRT0_PWR;
 			hprt0 &= ~HPRT0_PWR;
 			dwc2_writel(hsotg, hprt0, HPRT0);
+			if (pwr)
+				dwc2_vbus_supply_exit(hsotg);
 			break;
 
 		case USB_PORT_FEAT_INDICATOR:
@@ -3817,8 +3821,11 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dev_dbg(hsotg->dev,
 				"SetPortFeature - USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
+			pwr = hprt0 & HPRT0_PWR;
 			hprt0 |= HPRT0_PWR;
 			dwc2_writel(hsotg, hprt0, HPRT0);
+			if (!pwr)
+				dwc2_vbus_supply_init(hsotg);
 			break;
 
 		case USB_PORT_FEAT_RESET:
@@ -3835,6 +3842,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dwc2_writel(hsotg, 0, PCGCTL);
 
 			hprt0 = dwc2_read_hprt0(hsotg);
+			pwr = hprt0 & HPRT0_PWR;
 			/* Clear suspend bit if resetting from suspend state */
 			hprt0 &= ~HPRT0_SUSP;
 
@@ -3848,6 +3856,8 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				dev_dbg(hsotg->dev,
 					"In host mode, hprt0=%08x\n", hprt0);
 				dwc2_writel(hsotg, hprt0, HPRT0);
+				if (!pwr)
+					dwc2_vbus_supply_init(hsotg);
 			}
 
 			/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
@@ -4387,6 +4397,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	u32 hprt0;
 	int ret;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD START\n");
@@ -4403,12 +4414,16 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	dwc2_hcd_reinit(hsotg);
 
-	/* enable external vbus supply before resuming root hub */
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	ret = dwc2_vbus_supply_init(hsotg);
-	if (ret)
-		return ret;
-	spin_lock_irqsave(&hsotg->lock, flags);
+	hprt0 = dwc2_read_hprt0(hsotg);
+	/* Has vbus power been turned on in dwc2_core_host_init ? */
+	if (hprt0 & HPRT0_PWR) {
+		/* Enable external vbus supply before resuming root hub */
+		spin_unlock_irqrestore(&hsotg->lock, flags);
+		ret = dwc2_vbus_supply_init(hsotg);
+		if (ret)
+			return ret;
+		spin_lock_irqsave(&hsotg->lock, flags);
+	}
 
 	/* Initialize and connect root hub if one is not already attached */
 	if (bus->root_hub) {
@@ -4430,6 +4445,7 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 {
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	unsigned long flags;
+	u32 hprt0;
 
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
@@ -4438,6 +4454,7 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	synchronize_irq(hcd->irq);
 
 	spin_lock_irqsave(&hsotg->lock, flags);
+	hprt0 = dwc2_read_hprt0(hsotg);
 	/* Ensure hcd is disconnected */
 	dwc2_hcd_disconnect(hsotg, true);
 	dwc2_hcd_stop(hsotg);
@@ -4446,7 +4463,9 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_exit(hsotg);
+	/* keep balanced supply init/exit by checking HPRT0_PWR */
+	if (hprt0 & HPRT0_PWR)
+		dwc2_vbus_supply_exit(hsotg);
 
 	usleep_range(1000, 3000);
 }
-- 
2.7.4

