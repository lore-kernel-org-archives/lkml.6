Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB07ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B7620645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B7620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeISPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43224 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbeISPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B1D8320798; Wed, 19 Sep 2018 11:30:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D927207D4;
        Wed, 19 Sep 2018 11:30:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 04/12] net: mvpp2: do not update the queue mode while probing
Date:   Wed, 19 Sep 2018 11:27:03 +0200
Message-Id: <20180919092711.22296-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the probing function so that the queue mode isn't
updated while probing, as the driver would silently end up using a
configuration not wanted by the user. The patch adds an extra check to
validate the chosen queue mode instead, and the driver will fail to
probe if the configuration is invalid.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 69ab80911756..546328041898 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4243,6 +4243,10 @@ static bool mvpp2_port_has_irqs(struct mvpp2 *priv,
 	char name[5];
 	int i;
 
+	/* ACPI */
+	if (!port_node)
+		return true;
+
 	if (priv->hw_version == MVPP21)
 		return false;
 
@@ -4637,16 +4641,13 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	int phy_mode;
 	int err, i, cpu;
 
-	if (port_node) {
-		has_tx_irqs = mvpp2_port_has_irqs(priv, port_node, &flags);
-	} else {
-		has_tx_irqs = true;
-		queue_mode = MVPP2_QDIST_MULTI_MODE;
+	has_tx_irqs = mvpp2_port_has_irqs(priv, port_node, &flags);
+	if (!has_tx_irqs && queue_mode == MVPP2_QDIST_MULTI_MODE) {
+		dev_err(&pdev->dev,
+			"not enough IRQs to support multi queue mode\n");
+		return -EINVAL;
 	}
 
-	if (!has_tx_irqs)
-		queue_mode = MVPP2_QDIST_SINGLE_MODE;
-
 	ntxqs = MVPP2_MAX_TXQ;
 	if (priv->hw_version == MVPP22 && queue_mode == MVPP2_QDIST_MULTI_MODE)
 		nrxqs = MVPP2_DEFAULT_RXQ * num_possible_cpus();
-- 
2.17.1

