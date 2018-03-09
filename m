Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCICGG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:06:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38062 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751026AbeCICFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:05 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 2/9] net: hns3: refactor the hclge_get/set_rss_tuple function
Date: Fri, 9 Mar 2018 10:36:57 +0800
Message-ID: <1520563024-94811-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
References: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch refactors the hclge_get/set_rss_tuple function
in order to fix the rss configuration loss problem during
reset process.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 91 +++++++++++++---------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    | 13 ++++
 2 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cd5b040..747cc8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3091,14 +3091,16 @@ static int hclge_set_rss_input_tuple(struct hclge_dev *hdev)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RSS_INPUT_TUPLE, false);
 
 	req = (struct hclge_rss_input_tuple_cmd *)desc.data;
-	req->ipv4_tcp_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
-	req->ipv4_udp_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
-	req->ipv4_sctp_en = HCLGE_RSS_INPUT_TUPLE_SCTP;
-	req->ipv4_fragment_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
-	req->ipv6_tcp_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
-	req->ipv6_udp_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
-	req->ipv6_sctp_en = HCLGE_RSS_INPUT_TUPLE_SCTP;
-	req->ipv6_fragment_en = HCLGE_RSS_INPUT_TUPLE_OTHER;
+
+	/* Get the tuple cfg from pf */
+	req->ipv4_tcp_en = hdev->vport[0].rss_tuple_sets.ipv4_tcp_en;
+	req->ipv4_udp_en = hdev->vport[0].rss_tuple_sets.ipv4_udp_en;
+	req->ipv4_sctp_en = hdev->vport[0].rss_tuple_sets.ipv4_sctp_en;
+	req->ipv4_fragment_en = hdev->vport[0].rss_tuple_sets.ipv4_fragment_en;
+	req->ipv6_tcp_en = hdev->vport[0].rss_tuple_sets.ipv6_tcp_en;
+	req->ipv6_udp_en = hdev->vport[0].rss_tuple_sets.ipv6_udp_en;
+	req->ipv6_sctp_en = hdev->vport[0].rss_tuple_sets.ipv6_sctp_en;
+	req->ipv6_fragment_en = hdev->vport[0].rss_tuple_sets.ipv6_fragment_en;
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
@@ -3204,15 +3206,16 @@ static int hclge_set_rss_tuple(struct hnae3_handle *handle,
 		return -EINVAL;
 
 	req = (struct hclge_rss_input_tuple_cmd *)desc.data;
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RSS_INPUT_TUPLE, true);
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"Read rss tuple fail, status = %d\n", ret);
-		return ret;
-	}
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RSS_INPUT_TUPLE, false);
 
-	hclge_cmd_reuse_desc(&desc, false);
+	req->ipv4_tcp_en = vport->rss_tuple_sets.ipv4_tcp_en;
+	req->ipv4_udp_en = vport->rss_tuple_sets.ipv4_udp_en;
+	req->ipv4_sctp_en = vport->rss_tuple_sets.ipv4_sctp_en;
+	req->ipv4_fragment_en = vport->rss_tuple_sets.ipv4_fragment_en;
+	req->ipv6_tcp_en = vport->rss_tuple_sets.ipv6_tcp_en;
+	req->ipv6_udp_en = vport->rss_tuple_sets.ipv6_udp_en;
+	req->ipv6_sctp_en = vport->rss_tuple_sets.ipv6_sctp_en;
+	req->ipv6_fragment_en = vport->rss_tuple_sets.ipv6_fragment_en;
 
 	tuple_sets = hclge_get_rss_hash_bits(nfc);
 	switch (nfc->flow_type) {
@@ -3249,52 +3252,49 @@ static int hclge_set_rss_tuple(struct hnae3_handle *handle,
 	}
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Set rss tuple fail, status = %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	vport->rss_tuple_sets.ipv4_tcp_en = req->ipv4_tcp_en;
+	vport->rss_tuple_sets.ipv4_udp_en = req->ipv4_udp_en;
+	vport->rss_tuple_sets.ipv4_sctp_en = req->ipv4_sctp_en;
+	vport->rss_tuple_sets.ipv4_fragment_en = req->ipv4_fragment_en;
+	vport->rss_tuple_sets.ipv6_tcp_en = req->ipv6_tcp_en;
+	vport->rss_tuple_sets.ipv6_udp_en = req->ipv6_udp_en;
+	vport->rss_tuple_sets.ipv6_sctp_en = req->ipv6_sctp_en;
+	vport->rss_tuple_sets.ipv6_fragment_en = req->ipv6_fragment_en;
+	return 0;
 }
 
 static int hclge_get_rss_tuple(struct hnae3_handle *handle,
 			       struct ethtool_rxnfc *nfc)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-	struct hclge_rss_input_tuple_cmd *req;
