Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1334427D6F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1334427D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935449AbeF2Kzu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:55:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49206 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932429AbeF2Kyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7DE594AB4BE6A;
        Fri, 29 Jun 2018 18:54:41 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:24 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 09/10] net: hns3: use dma_zalloc_coherent instead of kzalloc/dma_map_single
Date:   Fri, 29 Jun 2018 19:23:04 +0800
Message-ID: <1530271385-49668-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

Reference to Documentation/DMA-API-HOWTO.txt,
Streaming DMA mappings which are usually mapped for one DMA transfer,
Network card DMA ring descriptors should use Consistent DMA mappings.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 26 +++++++++-------------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 25 ++++++++-------------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 26 ++++++++--------------
 3 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index beca364..8fce363 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1780,33 +1780,27 @@ static void hns3_free_buffers(struct hns3_enet_ring *ring)
 /* free desc along with its attached buffer */
 static void hns3_free_desc(struct hns3_enet_ring *ring)
 {
+	int size = ring->desc_num * sizeof(ring->desc[0]);
+
 	hns3_free_buffers(ring);
 
-	dma_unmap_single(ring_to_dev(ring), ring->desc_dma_addr,
-			 ring->desc_num * sizeof(ring->desc[0]),
-			 DMA_BIDIRECTIONAL);
-	ring->desc_dma_addr = 0;
-	kfree(ring->desc);
-	ring->desc = NULL;
+	if (ring->desc) {
+		dma_free_coherent(ring_to_dev(ring), size,
+				  ring->desc, ring->desc_dma_addr);
+		ring->desc = NULL;
+	}
 }
 
 static int hns3_alloc_desc(struct hns3_enet_ring *ring)
 {
 	int size = ring->desc_num * sizeof(ring->desc[0]);
 
-	ring->desc = kzalloc(size, GFP_KERNEL);
+	ring->desc = dma_zalloc_coherent(ring_to_dev(ring), size,
+					 &ring->desc_dma_addr,
+					 GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
-	ring->desc_dma_addr = dma_map_single(ring_to_dev(ring), ring->desc,
-					     size, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(ring_to_dev(ring), ring->desc_dma_addr)) {
-		ring->desc_dma_addr = 0;
-		kfree(ring->desc);
-		ring->desc = NULL;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index facfff6..9542d2c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -45,31 +45,24 @@ static int hclge_alloc_cmd_desc(struct hclge_cmq_ring *ring)
 {
 	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
-	ring->desc = kzalloc(size, GFP_KERNEL);
+	ring->desc = dma_zalloc_coherent(cmq_ring_to_dev(ring),
+					 size, &ring->desc_dma_addr,
+					 GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
-	ring->desc_dma_addr = dma_map_single(cmq_ring_to_dev(ring), ring->desc,
-					     size, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(cmq_ring_to_dev(ring), ring->desc_dma_addr)) {
-		ring->desc_dma_addr = 0;
-		kfree(ring->desc);
-		ring->desc = NULL;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static void hclge_free_cmd_desc(struct hclge_cmq_ring *ring)
 {
-	dma_unmap_single(cmq_ring_to_dev(ring), ring->desc_dma_addr,
-			 ring->desc_num * sizeof(ring->desc[0]),
-			 DMA_BIDIRECTIONAL);
+	int size  = ring->desc_num * sizeof(struct hclge_desc);
 
-	ring->desc_dma_addr = 0;
-	kfree(ring->desc);
-	ring->desc = NULL;
+	if (ring->desc) {
+		dma_free_coherent(cmq_ring_to_dev(ring), size,
+				  ring->desc, ring->desc_dma_addr);
+		ring->desc = NULL;
+	}
 }
 
 static int hclge_alloc_cmd_queue(struct hclge_dev *hdev, int ring_type)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 1bbfe13..fb471fe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -76,32 +76,24 @@ static int hclgevf_alloc_cmd_desc(struct hclgevf_cmq_ring *ring)
 {
 	int size = ring->desc_num * sizeof(struct hclgevf_desc);
 
-	ring->desc = kzalloc(size, GFP_KERNEL);
+	ring->desc = dma_zalloc_coherent(cmq_ring_to_dev(ring),
+					 size, &ring->desc_dma_addr,
+					 GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
-	ring->desc_dma_addr = dma_map_single(cmq_ring_to_dev(ring), ring->desc,
-					     size, DMA_BIDIRECTIONAL);
-
-	if (dma_mapping_error(cmq_ring_to_dev(ring), ring->desc_dma_addr)) {
-		ring->desc_dma_addr = 0;
-		kfree(ring->desc);
-		ring->desc = NULL;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static void hclgevf_free_cmd_desc(struct hclgevf_cmq_ring *ring)
 {
-	dma_unmap_single(cmq_ring_to_dev(ring), ring->desc_dma_addr,
-			 ring->desc_num * sizeof(ring->desc[0]),
-			 hclgevf_ring_to_dma_dir(ring));
+	int size  = ring->desc_num * sizeof(struct hclgevf_desc);
 
-	ring->desc_dma_addr = 0;
-	kfree(ring->desc);
-	ring->desc = NULL;
+	if (ring->desc) {
+		dma_free_coherent(cmq_ring_to_dev(ring), size,
+				  ring->desc, ring->desc_dma_addr);
+		ring->desc = NULL;
+	}
 }
 
 static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
-- 
1.9.1

