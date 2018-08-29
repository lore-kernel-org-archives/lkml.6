Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E4C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36FD20852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36FD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeH2GuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:50:11 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19349 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbeH2GuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:50:10 -0400
X-UUID: 1debde76d4604a5e80d37a7f3afc0ee6-20180829
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1640217028; Wed, 29 Aug 2018 10:55:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:55:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:55:24 +0800
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
Subject: [PATCH 5/6] usb: xhci-mtk: supports bandwidth scheduling with multi-TT
Date:   Wed, 29 Aug 2018 10:55:17 +0800
Message-ID: <57f6f53d29d6adef7e12ed958ed29688fe37f7e0.1535510898.git.chunfeng.yun@mediatek.com>
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

Supports LowSpeed and FullSpeed INT/ISOC bandwidth scheduling
with USB multi-TT

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 247 ++++++++++++++++++++++++++++++++++++++--
 drivers/usb/host/xhci-mtk.h     |  21 ++++
 2 files changed, 258 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 7efd890..36050a1 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -80,10 +80,98 @@ static u32 get_esit(struct xhci_ep_ctx *ep_ctx)
 	return esit;
 }
 
+static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
+{
+	struct usb_tt *utt = udev->tt;
+	struct mu3h_sch_tt *tt, **tt_index, **ptt;
+	unsigned int port;
+	bool allocated_index = false;
+
+	if (!utt)
+		return NULL;	/* Not below a TT */
+
+	/*
+	 * Find/create our data structure.
+	 * For hubs with a single TT, we get it directly.
+	 * For hubs with multiple TTs, there's an extra level of pointers.
+	 */
+	tt_index = NULL;
+	if (utt->multi) {
+		tt_index = utt->hcpriv;
+		if (!tt_index) {	/* Create the index array */
+			tt_index = kcalloc(utt->hub->maxchild,
+					sizeof(*tt_index), GFP_KERNEL);
+			if (!tt_index)
+				return ERR_PTR(-ENOMEM);
+			utt->hcpriv = tt_index;
+			allocated_index = true;
+		}
+		port = udev->ttport - 1;
+		ptt = &tt_index[port];
+	} else {
+		port = 0;
+		ptt = (struct mu3h_sch_tt **) &utt->hcpriv;
+	}
+
+	tt = *ptt;
+	if (!tt) {	/* Create the mu3h_sch_tt */
+		tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+		if (!tt) {
+			if (allocated_index) {
+				utt->hcpriv = NULL;
+				kfree(tt_index);
+			}
+			return ERR_PTR(-ENOMEM);
+		}
+		INIT_LIST_HEAD(&tt->ep_list);
+		tt->usb_tt = utt;
+		tt->tt_port = port;
+		*ptt = tt;
+	}
+
+	return tt;
+}
+
+/* Release the TT above udev, if it's not in use */
+static void drop_tt(struct usb_device *udev)
+{
+	struct usb_tt *utt = udev->tt;
+	struct mu3h_sch_tt *tt, **tt_index, **ptt;
+	int i, cnt;
+
+	if (!utt || !utt->hcpriv)
+		return;		/* Not below a TT, or never allocated */
+
+	cnt = 0;
+	if (utt->multi) {
+		tt_index = utt->hcpriv;
+		ptt = &tt_index[udev->ttport - 1];
+		/*  How many entries are left in tt_index? */
+		for (i = 0; i < utt->hub->maxchild; ++i)
+			cnt += !!tt_index[i];
+	} else {
+		tt_index = NULL;
+		ptt = (struct mu3h_sch_tt **)&utt->hcpriv;
+	}
+
+	tt = *ptt;
+	if (!tt || !list_empty(&tt->ep_list))
+		return;		/* never allocated , or still in use*/
+
+	*ptt = NULL;
+	kfree(tt);
+
+	if (cnt == 1) {
+		utt->hcpriv = NULL;
+		kfree(tt_index);
+	}
+}
+
 static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	struct usb_host_endpoint *ep, struct xhci_ep_ctx *ep_ctx)
 {
 	struct mu3h_sch_ep_info *sch_ep;
+	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
 	size_t mem_size;
 
@@ -101,6 +189,15 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 	if (!sch_ep)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_fs_or_ls(udev->speed)) {
+		tt = find_tt(udev);
+		if (IS_ERR(tt)) {
+			kfree(sch_ep);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
 
 	return sch_ep;
@@ -128,6 +225,8 @@ static void setup_sch_info(struct usb_device *udev,
 		 CTX_TO_MAX_ESIT_PAYLOAD(le32_to_cpu(ep_ctx->tx_info));
 
 	sch_ep->esit = get_esit(ep_ctx);
+	sch_ep->ep_type = ep_type;
+	sch_ep->maxpkt = maxpkt;
 	sch_ep->offset = 0;
 	sch_ep->burst_mode = 0;
 	sch_ep->repeat = 0;
@@ -197,8 +296,13 @@ static void setup_sch_info(struct usb_device *udev,
 		}
 	} else if (is_fs_or_ls(udev->speed)) {
 		sch_ep->pkts = 1; /* at most one packet for each microframe */
+
+		/*
+		 * num_budget_microframes and cs_count will be updated when
+		 * check TT for INT_OUT_EP, ISOC/INT_IN_EP type
+		 */
 		sch_ep->cs_count = DIV_ROUND_UP(maxpkt, FS_PAYLOAD_MAX);
-		sch_ep->num_budget_microframes = sch_ep->cs_count + 2;
+		sch_ep->num_budget_microframes = sch_ep->cs_count;
 		sch_ep->bw_cost_per_microframe =
 			(maxpkt < FS_PAYLOAD_MAX) ? maxpkt : FS_PAYLOAD_MAX;
 
@@ -212,7 +316,13 @@ static void setup_sch_info(struct usb_device *udev,
 		} else { /* INT_IN_EP or ISOC_IN_EP */
 			bwb_table[0] = 0; /* start split */
 			bwb_table[1] = 0; /* idle */
-			for (i = 2; i < sch_ep->num_budget_microframes; i++)
+			/*
+			 * due to cs_count will be updated according to cs
+			 * position, assign all remainder budget array
+			 * elements as @bw_cost_per_microframe, but only first
+			 * @num_budget_microframes elements will be used later
+			 */
+			for (i = 2; i < TT_MICROFRAMES_MAX; i++)
 				bwb_table[i] =	sch_ep->bw_cost_per_microframe;
 		}
 	}
@@ -264,6 +374,96 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	}
 }
 
