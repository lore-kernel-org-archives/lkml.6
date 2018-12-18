Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04836C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3044217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLRLDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:03:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeLRLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE3CF1872A3DD;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:58 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: getting tx and dv buffer size through firmware
Date:   Tue, 18 Dec 2018 19:37:57 +0800
Message-ID: <1545133079-79605-11-git-send-email-lipeng321@huawei.com>
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

This patch adds support of getting tx and dv buffer size through
firmware, because different version of hardware requires different
size of tx and dv buffer.

This patch also add dv_buf_size to tc' private buffer size even if
pfc is not enable for the tc.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  5 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 41 ++++++++++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  3 ++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 4771780..f23042b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -420,7 +420,9 @@ struct hclge_pf_res_cmd {
 #define HCLGE_PF_VEC_NUM_M		GENMASK(7, 0)
 	__le16 pf_intr_vector_number;
 	__le16 pf_own_fun_number;
-	__le32 rsv[3];
+	__le16 tx_buf_size;
+	__le16 dv_buf_size;
+	__le32 rsv[2];
 };
 
 #define HCLGE_CFG_OFFSET_S	0
@@ -839,6 +841,7 @@ struct hclge_serdes_lb_cmd {
 #define HCLGE_TOTAL_PKT_BUF		0x108000 /* 1.03125M bytes */
 #define HCLGE_DEFAULT_DV		0xA000	 /* 40k byte */
 #define HCLGE_DEFAULT_NON_DCB_DV	0x7800	/* 30K byte */
+#define HCLGE_NON_DCB_ADDITIONAL_BUF	0x200	/* 512 byte */
 
 #define HCLGE_TYPE_CRQ			0
 #define HCLGE_TYPE_CSQ			1
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b66eee9..c52e903 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -687,6 +687,18 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 	hdev->num_tqps = __le16_to_cpu(req->tqp_num);
 	hdev->pkt_buf_size = __le16_to_cpu(req->buf_size) << HCLGE_BUF_UNIT_S;
 
+	if (req->tx_buf_size)
+		hdev->tx_buf_size =
+			__le16_to_cpu(req->tx_buf_size) << HCLGE_BUF_UNIT_S;
+	else
+		hdev->tx_buf_size = HCLGE_DEFAULT_TX_BUF;
+
+	if (req->dv_buf_size)
+		hdev->dv_buf_size =
+			__le16_to_cpu(req->dv_buf_size) << HCLGE_BUF_UNIT_S;
+	else
+		hdev->dv_buf_size = HCLGE_DEFAULT_DV;
+
 	if (hnae3_dev_roce_supported(hdev)) {
 		hdev->roce_base_msix_offset =
 		hnae3_get_field(__le16_to_cpu(req->msixcap_localid_ba_rocee),
@@ -1376,9 +1388,10 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 	pfc_enable_num = hclge_get_pfc_enalbe_num(hdev);
 
 	if (hnae3_dev_dcb_supported(hdev))
-		shared_buf_min = 2 * hdev->mps + HCLGE_DEFAULT_DV;
+		shared_buf_min = 2 * hdev->mps + hdev->dv_buf_size;
 	else
-		shared_buf_min = 2 * hdev->mps + HCLGE_DEFAULT_NON_DCB_DV;
+		shared_buf_min = hdev->mps + HCLGE_NON_DCB_ADDITIONAL_BUF
+					+ hdev->dv_buf_size;
 
 	shared_buf_tc = pfc_enable_num * hdev->mps +
 			(tc_num - pfc_enable_num) * hdev->mps / 2 +
@@ -1391,8 +1404,15 @@ static bool  hclge_is_rx_buf_ok(struct hclge_dev *hdev,
 
 	shared_buf = rx_all - rx_priv;
 	buf_alloc->s_buf.buf_size = shared_buf;
-	buf_alloc->s_buf.self.high = shared_buf;
-	buf_alloc->s_buf.self.low =  2 * hdev->mps;
+	if (hnae3_dev_dcb_supported(hdev)) {
+		buf_alloc->s_buf.self.high = shared_buf - hdev->dv_buf_size;
+		buf_alloc->s_buf.self.low = buf_alloc->s_buf.self.high
+						- hdev->mps / 2;
+	} else {
+		buf_alloc->s_buf.self.high = hdev->mps +
+						HCLGE_NON_DCB_ADDITIONAL_BUF;
+		buf_alloc->s_buf.self.low = hdev->mps / 2;
+	}
 
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
 		if ((hdev->hw_tc_map & BIT(i)) &&
@@ -1419,11 +1439,11 @@ static int hclge_tx_buffer_calc(struct hclge_dev *hdev,
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
 		struct hclge_priv_buf *priv = &buf_alloc->priv_buf[i];
 
-		if (total_size < HCLGE_DEFAULT_TX_BUF)
+		if (total_size < hdev->tx_buf_size)
 			return -ENOMEM;
 
 		if (hdev->hw_tc_map & BIT(i))
-			priv->tx_buf_size = HCLGE_DEFAULT_TX_BUF;
+			priv->tx_buf_size = hdev->tx_buf_size;
 		else
 			priv->tx_buf_size = 0;
 
@@ -1469,11 +1489,12 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 				priv->wl.low = aligned_mps;
 				priv->wl.high = priv->wl.low + aligned_mps;
 				priv->buf_size = priv->wl.high +
-						HCLGE_DEFAULT_DV;
+						hdev->dv_buf_size;
 			} else {
 				priv->wl.low = 0;
 				priv->wl.high = 2 * aligned_mps;
-				priv->buf_size = priv->wl.high;
+				priv->buf_size = priv->wl.high +
+						hdev->dv_buf_size;
 			}
 		} else {
 			priv->enable = 0;
@@ -1505,11 +1526,11 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		if (hdev->tm_info.hw_pfc_map & BIT(i)) {
 			priv->wl.low = 128;
 			priv->wl.high = priv->wl.low + aligned_mps;
-			priv->buf_size = priv->wl.high + HCLGE_DEFAULT_DV;
+			priv->buf_size = priv->wl.high + hdev->dv_buf_size;
 		} else {
 			priv->wl.low = 0;
 			priv->wl.high = aligned_mps;
-			priv->buf_size = priv->wl.high;
+			priv->buf_size = priv->wl.high + hdev->dv_buf_size;
 		}
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 9571e22..6615b85 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -736,6 +736,9 @@ struct hclge_dev {
 	u32 flag;
 
 	u32 pkt_buf_size; /* Total pf buf size for tx/rx */
+	u32 tx_buf_size; /* Tx buffer size for each TC */
+	u32 dv_buf_size; /* Dv buffer size for each TC */
+
 	u32 mps; /* Max packet size */
 	/* vport_lock protect resource shared by vports */
 	struct mutex vport_lock;
-- 
1.9.1

