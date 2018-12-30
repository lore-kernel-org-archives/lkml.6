Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C827C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CC720836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeL3Tox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:44:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbeL3Tox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:44:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDA13AE1D;
        Sun, 30 Dec 2018 19:44:51 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Whitten <ben.whitten@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH lora-next] net: lora: sx1301: Fix clk32m handling
Date:   Sun, 30 Dec 2018 20:44:44 +0100
Message-Id: <20181230194444.11970-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
References: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't get the clk32m during probe because the radio is not yet probed then.
When doing it during netdev open we also need to undo that during netdev stop.
Revamp the error handling for open and tidy our debug output while at it.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx1301.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 23cbddc364e5..533fd37c350d 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -379,58 +379,73 @@ static int sx130x_loradev_open(struct net_device *netdev)
 		return -ENXIO;
 	}
 
-	priv->clk32m = devm_clk_get(priv->dev, "clk32m");
+	priv->clk32m = clk_get(priv->dev, "clk32m");
 	if (IS_ERR(priv->clk32m)) {
-		dev_err(priv->dev, "failed to get clk32m\n");
+		dev_err(priv->dev, "failed to get clk32m (%ld)\n", PTR_ERR(priv->clk32m));
 		return PTR_ERR(priv->clk32m);
 	}
 
 	ret = clk_prepare_enable(priv->clk32m);
 	if (ret) {
-		dev_err(priv->dev, "failed to enable clk32m: %d\n", ret);
-		return ret;
+		dev_err(priv->dev, "failed to enable clk32m (%d)\n", ret);
+		goto err_clk_enable;
 	}
 
 	ret = sx1301_field_write(priv, F_GLOBAL_EN, 1);
 	if (ret) {
-		dev_err(priv->dev, "enable global clocks failed\n");
-		return ret;
+		dev_err(priv->dev, "enable global clocks failed (%d)\n", ret);
+		goto err_reg;
 	}
 
 	ret = sx1301_field_write(priv, F_CLK32M_EN, 1);
 	if (ret) {
-		dev_err(priv->dev, "enable 32M clock failed\n");
-		return ret;
+		dev_err(priv->dev, "enable 32M clock failed (%d)\n", ret);
+		goto err_reg;
 	}
 
 	/* calibration */
 
 	ret = sx1301_agc_calibrate(priv);
 	if (ret)
-		return ret;
+		goto err_calibrate;
 
 	/* TODO */
 
 	ret = sx1301_load_all_firmware(priv);
 	if (ret)
-		return ret;
+		goto err_firmware;
 
 	ret = open_loradev(netdev);
 	if (ret)
-		return ret;
+		goto err_open;
 
 	netif_start_queue(netdev);
 
 	return 0;
+
+err_open:
+err_firmware:
+err_calibrate:
+err_reg:
+	clk_disable_unprepare(priv->clk32m);
+err_clk_enable:
+	clk_put(priv->clk32m);
+	return ret;
 }
 
 static int sx130x_loradev_stop(struct net_device *netdev)
 {
+	struct sx1301_priv *priv = netdev_priv(netdev);
+
 	netdev_dbg(netdev, "%s", __func__);
 
 	netif_stop_queue(netdev);
 	close_loradev(netdev);
 
+	clk_disable_unprepare(priv->clk32m);
+	clk_put(priv->clk32m);
+	priv->clk32m = NULL;
+
 	return 0;
 }
 
-- 
2.16.4