+static int check_sch_tt(struct usb_device *udev,
+	struct mu3h_sch_ep_info *sch_ep, u32 offset)
+{
+	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
+	u32 extra_cs_count;
+	u32 fs_budget_start;
+	u32 start_ss, last_ss;
+	u32 start_cs, last_cs;
+	int i;
+
+	start_ss = offset % 8;
+	fs_budget_start = (start_ss + 1) % 8;
+
+	if (sch_ep->ep_type == ISOC_OUT_EP) {
+		last_ss = start_ss + sch_ep->cs_count - 1;
+
+		/*
+		 * usb_20 spec section11.18:
+		 * must never schedule Start-Split in Y6
+		 */
+		if (!(start_ss == 7 || last_ss < 6))
+			return -ERANGE;
+
+		for (i = 0; i < sch_ep->cs_count; i++)
+			if (test_bit(offset + i, tt->split_bit_map))
+				return -ERANGE;
+
+	} else {
+		u32 cs_count = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
+
+		/*
+		 * usb_20 spec section11.18:
+		 * must never schedule Start-Split in Y6
+		 */
+		if (start_ss == 6)
+			return -ERANGE;
+
+		/* one uframe for ss + one uframe for idle */
+		start_cs = (start_ss + 2) % 8;
+		last_cs = start_cs + cs_count - 1;
+
+		if (last_cs > 7)
+			return -ERANGE;
+
+		if (sch_ep->ep_type == ISOC_IN_EP)
+			extra_cs_count = (last_cs == 7) ? 1 : 2;
+		else /*  ep_type : INTR IN / INTR OUT */
+			extra_cs_count = (fs_budget_start == 6) ? 1 : 2;
+
+		cs_count += extra_cs_count;
+		if (cs_count > 7)
+			cs_count = 7; /* HW limit */
+
+		for (i = 0; i < cs_count + 2; i++) {
+			if (test_bit(offset + i, tt->split_bit_map))
+				return -ERANGE;
+		}
+
+		sch_ep->cs_count = cs_count;
+		/* one for ss, the other for idle */
+		sch_ep->num_budget_microframes = cs_count + 2;
+
+		/*
+		 * if interval=1, maxp >752, num_budge_micoframe is larger
+		 * than sch_ep->esit, will overstep boundary
+		 */
+		if (sch_ep->num_budget_microframes > sch_ep->esit)
+			sch_ep->num_budget_microframes = sch_ep->esit;
+	}
+
+	return 0;
+}
+
+static void update_sch_tt(struct usb_device *udev,
+	struct mu3h_sch_ep_info *sch_ep)
+{
+	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
+	u32 base, num_esit;
+	int i, j;
+
+	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
+	for (i = 0; i < num_esit; i++) {
+		base = sch_ep->offset + i * sch_ep->esit;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++)
+			set_bit(base + j, tt->split_bit_map);
+	}
+
+	list_add_tail(&sch_ep->tt_endpoint, &tt->ep_list);
+}
+
 static int check_sch_bw(struct usb_device *udev,
 	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
 {
@@ -273,6 +473,10 @@ static int check_sch_bw(struct usb_device *udev,
 	u32 min_index;
 	u32 worst_bw;
 	u32 bw_boundary;
+	u32 min_num_budget;
+	u32 min_cs_count;
+	bool tt_offset_ok = false;
+	int ret;
 
 	esit = sch_ep->esit;
 
@@ -282,26 +486,30 @@ static int check_sch_bw(struct usb_device *udev,
 	 */
 	min_bw = ~0;
 	min_index = 0;
+	min_cs_count = sch_ep->cs_count;
+	min_num_budget = sch_ep->num_budget_microframes;
 	for (offset = 0; offset < esit; offset++) {
+		if (is_fs_or_ls(udev->speed)) {
+			ret = check_sch_tt(udev, sch_ep, offset);
+			if (ret)
+				continue;
+			else
+				tt_offset_ok = true;
+		}
+
 		if ((offset + sch_ep->num_budget_microframes) > sch_ep->esit)
 			break;
 
-		/*
-		 * usb_20 spec section11.18:
-		 * must never schedule Start-Split in Y6
-		 */
-		if (is_fs_or_ls(udev->speed) && (offset % 8 == 6))
-			continue;
-
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
 		if (min_bw > worst_bw) {
 			min_bw = worst_bw;
 			min_index = offset;
+			min_cs_count = sch_ep->cs_count;
+			min_num_budget = sch_ep->num_budget_microframes;
 		}
 		if (min_bw == 0)
 			break;
 	}
-	sch_ep->offset = min_index;
 
 	bw_boundary = (udev->speed == USB_SPEED_SUPER)
 				? SS_BW_BOUNDARY : HS_BW_BOUNDARY;
@@ -310,6 +518,18 @@ static int check_sch_bw(struct usb_device *udev,
 	if (min_bw > bw_boundary)
 		return -ERANGE;
 
+	sch_ep->offset = min_index;
+	sch_ep->cs_count = min_cs_count;
+	sch_ep->num_budget_microframes = min_num_budget;
+
+	if (is_fs_or_ls(udev->speed)) {
+		/* all offset for tt is not ok*/
+		if (!tt_offset_ok)
+			return -ERANGE;
+
+		update_sch_tt(udev, sch_ep);
+	}
+
 	/* update bus bandwidth info */
 	update_bus_bw(sch_bw, sch_ep, 1);
 
@@ -415,6 +635,9 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	ret = check_sch_bw(udev, sch_bw, sch_ep);
 	if (ret) {
 		xhci_err(xhci, "Not enough bandwidth!\n");
+		if (is_fs_or_ls(udev->speed))
+			drop_tt(udev);
+
 		kfree(sch_ep);
 		return -ENOSPC;
 	}
@@ -466,6 +689,10 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		if (sch_ep->ep == ep) {
 			update_bus_bw(sch_bw, sch_ep, 0);
 			list_del(&sch_ep->endpoint);
+			if (is_fs_or_ls(udev->speed)) {
+				list_del(&sch_ep->tt_endpoint);
+				drop_tt(udev);
+			}
 			kfree(sch_ep);
 			break;
 		}
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index f8864fc..8be8c5f 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -20,6 +20,19 @@
 #define XHCI_MTK_MAX_ESIT	64
 
 /**
+ * @split_bit_map: used to avoid split microframes overlay
+ * @ep_list: Endpoints using this TT
+ * @usb_tt: usb TT related
+ * @tt_port: TT port number
+ */
+struct mu3h_sch_tt {
+	DECLARE_BITMAP(split_bit_map, XHCI_MTK_MAX_ESIT);
+	struct list_head ep_list;
+	struct usb_tt *usb_tt;
+	int tt_port;
+};
+
+/**
  * struct mu3h_sch_bw_info: schedule information for bandwidth domain
  *
  * @bus_bw: array to keep track of bandwidth already used at each uframes
@@ -41,6 +54,10 @@ struct mu3h_sch_bw_info {
  *		(@repeat==1) scheduled within the interval
  * @bw_cost_per_microframe: bandwidth cost per microframe
  * @endpoint: linked into bandwidth domain which it belongs to
+ * @tt_endpoint: linked into mu3h_sch_tt's list which it belongs to
+ * @sch_tt: mu3h_sch_tt linked into
+ * @ep_type: endpoint type
+ * @maxpkt: max packet size of endpoint
  * @ep: address of usb_host_endpoint struct
  * @offset: which uframe of the interval that transfer should be
  *		scheduled first time within the interval
@@ -64,6 +81,10 @@ struct mu3h_sch_ep_info {
 	u32 num_budget_microframes;
 	u32 bw_cost_per_microframe;
 	struct list_head endpoint;
+	struct list_head tt_endpoint;
+	struct mu3h_sch_tt *sch_tt;
+	u32 ep_type;
+	u32 maxpkt;
 	void *ep;
 	/*
 	 * mtk xHCI scheduling information put into reserved DWs
-- 
1.9.1

