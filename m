Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE265C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3120989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F3120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeIXPMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56029 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbeIXPMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C08F207CA; Mon, 24 Sep 2018 11:11:10 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id ABAE820618;
        Mon, 24 Sep 2018 11:11:09 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 2/2] net: mvpp2: use round-robin scheduling for TX queues on the same CPU
Date:   Mon, 24 Sep 2018 11:11:06 +0200
Message-Id: <20180924091106.15094-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924091106.15094-1-maxime.chevallier@bootlin.com>
References: <20180924091106.15094-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows each TXQ to be picked in a round-robin fashion by
the PPv2 transmit scheduling mechanism. This is opposed to the default
behaviour that prioritizes the highest numbered queues.

Suggested-by: Yan Markman <ymarkman@marvell.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index f5dceef60b0e..176c6b56fdcc 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -331,6 +331,7 @@
 #define     MVPP2_TXP_SCHED_ENQ_MASK		0xff
 #define     MVPP2_TXP_SCHED_DISQ_OFFSET		8
 #define MVPP2_TXP_SCHED_CMD_1_REG		0x8010
+#define MVPP2_TXP_SCHED_FIXED_PRIO_REG		0x8014
 #define MVPP2_TXP_SCHED_PERIOD_REG		0x8018
 #define MVPP2_TXP_SCHED_MTU_REG			0x801c
 #define     MVPP2_TXP_MTU_MAX			0x7FFFF
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index bdacb9577216..c2ed71788e4f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1448,6 +1448,9 @@ static void mvpp2_defaults_set(struct mvpp2_port *port)
 		    tx_port_num);
 	mvpp2_write(port->priv, MVPP2_TXP_SCHED_CMD_1_REG, 0);
 
+	/* Set TXQ scheduling to Round-Robin */
+	mvpp2_write(port->priv, MVPP2_TXP_SCHED_FIXED_PRIO_REG, 0);
+
 	/* Close bandwidth for all queues */
 	for (queue = 0; queue < MVPP2_MAX_TXQ; queue++) {
 		ptxq = mvpp2_txq_phys(port->id, queue);
-- 
2.11.0

