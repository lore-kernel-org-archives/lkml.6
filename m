Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAAAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0612075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0612075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJKC3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727447AbeJKC3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3427508A9CF;
        Thu, 11 Oct 2018 03:06:22 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 03:06:14 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 3/4] net: hns3: Add RSS tuples support for VF
Date:   Wed, 10 Oct 2018 20:05:36 +0100
Message-ID: <20181010190537.20972-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181010190537.20972-1-salil.mehta@huawei.com>
References: <20181010190537.20972-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds RSS tuple support for VF in revision
0x21.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   |   5 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 211 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  19 ++
 4 files changed, 234 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index cbf9a65..f1354f6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1078,6 +1078,7 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_ethtool_stats = hns3_get_stats,
 	.get_sset_count = hns3_get_sset_count,
 	.get_rxnfc = hns3_get_rxnfc,
+	.set_rxnfc = hns3_set_rxnfc,
 	.get_rxfh_key_size = hns3_get_rss_key_size,
 	.get_rxfh_indir_size = hns3_get_rss_indir_size,
 	.get_rxfh = hns3_get_rss,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
index eb8ed11..bc294b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h
@@ -89,6 +89,7 @@ enum hclgevf_opcode_type {
 	HCLGEVF_OPC_CFG_COM_TQP_QUEUE	= 0x0B20,
 	/* RSS cmd */
 	HCLGEVF_OPC_RSS_GENERIC_CONFIG	= 0x0D01,
+	HCLGEVF_OPC_RSS_INPUT_TUPLE     = 0x0D02,
 	HCLGEVF_OPC_RSS_INDIR_TABLE	= 0x0D07,
 	HCLGEVF_OPC_RSS_TC_MODE		= 0x0D08,
 	/* Mailbox cmd */
@@ -160,11 +161,11 @@ struct hclgevf_rss_config_cmd {
 struct hclgevf_rss_input_tuple_cmd {
 	u8 ipv4_tcp_en;
 	u8 ipv4_udp_en;
-	u8 ipv4_stcp_en;
+	u8 ipv4_sctp_en;
 	u8 ipv4_fragment_en;
 	u8 ipv6_tcp_en;
 	u8 ipv6_udp_en;
-	u8 ipv6_stcp_en;
+	u8 ipv6_sctp_en;
 	u8 ipv6_fragment_en;
 	u8 rsv[16];
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index f21196b..ac67fec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -587,6 +587,193 @@ static int hclgevf_set_rss(struct hnae3_handle *handle, const u32 *indir,
 	return hclgevf_set_rss_indir_table(hdev);
 }
 
+static u8 hclgevf_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
+{
+	u8 hash_sets = nfc->data & RXH_L4_B_0_1 ? HCLGEVF_S_PORT_BIT : 0;
+
+	if (nfc->data & RXH_L4_B_2_3)
+		hash_sets |= HCLGEVF_D_PORT_BIT;
+	else
+		hash_sets &= ~HCLGEVF_D_PORT_BIT;
+
+	if (nfc->data & RXH_IP_SRC)
+		hash_sets |= HCLGEVF_S_IP_BIT;
+	else
+		hash_sets &= ~HCLGEVF_S_IP_BIT;
+
+	if (nfc->data & RXH_IP_DST)
+		hash_sets |= HCLGEVF_D_IP_BIT;
+	else
+		hash_sets &= ~HCLGEVF_D_IP_BIT;
+
+	if (nfc->flow_type == SCTP_V4_FLOW || nfc->flow_type == SCTP_V6_FLOW)
+		hash_sets |= HCLGEVF_V_TAG_BIT;
+
+	return hash_sets;
+}
+
+static int hclgevf_set_rss_tuple(struct hnae3_handle *handle,
+				 struct ethtool_rxnfc *nfc)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
+	struct hclgevf_rss_input_tuple_cmd *req;
+	struct hclgevf_desc desc;
+	u8 tuple_sets;
+	int ret;
+
+	if (handle->pdev->revision == 0x20)
+		return -EOPNOTSUPP;
+
+	if (nfc->data &
+	    ~(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3))
+		return -EINVAL;
+
+	req = (struct hclgevf_rss_input_tuple_cmd *)desc.data;
+	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_RSS_INPUT_TUPLE, false);
+
+	req->ipv4_tcp_en = rss_cfg->rss_tuple_sets.ipv4_tcp_en;
+	req->ipv4_udp_en = rss_cfg->rss_tuple_sets.ipv4_udp_en;
+	req->ipv4_sctp_en = rss_cfg->rss_tuple_sets.ipv4_sctp_en;
+	req->ipv4_fragment_en = rss_cfg->rss_tuple_sets.ipv4_fragment_en;
+	req->ipv6_tcp_en = rss_cfg->rss_tuple_sets.ipv6_tcp_en;
+	req->ipv6_udp_en = rss_cfg->rss_tuple_sets.ipv6_udp_en;
+	req->ipv6_sctp_en = rss_cfg->rss_tuple_sets.ipv6_sctp_en;
+	req->ipv6_fragment_en = rss_cfg->rss_tuple_sets.ipv6_fragment_en;
+
+	tuple_sets = hclgevf_get_rss_hash_bits(nfc);
+	switch (nfc->flow_type) {
+	case TCP_V4_FLOW:
+		req->ipv4_tcp_en = tuple_sets;
+		break;
+	case TCP_V6_FLOW:
+		req->ipv6_tcp_en = tuple_sets;
+		break;
+	case UDP_V4_FLOW:
+		req->ipv4_udp_en = tuple_sets;
+		break;
+	case UDP_V6_FLOW:
+		req->ipv6_udp_en = tuple_sets;
+		break;
+	case SCTP_V4_FLOW:
+		req->ipv4_sctp_en = tuple_sets;
+		break;
+	case SCTP_V6_FLOW:
+		if ((nfc->data & RXH_L4_B_0_1) ||
+		    (nfc->data & RXH_L4_B_2_3))
+			return -EINVAL;
+
+		req->ipv6_sctp_en = tuple_sets;
+		break;
+	case IPV4_FLOW:
+		req->ipv4_fragment_en = HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		break;
+	case IPV6_FLOW:
+		req->ipv6_fragment_en = HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = hclgevf_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"Set rss tuple fail, status = %d\n", ret);
+		return ret;
+	}
+
+	rss_cfg->rss_tuple_sets.ipv4_tcp_en = req->ipv4_tcp_en;
+	rss_cfg->rss_tuple_sets.ipv4_udp_en = req->ipv4_udp_en;
+	rss_cfg->rss_tuple_sets.ipv4_sctp_en = req->ipv4_sctp_en;
+	rss_cfg->rss_tuple_sets.ipv4_fragment_en = req->ipv4_fragment_en;
+	rss_cfg->rss_tuple_sets.ipv6_tcp_en = req->ipv6_tcp_en;
+	rss_cfg->rss_tuple_sets.ipv6_udp_en = req->ipv6_udp_en;
+	rss_cfg->rss_tuple_sets.ipv6_sctp_en = req->ipv6_sctp_en;
+	rss_cfg->rss_tuple_sets.ipv6_fragment_en = req->ipv6_fragment_en;
+	return 0;
+}
+
+static int hclgevf_get_rss_tuple(struct hnae3_handle *handle,
+				 struct ethtool_rxnfc *nfc)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
+	u8 tuple_sets;
+
+	if (handle->pdev->revision == 0x20)
+		return -EOPNOTSUPP;
+
+	nfc->data = 0;
+
+	switch (nfc->flow_type) {
+	case TCP_V4_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv4_tcp_en;
+		break;
+	case UDP_V4_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv4_udp_en;
+		break;
+	case TCP_V6_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv6_tcp_en;
+		break;
+	case UDP_V6_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv6_udp_en;
+		break;
+	case SCTP_V4_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv4_sctp_en;
+		break;
+	case SCTP_V6_FLOW:
+		tuple_sets = rss_cfg->rss_tuple_sets.ipv6_sctp_en;
+		break;
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		tuple_sets = HCLGEVF_S_IP_BIT | HCLGEVF_D_IP_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!tuple_sets)
+		return 0;
+
+	if (tuple_sets & HCLGEVF_D_PORT_BIT)
+		nfc->data |= RXH_L4_B_2_3;
+	if (tuple_sets & HCLGEVF_S_PORT_BIT)
+		nfc->data |= RXH_L4_B_0_1;
+	if (tuple_sets & HCLGEVF_D_IP_BIT)
+		nfc->data |= RXH_IP_DST;
+	if (tuple_sets & HCLGEVF_S_IP_BIT)
+		nfc->data |= RXH_IP_SRC;
+
+	return 0;
+}
+
+static int hclgevf_set_rss_input_tuple(struct hclgevf_dev *hdev,
+				       struct hclgevf_rss_cfg *rss_cfg)
+{
+	struct hclgevf_rss_input_tuple_cmd *req;
+	struct hclgevf_desc desc;
+	int ret;
+
+	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_RSS_INPUT_TUPLE, false);
+
+	req = (struct hclgevf_rss_input_tuple_cmd *)desc.data;
+
+	req->ipv4_tcp_en = rss_cfg->rss_tuple_sets.ipv4_tcp_en;
+	req->ipv4_udp_en = rss_cfg->rss_tuple_sets.ipv4_udp_en;
+	req->ipv4_sctp_en = rss_cfg->rss_tuple_sets.ipv4_sctp_en;
+	req->ipv4_fragment_en = rss_cfg->rss_tuple_sets.ipv4_fragment_en;
+	req->ipv6_tcp_en = rss_cfg->rss_tuple_sets.ipv6_tcp_en;
+	req->ipv6_udp_en = rss_cfg->rss_tuple_sets.ipv6_udp_en;
+	req->ipv6_sctp_en = rss_cfg->rss_tuple_sets.ipv6_sctp_en;
+	req->ipv6_fragment_en = rss_cfg->rss_tuple_sets.ipv6_fragment_en;
+
+	ret = hclgevf_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"Configure rss input fail, status = %d\n", ret);
+	return ret;
+}
+
 static int hclgevf_get_tc_size(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
@@ -1327,6 +1514,28 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 					       rss_cfg->rss_hash_key);
 		if (ret)
 			return ret;
