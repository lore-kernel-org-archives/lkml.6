Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B6DECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0C2159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED0C2159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbeIUVce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389547AbeIUVcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 108CF2E2A7F50;
        Fri, 21 Sep 2018 23:42:58 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:42:51 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: Fix tqp array traversal condition for vf
Date:   Fri, 21 Sep 2018 16:41:40 +0100
Message-ID: <20180921154148.26756-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

There are two tqp_num variables "hdev->tqp_num" and "kinfo->tqp_num"
used in VF. "hdev->tqp_num" is the total tqp number allocated to the
VF, and "kinfo->tqp_num" indicates the tqp number being used by the
VF. Usually the two variables are equal. But for the case hdev->tqp_num
larger than rss_size_max, and num_tc is 1, "kinfo->tqp_num" will be
less than "hdev->tqp_num".

In original codes, "hdev->tqp_num" is always used to traverse the
tqp array of kinfo. It may cause null pointer error when "hdev->tqp_num"
is larger than "kinfo->tqp_num"

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 50 +++++++++++-----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c220d9b..f7ab2eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -31,16 +31,15 @@ static inline struct hclgevf_dev *hclgevf_ae_get_hdev(
 
 static int hclgevf_tqps_update_stats(struct hnae3_handle *handle)
 {
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	struct hnae3_queue *queue;
 	struct hclgevf_desc desc;
 	struct hclgevf_tqp *tqp;
 	int status;
 	int i;
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		queue = handle->kinfo.tqp[i];
-		tqp = container_of(queue, struct hclgevf_tqp, q);
+	for (i = 0; i < kinfo->num_tqps; i++) {
+		tqp = container_of(kinfo->tqp[i], struct hclgevf_tqp, q);
 		hclgevf_cmd_setup_basic_desc(&desc,
 					     HCLGEVF_OPC_QUERY_RX_STATUS,
 					     true);
@@ -77,17 +76,16 @@ static int hclgevf_tqps_update_stats(struct hnae3_handle *handle)
 static u64 *hclgevf_tqps_get_stats(struct hnae3_handle *handle, u64 *data)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclgevf_tqp *tqp;
 	u64 *buff = data;
 	int i;
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		tqp = container_of(handle->kinfo.tqp[i], struct hclgevf_tqp, q);
+	for (i = 0; i < kinfo->num_tqps; i++) {
+		tqp = container_of(kinfo->tqp[i], struct hclgevf_tqp, q);
 		*buff++ = tqp->tqp_stats.rcb_tx_ring_pktnum_rcd;
 	}
 	for (i = 0; i < kinfo->num_tqps; i++) {
-		tqp = container_of(handle->kinfo.tqp[i], struct hclgevf_tqp, q);
+		tqp = container_of(kinfo->tqp[i], struct hclgevf_tqp, q);
 		*buff++ = tqp->tqp_stats.rcb_rx_ring_pktnum_rcd;
 	}
 
@@ -96,28 +94,28 @@ static u64 *hclgevf_tqps_get_stats(struct hnae3_handle *handle, u64 *data)
 
 static int hclgevf_tqps_get_sset_count(struct hnae3_handle *handle, int strset)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 
-	return hdev->num_tqps * 2;
+	return kinfo->num_tqps * 2;
 }
 
 static u8 *hclgevf_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	u8 *buff = data;
 	int i = 0;
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		struct hclgevf_tqp *tqp = container_of(handle->kinfo.tqp[i],
-			struct hclgevf_tqp, q);
+	for (i = 0; i < kinfo->num_tqps; i++) {
+		struct hclgevf_tqp *tqp = container_of(kinfo->tqp[i],
+						       struct hclgevf_tqp, q);
 		snprintf(buff, ETH_GSTRING_LEN, "txq%d_pktnum_rcd",
 			 tqp->index);
 		buff += ETH_GSTRING_LEN;
 	}
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		struct hclgevf_tqp *tqp = container_of(handle->kinfo.tqp[i],
-			struct hclgevf_tqp, q);
+	for (i = 0; i < kinfo->num_tqps; i++) {
+		struct hclgevf_tqp *tqp = container_of(kinfo->tqp[i],
+						       struct hclgevf_tqp, q);
 		snprintf(buff, ETH_GSTRING_LEN, "rxq%d_pktnum_rcd",
 			 tqp->index);
 		buff += ETH_GSTRING_LEN;
@@ -738,14 +736,12 @@ static int hclgevf_get_queue_id(struct hnae3_queue *queue)
 
 static void hclgevf_reset_tqp_stats(struct hnae3_handle *handle)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	struct hnae3_queue *queue;
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_tqp *tqp;
 	int i;
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		queue = handle->kinfo.tqp[i];
-		tqp = container_of(queue, struct hclgevf_tqp, q);
+	for (i = 0; i < kinfo->num_tqps; i++) {
+		tqp = container_of(kinfo->tqp[i], struct hclgevf_tqp, q);
 		memset(&tqp->tqp_stats, 0, sizeof(tqp->tqp_stats));
 	}
 }
@@ -1420,12 +1416,13 @@ static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
 
 static int hclgevf_ae_start(struct hnae3_handle *handle)
 {
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	int i, queue_id;
 
-	for (i = 0; i < handle->kinfo.num_tqps; i++) {
+	for (i = 0; i < kinfo->num_tqps; i++) {
 		/* ring enable */
-		queue_id = hclgevf_get_queue_id(handle->kinfo.tqp[i]);
+		queue_id = hclgevf_get_queue_id(kinfo->tqp[i]);
 		if (queue_id < 0) {
 			dev_warn(&hdev->pdev->dev,
 				 "Get invalid queue id, ignore it\n");
@@ -1448,14 +1445,15 @@ static int hclgevf_ae_start(struct hnae3_handle *handle)
 
 static void hclgevf_ae_stop(struct hnae3_handle *handle)
 {
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	int i, queue_id;
 
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-	for (i = 0; i < hdev->num_tqps; i++) {
+	for (i = 0; i < kinfo->num_tqps; i++) {
 		/* Ring disable */
-		queue_id = hclgevf_get_queue_id(handle->kinfo.tqp[i]);
+		queue_id = hclgevf_get_queue_id(kinfo->tqp[i]);
 		if (queue_id < 0) {
 			dev_warn(&hdev->pdev->dev,
 				 "Get invalid queue id, ignore it\n");
-- 
2.7.4


