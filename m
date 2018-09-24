Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921320989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7921320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeIXPMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56026 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbeIXPMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1F8A820731; Mon, 24 Sep 2018 11:11:09 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8D6F20618;
        Mon, 24 Sep 2018 11:11:08 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 1/2] net: mvpp2: support XPS by mapping TX queues to CPUs
Date:   Mon, 24 Sep 2018 11:11:05 +0200
Message-Id: <20180924091106.15094-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924091106.15094-1-maxime.chevallier@bootlin.com>
References: <20180924091106.15094-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PPv2 controller has multiple TX queues, we can spread traffic
by assining TX queues to CPUs, allowing to use XPS to balance egress
traffic between CPUs.

Suggested-by : Yan Markman <ymarkman@marvell.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d30ccc515bb7..bdacb9577216 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2423,13 +2423,17 @@ static int mvpp2_setup_rxqs(struct mvpp2_port *port)
 static int mvpp2_setup_txqs(struct mvpp2_port *port)
 {
 	struct mvpp2_tx_queue *txq;
-	int queue, err;
+	int queue, err, cpu;
 
 	for (queue = 0; queue < port->ntxqs; queue++) {
 		txq = port->txqs[queue];
 		err = mvpp2_txq_init(port, txq);
 		if (err)
 			goto err_cleanup;
+
+		/* Assign this queue to a CPU */
+		cpu = queue % num_present_cpus();
+		netif_set_xps_queue(port->dev, cpumask_of(cpu), queue);
 	}
 
 	if (port->has_tx_irqs) {
-- 
2.11.0

