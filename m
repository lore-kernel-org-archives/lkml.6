Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEFC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE2B20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE2B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeK2TNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:13:16 -0500
Received: from mx.socionext.com ([202.248.49.38]:4132 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbeK2TNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:13:16 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2018 17:08:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D6491180BCB;
        Thu, 29 Nov 2018 17:08:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 29 Nov 2018 17:08:44 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 38EC81A03A2;
        Thu, 29 Nov 2018 17:08:44 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 1/3] net: ethernet: ave: Increase descriptors to improve performance
Date:   Thu, 29 Nov 2018 17:08:36 +0900
Message-Id: <1543478918-13883-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1543478918-13883-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve performance, this increases Rx descriptor to 256, Tx descriptor
to 64, and adjusts NAPI weight to NAPI_POLL_WEIGHT.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 8c1e120..598b963 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -185,8 +185,8 @@
 				 NETIF_MSG_TX_ERR)
 
 /* Parameter for descriptor */
-#define AVE_NR_TXDESC		32	/* Tx descriptor */
-#define AVE_NR_RXDESC		64	/* Rx descriptor */
+#define AVE_NR_TXDESC		64	/* Tx descriptor */
+#define AVE_NR_RXDESC		256	/* Rx descriptor */
 
 #define AVE_DESC_OFS_CMDSTS	0
 #define AVE_DESC_OFS_ADDRL	4
@@ -1694,9 +1694,10 @@ static int ave_probe(struct platform_device *pdev)
 		 pdev->name, pdev->id);
 
 	/* Register as a NAPI supported driver */
-	netif_napi_add(ndev, &priv->napi_rx, ave_napi_poll_rx, priv->rx.ndesc);
+	netif_napi_add(ndev, &priv->napi_rx, ave_napi_poll_rx,
+		       NAPI_POLL_WEIGHT);
 	netif_tx_napi_add(ndev, &priv->napi_tx, ave_napi_poll_tx,
-			  priv->tx.ndesc);
+			  NAPI_POLL_WEIGHT);
 
 	platform_set_drvdata(pdev, ndev);
 
-- 
2.7.4

