Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9272083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9272083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeH2GuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:50:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40039 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727067AbeH2GuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:50:09 -0400
X-UUID: 3264ebb230f14bafa9934d6a3c8d4f3f-20180829
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 178765800; Wed, 29 Aug 2018 10:55:23 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:55:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:55:20 +0800
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
Subject: [PATCH 2/6] usb: xhci-mtk: use maximum ESIT payload of endpiont context
Date:   Wed, 29 Aug 2018 10:55:14 +0800
Message-ID: <19a0f3e20ba5314112c08307ee39cca603ddf819.1535510898.git.chunfeng.yun@mediatek.com>
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

Make use of maximum ESIT payload of endpoint context to calculate
the number of packets to send in each ESIT

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index fa33d6e..46fe0a2 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -73,12 +73,17 @@ static void setup_sch_info(struct usb_device *udev,
 	u32 max_burst;
 	u32 mult;
 	u32 esit_pkts;
+	u32 max_esit_payload;
 
 	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
 	ep_interval = CTX_TO_EP_INTERVAL(le32_to_cpu(ep_ctx->ep_info));
 	max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
 	max_burst = CTX_TO_MAX_BURST(le32_to_cpu(ep_ctx->ep_info2));
 	mult = CTX_TO_EP_MULT(le32_to_cpu(ep_ctx->ep_info));
+	max_esit_payload =
+		(CTX_TO_MAX_ESIT_PAYLOAD_HI(
+			le32_to_cpu(ep_ctx->ep_info)) << 16) |
+		 CTX_TO_MAX_ESIT_PAYLOAD(le32_to_cpu(ep_ctx->tx_info));
 
 	sch_ep->esit = 1 << ep_interval;
 	sch_ep->offset = 0;
@@ -105,7 +110,15 @@ static void setup_sch_info(struct usb_device *udev,
 	} else if (udev->speed == USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
-		esit_pkts = (mult + 1) * (max_burst + 1);
+		/*
+		 * some device's (d)wBytesPerInterval is set as 0,
+		 * then max_esit_payload is 0, so evaluate esit_pkts from
+		 * mult and burst
+		 */
+		esit_pkts = DIV_ROUND_UP(max_esit_payload, max_packet_size);
+		if (esit_pkts == 0)
+			esit_pkts = (mult + 1) * (max_burst + 1);
+
 		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
 			sch_ep->pkts = esit_pkts;
 			sch_ep->num_budget_microframes = 1;
-- 
1.9.1

