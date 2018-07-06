Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E301CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB1E23FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB1E23FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbeGFNUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:20:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57299 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933102AbeGFNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:20:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 302CA20875; Fri,  6 Jul 2018 15:20:00 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0216620734;
        Fri,  6 Jul 2018 15:19:49 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 1/6] net: mvneta: remove data pointer usage from device_node structure
Date:   Fri,  6 Jul 2018 15:19:44 +0200
Message-Id: <20180706131949.2684-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706131949.2684-1-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On year ago Rob Herring wanted to remove the data pointer from the
device_node structure[1]. The mvneta driver seemed to be the only one
which used (abused ?) it. However, the proposal of Rob to remove this
pointer from the driver introduced a regression, and I tested and fixed an
alternative way, but it was never submitted as a proper patch.

Now here it is: Instead of using the device_node structure ->data
pointer, we store the BM private data as the driver data of the BM
platform_device. The core mvneta code can retrieve it by doing a lookup
on which platform_device corresponds to the BM device tree node using
of_find_device_by_node(), and get its driver data

[1]https://www.spinics.net/lists/netdev/msg445197.html

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c    | 18 ++++++++++++------
 drivers/net/ethernet/marvell/mvneta_bm.c | 13 +++++++++++++
 drivers/net/ethernet/marvell/mvneta_bm.h |  5 +++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0ad2f3f7da85..26d68add184f 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4460,12 +4460,16 @@ static int mvneta_probe(struct platform_device *pdev)
 
 	/* Obtain access to BM resources if enabled and already initialized */
 	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
-	if (bm_node && bm_node->data) {
-		pp->bm_priv = bm_node->data;
-		err = mvneta_bm_port_init(pdev, pp);
-		if (err < 0) {
-			dev_info(&pdev->dev, "use SW buffer management\n");
-			pp->bm_priv = NULL;
+	if (bm_node) {
+		pp->bm_priv = mvneta_bm_get(bm_node);
+		if (pp->bm_priv) {
+			err = mvneta_bm_port_init(pdev, pp);
+			if (err < 0) {
+				dev_info(&pdev->dev,
+					 "use SW buffer management\n");
+				mvneta_bm_put(pp->bm_priv);
+				pp->bm_priv = NULL;
+			}
 		}
 	}
 	of_node_put(bm_node);
@@ -4526,6 +4530,7 @@ static int mvneta_probe(struct platform_device *pdev)
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_long, 1 << pp->id);
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_short,
 				       1 << pp->id);
+		mvneta_bm_put(pp->bm_priv);
 	}
 err_free_stats:
 	free_percpu(pp->stats);
@@ -4563,6 +4568,7 @@ static int mvneta_remove(struct platform_device *pdev)
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_long, 1 << pp->id);
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_short,
 				       1 << pp->id);
+		mvneta_bm_put(pp->bm_priv);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 466939f8f0cf..01e3152e76c8 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <net/hwbm.h>
@@ -392,6 +393,18 @@ static void mvneta_bm_put_sram(struct mvneta_bm *priv)
 		      MVNETA_BM_BPPI_SIZE);
 }
 
+struct mvneta_bm *mvneta_bm_get(struct device_node *node)
+{
+	struct platform_device *pdev = of_find_device_by_node(node);
+
+	return pdev ? platform_get_drvdata(pdev) : NULL;
+}
+
+void mvneta_bm_put(struct mvneta_bm *priv)
+{
+	platform_device_put(priv->pdev);
+}
+
 static int mvneta_bm_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.h b/drivers/net/ethernet/marvell/mvneta_bm.h
index a32de432800c..9358626e51ec 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.h
+++ b/drivers/net/ethernet/marvell/mvneta_bm.h
@@ -134,6 +134,9 @@ void *mvneta_frag_alloc(unsigned int frag_size);
 void mvneta_frag_free(unsigned int frag_size, void *data);
 
 #if IS_ENABLED(CONFIG_MVNETA_BM)
+struct mvneta_bm *mvneta_bm_get(struct device_node *node);
+void mvneta_bm_put(struct mvneta_bm *priv);
+
 void mvneta_bm_pool_destroy(struct mvneta_bm *priv,
 			    struct mvneta_bm_pool *bm_pool, u8 port_map);
 void mvneta_bm_bufs_free(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
@@ -178,5 +181,7 @@ static inline void mvneta_bm_pool_put_bp(struct mvneta_bm *priv,
 static inline u32 mvneta_bm_pool_get_bp(struct mvneta_bm *priv,
 					struct mvneta_bm_pool *bm_pool)
 { return 0; }
+struct mvneta_bm *mvneta_bm_get(struct device_node *node) { return NULL; }
+void mvneta_bm_put(struct mvneta_bm *priv) {}
 #endif /* CONFIG_MVNETA_BM */
 #endif
-- 
2.17.1

