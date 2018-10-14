Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C99C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F320876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342F320876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJNXLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35951 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cm-SN; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000mg-Ix; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Felipe Balbi" <balbi@ti.com>,
        "Brian Hutchinson" <b.hutchman@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Mark A. Greer" <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.42793464@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 363/366] net: davinci_emac: Fix runtime pm calls for
 davinci_emac
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

From: Tony Lindgren <tony@atomide.com>

commit b5133e7a988b2cf8e1cd2b23231f36aff35ceffc upstream.

Commit 3ba97381343b ("net: ethernet: davinci_emac: add pm_runtime support")
added support for runtime PM, but it causes issues on omap3 related devices
that actually gate the clocks:

Unhandled fault: external abort on non-linefetch (0x1008)
...
[<c04160f0>] (emac_dev_getnetstats) from [<c04d6a3c>] (dev_get_stats+0x78/0xc8)
[<c04d6a3c>] (dev_get_stats) from [<c04e9ccc>] (rtnl_fill_ifinfo+0x3b8/0x938)
[<c04e9ccc>] (rtnl_fill_ifinfo) from [<c04eade4>] (rtmsg_ifinfo+0x68/0xd8)
[<c04eade4>] (rtmsg_ifinfo) from [<c04dd35c>] (register_netdevice+0x3a0/0x4ec)
[<c04dd35c>] (register_netdevice) from [<c04dd4bc>] (register_netdev+0x14/0x24)
[<c04dd4bc>] (register_netdev) from [<c041755c>] (davinci_emac_probe+0x408/0x5c8)
[<c041755c>] (davinci_emac_probe) from [<c0396d78>] (platform_drv_probe+0x48/0xa4)

Let's fix it by moving the pm_runtime_get() call earlier, and also add it to
the emac_dev_getnetstats(). Also note that we want to use pm_runtime_get_sync()
as we don't want to have deferred_resume happen. And let's also check the
return value for pm_runtime_get_sync() as noted by Felipe Balbi <balbi@ti.com>.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Acked-by: Mark A. Greer <mgreer@animalcreek.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/ti/davinci_emac.c | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1537,7 +1537,13 @@ static int emac_dev_open(struct net_devi
 	int i = 0;
 	struct emac_priv *priv = netdev_priv(ndev);
 
-	pm_runtime_get(&priv->pdev->dev);
+	ret = pm_runtime_get_sync(&priv->pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&priv->pdev->dev);
+		dev_err(&priv->pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, ret);
+		return ret;
+	}
 
 	netif_carrier_off(ndev);
 	for (cnt = 0; cnt < ETH_ALEN; cnt++)
@@ -1724,6 +1730,15 @@ static struct net_device_stats *emac_dev
 	struct emac_priv *priv = netdev_priv(ndev);
 	u32 mac_control;
 	u32 stats_clear_mask;
+	int err;
+
+	err = pm_runtime_get_sync(&priv->pdev->dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(&priv->pdev->dev);
+		dev_err(&priv->pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, err);
+		return &ndev->stats;
+	}
 
 	/* update emac hardware stats and reset the registers*/
 
@@ -1766,6 +1781,8 @@ static struct net_device_stats *emac_dev
 	ndev->stats.tx_fifo_errors += emac_read(EMAC_TXUNDERRUN);
 	emac_write(EMAC_TXUNDERRUN, stats_clear_mask);
 
+	pm_runtime_put(&priv->pdev->dev);
+
 	return &ndev->stats;
 }
 
@@ -1985,12 +2002,22 @@ static int davinci_emac_probe(struct pla
 	ndev->ethtool_ops = &ethtool_ops;
 	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
 
+	pm_runtime_enable(&pdev->dev);
+	rc = pm_runtime_get_sync(&pdev->dev);
+	if (rc < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		dev_err(&pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, rc);
+		goto no_cpdma_chan;
+	}
+
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	rc = register_netdev(ndev);
 	if (rc) {
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc = -ENODEV;
+		pm_runtime_put(&pdev->dev);
 		goto no_cpdma_chan;
 	}
 
@@ -2000,9 +2027,7 @@ static int davinci_emac_probe(struct pla
 			   "(regs: %p, irq: %d)\n",
 			   (void *)priv->emac_base_phys, ndev->irq);
 	}
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 

