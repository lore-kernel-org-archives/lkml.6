Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34F820854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34F820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeGRQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60397 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbeGRQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8495220884; Wed, 18 Jul 2018 18:11:09 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5E1F420741;
        Wed, 18 Jul 2018 18:11:09 +0200 (CEST)
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
Subject: [PATCH net-next v3 2/8] net: mvneta: fix mtu change on port without link
Date:   Wed, 18 Jul 2018 18:10:51 +0200
Message-Id: <20180718161057.28704-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

It is incorrect to enable TX/RX queues (call by mvneta_port_up()) for
port without link. Indeed MTU change for interface without link causes TX
queues to stuck.

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory.clement: adding Fixes tags and rewording commit log]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index ec84db47d82d..3d1f4335b0d3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3196,7 +3196,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 
 	on_each_cpu(mvneta_percpu_enable, pp, true);
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
 
 	netdev_update_features(dev);
 
-- 
2.18.0

