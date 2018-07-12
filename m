Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF08213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF08213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeGLMEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:04:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58001 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732247AbeGLMEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:04:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B7C5D20731; Thu, 12 Jul 2018 13:54:55 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6D1BC206A6;
        Thu, 12 Jul 2018 13:54:55 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 13/18] net: mvpp2: make sure we don't spread load on disabled CPUs
Date:   Thu, 12 Jul 2018 13:54:22 +0200
Message-Id: <20180712115427.27375-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When filling the RSS table, we have to make sure that the rx queue is
attached to an online CPU.

This patch is not a full support for cpu_hotplug, but rather a way to
make sure that we don't break network on system booted with the maxcpus
parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 7dafc8c425b8..f2bcfa8f1dfd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -109,11 +109,17 @@ void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
 
 static inline u32 mvpp22_rxfh_indir(struct mvpp2_port *port, u32 rxq)
 {
-	int nrxqs, cpus = num_possible_cpus();
+	int nrxqs, cpu, cpus = num_possible_cpus();
 
 	/* Number of RXQs per CPU */
 	nrxqs = port->nrxqs / cpus;
 
+	/* CPU that will handle this rx queue */
+	cpu = rxq / nrxqs;
+
+	if (!cpu_online(cpu))
+		return port->first_rxq;
+
 	/* Indirection to better distribute the paquets on the CPUs when
 	 * configuring the RSS queues.
 	 */
-- 
2.11.0

