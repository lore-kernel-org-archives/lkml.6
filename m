Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB28C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B82083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3B82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeH2GuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:50:14 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:15917 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727426AbeH2GuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:50:13 -0400
X-UUID: 646716a2f34e42eea56c38e61d2ed0c4-20180829
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2035301709; Wed, 29 Aug 2018 10:55:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:55:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:55:23 +0800
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
Subject: [PATCH 4/6] usb: xhci-mtk: improve bandwidth scheduling
Date:   Wed, 29 Aug 2018 10:55:16 +0800
Message-ID: <dc1094721812573189f3c7db4548b9c4fc761d81.1535510898.git.chunfeng.yun@mediatek.com>
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

Mainly improve SuperSpeed ISOC bandwidth in last microframe,
and LowSpeed/FullSpeed IN INT/ISOC bandwidth in split and
idle microframes by introduing a bandwidth budget table;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 162 +++++++++++++++++++++++++---------------
 drivers/usb/host/xhci-mtk.h     |   2 +
 2 files changed, 104 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 057f453..7efd890 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -18,6 +18,11 @@
 #define HS_BW_BOUNDARY	6144
 /* usb2 spec section11.18.1: at most 188 FS bytes per microframe */
 #define FS_PAYLOAD_MAX 188
+/*
+ * max number of microframes for split transfer,
+ * for fs isoc in : 1 ss + 1 idle + 7 cs
+ */
+#define TT_MICROFRAMES_MAX 9
 
 /* mtk scheduler bitmasks */
 #define EP_BPKTS(p)	((p) & 0x3f)
@@ -64,20 +69,57 @@ static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
 	return bw_index;
 }
 
+static u32 get_esit(struct xhci_ep_ctx *ep_ctx)
+{
+	u32 esit;
+
+	esit = 1 << CTX_TO_EP_INTERVAL(le32_to_cpu(ep_ctx->ep_info));
+	if (esit > XHCI_MTK_MAX_ESIT)
+		esit = XHCI_MTK_MAX_ESIT;
+
+	return esit;
+}
+
+static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
+	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
+{
+	struct mu3h_sch_ep_info *sch_ep;
+	u32 len_bw_budget_table;
+	size_t mem_size;
+
+	if (is_fs_or_ls(udev->speed))
+		len_bw_budget_table = TT_MICROFRAMES_MAX;
+	else if ((udev->speed == USB_SPEED_SUPER)
+			&& usb_endpoint_xfer_isoc(&ep->desc))
+		len_bw_budget_table = get_esit(ep_ctx);
+	else
+		len_bw_budget_table = 1;
+
+	mem_size = sizeof(struct mu3h_sch_ep_info) +
+			len_bw_budget_table * sizeof(u32);
+	sch_ep = kzalloc(mem_size, GFP_KERNEL);
+	if (!sch_ep)
+		return ERR_PTR(-ENOMEM);
+
+	sch_ep->ep = ep;
+
+	return sch_ep;
+}
+
 static void setup_sch_info(struct usb_device *udev,
 		struct xhci_ep_ctx *ep_ctx, struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 ep_type;
-	u32 ep_interval;
-	u32 max_packet_size;
+	u32 maxpkt;
 	u32 max_burst;
 	u32 mult;
 	u32 esit_pkts;
 	u32 max_esit_payload;
+	u32 *bwb_table = sch_ep->bw_budget_table;
+	int i;
 
 	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
-	ep_interval = CTX_TO_EP_INTERVAL(le32_to_cpu(ep_ctx->ep_info));
-	max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
+	maxpkt = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
 	max_burst = CTX_TO_MAX_BURST(le32_to_cpu(ep_ctx->ep_info2));
 	mult = CTX_TO_EP_MULT(le32_to_cpu(ep_ctx->ep_info));
 	max_esit_payload =
@@ -85,9 +127,10 @@ static void setup_sch_info(struct usb_device *udev,
 			le32_to_cpu(ep_ctx->ep_info)) << 16) |
 		 CTX_TO_MAX_ESIT_PAYLOAD(le32_to_cpu(ep_ctx->tx_info));
 
-	sch_ep->esit = 1 << ep_interval;
+	sch_ep->esit = get_esit(ep_ctx);
 	sch_ep->offset = 0;
 	sch_ep->burst_mode = 0;
