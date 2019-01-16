Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C0206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547634467;
	bh=+yhquqpOuDoj1Lnw/39iOILCN5166vzqeK5qZibx6Qw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LIlg1dP6eWzFCYJdUb0bpOykkMyXRhYjtCSmQUL1cCu8xRVji4o2D0jqwBg/fO059
	 CMBS87Ii0mTvE9zZ/zwDrA0+oOfMOJwFW4JIpIq0x76KeeznNa/RmpqUSo4wnqfpgL
	 NitdlByNDE1aI0KJ221Y8KXVS90aTsO0ISGrbtFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392013AbfAPK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:27:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36861 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfAPK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:27:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so4459688lfg.3;
        Wed, 16 Jan 2019 02:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PM5jJFBb+raYWgZeLbLRCOD3DLFWKq/Us6K9CVm3ahA=;
        b=M44tMHKCUTm6lhaKO3TuHJaU68qnSom7g7rmz0XCdTyPw0peT/1399NDggIAwPa/On
         FjwAovAN9ldLg5cyS3DoY4FkshHNZQnFPAAbBa1xETO1eSM5CGddkHm7+wIq6+zrgA27
         fV2jfmmj+iEVHulG0EG1JsI+emlqxN834UcKZo9VTm9hITc6sToToOwPSvwix/JP2mPk
         VIA4bGMnHRfLTu6kohKuERPu46npO5OI/mqUUP+m/9qu6qodwaVmGyR9IfCXwaMNt+dO
         KDPOPnSa088puR74mnOi6qHr3sFmtHfOZycxmyLqrBSpZ25nF6chnj2VGwM2MdvXitqI
         uMyA==
X-Gm-Message-State: AJcUukdlsNepgg6i91rfPLKliQGw04VGkrP/+NKRYSByGP/BaG8xBIP2
        JvLV5T+wggOEPAt9QKaDI40=
X-Google-Smtp-Source: ALg8bN7CeFmaVO9bUC0dkyhIJwXeZbZPBu/rPpp1lIgbXOZ+oXq7A9/BuW5Mpo3tjx4KyA2LhEI8dw==
X-Received: by 2002:a19:1994:: with SMTP id 142mr6518594lfz.134.1547634463166;
        Wed, 16 Jan 2019 02:27:43 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c2-v6sm959884ljj.41.2019.01.16.02.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:27:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gjiQB-0007yN-8f; Wed, 16 Jan 2019 11:27:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] net: dsa: realtek-smi: fix OF child-node lookup
Date:   Wed, 16 Jan 2019 11:27:08 +0100
Message-Id: <20190116102708.30608-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to look up child nodes to
avoid ever matching non-child nodes elsewhere in the tree.

Also fix up the related struct device_node leaks.

Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
Cc: stable <stable@vger.kernel.org>     # 4.19: 36156f9241cb0
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Note that this one has only been compile tested.


 drivers/net/dsa/realtek-smi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek-smi.c b/drivers/net/dsa/realtek-smi.c
index b4b839a1d095..ad41ec63cc9f 100644
--- a/drivers/net/dsa/realtek-smi.c
+++ b/drivers/net/dsa/realtek-smi.c
@@ -347,16 +347,17 @@ int realtek_smi_setup_mdio(struct realtek_smi *smi)
 	struct device_node *mdio_np;
 	int ret;
 
-	mdio_np = of_find_compatible_node(smi->dev->of_node, NULL,
-					  "realtek,smi-mdio");
+	mdio_np = of_get_compatible_child(smi->dev->of_node, "realtek,smi-mdio");
 	if (!mdio_np) {
 		dev_err(smi->dev, "no MDIO bus node\n");
 		return -ENODEV;
 	}
 
 	smi->slave_mii_bus = devm_mdiobus_alloc(smi->dev);
-	if (!smi->slave_mii_bus)
-		return -ENOMEM;
+	if (!smi->slave_mii_bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
 	smi->slave_mii_bus->priv = smi;
 	smi->slave_mii_bus->name = "SMI slave MII";
 	smi->slave_mii_bus->read = realtek_smi_mdio_read;
@@ -371,10 +372,15 @@ int realtek_smi_setup_mdio(struct realtek_smi *smi)
 	if (ret) {
 		dev_err(smi->dev, "unable to register MDIO bus %s\n",
 			smi->slave_mii_bus->id);
-		of_node_put(mdio_np);
+		goto err_put_node;
 	}
 
 	return 0;
+
+err_put_node:
+	of_node_put(mdio_np);
+
+	return ret;
 }
 
 static int realtek_smi_probe(struct platform_device *pdev)
@@ -457,6 +463,8 @@ static int realtek_smi_remove(struct platform_device *pdev)
 	struct realtek_smi *smi = dev_get_drvdata(&pdev->dev);
 
 	dsa_unregister_switch(smi->ds);
+	if (smi->slave_mii_bus)
+		of_node_put(smi->slave_mii_bus->dev.of_node);
 	gpiod_set_value(smi->reset, 1);
 
 	return 0;
-- 
2.20.1

