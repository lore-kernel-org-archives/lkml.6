Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A805C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E070720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547634240;
	bh=MBfW3yFdej5jiX29nrfIubMo8LABzqMdr1YQEgDAJgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAvNoDX3LTxaUljPuMhifNQ0yLK5SE58jzP0rK7EERXWpfgmBvM9KXbNFaoxcd6mo
	 pqMMBtzFNWKbACezFSqB8IE2hm2LZyodtHanxnOU3ovdpbaeqTMu42+/xUvqf8K76H
	 0ha9qZXI6f3siw4IOX4dw3YkKnLHzBQYrljvILrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391943AbfAPKXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:23:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43008 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbfAPKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:23:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so4418659lff.10;
        Wed, 16 Jan 2019 02:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YA0AiDvRAudQt5u8BUa4L1frP6objJYUQxko5FZsQNk=;
        b=Ofm0Zpt9JzcE1kFYmk/U+23+jWWgJXHVyDtAG6YrFg9HdlkB5WDlbG2GU2n3XMyd68
         6WFRwKPLVEMM+Z4ZoePmN5q/58JXSmejXgJVaBS4KPLSIys1eM/6Mc56jiJHHFjvMtZU
         5x87NIYjpMRtRzks0JP150sbtMinfdQYy8fvSP+Mck+Gk5zehRwzSvGn7ggNbidFSY9u
         //Pi8aVjgpbaqHg9k5nfhxoLxgRSXugra1fpqO94C4xCgjVFFPuV75fYkl8ut+1bZBDo
         jJTlYsomA1P4UJC8nD+gTFtpSIjvThnTRnmQqw7r3bah0qnMR5gy5BB8UQhdaEJEOtVt
         TeQg==
X-Gm-Message-State: AJcUukcinszM9HAV6dvzBFfQINlP54Jmk979Ouuz6ANWoEIyWuI/wYbz
        AasLT1/qA5cGRoD3CW21V8s=
X-Google-Smtp-Source: ALg8bN5VLaBeBuO7OV1dHbDsz+NccoSu00zgfSeCe8lYr6NoPR/7AStCKyoKWcAyvqC3igBcq1K36g==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr6231146lfm.81.1547634221660;
        Wed, 16 Jan 2019 02:23:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q11sm1079576lfc.92.2019.01.16.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:23:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gjiMH-0007vm-QY; Wed, 16 Jan 2019 11:23:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 2/3] net: dsa: lantiq_gswip: fix OF child-node lookups
Date:   Wed, 16 Jan 2019 11:23:34 +0100
Message-Id: <20190116102335.30433-3-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116102335.30433-1-johan@kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to look up child nodes to
avoid ever matching non-child nodes elsewhere in the tree.

Also fix up the related struct device_node leaks.

Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Cc: stable <stable@vger.kernel.org>	# 4.20
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index b06c41c98de9..5792674dd4e4 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1069,10 +1069,10 @@ static int gswip_probe(struct platform_device *pdev)
 	version = gswip_switch_r(priv, GSWIP_VERSION);
 
 	/* bring up the mdio bus */
-	gphy_fw_np = of_find_compatible_node(pdev->dev.of_node, NULL,
-					     "lantiq,gphy-fw");
+	gphy_fw_np = of_get_compatible_child(dev->of_node, "lantiq,gphy-fw");
 	if (gphy_fw_np) {
 		err = gswip_gphy_fw_list(priv, gphy_fw_np, version);
+		of_node_put(gphy_fw_np);
 		if (err) {
 			dev_err(dev, "gphy fw probe failed\n");
 			return err;
@@ -1080,13 +1080,12 @@ static int gswip_probe(struct platform_device *pdev)
 	}
 
 	/* bring up the mdio bus */
-	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
-					  "lantiq,xrx200-mdio");
+	mdio_np = of_get_compatible_child(dev->of_node, "lantiq,xrx200-mdio");
 	if (mdio_np) {
 		err = gswip_mdio(priv, mdio_np);
 		if (err) {
 			dev_err(dev, "mdio probe failed\n");
-			goto gphy_fw;
+			goto put_mdio_node;
 		}
 	}
 
@@ -1115,7 +1114,8 @@ static int gswip_probe(struct platform_device *pdev)
 mdio_bus:
 	if (mdio_np)
 		mdiobus_unregister(priv->ds->slave_mii_bus);
-gphy_fw:
+put_mdio_node:
+	of_node_put(mdio_np);
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
 	return err;
@@ -1134,8 +1134,10 @@ static int gswip_remove(struct platform_device *pdev)
 
 	dsa_unregister_switch(priv->ds);
 
-	if (priv->ds->slave_mii_bus)
+	if (priv->ds->slave_mii_bus) {
 		mdiobus_unregister(priv->ds->slave_mii_bus);
+		of_node_put(priv->ds->slave_mii_bus->dev.of_node);
+	}
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
-- 
2.20.1

