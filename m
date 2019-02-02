Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE2C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985F72085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfBBOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:41:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728076AbfBBOk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:57 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 983663E6630B19AF3977;
        Sat,  2 Feb 2019 22:40:55 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: code optimization for hclge_rx_buffer_calc
Date:   Sat, 2 Feb 2019 22:39:29 +0800
Message-ID: <20190202143937.8924-5-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190202143937.8924-1-tanhuazhong@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

There are four steps to calcuate the rx private buffer, each step
can be done in a function to avoid code duplication and aid code
readability.

This patch adds three separate functions do the job. Also, the
function name more or less make the comment redundant, so remove
some obvious comment.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 140 ++++++++----------
 1 file changed, 63 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9630bbce5932..be7d82502f5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1520,66 +1520,15 @@ static int hclge_tx_buffer_calc(struct hclge_dev *hdev,
 	return 0;
 }
 
-/* hclge_rx_buffer_calc: calculate the rx private buffer size for all TCs
- * @hdev: pointer to struct hclge_dev
- * @buf_alloc: pointer to buffer calculation data
- * @return: 0: calculate sucessful, negative: fail
- */
-static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
-				struct hclge_pkt_buf_alloc *buf_alloc)
+static bool hclge_rx_buf_calc_all(struct hclge_dev *hdev, bool max,
+				  struct hclge_pkt_buf_alloc *buf_alloc)
 {
-	u32 rx_all = hdev->pkt_buf_size, aligned_mps;
-	int no_pfc_priv_num, pfc_priv_num;
-	struct hclge_priv_buf *priv;
+	u32 rx_all = hdev->pkt_buf_size - hclge_get_tx_buff_alloced(buf_alloc);
+	u32 aligned_mps = round_up(hdev->mps, HCLGE_BUF_SIZE_UNIT);
 	int i;
 
-	aligned_mps = round_up(hdev->mps, HCLGE_BUF_SIZE_UNIT);
-	rx_all -= hclge_get_tx_buff_alloced(buf_alloc);
-
-	/* When DCB is not supported, rx private
-	 * buffer is not allocated.
-	 */
-	if (!hnae3_dev_dcb_supported(hdev)) {
-		if (!hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
-			return -ENOMEM;
-
-		return 0;
-	}
-
-	/* step 1, try to alloc private buffer for all enabled tc */
-	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
-		priv = &buf_alloc->priv_buf[i];
-		if (hdev->hw_tc_map & BIT(i)) {
-			priv->enable = 1;
-			if (hdev->tm_info.hw_pfc_map & BIT(i)) {
-				priv->wl.low = aligned_mps;
-				priv->wl.high =
-					roundup(priv->wl.low + aligned_mps,
-						HCLGE_BUF_SIZE_UNIT);
-				priv->buf_size = priv->wl.high +
-					hdev->dv_buf_size;
-			} else {
-				priv->wl.low = 0;
-				priv->wl.high = 2 * aligned_mps;
-				priv->buf_size = priv->wl.high +
-						hdev->dv_buf_size;
-			}
-		} else {
-			priv->enable = 0;
-			priv->wl.low = 0;
-			priv->wl.high = 0;
-			priv->buf_size = 0;
-		}
-	}
-
-	if (hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
-		return 0;
-
-	/* step 2, try to decrease the buffer size of
-	 * no pfc TC's private buffer
-	 */
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
-		priv = &buf_alloc->priv_buf[i];
+		struct hclge_priv_buf *priv = &buf_alloc->priv_buf[i];
 
 		priv->enable = 0;
 		priv->wl.low = 0;
@@ -1592,28 +1541,30 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		priv->enable = 1;
 
 		if (hdev->tm_info.hw_pfc_map & BIT(i)) {
-			priv->wl.low = 256;
-			priv->wl.high = priv->wl.low + aligned_mps;
-			priv->buf_size = priv->wl.high + hdev->dv_buf_size;
+			priv->wl.low = max ? aligned_mps : 256;
+			priv->wl.high = roundup(priv->wl.low + aligned_mps,
+						HCLGE_BUF_SIZE_UNIT);
 		} else {
 			priv->wl.low = 0;
-			priv->wl.high = aligned_mps;
-			priv->buf_size = priv->wl.high + hdev->dv_buf_size;
+			priv->wl.high = max ? (aligned_mps * 2) : aligned_mps;
 		}
+
+		priv->buf_size = priv->wl.high + hdev->dv_buf_size;
 	}
 
-	if (hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
-		return 0;
+	return hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all);
+}
 
