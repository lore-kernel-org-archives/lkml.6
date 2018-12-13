Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675333;
	bh=NsacCFtlTmwPMHNMAFtbP/JG7NGM3lone9hfForMMn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVomVU6p/ZT5OATiksSIAGtYOiHPBxf+vSdZnNtZfN0bJPu5HpABvYPyQqUZ/nRL0
	 m4m5Xymz2KbC3HBfvMZ8+eRMHyFawGR8u06zwA40iAFKIiWKQOV11SwErUc7ANrgb2
	 d4fhEorxeTPJzD74Tg9kF4MlEPAGhjz3pxzjB5Rg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLME2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeLME2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539A320849;
        Thu, 13 Dec 2018 04:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675329;
        bh=NsacCFtlTmwPMHNMAFtbP/JG7NGM3lone9hfForMMn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbcjS941OeDru80t9Q8wvq5JLrarxKLfbaAAd1XfcN1i5aLocS78eWpjBGdIlO8MF
         4PSRJDfAgX6EPeyvy50RddPi1kwtyjZQvoRVgsbJt2U5Fc3Oo6PJaBupFVaiqrFBLI
         LGt7pBHl4uJ5++CYDjWHbc2dETKQdFC8ylSTlEy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/73] net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM
Date:   Wed, 12 Dec 2018 23:27:33 -0500
Message-Id: <20181213042838.75160-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

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

