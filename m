Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YjGSEkPzG1vfYwAAmS7hNA
	; Sat, 09 Jun 2018 15:33:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2EE59608D4; Sat,  9 Jun 2018 15:33:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua8WWRIt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E556608BF;
	Sat,  9 Jun 2018 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E556608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932667AbeFIPdT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932599AbeFIPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:15 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80056204EC;
        Sat,  9 Jun 2018 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558395;
        bh=/DPhUmxOq7335QDeTWuBwSSf/MfEyzjBMaDEtU67/J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ua8WWRItOSKQvTFdWI5UYUyMNkpyW77wN901PqcSZY1Qs9zCtr5jp8c/WdlblKkRK
         HW9XEammn0cJ3o9dtO0JY/wGpu0FB/OwBk6kScSNQYmNHHkmGBac+pgPj/pJK+HPTk
         ng1m+9eu7x7G+S41UPQAbFIHdwfQy5aLz4K2I8qA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 20/48] net: ethernet: davinci_emac: fix error handling in probe()
Date: Sat,  9 Jun 2018 17:29:32 +0200
Message-Id: <20180609145948.966931231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8005b09d99fac78e6f5fb9da30b5ae94840af03b ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/davinci_emac.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1873,7 +1873,7 @@ static int davinci_emac_probe(struct pla
 	if (IS_ERR(priv->txchan)) {
 		dev_err(&pdev->dev, "error initializing tx dma channel\n");
 		rc = PTR_ERR(priv->txchan);
-		goto no_cpdma_chan;
+		goto err_free_dma;
 	}
 
 	priv->rxchan = cpdma_chan_create(priv->dma, EMAC_DEF_RX_CH,
@@ -1881,14 +1881,14 @@ static int davinci_emac_probe(struct pla
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
 
@@ -1914,7 +1914,7 @@ static int davinci_emac_probe(struct pla
 		pm_runtime_put_noidle(&pdev->dev);
 		dev_err(&pdev->dev, "%s: failed to get_sync(%d)\n",
 			__func__, rc);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 	/* register the network device */
@@ -1924,7 +1924,7 @@ static int davinci_emac_probe(struct pla
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc = -ENODEV;
 		pm_runtime_put(&pdev->dev);
-		goto no_cpdma_chan;
+		goto err_napi_del;
 	}
 
 
@@ -1937,11 +1937,13 @@ static int davinci_emac_probe(struct pla
 
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
 	if (of_phy_is_fixed_link(np))