-	/* step 3, try to reduce the number of pfc disabled TCs,
-	 * which have private buffer
-	 */
-	/* get the total no pfc enable TC number, which have private buffer */
-	no_pfc_priv_num = hclge_get_no_pfc_priv_num(hdev, buf_alloc);
+static bool hclge_drop_nopfc_buf_till_fit(struct hclge_dev *hdev,
+					  struct hclge_pkt_buf_alloc *buf_alloc)
+{
+	u32 rx_all = hdev->pkt_buf_size - hclge_get_tx_buff_alloced(buf_alloc);
+	int no_pfc_priv_num = hclge_get_no_pfc_priv_num(hdev, buf_alloc);
+	int i;
 
 	/* let the last to be cleared first */
 	for (i = HCLGE_MAX_TC_NUM - 1; i >= 0; i--) {
-		priv = &buf_alloc->priv_buf[i];
+		struct hclge_priv_buf *priv = &buf_alloc->priv_buf[i];
 
 		if (hdev->hw_tc_map & BIT(i) &&
 		    !(hdev->tm_info.hw_pfc_map & BIT(i))) {
@@ -1630,17 +1581,19 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 			break;
 	}
 
-	if (hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
-		return 0;
+	return hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all);
+}
 
-	/* step 4, try to reduce the number of pfc enabled TCs
-	 * which have private buffer.
-	 */
-	pfc_priv_num = hclge_get_pfc_priv_num(hdev, buf_alloc);
+static bool hclge_drop_pfc_buf_till_fit(struct hclge_dev *hdev,
+					struct hclge_pkt_buf_alloc *buf_alloc)
+{
+	u32 rx_all = hdev->pkt_buf_size - hclge_get_tx_buff_alloced(buf_alloc);
+	int pfc_priv_num = hclge_get_pfc_priv_num(hdev, buf_alloc);
+	int i;
 
 	/* let the last to be cleared first */
 	for (i = HCLGE_MAX_TC_NUM - 1; i >= 0; i--) {
-		priv = &buf_alloc->priv_buf[i];
+		struct hclge_priv_buf *priv = &buf_alloc->priv_buf[i];
 
 		if (hdev->hw_tc_map & BIT(i) &&
 		    hdev->tm_info.hw_pfc_map & BIT(i)) {
@@ -1656,7 +1609,40 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		    pfc_priv_num == 0)
 			break;
 	}
-	if (hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
+
+	return hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all);
+}
+
+/* hclge_rx_buffer_calc: calculate the rx private buffer size for all TCs
+ * @hdev: pointer to struct hclge_dev
+ * @buf_alloc: pointer to buffer calculation data
+ * @return: 0: calculate sucessful, negative: fail
+ */
+static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
+				struct hclge_pkt_buf_alloc *buf_alloc)
+{
+	/* When DCB is not supported, rx private buffer is not allocated. */
+	if (!hnae3_dev_dcb_supported(hdev)) {
+		u32 rx_all = hdev->pkt_buf_size;
+
+		rx_all -= hclge_get_tx_buff_alloced(buf_alloc);
+		if (!hclge_is_rx_buf_ok(hdev, buf_alloc, rx_all))
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	if (hclge_rx_buf_calc_all(hdev, true, buf_alloc))
+		return 0;
+
+	/* try to decrease the buffer size */
+	if (hclge_rx_buf_calc_all(hdev, false, buf_alloc))
+		return 0;
+
+	if (hclge_drop_nopfc_buf_till_fit(hdev, buf_alloc))
+		return 0;
+
+	if (hclge_drop_pfc_buf_till_fit(hdev, buf_alloc))
 		return 0;
 
 	return -ENOMEM;
-- 
2.20.1


