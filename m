Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE86C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD43213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD43213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbeGLMEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58016 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbeGLMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B7C0C2074F; Thu, 12 Jul 2018 13:54:54 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6D521206A6;
        Thu, 12 Jul 2018 13:54:54 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 12/18] net: mvpp2: improve the distribution of packets on CPUs when using RSS
Date:   Thu, 12 Jul 2018 13:54:21 +0200
Message-Id: <20180712115427.27375-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

This patch adds an extra indirection when setting the indirection table
into the RSS hardware table to improve the packets distribution across
CPUs. For example, if 2 queues are used on a multi-core system this new
indirection will choose two queues on two different CPUs instead of the
two first queues which are on the same first CPU.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index c80a1a549224..7dafc8c425b8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -107,6 +107,19 @@ void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
 	mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
 }
 
+static inline u32 mvpp22_rxfh_indir(struct mvpp2_port *port, u32 rxq)
+{
+	int nrxqs, cpus = num_possible_cpus();
+
+	/* Number of RXQs per CPU */
+	nrxqs = port->nrxqs / cpus;
+
+	/* Indirection to better distribute the paquets on the CPUs when
+	 * configuring the RSS queues.
+	 */
+	return port->first_rxq + ((rxq * nrxqs + rxq / cpus) % port->nrxqs);
+}
+
 void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table)
 {
 	struct mvpp2 *priv = port->priv;
@@ -117,7 +130,8 @@ void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table)
 			  MVPP22_RSS_INDEX_TABLE_ENTRY(i);
 		mvpp2_write(priv, MVPP22_RSS_INDEX, sel);
 
-		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY, port->indir[i]);
+		mvpp2_write(priv, MVPP22_RSS_TABLE_ENTRY,
+			    mvpp22_rxfh_indir(port, port->indir[i]));
 	}
 }
 
-- 
2.11.0