+
+		rss_cfg->rss_tuple_sets.ipv4_tcp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		rss_cfg->rss_tuple_sets.ipv4_udp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		rss_cfg->rss_tuple_sets.ipv4_sctp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_SCTP;
+		rss_cfg->rss_tuple_sets.ipv4_fragment_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		rss_cfg->rss_tuple_sets.ipv6_tcp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		rss_cfg->rss_tuple_sets.ipv6_udp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+		rss_cfg->rss_tuple_sets.ipv6_sctp_en =
+					HCLGEVF_RSS_INPUT_TUPLE_SCTP;
+		rss_cfg->rss_tuple_sets.ipv6_fragment_en =
+					HCLGEVF_RSS_INPUT_TUPLE_OTHER;
+
+		ret = hclgevf_set_rss_input_tuple(hdev, rss_cfg);
+		if (ret)
+			return ret;
+
 	}
 
 	/* Initialize RSS indirect table for each vport */
@@ -1971,6 +2180,8 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.get_rss_indir_size = hclgevf_get_rss_indir_size,
 	.get_rss = hclgevf_get_rss,
 	.set_rss = hclgevf_set_rss,
+	.get_rss_tuple = hclgevf_get_rss_tuple,
+	.set_rss_tuple = hclgevf_set_rss_tuple,
 	.get_tc_size = hclgevf_get_tc_size,
 	.get_fw_version = hclgevf_get_fw_version,
 	.set_vlan_filter = hclgevf_set_vlan_filter,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index cf5fbf7..aed241e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -46,6 +46,13 @@
 #define HCLGEVF_RSS_HASH_ALGO_MASK	0xf
 #define HCLGEVF_RSS_CFG_TBL_NUM \
 	(HCLGEVF_RSS_IND_TBL_SIZE / HCLGEVF_RSS_CFG_TBL_SIZE)
