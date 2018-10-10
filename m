Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74714C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30626214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30626214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJKC34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:29:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727536AbeJKC34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:29:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE2AE99128540;
        Thu, 11 Oct 2018 03:06:22 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 03:06:17 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 4/4] net: hns3: Add HW RSS hash information to RX skb
Date:   Wed, 10 Oct 2018 20:05:37 +0100
Message-ID: <20181010190537.20972-5-salil.mehta@huawei.com>
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

From: Peng Li <lipeng321@huawei.com>

Drivers should call skb_set_hash to set the hash and its type
in an skbuff.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h            |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        | 17 +++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 1b49c5d..3df62a5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -479,6 +479,7 @@ struct hnae3_knic_private_info {
 	const struct hnae3_dcb_ops *dcb_ops;
 
 	u16 int_rl_setting;
+	enum pkt_hash_types rss_type;
 };
 
 struct hnae3_roce_private_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e9d4564..9bbb53c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2230,6 +2230,21 @@ static bool hns3_parse_vlan_tag(struct hns3_enet_ring *ring,
 	}
 }
 
+static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
+				     struct sk_buff *skb)
+{
+	struct hns3_desc *desc = &ring->desc[ring->next_to_clean];
+	struct hnae3_handle *handle = ring->tqp->handle;
+	enum pkt_hash_types rss_type;
+
+	if (le32_to_cpu(desc->rx.rss_hash))
+		rss_type = handle->kinfo.rss_type;
+	else
+		rss_type = PKT_HASH_TYPE_NONE;
+
+	skb_set_hash(skb, le32_to_cpu(desc->rx.rss_hash), rss_type);
+}
+
 static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 			     struct sk_buff **out_skb, int *out_bnum)
 {
@@ -2371,6 +2386,8 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	ring->tqp_vector->rx_group.total_bytes += skb->len;
 
 	hns3_rx_checksum(ring, skb, desc);
+	hns3_set_rx_skb_rss_type(ring, skb);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0c5a053..db97f6a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2773,6 +2773,22 @@ static int hclge_set_rss_tc_mode(struct hclge_dev *hdev, u16 *tc_valid,
 	return ret;
 }
 
+static void hclge_get_rss_type(struct hclge_vport *vport)
+{
+	if (vport->rss_tuple_sets.ipv4_tcp_en ||
+	    vport->rss_tuple_sets.ipv4_udp_en ||
+	    vport->rss_tuple_sets.ipv4_sctp_en ||
+	    vport->rss_tuple_sets.ipv6_tcp_en ||
+	    vport->rss_tuple_sets.ipv6_udp_en ||
+	    vport->rss_tuple_sets.ipv6_sctp_en)
+		vport->nic.kinfo.rss_type = PKT_HASH_TYPE_L4;
+	else if (vport->rss_tuple_sets.ipv4_fragment_en ||
+		 vport->rss_tuple_sets.ipv6_fragment_en)
+		vport->nic.kinfo.rss_type = PKT_HASH_TYPE_L3;
+	else
+		vport->nic.kinfo.rss_type = PKT_HASH_TYPE_NONE;
+}
+
 static int hclge_set_rss_input_tuple(struct hclge_dev *hdev)
 {
 	struct hclge_rss_input_tuple_cmd *req;
@@ -2792,6 +2808,7 @@ static int hclge_set_rss_input_tuple(struct hclge_dev *hdev)
 	req->ipv6_udp_en = hdev->vport[0].rss_tuple_sets.ipv6_udp_en;
 	req->ipv6_sctp_en = hdev->vport[0].rss_tuple_sets.ipv6_sctp_en;
 	req->ipv6_fragment_en = hdev->vport[0].rss_tuple_sets.ipv6_fragment_en;
+	hclge_get_rss_type(&hdev->vport[0]);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
 		dev_err(&hdev->pdev->dev,
@@ -2973,6 +2990,7 @@ static int hclge_set_rss_tuple(struct hnae3_handle *handle,
 	vport->rss_tuple_sets.ipv6_udp_en = req->ipv6_udp_en;
 	vport->rss_tuple_sets.ipv6_sctp_en = req->ipv6_sctp_en;
 	vport->rss_tuple_sets.ipv6_fragment_en = req->ipv6_fragment_en;
+	hclge_get_rss_type(vport);
 	return 0;
 }
 
-- 
2.7.4


