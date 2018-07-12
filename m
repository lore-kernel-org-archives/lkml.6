Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14419213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14419213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbeGLMEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbeGLMEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B875020741; Thu, 12 Jul 2018 13:54:56 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6D582206A6;
        Thu, 12 Jul 2018 13:54:56 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 14/18] net: mvpp2: rename per-port RSS init function
Date:   Thu, 12 Jul 2018 13:54:23 +0200
Message-Id: <20180712115427.27375-15-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mvpp22_init_rss function configures the RSS parameters for each port, so
rename it accordingly. Since this function relies on classifier
configuration, move its call right after the classifier config.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index f2bcfa8f1dfd..66160b9b8a9a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -141,7 +141,7 @@ void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table)
 	}
 }
 
-void mvpp22_init_rss(struct mvpp2_port *port)
+void mvpp22_rss_port_init(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
 	int i;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 4c7be7469a92..38a8cf1172df 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -34,7 +34,7 @@ struct mvpp2_cls_lookup_entry {
 
 void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table);
 
-void mvpp22_init_rss(struct mvpp2_port *port);
+void mvpp22_rss_port_init(struct mvpp2_port *port);
 
 void mvpp2_cls_init(struct mvpp2 *priv);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f0b5fb78cd67..93e37d20899d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3373,9 +3373,6 @@ static int mvpp2_open(struct net_device *dev)
 
 	mvpp2_start_dev(port);
 
-	if (mvpp22_rss_is_supported())
-		mvpp22_init_rss(port);
-
 	/* Start hardware statistics gathering */
 	queue_delayed_work(priv->stats_queue, &port->stats_work,
 			   MVPP2_MIB_COUNTERS_STATS_DELAY);
@@ -4153,6 +4150,9 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	mvpp2_cls_oversize_rxq_set(port);
 	mvpp2_cls_port_config(port);
 
+	if (mvpp22_rss_is_supported())
+		mvpp22_rss_port_init(port);
+
 	/* Provide an initial Rx packet size */
 	port->pkt_size = MVPP2_RX_PKT_SIZE(port->dev->mtu);
 
-- 
2.11.0

