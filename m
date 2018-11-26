Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B462089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkN4w+M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B462089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeKZV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbeKZV64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8D020989;
        Mon, 26 Nov 2018 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230310;
        bh=Az2+DTaGTxezErzsDj3mGq9ddrvDFvdchqtdvPi0bfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FkN4w+M5iWdyJS8BaCsnGMVEFpMDJqsUw0qWU1lvSJqINqSCGbfZ8wW9M36MCjLFO
         3NniqUvhMpCe0n4vaKw4gM1MrNMcfY31nx6Wv2Qwc8DWZe622nkjPfbzsO10oiNKq3
         r485CrsMw5WuW5q8WmTS0/utHNY1G/hh3jtuSpCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/118] net: aquantia: invalid checksumm offload implementation
Date:   Mon, 26 Nov 2018 11:51:22 +0100
Message-Id: <20181126105105.234023175@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ad703c2b9127f9acdef697ec4755f6da4beaa266 ]

Packets with marked invalid IP/UDP/TCP checksums were considered as good
by the driver. The error was in a logic, processing offload bits in
RX descriptor.

Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 35 +++++++++++-------
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 36 +++++++++----------
 2 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index d1e1a0ba8615..7134d0d4cdf7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -172,6 +172,27 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 	return !!budget;
 }
 
+static void aq_rx_checksum(struct aq_ring_s *self,
+			   struct aq_ring_buff_s *buff,
+			   struct sk_buff *skb)
+{
+	if (!(self->aq_nic->ndev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (unlikely(buff->is_cso_err)) {
+		++self->stats.rx.errors;
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+	if (buff->is_ip_cso) {
+		__skb_incr_checksum_unnecessary(skb);
+		if (buff->is_udp_cso || buff->is_tcp_cso)
+			__skb_incr_checksum_unnecessary(skb);
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+}
+
 #define AQ_SKB_ALIGN SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
 int aq_ring_rx_clean(struct aq_ring_s *self,
 		     struct napi_struct *napi,
@@ -267,18 +288,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		}
 
 		skb->protocol = eth_type_trans(skb, ndev);
-		if (unlikely(buff->is_cso_err)) {
-			++self->stats.rx.errors;
-			skb->ip_summed = CHECKSUM_NONE;
-		} else {
-			if (buff->is_ip_cso) {
-				__skb_incr_checksum_unnecessary(skb);
-				if (buff->is_udp_cso || buff->is_tcp_cso)
-					__skb_incr_checksum_unnecessary(skb);
-			} else {
-				skb->ip_summed = CHECKSUM_NONE;
-			}
-		}
+
+		aq_rx_checksum(self, buff, skb);
 
 		skb_set_hash(skb, buff->rss_hash,
 			     buff->is_hash_l4 ? PKT_HASH_TYPE_L4 :
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 0271a0fdfee8..88705dee5b95 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -655,9 +655,9 @@ static int hw_atl_b0_hw_ring_rx_receive(struct aq_hw_s *self,
 		struct hw_atl_rxd_wb_s *rxd_wb = (struct hw_atl_rxd_wb_s *)
 			&ring->dx_ring[ring->hw_head * HW_ATL_B0_RXD_SIZE];
 
-		unsigned int is_err = 1U;
 		unsigned int is_rx_check_sum_enabled = 0U;
 		unsigned int pkt_type = 0U;
+		u8 rx_stat = 0U;
 
 		if (!(rxd_wb->status & 0x1U)) { /* RxD is not done */
 			break;
@@ -665,35 +665,35 @@ static int hw_atl_b0_hw_ring_rx_receive(struct aq_hw_s *self,
 
 		buff = &ring->buff_ring[ring->hw_head];
 
-		is_err = (0x0000003CU & rxd_wb->status);
+		rx_stat = (0x0000003CU & rxd_wb->status) >> 2;
 
 		is_rx_check_sum_enabled = (rxd_wb->type) & (0x3U << 19);
-		is_err &= ~0x20U; /* exclude validity bit */
 
 		pkt_type = 0xFFU & (rxd_wb->type >> 4);
 
-		if (is_rx_check_sum_enabled) {
-			if (0x0U == (pkt_type & 0x3U))
-				buff->is_ip_cso = (is_err & 0x08U) ? 0U : 1U;
+		if (is_rx_check_sum_enabled & BIT(0) &&
+		    (0x0U == (pkt_type & 0x3U)))
+			buff->is_ip_cso = (rx_stat & BIT(1)) ? 0U : 1U;
 
+		if (is_rx_check_sum_enabled & BIT(1)) {
 			if (0x4U == (pkt_type & 0x1CU))
-				buff->is_udp_cso = buff->is_cso_err ? 0U : 1U;
+				buff->is_udp_cso = (rx_stat & BIT(2)) ? 0U :
+						   !!(rx_stat & BIT(3));
 			else if (0x0U == (pkt_type & 0x1CU))
-				buff->is_tcp_cso = buff->is_cso_err ? 0U : 1U;
-
-			/* Checksum offload workaround for small packets */
-			if (rxd_wb->pkt_len <= 60) {
-				buff->is_ip_cso = 0U;
-				buff->is_cso_err = 0U;
-			}
+				buff->is_tcp_cso = (rx_stat & BIT(2)) ? 0U :
+						   !!(rx_stat & BIT(3));
+		}
+		buff->is_cso_err = !!(rx_stat & 0x6);
+		/* Checksum offload workaround for small packets */
+		if (unlikely(rxd_wb->pkt_len <= 60)) {
+			buff->is_ip_cso = 0U;
+			buff->is_cso_err = 0U;
 		}
-
-		is_err &= ~0x18U;
 
 		dma_unmap_page(ndev, buff->pa, buff->len, DMA_FROM_DEVICE);
 
-		if (is_err || rxd_wb->type & 0x1000U) {
-			/* status error or DMA error */
+		if ((rx_stat & BIT(0)) || rxd_wb->type & 0x1000U) {
+			/* MAC error or DMA error */
 			buff->is_error = 1U;
 		} else {
 			if (self->aq_nic_cfg->is_rss) {
-- 
2.17.1



