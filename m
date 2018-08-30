Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387D20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F387D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH3EtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:49:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41365 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeH3EtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:49:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so3045492plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZdAF1HX9BbdV1yfLCar67yxiHmtRQzQeHqMiNrKbPs=;
        b=f4WNoSpMFukfC0Q+4uXcObGS56rFQuRPdhno4HgA+5dUevRGkvegzbvy1oFqJZ6KXd
         mqKv3jjD2kw0vPKov2Aycq7tslzxkS+JNjiWwlhfC42v/+NEGk258Bbd83+AkY1wr7bt
         UvigpKn2O68P2Egevt01tqcVKeAtxHu95fZ3CjyS/Hf4yeXffBr+ciZ9dUoAa0zek1Ja
         lTGiKtmL5jYt2EUP8RuX8NR67bWaO09nsiSXA6evwFvF1r+4IH2NJetVD8dhqlgm5NfU
         fatN0VJ6pje2t/MyyaqAKT3BTOlXU+IxO9PIrju3O2YtIP380JWkWl+3ucWGmkbF1+z5
         uTog==
X-Gm-Message-State: APzg51CCCxHiqqWJiT8i0bpl6nA2WqefcCcARe0E1/D+pF56t6XTKG9W
        3O6krarK8OW//Pln3ghOtmDtc7ZIbGk=
X-Google-Smtp-Source: ANB0VdZzNiZOPPWdii9hE3dkkI694wXXyffNNIdd97RySz8gu7J2FItgi6KavfQEW6qCKObye6GhHA==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr8142653plz.49.1535590195049;
        Wed, 29 Aug 2018 17:49:55 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id c68-v6sm8942472pfj.51.2018.08.29.17.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 17:49:54 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 1/3] net: nixge: Add support for fixed-link subnodes
Date:   Wed, 29 Aug 2018 17:40:44 -0700
Message-Id: <20180830004046.9417-2-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830004046.9417-1-mdf@kernel.org>
References: <20180830004046.9417-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for fixed-link cases where no MDIO is
actually required to run the device.
In that case no MDIO bus is instantiated since the
actual registers are not available in hardware.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 72 ++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e3fb09..670249313ff0 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1189,9 +1189,36 @@ static int nixge_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 val)
 	return err;
 }
 
+static int nixge_of_get_phy(struct nixge_priv *priv, struct device_node *np)
+{
+	priv->phy_mode = of_get_phy_mode(np);
+	if (priv->phy_mode < 0) {
+		dev_err(priv->dev, "not find \"phy-mode\" property\n");
+		return -EINVAL;
+	}
+
+	if (of_phy_is_fixed_link(np)) {
+		if (of_phy_register_fixed_link(np) < 0) {
+			dev_err(priv->dev, "broken fixed link spec\n");
+			return -EINVAL;
+		}
+
+		priv->phy_node = of_node_get(np);
+	} else {
+		priv->phy_node = of_parse_phandle(np, "phy-handle", 0);
+		if (!priv->phy_node) {
+			dev_err(priv->dev, "not find \"phy-handle\" property\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int nixge_mdio_setup(struct nixge_priv *priv, struct device_node *np)
 {
 	struct mii_bus *bus;
+	int err;
 
 	bus = devm_mdiobus_alloc(priv->dev);
 	if (!bus)
@@ -1230,6 +1257,7 @@ static int nixge_probe(struct platform_device *pdev)
 	struct nixge_priv *priv;
 	struct net_device *ndev;
 	struct resource *dmares;
+	struct device_node *np;
 	const u8 *mac_addr;
 	int err;
 
@@ -1237,6 +1265,8 @@ static int nixge_probe(struct platform_device *pdev)
 	if (!ndev)
 		return -ENOMEM;
 
+	np = pdev->dev.of_node;
+
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
@@ -1286,24 +1316,19 @@ static int nixge_probe(struct platform_device *pdev)
 	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
-	err = nixge_mdio_setup(priv, pdev->dev.of_node);
-	if (err) {
-		netdev_err(ndev, "error registering mdio bus");
-		goto free_netdev;
-	}
-
-	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
-	if (priv->phy_mode < 0) {
-		netdev_err(ndev, "not find \"phy-mode\" property\n");
-		err = -EINVAL;
-		goto unregister_mdio;
+	if (np) {
+		err = nixge_of_get_phy(priv, np);
+		if (err)
+			goto free_netdev;
 	}
 
-	priv->phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
-	if (!priv->phy_node) {
-		netdev_err(ndev, "not find \"phy-handle\" property\n");
-		err = -EINVAL;
-		goto unregister_mdio;
+	/* only if it's not a fixed link, do we care about MDIO at all */
+	if (priv->phy_node && !of_phy_is_fixed_link(np)) {
+		err = nixge_mdio_setup(priv, np);
+		if (err) {
+			dev_err(&pdev->dev, "error registering mdio bus");
+			goto free_phy;
+		}
 	}
 
 	err = register_netdev(priv->ndev);
@@ -1315,8 +1340,13 @@ static int nixge_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_mdio:
-	mdiobus_unregister(priv->mii_bus);
-
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
+free_phy:
+	if (np && of_phy_is_fixed_link(np)) {
+		of_phy_deregister_fixed_link(np);
+		of_node_put(np);
+	}
 free_netdev:
 	free_netdev(ndev);
 
@@ -1330,7 +1360,11 @@ static int nixge_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
-	mdiobus_unregister(priv->mii_bus);
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
+
+	if (np && of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
 
 	free_netdev(ndev);
 
-- 
2.18.0

