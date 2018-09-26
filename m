Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E32C21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E32C21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeI0AoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:44:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbeI0AoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:44:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90338323B27A;
        Thu, 27 Sep 2018 02:29:43 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 02:29:34 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 05/10] net: hns3: Add serdes parallel inner loopback support
Date:   Wed, 26 Sep 2018 19:28:35 +0100
Message-ID: <20180926182840.28392-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180926182840.28392-1-salil.mehta@huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

This patch adds serdes parallel inner loopback support for self test.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  6 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 16 +++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 54 ++++++++++++++++------
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 27155ea..8581e16 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -85,7 +85,8 @@ struct hnae3_queue {
 /*hnae3 loop mode*/
 enum hnae3_loop {
 	HNAE3_LOOP_APP,
-	HNAE3_LOOP_SERDES,
+	HNAE3_LOOP_SERIAL_SERDES,
+	HNAE3_LOOP_PARALLEL_SERDES,
 	HNAE3_LOOP_PHY,
 	HNAE3_LOOP_NONE,
 };
@@ -480,8 +481,9 @@ struct hnae3_unic_private_info {
 
 #define HNAE3_SUPPORT_APP_LOOPBACK    BIT(0)
 #define HNAE3_SUPPORT_PHY_LOOPBACK    BIT(1)
-#define HNAE3_SUPPORT_SERDES_LOOPBACK BIT(2)
+#define HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK	BIT(2)
 #define HNAE3_SUPPORT_VF	      BIT(3)
+#define HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK	BIT(4)
 
 struct hnae3_handle {
 	struct hnae3_client *client;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 75ebd2e..e959b7b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -53,7 +53,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 
 #define HNS3_TQP_STATS_COUNT (HNS3_TXQ_STATS_COUNT + HNS3_RXQ_STATS_COUNT)
 
-#define HNS3_SELF_TEST_TYPE_NUM		2
+#define HNS3_SELF_TEST_TPYE_NUM         3
 #define HNS3_NIC_LB_TEST_PKT_NUM	1
 #define HNS3_NIC_LB_TEST_RING_ID	0
 #define HNS3_NIC_LB_TEST_PACKET_SIZE	128
@@ -78,7 +78,8 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 		return -EOPNOTSUPP;
 
 	switch (loop) {
-	case HNAE3_LOOP_SERDES:
+	case HNAE3_LOOP_SERIAL_SERDES:
+	case HNAE3_LOOP_PARALLEL_SERDES:
 	case HNAE3_LOOP_APP:
 		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
@@ -290,9 +291,14 @@ static void hns3_self_test(struct net_device *ndev,
 	st_param[HNAE3_LOOP_APP][1] =
 			h->flags & HNAE3_SUPPORT_APP_LOOPBACK;
 
-	st_param[HNAE3_LOOP_SERDES][0] = HNAE3_LOOP_SERDES;
-	st_param[HNAE3_LOOP_SERDES][1] =
-			h->flags & HNAE3_SUPPORT_SERDES_LOOPBACK;
+	st_param[HNAE3_LOOP_SERIAL_SERDES][0] = HNAE3_LOOP_SERIAL_SERDES;
+	st_param[HNAE3_LOOP_SERIAL_SERDES][1] =
+			h->flags & HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK;
+
+	st_param[HNAE3_LOOP_PARALLEL_SERDES][0] =
+			HNAE3_LOOP_PARALLEL_SERDES;
+	st_param[HNAE3_LOOP_PARALLEL_SERDES][1] =
+			h->flags & HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK;
 
 	if (if_running)
 		ndev->netdev_ops->ndo_stop(ndev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 821d4c2..842dc3f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -778,6 +778,7 @@ struct hclge_reset_cmd {
 };
 
 #define HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B	BIT(0)
+#define HCLGE_CMD_SERDES_PARALLEL_INNER_LOOP_B	BIT(2)
 #define HCLGE_CMD_SERDES_DONE_B			BIT(0)
 #define HCLGE_CMD_SERDES_SUCCESS_B		BIT(1)
 struct hclge_serdes_lb_cmd {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a0f6329..72bc8c3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -50,7 +50,8 @@ MODULE_DEVICE_TABLE(pci, ae_algo_pci_tbl);
 
 static const char hns3_nic_test_strs[][ETH_GSTRING_LEN] = {
 	"App    Loopback test",
-	"Serdes Loopback test",
+	"Serdes serial Loopback test",
+	"Serdes parallel Loopback test",
 	"Phy    Loopback test"
 };
 
@@ -475,7 +476,10 @@ static void hclge_update_stats(struct hnae3_handle *handle,
 
 static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 {
-#define HCLGE_LOOPBACK_TEST_FLAGS 0x7
+#define HCLGE_LOOPBACK_TEST_FLAGS (HNAE3_SUPPORT_APP_LOOPBACK |\
+		HNAE3_SUPPORT_PHY_LOOPBACK |\
+		HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK |\
+		HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK)
 
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
@@ -489,15 +493,17 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 	if (stringset == ETH_SS_TEST) {
 		/* clear loopback bit flags at first */
 		handle->flags = (handle->flags & (~HCLGE_LOOPBACK_TEST_FLAGS));
-		if (hdev->hw.mac.speed == HCLGE_MAC_SPEED_10M ||
+		if (hdev->pdev->revision >= HNAE3_REVISION_ID_21 ||
+		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_10M ||
 		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_100M ||
 		    hdev->hw.mac.speed == HCLGE_MAC_SPEED_1G) {
 			count += 1;
 			handle->flags |= HNAE3_SUPPORT_APP_LOOPBACK;
 		}
 
-		count++;
-		handle->flags |= HNAE3_SUPPORT_SERDES_LOOPBACK;
+		count += 2;
+		handle->flags |= HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK;
+		handle->flags |= HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK;
 	} else if (stringset == ETH_SS_STATS) {
 		count = ARRAY_SIZE(g_mac_stats_string) +
 			hclge_tqps_get_sset_count(handle, stringset);
@@ -527,9 +533,15 @@ static void hclge_get_strings(struct hnae3_handle *handle,
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
-		if (handle->flags & HNAE3_SUPPORT_SERDES_LOOPBACK) {
+		if (handle->flags & HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK) {
 			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_LOOP_SERDES],
+			       hns3_nic_test_strs[HNAE3_LOOP_SERIAL_SERDES],
+			       ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
+		if (handle->flags & HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK) {
+			memcpy(p,
+			       hns3_nic_test_strs[HNAE3_LOOP_PARALLEL_SERDES],
 			       ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
@@ -3381,22 +3393,37 @@ static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
-static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en)
+static int hclge_set_serdes_loopback(struct hclge_dev *hdev, bool en,
+				     enum hnae3_loop loop_mode)
 {
 #define HCLGE_SERDES_RETRY_MS	10
 #define HCLGE_SERDES_RETRY_NUM	100
 	struct hclge_serdes_lb_cmd *req;
 	struct hclge_desc desc;
 	int ret, i = 0;
+	u8 loop_mode_b;
 
 	req = (struct hclge_serdes_lb_cmd *)desc.data;
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SERDES_LOOPBACK, false);
 
+	switch (loop_mode) {
+	case HNAE3_LOOP_SERIAL_SERDES:
+		loop_mode_b = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+		break;
+	case HNAE3_LOOP_PARALLEL_SERDES:
+		loop_mode_b = HCLGE_CMD_SERDES_PARALLEL_INNER_LOOP_B;
+		break;
+	default:
+		dev_err(&hdev->pdev->dev,
+			"unsupported serdes loopback mode %d\n", loop_mode);
+		return -ENOTSUPP;
+	}
+
 	if (en) {
-		req->enable = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
-		req->mask = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+		req->enable = loop_mode_b;
+		req->mask = loop_mode_b;
 	} else {
-		req->mask = HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+		req->mask = loop_mode_b;
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -3462,8 +3489,9 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	case HNAE3_LOOP_APP:
 		ret = hclge_set_app_loopback(hdev, en);
 		break;
-	case HNAE3_LOOP_SERDES:
-		ret = hclge_set_serdes_loopback(hdev, en);
+	case HNAE3_LOOP_SERIAL_SERDES:
+	case HNAE3_LOOP_PARALLEL_SERDES:
+		ret = hclge_set_serdes_loopback(hdev, en, loop_mode);
 		break;
 	default:
 		ret = -ENOTSUPP;
-- 
2.7.4