+#define HCLGEVF_RSS_INPUT_TUPLE_OTHER	GENMASK(3, 0)
+#define HCLGEVF_RSS_INPUT_TUPLE_SCTP	GENMASK(4, 0)
+#define HCLGEVF_D_PORT_BIT		BIT(0)
+#define HCLGEVF_S_PORT_BIT		BIT(1)
+#define HCLGEVF_D_IP_BIT		BIT(2)
+#define HCLGEVF_S_IP_BIT		BIT(3)
+#define HCLGEVF_V_TAG_BIT		BIT(4)
 
 /* states of hclgevf device & tasks */
 enum hclgevf_states {
@@ -106,12 +113,24 @@ struct hclgevf_cfg {
 	u32 numa_node_map;
 };
 
+struct hclgevf_rss_tuple_cfg {
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
 struct hclgevf_rss_cfg {
 	u8  rss_hash_key[HCLGEVF_RSS_KEY_SIZE]; /* user configured hash keys */
 	u32 hash_algo;
 	u32 rss_size;
 	u8 hw_tc_map;
 	u8  rss_indirection_tbl[HCLGEVF_RSS_IND_TBL_SIZE]; /* shadow table */
+	struct hclgevf_rss_tuple_cfg rss_tuple_sets;
 };
 
 struct hclgevf_misc_vector {
-- 
2.7.4


