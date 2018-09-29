Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1270C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B12073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B12073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeI2V1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:27:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728481AbeI2V1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:27:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F3071B65BB22;
        Sat, 29 Sep 2018 22:58:52 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.85.66) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 22:58:44 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH V2 net-next 06/10] net: hns3: Fix for packet buffer setting bug
Date:   Sat, 29 Sep 2018 15:56:18 +0100
Message-ID: <20180929145622.5448-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The hardware expects a unit of 128 bytes when setting
packet buffer. When calculating the packet buffer size,
hclge_rx_buffer_calc does not round up the size as a unit
of 128 byte, which may casue packet lost problem when stress
testing.

This patch fixes it by rounding up packet size when calculating.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fa14bb900b2d..e2dc45c9c950 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1356,11 +1356,13 @@ static int hclge_tx_buffer_calc(struct hclge_dev *hdev,
 static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 				struct hclge_pkt_buf_alloc *buf_alloc)
 {
-	u32 rx_all = hdev->pkt_buf_size;
+#define HCLGE_BUF_SIZE_UNIT	128
+	u32 rx_all = hdev->pkt_buf_size, aligned_mps;
 	int no_pfc_priv_num, pfc_priv_num;
 	struct hclge_priv_buf *priv;
 	int i;
 
+	aligned_mps = round_up(hdev->mps, HCLGE_BUF_SIZE_UNIT);
 	rx_all -= hclge_get_tx_buff_alloced(buf_alloc);
 
 	/* When DCB is not supported, rx private
@@ -1379,13 +1381,13 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 		if (hdev->hw_tc_map & BIT(i)) {
 			priv->enable = 1;
 			if (hdev->tm_info.hw_pfc_map & BIT(i)) {
-				priv->wl.low = hdev->mps;
-				priv->wl.high = priv->wl.low + hdev->mps;
+				priv->wl.low = aligned_mps;
+				priv->wl.high = priv->wl.low + aligned_mps;
 				priv->buf_size = priv->wl.high +
 						HCLGE_DEFAULT_DV;
 			} else {
 				priv->wl.low = 0;
-				priv->wl.high = 2 * hdev->mps;
+				priv->wl.high = 2 * aligned_mps;
 				priv->buf_size = priv->wl.high;
 			}
 		} else {
@@ -1417,11 +1419,11 @@ static int hclge_rx_buffer_calc(struct hclge_dev *hdev,
 
 		if (hdev->tm_info.hw_pfc_map & BIT(i)) {
 			priv->wl.low = 128;
-			priv->wl.high = priv->wl.low + hdev->mps;
+			priv->wl.high = priv->wl.low + aligned_mps;
 			priv->buf_size = priv->wl.high + HCLGE_DEFAULT_DV;
 		} else {
 			priv->wl.low = 0;
-			priv->wl.high = hdev->mps;
+			priv->wl.high = aligned_mps;
 			priv->buf_size = priv->wl.high;
 		}
 	}
-- 
2.11.0


