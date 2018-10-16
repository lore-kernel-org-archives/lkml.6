Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98121C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D834208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgalj+lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D834208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJPMBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeJPMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273CB21476;
        Tue, 16 Oct 2018 04:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663163;
        bh=RFvalYRd6uVUxY/AqTJe7TqdXJAPs1eSZ7qdPBwWFew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wgalj+lB2hSstV299qcnuDJE4RXb5IbQ6t3drH+pTPFdg9oJOF7/mU2nsAhbqs68G
         JMbXVQWXYrBn82B3Hed8RES0RpPAYq7O6ehejRPdYIS/91dV2vgaiKc4ZxJVncxbaZ
         sgSPSZNAXc8JlmlsAYqeB07aO0HjtjiVWcci1r8M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 021/100] net: hns: fix for unmapping problem when SMMU is on
Date:   Tue, 16 Oct 2018 00:11:02 -0400
Message-Id: <20181016041221.135528-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 2e9361efa707e186d91b938e44f9e326725259f7 ]

If SMMU is on, there is more likely that skb_shinfo(skb)->frags[i]
can not send by a single BD. when this happen, the
hns_nic_net_xmit_hw function map the whole data in a frags using
skb_frag_dma_map, but unmap each BD' data individually when tx is
done, which causes problem when SMMU is on.

This patch fixes this problem by ummapping the whole data in a
frags when tx is done.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hnae.c     |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 30 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index a051e582d541..79d03f8ee7b1 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -84,7 +84,7 @@ static void hnae_unmap_buffer(struct hnae_ring *ring, struct hnae_desc_cb *cb)
 	if (cb->type == DESC_TYPE_SKB)
 		dma_unmap_single(ring_to_dev(ring), cb->dma, cb->length,
 				 ring_to_dma_dir(ring));
-	else
+	else if (cb->length)
 		dma_unmap_page(ring_to_dev(ring), cb->dma, cb->length,
 			       ring_to_dma_dir(ring));
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index b4518f45f048..1336ec73230d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -40,9 +40,9 @@
 #define SKB_TMP_LEN(SKB) \
 	(((SKB)->transport_header - (SKB)->mac_header) + tcp_hdrlen(SKB))
 
-static void fill_v2_desc(struct hnae_ring *ring, void *priv,
-			 int size, dma_addr_t dma, int frag_end,
-			 int buf_num, enum hns_desc_type type, int mtu)
+static void fill_v2_desc_hw(struct hnae_ring *ring, void *priv, int size,
+			    int send_sz, dma_addr_t dma, int frag_end,
+			    int buf_num, enum hns_desc_type type, int mtu)
 {
 	struct hnae_desc *desc = &ring->desc[ring->next_to_use];
 	struct hnae_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
@@ -64,7 +64,7 @@ static void fill_v2_desc(struct hnae_ring *ring, void *priv,
 	desc_cb->type = type;
 
 	desc->addr = cpu_to_le64(dma);
-	desc->tx.send_size = cpu_to_le16((u16)size);
+	desc->tx.send_size = cpu_to_le16((u16)send_sz);
 
 	/* config bd buffer end */
 	hnae_set_bit(rrcfv, HNSV2_TXD_VLD_B, 1);
@@ -133,6 +133,14 @@ static void fill_v2_desc(struct hnae_ring *ring, void *priv,
 	ring_ptr_move_fw(ring, next_to_use);
 }
 
+static void fill_v2_desc(struct hnae_ring *ring, void *priv,
+			 int size, dma_addr_t dma, int frag_end,
+			 int buf_num, enum hns_desc_type type, int mtu)
+{
+	fill_v2_desc_hw(ring, priv, size, size, dma, frag_end,
+			buf_num, type, mtu);
+}
+
 static const struct acpi_device_id hns_enet_acpi_match[] = {
 	{ "HISI00C1", 0 },
 	{ "HISI00C2", 0 },
@@ -289,15 +297,15 @@ static void fill_tso_desc(struct hnae_ring *ring, void *priv,
 
 	/* when the frag size is bigger than hardware, split this frag */
 	for (k = 0; k < frag_buf_num; k++)
-		fill_v2_desc(ring, priv,
-			     (k == frag_buf_num - 1) ?
+		fill_v2_desc_hw(ring, priv, k == 0 ? size : 0,
+				(k == frag_buf_num - 1) ?
 					sizeoflast : BD_MAX_SEND_SIZE,
-			     dma + BD_MAX_SEND_SIZE * k,
-			     frag_end && (k == frag_buf_num - 1) ? 1 : 0,
-			     buf_num,
-			     (type == DESC_TYPE_SKB && !k) ?
+				dma + BD_MAX_SEND_SIZE * k,
+				frag_end && (k == frag_buf_num - 1) ? 1 : 0,
+				buf_num,
+				(type == DESC_TYPE_SKB && !k) ?
 					DESC_TYPE_SKB : DESC_TYPE_PAGE,
-			     mtu);
+				mtu);
 }
 
 netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
-- 
2.17.1

