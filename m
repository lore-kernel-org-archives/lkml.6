Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D7ECDE47
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCC92086B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 10:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCC92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeJ0Sk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 14:40:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbeJ0SkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 14:40:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3AAE9A5806C17;
        Sat, 27 Oct 2018 17:59:57 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 27 Oct 2018 17:59:50 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Binghui Wang" <wangbinghui@hisilicon.com>
Subject: [PATCH 05/10] usb: dwc3: Add two quirks for Hisilicon Kirin Soc Platform
Date:   Sat, 27 Oct 2018 17:58:15 +0800
Message-ID: <20181027095820.40056-6-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181027095820.40056-1-chenyu56@huawei.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are tow quirks for DesignWare USB3 DRD Core of Hisilicon Kirin Soc.
1)SPLIT_BOUNDARY_DISABLE should be set for Host mode
2)A GCTL soft reset should be executed when switch mode

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/dwc3/core.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c |  2 +-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index becfbb87f791..68c29e549bfb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -111,11 +111,25 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
+{
+	int reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |= (DWC3_GCTL_CORESOFTRESET);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~(DWC3_GCTL_CORESOFTRESET);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
 	int ret;
+	int reg;
 
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
@@ -168,9 +182,18 @@ static void __dwc3_set_mode(struct work_struct *work)
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 			phy_calibrate(dwc->usb2_generic_phy);
+			if (dwc->dis_split_quirk) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+				reg |= DWC3_GUCTL3_SPLITDISABLE;
+				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+			}
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		/* Execute a GCTL Core Soft Reset when switch mode */
+		if (dwc->gctl_reset_quirk)
+			dwc3_gctl_core_soft_reset(dwc);
+
 		dwc3_event_buffers_setup(dwc);
 
 		if (dwc->usb2_phy)
@@ -1298,6 +1321,11 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
 
+	dwc->dis_split_quirk = device_property_read_bool(dev,
+				"snps,dis-split-quirk");
+	dwc->gctl_reset_quirk = device_property_read_bool(dev,
+				"snps,gctl-reset-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1815,10 +1843,25 @@ static int dwc3_resume(struct device *dev)
 
 	return 0;
 }
+
+static void dwc3_complete(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	u32		reg;
+
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
+			dwc->dis_split_quirk) {
+		dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_SPLITDISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+	.complete = dwc3_complete,
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb62533e0f..b3cea95f7720 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -135,6 +135,7 @@
 #define DWC3_GEVNTCOUNT(n)	(0xc40c + ((n) * 0x10))
 
 #define DWC3_GHWPARAMS8		0xc600
+#define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
 
 /* Device Registers */
@@ -359,6 +360,9 @@
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
+/* Global User Control Register 3 */
+#define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -1168,6 +1172,9 @@ struct dwc3 {
 
 	unsigned		dis_metastability_quirk:1;
 
+	unsigned		dis_split_quirk:1;
+	unsigned		gctl_reset_quirk:1;
+
 	u16			imod_interval;
 };
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 679c12e14522..cd54ad3eaf01 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -269,7 +269,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 1000;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
-- 
2.15.0-rc2

