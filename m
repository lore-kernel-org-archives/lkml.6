Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3B2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB3B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeICOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:42:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbeICOmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:42:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B9E852574C767;
        Mon,  3 Sep 2018 18:23:09 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:23:03 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 05/11] net: hns3: Fix for loopback selftest failed problem
Date:   Mon, 3 Sep 2018 11:21:50 +0100
Message-ID: <20180903102156.18676-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180903102156.18676-1-salil.mehta@huawei.com>
References: <20180903102156.18676-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Tqp and mac need to be enabled when doing loopback selftest,
ae_algo->ops->start/stop is used to do the job, there is a
time window between ae_algo->ops->start/stop and loopback setup,
which will cause selftest failed problem when there is frame
coming in during that time window.

This patch fixes it by enabling the tqp and mac during loopback
setup process.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 17 +-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 51 +++++++++++++---------
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index f70ee69..14797b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -100,41 +100,26 @@ static int hns3_lp_up(struct net_device *ndev, enum hnae3_loop loop_mode)
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 	int ret;
 
-	if (!h->ae_algo->ops->start)
-		return -EOPNOTSUPP;
-
 	ret = hns3_nic_reset_all_ring(h);
 	if (ret)
 		return ret;
 
-	ret = h->ae_algo->ops->start(h);
-	if (ret) {
-		netdev_err(ndev,
-			   "hns3_lb_up ae start return error: %d\n", ret);
-		return ret;
-	}
-
 	ret = hns3_lp_setup(ndev, loop_mode, true);
 	usleep_range(10000, 20000);
 
-	return ret;
+	return 0;
 }
 
 static int hns3_lp_down(struct net_device *ndev, enum hnae3_loop loop_mode)
 {
-	struct hnae3_handle *h = hns3_get_handle(ndev);
 	int ret;
 
-	if (!h->ae_algo->ops->stop)
-		return -EOPNOTSUPP;
-
 	ret = hns3_lp_setup(ndev, loop_mode, false);
 	if (ret) {
 		netdev_err(ndev, "lb_setup return error: %d\n", ret);
 		return ret;
 	}
 
-	h->ae_algo->ops->stop(h);
 	usleep_range(10000, 20000);
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3cf8b80..4c7442e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3659,6 +3659,8 @@ static int hclge_set_mac_loopback(struct hclge_dev *hdev, bool en)
 	/* 2 Then setup the loopback flag */
 	loop_en = le32_to_cpu(req->txrx_pad_fcs_loop_en);
 	hnae3_set_bit(loop_en, HCLGE_MAC_APP_LP_B, en ? 1 : 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_TX_EN_B, en ? 1 : 0);
+	hnae3_set_bit(loop_en, HCLGE_MAC_RX_EN_B, en ? 1 : 0);
 
 	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
@@ -3719,15 +3721,36 @@ static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en)
 		return -EIO;
 	}
 
+	hclge_cfg_mac_mode(hdev, en);
 	return 0;
 }
 
+static int hclge_tqp_enable(struct hclge_dev *hdev, int tqp_id,
+			    int stream_id, bool enable)
+{
+	struct hclge_desc desc;
+	struct hclge_cfg_com_tqp_queue_cmd *req =
+		(struct hclge_cfg_com_tqp_queue_cmd *)desc.data;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_COM_TQP_QUEUE, false);
+	req->tqp_id = cpu_to_le16(tqp_id & HCLGE_RING_ID_MASK);
+	req->stream_id = cpu_to_le16(stream_id);
+	req->enable |= enable << HCLGE_TQP_ENABLE_B;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"Tqp enable fail, status =%d.\n", ret);
+	return ret;
+}
+
 static int hclge_set_loopback(struct hnae3_handle *handle,
 			      enum hnae3_loop loop_mode, bool en)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int ret;
+	int i, ret;
 
 	switch (loop_mode) {
 	case HNAE3_MAC_INTER_LOOP_MAC:
@@ -3743,27 +3766,13 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 		break;
 	}
 
-	return ret;
-}
-
-static int hclge_tqp_enable(struct hclge_dev *hdev, int tqp_id,
-			    int stream_id, bool enable)
-{
-	struct hclge_desc desc;
-	struct hclge_cfg_com_tqp_queue_cmd *req =
-		(struct hclge_cfg_com_tqp_queue_cmd *)desc.data;
-	int ret;
-
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_COM_TQP_QUEUE, false);
-	req->tqp_id = cpu_to_le16(tqp_id & HCLGE_RING_ID_MASK);
-	req->stream_id = cpu_to_le16(stream_id);
-	req->enable |= enable << HCLGE_TQP_ENABLE_B;
+	for (i = 0; i < vport->alloc_tqps; i++) {
+		ret = hclge_tqp_enable(hdev, i, 0, en);
+		if (ret)
+			return ret;
+	}
 
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret)
-		dev_err(&hdev->pdev->dev,
-			"Tqp enable fail, status =%d.\n", ret);
-	return ret;
+	return 0;
 }
 
 static void hclge_reset_tqp_stats(struct hnae3_handle *handle)
-- 
2.7.4


