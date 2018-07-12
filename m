Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A2C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A971213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A971213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbeGLMEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57985 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeGLMEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AAEB20731; Thu, 12 Jul 2018 13:54:47 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3DC6D206A6;
        Thu, 12 Jul 2018 13:54:47 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 05/18] net: mvpp2: use RSS only when using multi-queue mode
Date:   Thu, 12 Jul 2018 13:54:14 +0200
Message-Id: <20180712115427.27375-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Since RSS only applies when we have per-cpu rx queues, it should only
be enabled when the driver is configured to make use of multi-queue
mode.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Maxime: Commit message]
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b1d812b12421..75aa0dece8ae 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3276,6 +3276,11 @@ static void mvpp2_irqs_deinit(struct mvpp2_port *port)
 	}
 }
 
+static bool mvpp22_rss_is_supported(void)
+{
+	return queue_mode == MVPP2_QDIST_MULTI_MODE;
+}
+
 static int mvpp2_open(struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
@@ -3368,7 +3373,7 @@ static int mvpp2_open(struct net_device *dev)
 
 	mvpp2_start_dev(port);
 
-	if (priv->hw_version == MVPP22)
+	if (mvpp22_rss_is_supported())
 		mvpp22_init_rss(port);
 
 	/* Start hardware statistics gathering */
-- 
2.11.0

