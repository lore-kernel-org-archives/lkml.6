Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A9AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BF020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BF020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJPLVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:21:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbeJPLVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:21:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08D09722F64C8;
        Tue, 16 Oct 2018 11:32:50 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Tue, 16 Oct 2018 11:32:44 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     Zeng Tao <prime.zeng@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] xhci: remove the unused sw_lpm_support
Date:   Tue, 16 Oct 2018 19:37:08 +0800
Message-ID: <1539689828-35940-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is introduced for the pre-0.96 xHC controllers, and the driver only
support HW LPM for 1.0 and later controllers.It's not actually used now
and is thought not to be used in the future any more, so just remove it.

Acked-by: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/host/xhci-mem.c | 20 ++++----------------
 drivers/usb/host/xhci.c     |  3 +--
 drivers/usb/host/xhci.h     |  2 --
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b1f27aa..791c5d8 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2181,23 +2181,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
 		xhci->ext_caps[xhci->num_ext_caps++] = temp;
 
-	/* Check the host's USB2 LPM capability */
-	if ((xhci->hci_version == 0x96) && (major_revision != 0x03) &&
-			(temp & XHCI_L1C)) {
+	if ((xhci->hci_version >= 0x100) && (major_revision != 0x03) &&
+		 (temp & XHCI_HLC)) {
 		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-				"xHCI 0.96: support USB2 software lpm");
-		xhci->sw_lpm_support = 1;
-	}
-
-	if ((xhci->hci_version >= 0x100) && (major_revision != 0x03)) {
-		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-				"xHCI 1.0: support USB2 software lpm");
-		xhci->sw_lpm_support = 1;
-		if (temp & XHCI_HLC) {
-			xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-					"xHCI 1.0: support USB2 hardware lpm");
-			xhci->hw_lpm_support = 1;
-		}
+			       "xHCI 1.0: support USB2 hardware lpm");
+		xhci->hw_lpm_support = 1;
 	}
 
 	port_offset--;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0420eef..d565d5a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4372,8 +4372,7 @@ static int xhci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int		portnum = udev->portnum - 1;
 
-	if (hcd->speed >= HCD_USB3 || !xhci->sw_lpm_support ||
-			!udev->lpm_capable)
+	if (hcd->speed >= HCD_USB3 || !udev->lpm_capable)
 		return 0;
 
 	/* we only support lpm for non-hub device connected to root hub yet */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6230a57..746129d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1854,8 +1854,6 @@ struct xhci_hcd {
 	struct xhci_port	*hw_ports;
 	struct xhci_hub		usb2_rhub;
 	struct xhci_hub		usb3_rhub;
-	/* support xHCI 0.96 spec USB2 software LPM */
-	unsigned		sw_lpm_support:1;
 	/* support xHCI 1.0 spec USB2 hardware LPM */
 	unsigned		hw_lpm_support:1;
 	/* cached usb2 extened protocol capabilites */
-- 
2.7.4

