Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBEE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZWHdeGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBEE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeJQBPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755A12089E;
        Tue, 16 Oct 2018 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710619;
        bh=eB6SoYe63r+hhX4/cvZ71V9tW8blDbrwiAK539bjjOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZWHdeGGChpO5/4Gf2LNG17HeYANtsDDDmClJGcl+6ObIL2OqCgayEMZupuo7SDHL
         oN70yC6Hz8892SxQZcZGvUyqIHYRgdSceCFPKpxMWZ+HvYjPngzEMjQ4Xp7c+pDUjm
         Lw01E5W8MclfOrtGdPR4VpS6GnxvQHh0jH5/c32I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 29/71] net: hns: fix for unmapping problem when SMMU is on
Date:   Tue, 16 Oct 2018 19:09:26 +0200
Message-Id: <20181016170540.857388623@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hnae.c     |    2 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |   30 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -80,7 +80,7 @@ static void hnae_unmap_buffer(struct hna
 	if (cb->type == DESC_TYPE_SKB)
 		dma_unmap_single(ring_to_dev(ring), cb->dma, cb->length,
 				 ring_to_dma_dir(ring));
-	else
+	else if (cb->length)
 		dma_unmap_page(ring_to_dev(ring), cb->dma, cb->length,
 			       ring_to_dma_dir(ring));
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -39,9 +39,9 @@
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
@@ -63,7 +63,7 @@ static void fill_v2_desc(struct hnae_rin
 	desc_cb->type = type;
 
 	desc->addr = cpu_to_le64(dma);
-	desc->tx.send_size = cpu_to_le16((u16)size);
+	desc->tx.send_size = cpu_to_le16((u16)send_sz);
 
 	/* config bd buffer end */
 	hnae_set_bit(rrcfv, HNSV2_TXD_VLD_B, 1);
@@ -132,6 +132,14 @@ static void fill_v2_desc(struct hnae_rin
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
@@ -288,15 +296,15 @@ static void fill_tso_desc(struct hnae_ri
 
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


