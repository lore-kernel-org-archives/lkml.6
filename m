Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA8F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLRLDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:03:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38121 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbeLRLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B326E3D47F765;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:58 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: aligning buffer size in SSU to 256 bytes
Date:   Tue, 18 Dec 2018 19:37:58 +0800
Message-ID: <1545133079-79605-12-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The hardware expects the buffer size set to SSU is aligned to
256 bytes, this patch aligns the buffer size to 256 byte using
roundup or rounddown function.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 43 +++++++++++++---------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c52e903..f847fde 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -26,6 +26,8 @@
 #define HCLGE_STATS_READ(p, offset) (*((u64 *)((u8 *)(p) + (offset))))
 #define HCLGE_MAC_STATS_FIELD_OFF(f) (offsetof(struct hclge_mac_stats, f))
 
+#define HCLGE_BUF_SIZE_UNIT	256
+
 static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps);
 static int hclge_init_vlan_config(struct hclge_dev *hdev);
 static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev);
@@ -693,12 +695,16 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 	else
 		hdev->tx_buf_size = HCLGE_DEFAULT_TX_BUF;
 
+	hdev->tx_buf_size = roundup(hdev->tx_buf_size, HCLGE_BUF_SIZE_UNIT);
+
 	if (req->dv_buf_size)
 		hdev->dv_buf_size =
 			__le16_to_cpu(req->dv_buf_size) << HCLGE_BUF_UNIT_S;
 	else
 		hdev->dv_buf_size = HCLGE_DEFAULT_DV;
 
+	hdev->dv_buf_size = roundup(hdev->dv_buf_size, HCLGE_BUF_SIZE_UNIT);
+
 	if (hnae3_dev_roce_supported(hdev)) {
 		hdev->roce_base_msix_offset =
 		hnae3_get_field(__le16_to_cpu(req->msixcap_localid_ba_rocee),
@@ -1380,48 +1386,50 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 {
 	u32 shared_buf_min, shared_buf_tc, shared_std;
 	int tc_num, pfc_enable_num;
-	u32 shared_buf;
+	u32 shared_buf, aligned_mps;
 	u32 rx_priv;
 	int i;
 
 	tc_num = hclge_get_tc_num(hdev);
 	pfc_enable_num = hclge_get_pfc_enalbe_num(hdev);
+	aligned_mps = roundup(hdev->mps, HCLGE_BUF_SIZE_UNIT);
 
 	if (hnae3_dev_dcb_supported(hdev))
-		shared_buf_min = 2 * hdev->mps + hdev->dv_buf_size;
+		shared_buf_min = 2 * aligned_mps + hdev->dv_buf_size;
 	else
-		shared_buf_min = hdev->mps + HCLGE_NON_DCB_ADDITIONAL_BUF
+		shared_buf_min = aligned_mps + HCLGE_NON_DCB_ADDITIONAL_BUF
 					+ hdev->dv_buf_size;
 
-	shared_buf_tc = pfc_enable_num * hdev->mps +
-			(tc_num - pfc_enable_num) * hdev->mps / 2 +
-			hdev->mps;
+	shared_buf_tc = pfc_enable_num * aligned_mps +
+			(tc_num - pfc_enable_num) * aligned_mps / 2 +
+			aligned_mps;
 	shared_std = max_t(u32, shared_buf_min, shared_buf_tc);
 
 	rx_priv = hclge_get_rx_priv_buff_alloced(buf_alloc);
 	if (rx_all <= rx_priv + shared_std)
 		return false;
 
-	shared_buf = rx_all - rx_priv;
+	shared_buf = rounddown(rx_all - rx_priv, HCLGE_BUF_SIZE_UNIT);
 	buf_alloc->s_buf.buf_size = shared_buf;
 	if (hnae3_dev_dcb_supported(hdev)) {
 		buf_alloc->s_buf.self.high = shared_buf - hdev->dv_buf_size;
 		buf_alloc->s_buf.self.low = buf_alloc->s_buf.self.high
-						- hdev->mps / 2;
+			- roundup(aligned_mps / 2, HCLGE_BUF_SIZE_UNIT);
 	} else {
-		buf_alloc->s_buf.self.high = hdev->mps +
+		buf_alloc->s_buf.self.high = aligned_mps +
 						HCLGE_NON_DCB_ADDITIONAL_BUF;
-		buf_alloc->s_buf.self.low = hdev->mps / 2;
+		buf_alloc->s_buf.self.low =
+			roundup(aligned_mps / 2, HCLGE_BUF_SIZE_UNIT);
 	}
 
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
 		if ((hdev->hw_tc_map & BIT(i)) &&
 		    (hdev->tm_info.hw_pfc_map & BIT(i))) {
-			buf_alloc->s_buf.tc_thrd[i].low = hdev->mps;
-			buf_alloc->s_buf.tc_thrd[i].high = 2 * hdev->mps;
+			buf_alloc->s_buf.tc_thrd[i].low = aligned_mps;
+			buf_alloc->s_buf.tc_thrd[i].high = 2 * aligned_mps;
 		} else {
 			buf_alloc->s_buf.tc_thrd[i].low = 0;
-			buf_alloc->s_buf.tc_thrd[i].high = hdev->mps;
+			buf_alloc->s_buf.tc_thrd[i].high = aligned_mps;
 		}
 	}
 
@@ -1461,7 +1469,6 @@ static int hclge_tx_buffer_calc(struct hclge_dev *hdev,
 static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 				struct hclge_pkt_buf_alloc *buf_alloc)
 {
-#define HCLGE_BUF_SIZE_UNIT	128
 	u32 rx_all = hdev->pkt_buf_size, aligned_mps;
 	int no_pfc_priv_num, pfc_priv_num;
 	struct hclge_priv_buf *priv;
@@ -1487,9 +1494,11 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 			priv->enable = 1;
 			if (hdev->tm_info.hw_pfc_map & BIT(i)) {
 				priv->wl.low = aligned_mps;
-				priv->wl.high = priv->wl.low + aligned_mps;
+				priv->wl.high =
+					roundup(priv->wl.low + aligned_mps,
+						HCLGE_BUF_SIZE_UNIT);
 				priv->buf_size = priv->wl.high +
-						hdev->dv_buf_size;
+					hdev->dv_buf_size;
 			} else {
 				priv->wl.low = 0;
 				priv->wl.high = 2 * aligned_mps;
@@ -1524,7 +1533,7 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		priv->enable = 1;
 
 		if (hdev->tm_info.hw_pfc_map & BIT(i)) {
-			priv->wl.low = 128;
+			priv->wl.low = 256;
 			priv->wl.high = priv->wl.low + aligned_mps;
 			priv->buf_size = priv->wl.high + hdev->dv_buf_size;
 		} else {
-- 
1.9.1

