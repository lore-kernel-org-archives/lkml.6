Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E68C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E68C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeK2TNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:13:18 -0500
Received: from mx.socionext.com ([202.248.49.38]:4139 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbeK2TNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:13:18 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:08:45 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id BE32960062;
        Thu, 29 Nov 2018 17:08:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:08:45 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4CBB61A03A2;
        Thu, 29 Nov 2018 17:08:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 2/3] net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM
Date:   Thu, 29 Nov 2018 17:08:37 +0900
Message-Id: <1543478918-13883-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 26a4676faa1a ("arm64: mm: define NET_IP_ALIGN to 0"),
AVE controller affects this modification because the controller forces
to ignore lower 2bits of buffer start address, and make 2-byte headroom,
that is, data reception starts from (buffer + 2).

This patch defines AVE_FRAME_HEADROOM macro as hardware-specific value,
and replaces NET_IP_ALIGN with it.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 598b963..6710151 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -194,6 +194,7 @@
 
 /* Parameter for ethernet frame */
 #define AVE_MAX_ETHFRAME	1518
+#define AVE_FRAME_HEADROOM	2
 
 /* Parameter for interrupt */
 #define AVE_INTM_COUNT		20
@@ -577,12 +578,13 @@ static int ave_rxdesc_prepare(struct net_device *ndev, int entry)
 
 	skb = priv->rx.desc[entry].skbs;
 	if (!skb) {
-		skb = netdev_alloc_skb_ip_align(ndev,
-						AVE_MAX_ETHFRAME);
+		skb = netdev_alloc_skb(ndev, AVE_MAX_ETHFRAME);
 		if (!skb) {
 			netdev_err(ndev, "can't allocate skb for Rx\n");
 			return -ENOMEM;
 		}
+		skb->data += AVE_FRAME_HEADROOM;
+		skb->tail += AVE_FRAME_HEADROOM;
 	}
 
 	/* set disable to cmdsts */
@@ -595,12 +597,12 @@ static int ave_rxdesc_prepare(struct net_device *ndev, int entry)
 	 * - Rx buffer begins with 2 byte headroom, and data will be put from
 	 *   (buffer + 2).
 	 * To satisfy this, specify the address to put back the buffer
-	 * pointer advanced by NET_IP_ALIGN by netdev_alloc_skb_ip_align(),
-	 * and expand the map size by NET_IP_ALIGN.
+	 * pointer advanced by AVE_FRAME_HEADROOM, and expand the map size
+	 * by AVE_FRAME_HEADROOM.
 	 */
 	ret = ave_dma_map(ndev, &priv->rx.desc[entry],
-			  skb->data - NET_IP_ALIGN,
-			  AVE_MAX_ETHFRAME + NET_IP_ALIGN,
+			  skb->data - AVE_FRAME_HEADROOM,
+			  AVE_MAX_ETHFRAME + AVE_FRAME_HEADROOM,
 			  DMA_FROM_DEVICE, &paddr);
 	if (ret) {
 		netdev_err(ndev, "can't map skb for Rx\n");
-- 
2.7.4