+	sch_ep->repeat = 0;
 
 	if (udev->speed == USB_SPEED_HIGH) {
 		sch_ep->cs_count = 0;
@@ -98,7 +141,6 @@ static void setup_sch_info(struct usb_device *udev,
 		 * in a interval
 		 */
 		sch_ep->num_budget_microframes = 1;
-		sch_ep->repeat = 0;
 
 		/*
 		 * xHCI spec section6.2.3.4
@@ -106,26 +148,30 @@ static void setup_sch_info(struct usb_device *udev,
 		 * opportunities per microframe
 		 */
 		sch_ep->pkts = max_burst + 1;
-		sch_ep->bw_cost_per_microframe = max_packet_size * sch_ep->pkts;
+		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
+		bwb_table[0] = sch_ep->bw_cost_per_microframe;
 	} else if (udev->speed == USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
+		sch_ep->burst_mode = 1;
 		/*
 		 * some device's (d)wBytesPerInterval is set as 0,
 		 * then max_esit_payload is 0, so evaluate esit_pkts from
 		 * mult and burst
 		 */
-		esit_pkts = DIV_ROUND_UP(max_esit_payload, max_packet_size);
+		esit_pkts = DIV_ROUND_UP(max_esit_payload, maxpkt);
 		if (esit_pkts == 0)
 			esit_pkts = (mult + 1) * (max_burst + 1);
 
 		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
 			sch_ep->pkts = esit_pkts;
 			sch_ep->num_budget_microframes = 1;
-			sch_ep->repeat = 0;
+			bwb_table[0] = maxpkt * sch_ep->pkts;
 		}
 
 		if (ep_type == ISOC_IN_EP || ep_type == ISOC_OUT_EP) {
+			u32 remainder;
+
 			if (sch_ep->esit == 1)
 				sch_ep->pkts = esit_pkts;
 			else if (esit_pkts <= sch_ep->esit)
@@ -137,43 +183,37 @@ static void setup_sch_info(struct usb_device *udev,
 			sch_ep->num_budget_microframes =
 				DIV_ROUND_UP(esit_pkts, sch_ep->pkts);
 
-			if (sch_ep->num_budget_microframes > 1)
-				sch_ep->repeat = 1;
-			else
-				sch_ep->repeat = 0;
+			sch_ep->repeat = !!(sch_ep->num_budget_microframes > 1);
+			sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
+
+			remainder = sch_ep->bw_cost_per_microframe;
+			remainder *= sch_ep->num_budget_microframes;
+			remainder -= (maxpkt * esit_pkts);
+			for (i = 0; i < sch_ep->num_budget_microframes - 1; i++)
+				bwb_table[i] = sch_ep->bw_cost_per_microframe;
+
+			/* last one <= bw_cost_per_microframe */
+			bwb_table[i] = remainder;
 		}
-		sch_ep->bw_cost_per_microframe = max_packet_size * sch_ep->pkts;
 	} else if (is_fs_or_ls(udev->speed)) {
-
-		/*
-		 * usb_20 spec section11.18.4
-		 * assume worst cases
-		 */
-		sch_ep->repeat = 0;
 		sch_ep->pkts = 1; /* at most one packet for each microframe */
-		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
-			sch_ep->cs_count = 3; /* at most need 3 CS*/
-			/* one for SS and one for budgeted transaction */
-			sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
-			sch_ep->bw_cost_per_microframe = max_packet_size;
-		}
-		if (ep_type == ISOC_OUT_EP) {
+		sch_ep->cs_count = DIV_ROUND_UP(maxpkt, FS_PAYLOAD_MAX);
+		sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
+		sch_ep->bw_cost_per_microframe =
+			(maxpkt < FS_PAYLOAD_MAX) ? maxpkt : FS_PAYLOAD_MAX;
 
-			/*
-			 * the best case FS budget assumes that 188 FS bytes
-			 * occur in each microframe
-			 */
-			sch_ep->num_budget_microframes = DIV_ROUND_UP(
-				max_packet_size, FS_PAYLOAD_MAX);
-			sch_ep->bw_cost_per_microframe = FS_PAYLOAD_MAX;
-			sch_ep->cs_count = sch_ep->num_budget_microframes;
-		}
-		if (ep_type == ISOC_IN_EP) {
-			/* at most need additional two CS. */
-			sch_ep->cs_count = DIV_ROUND_UP(
-				max_packet_size, FS_PAYLOAD_MAX) + 2;
-			sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
-			sch_ep->bw_cost_per_microframe = FS_PAYLOAD_MAX;
+		/* init budget table */
+		if (ep_type == ISOC_OUT_EP) {
+			for (i = 0; i < sch_ep->num_budget_microframes; i++)
+				bwb_table[i] =	sch_ep->bw_cost_per_microframe;
+		} else if (ep_type == INT_OUT_EP) {
+			/* only first one consumes bandwidth, others as zero */
+			bwb_table[0] = sch_ep->bw_cost_per_microframe;
+		} else { /* INT_IN_EP or ISOC_IN_EP */
+			bwb_table[0] = 0; /* start split */
+			bwb_table[1] = 0; /* idle */
+			for (i = 2; i < sch_ep->num_budget_microframes; i++)
+				bwb_table[i] =	sch_ep->bw_cost_per_microframe;
 		}
 	}
 }
