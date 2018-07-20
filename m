Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C0EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B00206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B00206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbeGTNYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:24:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388378AbeGTNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:24:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67C7AC84;
        Fri, 20 Jul 2018 12:33:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 09/92] bcm63xx_enet: correct clock usage
Date:   Fri, 20 Jul 2018 14:13:13 +0200
Message-Id: <20180720121417.793949160@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 9c86b846ce02f7e35d7234cf090b80553eba5389 upstream.

Check the return code of prepare_enable and change one last instance of
enable only to prepare_enable. Also properly disable and release the
clock in error paths and on remove for enetsw.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c |   31 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1773,7 +1773,9 @@ static int bcm_enet_probe(struct platfor
 		ret = PTR_ERR(priv->mac_clk);
 		goto out;
 	}
-	clk_prepare_enable(priv->mac_clk);
+	ret = clk_prepare_enable(priv->mac_clk);
+	if (ret)
+		goto out_put_clk_mac;
 
 	/* initialize default and fetch platform data */
 	priv->rx_ring_size = BCMENET_DEF_RX_DESC;
@@ -1805,9 +1807,11 @@ static int bcm_enet_probe(struct platfor
 		if (IS_ERR(priv->phy_clk)) {
 			ret = PTR_ERR(priv->phy_clk);
 			priv->phy_clk = NULL;
-			goto out_put_clk_mac;
+			goto out_disable_clk_mac;
 		}
-		clk_prepare_enable(priv->phy_clk);
+		ret = clk_prepare_enable(priv->phy_clk);
+		if (ret)
+			goto out_put_clk_phy;
 	}
 
 	/* do minimal hardware init to be able to probe mii bus */
@@ -1901,13 +1905,16 @@ out_free_mdio:
 out_uninit_hw:
 	/* turn off mdc clock */
 	enet_writel(priv, 0, ENET_MIISC_REG);
-	if (priv->phy_clk) {
+	if (priv->phy_clk)
 		clk_disable_unprepare(priv->phy_clk);
+
+out_put_clk_phy:
+	if (priv->phy_clk)
 		clk_put(priv->phy_clk);
-	}
 
-out_put_clk_mac:
+out_disable_clk_mac:
 	clk_disable_unprepare(priv->mac_clk);
+out_put_clk_mac:
 	clk_put(priv->mac_clk);
 out:
 	free_netdev(dev);
@@ -2752,7 +2759,9 @@ static int bcm_enetsw_probe(struct platf
 		ret = PTR_ERR(priv->mac_clk);
 		goto out_unmap;
 	}
-	clk_enable(priv->mac_clk);
+	ret = clk_prepare_enable(priv->mac_clk);
+	if (ret)
+		goto out_put_clk;
 
 	priv->rx_chan = 0;
 	priv->tx_chan = 1;
@@ -2773,7 +2782,7 @@ static int bcm_enetsw_probe(struct platf
 
 	ret = register_netdev(dev);
 	if (ret)
-		goto out_put_clk;
+		goto out_disable_clk;
 
 	netif_carrier_off(dev);
 	platform_set_drvdata(pdev, dev);
@@ -2782,6 +2791,9 @@ static int bcm_enetsw_probe(struct platf
 
 	return 0;
 
+out_disable_clk:
+	clk_disable_unprepare(priv->mac_clk);
+
 out_put_clk:
 	clk_put(priv->mac_clk);
 
@@ -2813,6 +2825,9 @@ static int bcm_enetsw_remove(struct plat
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
+	clk_disable_unprepare(priv->mac_clk);
+	clk_put(priv->mac_clk);
+
 	free_netdev(dev);
 	return 0;
 }