-	struct hclge_desc desc;
 	u8 tuple_sets;
-	int ret;
 
 	nfc->data = 0;
 
-	req = (struct hclge_rss_input_tuple_cmd *)desc.data;
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RSS_INPUT_TUPLE, true);
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"Read rss tuple fail, status = %d\n", ret);
-		return ret;
-	}
-
 	switch (nfc->flow_type) {
 	case TCP_V4_FLOW:
-		tuple_sets = req->ipv4_tcp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv4_tcp_en;
 		break;
 	case UDP_V4_FLOW:
-		tuple_sets = req->ipv4_udp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv4_udp_en;
 		break;
 	case TCP_V6_FLOW:
-		tuple_sets = req->ipv6_tcp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv6_tcp_en;
 		break;
 	case UDP_V6_FLOW:
-		tuple_sets = req->ipv6_udp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv6_udp_en;
 		break;
 	case SCTP_V4_FLOW:
-		tuple_sets = req->ipv4_sctp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv4_sctp_en;
 		break;
 	case SCTP_V6_FLOW:
-		tuple_sets = req->ipv6_sctp_en;
+		tuple_sets = vport->rss_tuple_sets.ipv6_sctp_en;
 		break;
 	case IPV4_FLOW:
 	case IPV6_FLOW:
@@ -3349,6 +3349,23 @@ int hclge_rss_init_hw(struct hclge_dev *hdev)
 
 	/* Initialize RSS indirect table for each vport */
 	for (j = 0; j < hdev->num_vmdq_vport + 1; j++) {
+		vport[j].rss_tuple_sets.ipv4_tcp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[j].rss_tuple_sets.ipv4_udp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[j].rss_tuple_sets.ipv4_sctp_en =
+			HCLGE_RSS_INPUT_TUPLE_SCTP;
+		vport[j].rss_tuple_sets.ipv4_fragment_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[j].rss_tuple_sets.ipv6_tcp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[j].rss_tuple_sets.ipv6_udp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[j].rss_tuple_sets.ipv6_sctp_en =
+			HCLGE_RSS_INPUT_TUPLE_SCTP;
+		vport[j].rss_tuple_sets.ipv6_fragment_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+
 		for (i = 0; i < HCLGE_RSS_IND_TBL_SIZE; i++) {
 			vport[j].rss_indirection_tbl[i] =
 				i % vport[j].alloc_rss_size;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7e762c4..13d3999 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -573,6 +573,17 @@ struct hclge_rx_vtag_cfg {
 	bool vlan2_vlan_prionly;/* Outer VLAN Tag up to descriptor Enable */
 };
 
+struct hclge_rss_tuple_cfg {
+	u8 ipv4_tcp_en;
+	u8 ipv4_udp_en;
+	u8 ipv4_sctp_en;
+	u8 ipv4_fragment_en;
+	u8 ipv6_tcp_en;
+	u8 ipv6_udp_en;
+	u8 ipv6_sctp_en;
+	u8 ipv6_fragment_en;
+};
+
 struct hclge_vport {
 	u16 alloc_tqps;	/* Allocated Tx/Rx queues */
 
@@ -580,6 +591,8 @@ struct hclge_vport {
 	/* User configured lookup table entries */
 	u8  rss_indirection_tbl[HCLGE_RSS_IND_TBL_SIZE];
 	int rss_algo;		/* User configured hash algorithm */
+	/* User configured rss tuple sets */
+	struct hclge_rss_tuple_cfg rss_tuple_sets;
 
 	u16 alloc_rss_size;
 
-- 
2.9.3
