Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3BC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB42218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298137;
	bh=+n0CJVOeuTXRMSVakiOq0qgHiKiA1sx4ftoeEOw/9Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u5mGH6XbzOrkqspqAIv426OExwatPoJRhToYvGsql0tXQMmiqG7zzUoQY2tQFb7yG
	 w3Mk9O3vvhN4OhkaJWcSM/2qvzaxdud/bj9Hj6/MJWbMXwDpAZD0EHU0dQxLbRM274
	 AIzX1NqQKIFvGqBuRNVrw0vXtHCb6hfAcaBjoroQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeLTJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732588AbeLTJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C06220656;
        Thu, 20 Dec 2018 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298131;
        bh=+n0CJVOeuTXRMSVakiOq0qgHiKiA1sx4ftoeEOw/9Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0mp11CsErDKBcx+x0SPBiQDBcnFaljtKvEtgkDNCFQGAQRAIxvKeEbim4nneQjQU4
         a2GJc7N9QGcXlPJcgsW8mu9o6KJFMLoA/SiQWdHgkh/bWo2WVusjl6BBgoHZNTzAU+
         riRfueAetRsbtAWeLrIp1jKmcJx7QIRkHwCKdjJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/67] net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM
Date:   Thu, 20 Dec 2018 10:18:23 +0100
Message-Id: <20181220085904.013506792@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 88113957ddb7b7d5451e28cd708c82ea7e63b097 ]

In commit 26a4676faa1a ("arm64: mm: define NET_IP_ALIGN to 0"),
AVE controller affects this modification because the controller forces
to ignore lower 2bits of buffer start address, and make 2-byte headroom,
that is, data reception starts from (buffer + 2).

This patch defines AVE_FRAME_HEADROOM macro as hardware-specific value,
and replaces NET_IP_ALIGN with it.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/sni_ave.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f7ecceeb1e28..f27d67a4d304 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -194,6 +194,7 @@
 
 /* Parameter for ethernet frame */
 #define AVE_MAX_ETHFRAME	1518
+#define AVE_FRAME_HEADROOM	2
 
 /* Parameter for interrupt */
 #define AVE_INTM_COUNT		20
@@ -585,12 +586,13 @@ static int ave_rxdesc_prepare(struct net_device *ndev, int entry)
 
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
@@ -603,12 +605,12 @@ static int ave_rxdesc_prepare(struct net_device *ndev, int entry)
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
2.19.1



