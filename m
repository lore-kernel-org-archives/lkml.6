Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D8AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63002083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63002083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeH2GuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:50:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20205 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbeH2GuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:50:07 -0400
X-UUID: 65eb970079d1480b96d8b3ba654ec8a2-20180829
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1550199016; Wed, 29 Aug 2018 10:55:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:55:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:55:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 6/6] usb: xhci-mtk: supports SSP without external USB3 gen2 hub
Date:   Wed, 29 Aug 2018 10:55:18 +0800
Message-ID: <0b0ebe56390a9a66d5d84c5717665bf7d2ae179c.1535510898.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supports SSP scheduling only for SSP device directly connected
to root hub but not through external USB3 gen2 hub which need
use a new scheduling way.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 36050a1..fea5555 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -13,6 +13,7 @@
 #include "xhci.h"
 #include "xhci-mtk.h"
 
+#define SSP_BW_BOUNDARY	130000
 #define SS_BW_BOUNDARY	51000
 /* table 5-5. High-speed Isoc Transaction Limits in usb_20 spec */
 #define HS_BW_BOUNDARY	6144
@@ -25,7 +26,7 @@
 #define TT_MICROFRAMES_MAX 9
 
 /* mtk scheduler bitmasks */
-#define EP_BPKTS(p)	((p) & 0x3f)
+#define EP_BPKTS(p)	((p) & 0x7f)
 #define EP_BCSCOUNT(p)	(((p) & 0x7) << 8)
 #define EP_BBM(p)	((p) << 11)
 #define EP_BOFFSET(p)	((p) & 0x3fff)
@@ -56,7 +57,7 @@ static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
 
 	virt_dev = xhci->devs[udev->slot_id];
 
-	if (udev->speed == USB_SPEED_SUPER) {
+	if (udev->speed >= USB_SPEED_SUPER) {
 		if (usb_endpoint_dir_out(&ep->desc))
 			bw_index = (virt_dev->real_port - 1) * 2;
 		else
@@ -177,7 +178,7 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 
 	if (is_fs_or_ls(udev->speed))
 		len_bw_budget_table = TT_MICROFRAMES_MAX;
-	else if ((udev->speed == USB_SPEED_SUPER)
+	else if ((udev->speed >= USB_SPEED_SUPER)
 			&& usb_endpoint_xfer_isoc(&ep->desc))
 		len_bw_budget_table = get_esit(ep_ctx);
 	else
@@ -249,7 +250,7 @@ static void setup_sch_info(struct usb_device *udev,
 		sch_ep->pkts = max_burst + 1;
 		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
 		bwb_table[0] = sch_ep->bw_cost_per_microframe;
-	} else if (udev->speed == USB_SPEED_SUPER) {
+	} else if (udev->speed >= USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
 		sch_ep->burst_mode = 1;
@@ -511,8 +512,12 @@ static int check_sch_bw(struct usb_device *udev,
 			break;
 	}
 
-	bw_boundary = (udev->speed == USB_SPEED_SUPER)
-				? SS_BW_BOUNDARY : HS_BW_BOUNDARY;
+	if (udev->speed == USB_SPEED_SUPER_PLUS)
+		bw_boundary = SSP_BW_BOUNDARY;
+	else if (udev->speed == USB_SPEED_SUPER)
+		bw_boundary = SS_BW_BOUNDARY;
+	else
+		bw_boundary = HS_BW_BOUNDARY;
 
 	/* check bandwidth */
 	if (min_bw > bw_boundary)
-- 
1.9.1

