Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280FFC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED50420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeJNXj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:39:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35950 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727562AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cA-SG; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000mX-Hy; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Grygorii Strashko" <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ivan Khoronzhuk" <ivan.khoronzhuk@linaro.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.480429596@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 362/366] net: ethernet: ti: cpdma: correct error
 handling for chan create
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

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

commit 8a83c5d7969b8433584e3cf658a8d76c4dc37f4d upstream.

It's not correct to return NULL when that is actually an error and
function returns errors in any other wrong case. In the same time,
the cpsw driver and davinci emac doesn't check error case while
creating channel and it can miss actual error. Also remove WARNs
replacing them on dev_err msgs.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Channel pointers are stored in different fields
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/ti/cpsw.c          | 12 +++++++++---
 drivers/net/ethernet/ti/davinci_cpdma.c |  2 +-
 drivers/net/ethernet/ti/davinci_emac.c  | 11 +++++++++--
 3 files changed, 19 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2216,12 +2216,17 @@ static int cpsw_probe(struct platform_de
 
 	priv->txch = cpdma_chan_create(priv->dma, tx_chan_num(0),
 				       cpsw_tx_handler);
+	if (IS_ERR(priv->txch)) {
+		dev_err(priv->dev, "error initializing tx dma channel\n");
+		ret = PTR_ERR(priv->txch);
+		goto clean_dma_ret;
+	}
+
 	priv->rxch = cpdma_chan_create(priv->dma, rx_chan_num(0),
 				       cpsw_rx_handler);
-
-	if (WARN_ON(!priv->txch || !priv->rxch)) {
-		dev_err(priv->dev, "error initializing dma channels\n");
-		ret = -ENOMEM;
+	if (IS_ERR(priv->rxch)) {
+		dev_err(priv->dev, "error initializing rx dma channel\n");
+		ret = PTR_ERR(priv->rxch);
 		goto clean_dma_ret;
 	}
 
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -503,7 +503,7 @@ struct cpdma_chan *cpdma_chan_create(str
 	unsigned long flags;
 
 	if (__chan_linear(chan_num) >= ctlr->num_chan)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	chan = devm_kzalloc(ctlr->dev, sizeof(*chan), GFP_KERNEL);
 	if (!chan)
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1951,10 +1951,17 @@ static int davinci_emac_probe(struct pla
 
 	priv->txchan = cpdma_chan_create(priv->dma, tx_chan_num(EMAC_DEF_TX_CH),
 				       emac_tx_handler);
+	if (IS_ERR(priv->txchan)) {
+		dev_err(&pdev->dev, "error initializing tx dma channel\n");
+		rc = PTR_ERR(priv->txchan);
+		goto no_cpdma_chan;
+	}
+
 	priv->rxchan = cpdma_chan_create(priv->dma, rx_chan_num(EMAC_DEF_RX_CH),
 				       emac_rx_handler);
-	if (WARN_ON(!priv->txchan || !priv->rxchan)) {
-		rc = -ENOMEM;
+	if (IS_ERR(priv->rxchan)) {
+		dev_err(&pdev->dev, "error initializing rx dma channel\n");
+		rc = PTR_ERR(priv->rxchan);
 		goto no_cpdma_chan;
 	}
 

