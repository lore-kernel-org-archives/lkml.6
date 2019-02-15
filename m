Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568721924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395343AbfBOPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:36:18 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42201 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389964AbfBOPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:21 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B4203E0008;
        Fri, 15 Feb 2019 15:35:17 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 08/13] net: mvpp2: fix the computation of the RXQs
Date:   Fri, 15 Feb 2019 16:32:36 +0100
Message-Id: <20190215153241.6857-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215153241.6857-1-antoine.tenart@bootlin.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the computation of RXQs being used by the PPv2 driver,
which is set depending on the PPv2 engine version and the queue mode
used. There are three cases:

- PPv2.1: 1 RXQ per CPU.
- PPV2.2 with MVPP2_QDIST_MULTI_MODE: 1 RXQ per CPU.
- PPv2.2 with MVPP2_QDIST_SINGLE_MODE: 1 RXQ is shared between the CPUs.

The PPv2 engine supports a maximum of 32 queues per port. This patch
adds a check so that we do not overstep this maximum.

It appeared the calculation was broken for PPv2.1 engines since
f8c6ba8424b0, as PPv2.1 ports ended up with a single RXQ while they
needed 4. This patch fixes it.

Fixes: f8c6ba8424b0 ("net: mvpp2: use only one rx queue per port per CPU")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  4 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 23 ++++++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 83fb2b03e789..ceb3c4ad3739 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -549,8 +549,8 @@
 #define MVPP2_MAX_TSO_SEGS		300
 #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
 
-/* Default number of RXQs in use */
-#define MVPP2_DEFAULT_RXQ		1
+/* Max number of RXQs per port */
+#define MVPP2_PORT_MAX_RXQ		32
 
 /* Max number of Rx descriptors */
 #define MVPP2_MAX_RXD_MAX		1024
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f5b299656052..4a18f8e54c90 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4058,8 +4058,8 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 			snprintf(irqname, sizeof(irqname), "hif%d", i);
 
 		if (queue_mode == MVPP2_QDIST_MULTI_MODE) {
-			v->first_rxq = i * MVPP2_DEFAULT_RXQ;
-			v->nrxqs = MVPP2_DEFAULT_RXQ;
+			v->first_rxq = i;
+			v->nrxqs = 1;
 		} else if (queue_mode == MVPP2_QDIST_SINGLE_MODE &&
 			   i == (port->nqvecs - 1)) {
 			v->first_rxq = 0;
@@ -4152,8 +4152,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	    MVPP2_MAX_PORTS * priv->max_port_rxqs)
 		return -EINVAL;
 
-	if (port->nrxqs % MVPP2_DEFAULT_RXQ ||
-	    port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
+	if (port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
 		return -EINVAL;
 
 	/* Disable port */
@@ -4774,10 +4773,18 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	}
 
 	ntxqs = MVPP2_MAX_TXQ;
-	if (priv->hw_version == MVPP22 && queue_mode == MVPP2_QDIST_MULTI_MODE)
-		nrxqs = MVPP2_DEFAULT_RXQ * num_possible_cpus();
-	else
-		nrxqs = MVPP2_DEFAULT_RXQ;
+	if (priv->hw_version == MVPP22 && queue_mode == MVPP2_QDIST_SINGLE_MODE) {
+		nrxqs = 1;
+	} else {
+		/* According to the PPv2.2 datasheet and our experiments on
+		 * PPv2.1, RX queues have an allocation granularity of 4 (when
+		 * more than a single one on PPv2.2).
+		 * Round up to nearest multiple of 4.
+		 */
+		nrxqs = (num_possible_cpus() + 3) & ~0x3;
+		if (nrxqs > MVPP2_PORT_MAX_RXQ)
+			nrxqs = MVPP2_PORT_MAX_RXQ;
+	}
 
 	dev = alloc_etherdev_mqs(sizeof(*port), ntxqs, nrxqs);
 	if (!dev)
-- 
2.20.1