@@ -184,6 +224,7 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 {
 	u32 num_esit;
 	u32 max_bw = 0;
+	u32 bw;
 	int i;
 	int j;
 
@@ -192,15 +233,17 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 		u32 base = offset + i * sch_ep->esit;
 
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-			if (sch_bw->bus_bw[base + j] > max_bw)
-				max_bw = sch_bw->bus_bw[base + j];
+			bw = sch_bw->bus_bw[base + j] +
+					sch_ep->bw_budget_table[j];
+			if (bw > max_bw)
+				max_bw = bw;
 		}
 	}
 	return max_bw;
 }
 
 static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
-	struct mu3h_sch_ep_info *sch_ep, int bw_cost)
+	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	u32 num_esit;
 	u32 base;
@@ -210,8 +253,14 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
 	for (i = 0; i < num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
-		for (j = 0; j < sch_ep->num_budget_microframes; j++)
-			sch_bw->bus_bw[base + j] += bw_cost;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			if (used)
+				sch_bw->bus_bw[base + j] +=
+					sch_ep->bw_budget_table[j];
+			else
+				sch_bw->bus_bw[base + j] -=
+					sch_ep->bw_budget_table[j];
+		}
 	}
 }
 
@@ -220,17 +269,12 @@ static int check_sch_bw(struct usb_device *udev,
 {
 	u32 offset;
 	u32 esit;
-	u32 num_budget_microframes;
 	u32 min_bw;
 	u32 min_index;
 	u32 worst_bw;
 	u32 bw_boundary;
 
-	if (sch_ep->esit > XHCI_MTK_MAX_ESIT)
-		sch_ep->esit = XHCI_MTK_MAX_ESIT;
-
 	esit = sch_ep->esit;
-	num_budget_microframes = sch_ep->num_budget_microframes;
 
 	/*
 	 * Search through all possible schedule microframes.
@@ -239,7 +283,7 @@ static int check_sch_bw(struct usb_device *udev,
 	min_bw = ~0;
 	min_index = 0;
 	for (offset = 0; offset < esit; offset++) {
-		if ((offset + num_budget_microframes) > sch_ep->esit)
+		if ((offset + sch_ep->num_budget_microframes) > sch_ep->esit)
 			break;
 
 		/*
@@ -263,11 +307,11 @@ static int check_sch_bw(struct usb_device *udev,
 				? SS_BW_BOUNDARY : HS_BW_BOUNDARY;
 
 	/* check bandwidth */
-	if (min_bw + sch_ep->bw_cost_per_microframe > bw_boundary)
+	if (min_bw > bw_boundary)
 		return -ERANGE;
 
 	/* update bus bandwidth info */
-	update_bus_bw(sch_bw, sch_ep, sch_ep->bw_cost_per_microframe);
+	update_bus_bw(sch_bw, sch_ep, 1);
 
 	return 0;
 }
@@ -362,8 +406,8 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	bw_index = get_bw_index(xhci, udev, ep);
 	sch_bw = &sch_array[bw_index];
 
-	sch_ep = kzalloc(sizeof(struct mu3h_sch_ep_info), GFP_NOIO);
-	if (!sch_ep)
+	sch_ep = create_sch_ep(udev, ep, ep_ctx);
+	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
 	setup_sch_info(udev, ep_ctx, sch_ep);
@@ -376,7 +420,6 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	list_add_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
-	sch_ep->ep = ep;
 
 	ep_ctx->reserved[0] |= cpu_to_le32(EP_BPKTS(sch_ep->pkts)
 		| EP_BCSCOUNT(sch_ep->cs_count) | EP_BBM(sch_ep->burst_mode));
@@ -421,8 +464,7 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	list_for_each_entry(sch_ep, &sch_bw->bw_ep_list, endpoint) {
 		if (sch_ep->ep == ep) {
-			update_bus_bw(sch_bw, sch_ep,
-				-sch_ep->bw_cost_per_microframe);
+			update_bus_bw(sch_bw, sch_ep, 0);
 			list_del(&sch_ep->endpoint);
 			kfree(sch_ep);
 			break;
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index cc59d80..f8864fc 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -57,6 +57,7 @@ struct mu3h_sch_bw_info {
  *		times; 1: distribute the (bMaxBurst+1)*(Mult+1) packets
  *		according to @pkts and @repeat. normal mode is used by
  *		default
+ * @bw_budget_table: table to record bandwidth budget per microframe
  */
 struct mu3h_sch_ep_info {
 	u32 esit;
@@ -73,6 +74,7 @@ struct mu3h_sch_ep_info {
 	u32 pkts;
 	u32 cs_count;
 	u32 burst_mode;
+	u32 bw_budget_table[0];
 };
 
 #define MU3C_U3_PORT_MAX 4
-- 
1.9.1

