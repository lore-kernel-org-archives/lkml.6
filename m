Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D18FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1422077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1422077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeJNXkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:40:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35913 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cd-Ow; Sun, 14 Oct 2018 16:30:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000mn-JX; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.685696211@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 364/366] net: ethernet: davinci_emac: fix error
 handling in probe()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 8005b09d99fac78e6f5fb9da30b5ae94840af03b upstream.

The current error handling code has an issue where it does:

	if (priv->txchan)
		cpdma_chan_destroy(priv->txchan);

The problem is that ->txchan is either valid or an error pointer (which
would lead to an Oops).  I've changed it to use multiple error labels so
that the test can be removed.

Also there were some missing calls to netif_napi_del().

Fixes: 3ef0fdb2342c ("net: davinci_emac: switch to new cpdma layer")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/ti/davinci_emac.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1971,7 +1971,7 @@ static int davinci_emac_probe(struct pla
 	if (IS_ERR(priv->txchan)) {
 		dev_err(&pdev->dev, "error initializing tx dma channel\n");
 		rc = PTR_ERR(priv->txchan);
-		goto no_cpdma_chan;
+		goto err_free_dma;
 	}
 
 	priv->rxchan = cpdma_chan_create(priv->dma, rx_chan_num(EMAC_DEF_RX_CH),
@@ -1979,14 +1979,14 @@ static int davinci_emac_probe(struct pla
 	if (IS_ERR(priv->rxchan)) {
 		dev_err(&pdev->dev, "error initializing rx dma channel\n");
 		rc = PTR_ERR(priv->rxchan);
-		goto no_cpdma_chan;
+		goto err_free_txchan;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "error getting irq res\n");
 		rc = -ENOENT;
-		goto no_cpdma_chan;
+		goto err_free_rxchan;
 	}
 	ndev->irq = res->start;
 
@@ -2008,7 +2008,7 @@ static int davinci_emac_probe(struct pla
 		pm_runtime_put_noidle(&pdev->dev);
 		dev_err(&pdev->dev, "%s: failed to get_sync(%d)\n",
 			__func__, rc);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 	/* register the network device */
@@ -2018,7 +2018,7 @@ static int davinci_emac_probe(struct pla
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc = -ENODEV;
 		pm_runtime_put(&pdev->dev);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 
@@ -2031,11 +2031,13 @@ static int davinci_emac_probe(struct pla
 
 	return 0;
 
-no_cpdma_chan:
-	if (priv->txchan)
-		cpdma_chan_destroy(priv->txchan);
-	if (priv->rxchan)
-		cpdma_chan_destroy(priv->rxchan);
+err_napi_del:
+	netif_napi_del(&priv->napi);
+err_free_rxchan:
+	cpdma_chan_destroy(priv->rxchan);
+err_free_txchan:
+	cpdma_chan_destroy(priv->txchan);
+err_free_dma:
 	cpdma_ctlr_destroy(priv->dma);
 no_pdata:
 	free_netdev(ndev);

