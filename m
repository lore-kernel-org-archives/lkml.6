Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01454C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C302213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C302213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeGLMEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58001 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732249AbeGLMEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C7CFF20741; Thu, 12 Jul 2018 13:54:52 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74D7E206A6;
        Thu, 12 Jul 2018 13:54:52 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 10/18] net: mvpp2: use one RSS table per port
Date:   Thu, 12 Jul 2018 13:54:19 +0200
Message-Id: <20180712115427.27375-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPv2 Controller has 8 RSS Tables, of 32 entries each. A lookup in the
RXQ2RSS_TABLE is performed for each incoming packet, and the RSS Table
to be used is chosen according to the default rx queue that would be
used for the packet.

This default rx queue is set in the Lookup_id Table (also called
Decoding Table), and is equal to the port->first_rxq.

Since the Classifier itself isn't active at any time for the moment,
this doesn't have a direct effect, the default rx queue at the moment is
the one where all packets end-up into.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index fe4bcaf983b2..c8cf3db85ffe 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -115,23 +115,22 @@ void mvpp22_init_rss(struct mvpp2_port *port)
 	/* Set the table width: replace the whole classifier Rx queue number
 	 * with the ones configured in RSS table entries.
 	 */
-	mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_TABLE(0));
+	mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_TABLE(port->id));
 	mvpp2_write(priv, MVPP22_RSS_WIDTH, 8);
 
-	/* Loop through the classifier Rx Queues and map them to a RSS table.
-	 * Map them all to the first table (0) by default.
+	/* The default RxQ is used as a key to select the RSS table to use.
+	 * We use one RSS table per port.
 	 */
-	for (i = 0; i < MVPP2_CLS_RX_QUEUES; i++) {
-		mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_QUEUE(i));
-		mvpp2_write(priv, MVPP22_RXQ2RSS_TABLE,
-			    MVPP22_RSS_TABLE_POINTER(0));
-	}
+	mvpp2_write(priv, MVPP22_RSS_INDEX,
+		    MVPP22_RSS_INDEX_QUEUE(port->first_rxq));
+	mvpp2_write(priv, MVPP22_RXQ2RSS_TABLE,
+		    MVPP22_RSS_TABLE_POINTER(port->id));
 
 	/* Configure the first table to evenly distribute the packets across
 	 * real Rx Queues. The table entries map a hash to a port Rx Queue.
 	 */
 	for (i = 0; i < MVPP22_RSS_TABLE_ENTRIES; i++) {
-		u32 sel = MVPP22_RSS_INDEX_TABLE(0) |
+		u32 sel = MVPP22_RSS_INDEX_TABLE(port->id) |
 			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
 		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
 
-- 
2.11.0

