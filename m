Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120BC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711592087F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711592087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeHLM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727736AbeHLM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:00 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6AD562A85657A;
        Sun, 12 Aug 2018 17:48:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:23 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: Add support for serdes loopback selftest
Date:   Sun, 12 Aug 2018 10:47:30 +0100
Message-ID: <20180812094738.14852-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch adds support for serdes loopback selftest in hns3
driver.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  7 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 12 +++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 57 +++++++++++++++++++++-
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 80ba95d76260..f4710e498c59 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -53,7 +53,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 
 #define HNS3_TQP_STATS_COUNT (HNS3_TXQ_STATS_COUNT + HNS3_RXQ_STATS_COUNT)
 
-#define HNS3_SELF_TEST_TPYE_NUM		1
+#define HNS3_SELF_TEST_TPYE_NUM		2
 #define HNS3_NIC_LB_TEST_PKT_NUM	1
 #define HNS3_NIC_LB_TEST_RING_ID	0
 #define HNS3_NIC_LB_TEST_PACKET_SIZE	128
@@ -78,6 +78,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 		return -EOPNOTSUPP;
 
 	switch (loop) {
+	case HNAE3_MAC_INTER_LOOP_SERDES:
 	case HNAE3_MAC_INTER_LOOP_MAC:
 		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
@@ -303,6 +304,10 @@ static void hns3_self_test(struct net_device *ndev,
 	st_param[HNAE3_MAC_INTER_LOOP_MAC][1] =
 			h->flags & HNAE3_SUPPORT_MAC_LOOPBACK;
 
+	st_param[HNAE3_MAC_INTER_LOOP_SERDES][0] = HNAE3_MAC_INTER_LOOP_SERDES;
+	st_param[HNAE3_MAC_INTER_LOOP_SERDES][1] =
+			h->flags & HNAE3_SUPPORT_SERDES_LOOPBACK;
+
 	if (if_running)
 		dev_close(ndev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index cd0a4f228470..821d4c2f84bd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -94,6 +94,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QUERY_LINK_STATUS	= 0x0307,
 	HCLGE_OPC_CONFIG_MAX_FRM_SIZE	= 0x0308,
 	HCLGE_OPC_CONFIG_SPEED_DUP	= 0x0309,
+	HCLGE_OPC_SERDES_LOOPBACK       = 0x0315,
 
 	/* PFC/Pause commands */
 	HCLGE_OPC_CFG_MAC_PAUSE_EN      = 0x0701,
@@ -775,6 +776,17 @@ struct hclge_reset_cmd {
 	u8 fun_reset_vfid;
 	u8 rsv[22];
 };
+
+#define HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B	BIT(0)
+#define HCLGE_CMD_SERDES_DONE_B			BIT(0)
+#define HCLGE_CMD_SERDES_SUCCESS_B		BIT(1)
+struct hclge_serdes_lb_cmd {
+	u8 mask;
+	u8 enable;
+	u8 result;
+	u8 rsv[21];
+};
+
 #define HCLGE_DEFAULT_TX_BUF		0x4000	 /* 16k  bytes */
 #define HCLGE_TOTAL_PKT_BUF		0x108000 /* 1.03125M bytes */
 #define HCLGE_DEFAULT_DV		0xA000	 /* 40k byte */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fc813b7f20e8..99dda5051f5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -787,9 +787,10 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_1G) {
 			count += 1;
 			handle->flags |= HNAE3_SUPPORT_MAC_LOOPBACK;
-		} else {
-			count = -EOPNOTSUPP;
 		}
+
+		count ++;
+		handle->flags |= HNAE3_SUPPORT_SERDES_LOOPBACK;
 	} else if (stringset == ETH_SS_STATS) {
 		count = ARRAY_SIZE(g_mac_stats_string) +
 			ARRAY_SIZE(g_all_32bit_stats_string) +
@@ -3670,6 +3671,55 @@ static int hclge_set_mac_loopback(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en)
+{
+#define HCLGE_SERDES_RETRY_MS	10
+#define HCLGE_SERDES_RETRY_NUM	100
+	struct hclge_serdes_lb_cmd *req;
+	struct hclge_desc desc;
+	int ret, i = 0;
+
+	req = (struct hclge_serdes_lb_cmd *)&desc.data[0];
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SERDES_LOOPBACK, false);
+
+	if (en) {
+		req->enable = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+		req->mask = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+	} else {
+		req->mask = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+	}
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"serdes loopback set fail, ret = %d\n", ret);
+		return ret;
+	}
+
+	do {
+		msleep(HCLGE_SERDES_RETRY_MS);
+		hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SERDES_LOOPBACK,
+					   true);
+		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"serdes loopback get, ret = %d\n", ret);
+			return ret;
+		}
+	} while (++i < HCLGE_SERDES_RETRY_NUM  &&
+		 !(req->result & HCLGE_CMD_SERDES_DONE_B));
+
+	if (!(req->result & HCLGE_CMD_SERDES_DONE_B)) {
+		dev_err(&hdev->pdev->dev, "serdes loopback set timeout\n");
+		return -EBUSY;
+	} else if (!(req->result & HCLGE_CMD_SERDES_SUCCESS_B)) {
+		dev_err(&hdev->pdev->dev, "serdes loopback set failed in fw\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int hclge_set_loopback(struct hnae3_handle *handle,
 			      enum hnae3_loop loop_mode, bool en)
 {
@@ -3681,6 +3731,9 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	case HNAE3_MAC_INTER_LOOP_MAC:
 		ret = hclge_set_mac_loopback(hdev, en);
 		break;
+	case HNAE3_MAC_INTER_LOOP_SERDES:
+		ret = hclge_set_serdes_loopback(hdev, en);
+		break;
 	default:
 		ret = -ENOTSUPP;
 		dev_err(&hdev->pdev->dev,
-- 
2.11.0


