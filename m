Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A8C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3B20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080373;
	bh=w+0h2kDubArd3hdoGBVRy/zSIz+a9Ln7Fu+qzVNwyi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VrmouqB1LpLNVA6bnGmTtxIlciRihqOosQQnyCSc6k668eHi3yUTHC8TmFREvcYoh
	 Gq5t81OWd5qBPMlMZGRZo9+7cHlIb0j5MsOQQaaz+IYv+UknAWwZt79nRCbVoIB+XH
	 rDZKw88jR71RNdPjLsef9lJt+4e417R6NK5z+tAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfAUOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbfAUNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6AB20861;
        Mon, 21 Jan 2019 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078524;
        bh=w+0h2kDubArd3hdoGBVRy/zSIz+a9Ln7Fu+qzVNwyi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXPCNE+hIZrpDeqE1zx3FPOsiQdGiOiCgEo4r/3Lw0IMIY+Er1plb+Xyc5VPauPdV
         v2ESRB2Vk2SYSEeT6jEz8FlkTCe2RjT8k8bH6JMJdffVQ5FuemGd9o9WXnyt1g1dkA
         jKJQla1a3+ytSsFB1cPFLs5B9p3n6ybekxy6dI0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 063/111] net: dsa: realtek-smi: fix OF child-node lookup
Date:   Mon, 21 Jan 2019 14:42:57 +0100
Message-Id: <20190121122503.195129232@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 3f1bb6abdf19cfa89860b3bc9e7f31b44b6a0ba1 upstream.

Use the new of_get_compatible_child() helper to look up child nodes to
avoid ever matching non-child nodes elsewhere in the tree.

Also fix up the related struct device_node leaks.

Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
Cc: stable <stable@vger.kernel.org>     # 4.19: 36156f9241cb0
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/dsa/realtek-smi.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/net/dsa/realtek-smi.c
+++ b/drivers/net/dsa/realtek-smi.c
@@ -347,16 +347,17 @@ int realtek_smi_setup_mdio(struct realte
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
@@ -371,10 +372,15 @@ int realtek_smi_setup_mdio(struct realte
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
@@ -457,6 +463,8 @@ static int realtek_smi_remove(struct pla
 	struct realtek_smi *smi = dev_get_drvdata(&pdev->dev);
 
 	dsa_unregister_switch(smi->ds);
+	if (smi->slave_mii_bus)
+		of_node_put(smi->slave_mii_bus->dev.of_node);
 	gpiod_set_value(smi->reset, 1);
 
 	return 0;


