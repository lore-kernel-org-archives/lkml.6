Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F2BC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D7E2148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549075906;
	bh=Ao+ZsxowcpOSrEdM/grfWlnmP4tse0OKNF5E3RxZOo0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LyotCiFb2dM74WpM62xBDiXsVZXcddmMlHM5rweQHmEAB5VB+KvdYw8BD0q1Oj8lR
	 XdCB9QGDwCJZ9Ak8vvgFt69+oG2M0E9YiWBvx2aqoUqNNnoKBl4O8BA77P2Oz3xANr
	 foEaewNZ9RTh27BF8CwQJKGOs/BiKbOGPEwWETQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfBBCvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:51:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46111 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfBBCvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:51:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so7449921oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1bWMrev5g6V586Ur2U7l6ZK7gaeyNHR6dFOMXgg8r4=;
        b=WsNhvtGJgVhEwH0W9x+vht1CdtzlwixAR8xwgJtKIL3QPc/XO47BbJHoh1cXHcPAAV
         0DGb0exDXPqFOhun/rYx1rRx31YLWA2y+One1nnsDYYT/n/zOa/5MWBLiBe/uKQqkKNW
         6qGGF0uyboebv/NRFdCsdm36dbyRY2nCP3jRWQq0/Vk0nldxuW8dSl9WvYm0Ldrl3DdA
         8Q4+Z1HigcM4kpbnLi2NvDOk+zQAxEhgrUohXgk++9XJtuyvpO/LxDO2TPp42iGkBg4L
         WFhnYXVKywp0DSaG6MKVkz8ZMTJv02watFDHdrpB61+Kl5wJUHeetzoZ0/aSGVWpGhrd
         JSMA==
X-Gm-Message-State: AHQUAuaEprWdSWEoBvo9Y7eUkqIFRRpYonEYUjF2blKjEGUxEmLTxkEE
        L4qfL0PuztnaOKREawrS9plxUF59qdo=
X-Google-Smtp-Source: AHgI3IZKjtUcpxODLANRV0Y3swqPjYp7fi2B/XTup8adHxCG+Zy42yiIsmjol8LHQSm1mcaOuUJFOA==
X-Received: by 2002:aca:d78b:: with SMTP id o133mr19274496oig.232.1549075903110;
        Fri, 01 Feb 2019 18:51:43 -0800 (PST)
Received: from localhost ([130.164.62.201])
        by smtp.gmail.com with ESMTPSA id a201sm4443062oii.27.2019.02.01.18.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 18:51:42 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        davem@davemloft.net, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>
Subject: [net-next RFC/PATCH] net: nixge: Make mdio child node optional
Date:   Fri,  1 Feb 2019 18:50:48 -0800
Message-Id: <20190202025048.14772-1-mdf@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make MDIO child optional and only instantiate the
MDIO bus if the child is actually present.

There are currently no (in-tree) users of this
binding; all (out-of-tree) users use overlays that
get shipped together with the FPGA images that contain
the IP.

This will significantly increase maintainabilty
of future revisions of this IP.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>
---

Hi Rob, Andrew,

I know generally changing bindings is a no-no. Ultimately
I'm working on adding fixed-link support to this driver,
during the review of that Andrew suggested to drop the wrong
binding if I don't need legacy behavior.

In my case I can pretty much guarantee there's no users,
even out of tree due to how we ship the software with our
devices (overlays & fpga images always go together).

I think in the long this change will make the code easier to
maintain and allow to easier support the different variants.

Thanks,

Moritz

---
 .../devicetree/bindings/net/nixge.txt         | 27 ++++++++++++++++---
 drivers/net/ethernet/ni/nixge.c               | 19 ++++++++-----
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
index e55af7f0881a..5a0072b69ce7 100644
--- a/Documentation/devicetree/bindings/net/nixge.txt
+++ b/Documentation/devicetree/bindings/net/nixge.txt
@@ -10,6 +10,9 @@ Required properties:
 - nvmem-cells: Phandle of nvmem cell containing the MAC address
 - nvmem-cell-names: Should be "address"
 
+Optional properties:
+- mdio subnode to indicate presence of MDIO controller
+
 Examples (10G generic PHY):
 	nixge0: ethernet@40000000 {
 		compatible = "ni,xge-enet-2.00";
@@ -25,8 +28,26 @@ Examples (10G generic PHY):
 		phy-mode = "xgmii";
 		phy-handle = <&ethernet_phy1>;
 
-		ethernet_phy1: ethernet-phy@4 {
-			compatible = "ethernet-phy-ieee802.3-c45";
-			reg = <4>;
+		mdio {
+			ethernet_phy1: ethernet-phy@4 {
+				compatible = "ethernet-phy-ieee802.3-c45";
+				reg = <4>;
+			};
 		};
 	};
+
+Examples (10G generic PHY, no MDIO):
+	nixge0: ethernet@40000000 {
+		compatible = "ni,xge-enet-2.00";
+		reg = <0x40000000 0x6000>;
+
+		nvmem-cells = <&eth1_addr>;
+		nvmem-cell-names = "address";
+
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rx", "tx";
+		interrupt-parent = <&intc>;
+
+		phy-mode = "xgmii";
+		phy-handle = <&ethernet_phy1>;
+	};
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 1e408d1a9b5f..93d5263cc57e 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1230,6 +1230,7 @@ static int nixge_probe(struct platform_device *pdev)
 	struct nixge_priv *priv;
 	struct net_device *ndev;
 	struct resource *dmares;
+	struct device_node *mn;
 	const u8 *mac_addr;
 	int err;
 
@@ -1286,10 +1287,14 @@ static int nixge_probe(struct platform_device *pdev)
 	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
-	err = nixge_mdio_setup(priv, pdev->dev.of_node);
-	if (err) {
-		netdev_err(ndev, "error registering mdio bus");
-		goto free_netdev;
+	mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
+	if (mn) {
+		err = nixge_mdio_setup(priv, mn);
+		of_node_put(mn);
+		if (err) {
+			netdev_err(ndev, "error registering mdio bus");
+			goto free_netdev;
+		}
 	}
 
 	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
@@ -1315,7 +1320,8 @@ static int nixge_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_mdio:
-	mdiobus_unregister(priv->mii_bus);
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
 
 free_netdev:
 	free_netdev(ndev);
@@ -1330,7 +1336,8 @@ static int nixge_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
-	mdiobus_unregister(priv->mii_bus);
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
 
 	free_netdev(ndev);
 
-- 
2.20.1

