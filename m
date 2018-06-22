Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5BB23FDB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5BB23FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeFVJza (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:55:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47501 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbeFVJzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:55:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B7894206FF; Fri, 22 Jun 2018 11:55:10 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8015920A4A;
        Fri, 22 Jun 2018 11:55:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, f.fainelli@gmail.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: [PATCH net] net: mscc: make sparse happy
Date:   Fri, 22 Jun 2018 11:50:52 +0200
Message-Id: <20180622095052.26726-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a sparse warning about using an incorrect type in
argument 2 of ocelot_write_rix(), as an u32 was expected but a __be32
was given. The conversion to u32 is forced, which is safe as the value
will be written as-is in the hardware without any modification.

Fixes: 08d02364b12f ("net: mscc: fix the injection header")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 52c57e0ff617..776a8a9be8e3 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -374,7 +374,8 @@ static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 	ocelot_gen_ifh(ifh, &info);
 
 	for (i = 0; i < IFH_LEN; i++)
-		ocelot_write_rix(ocelot, cpu_to_be32(ifh[i]), QS_INJ_WR, grp);
+		ocelot_write_rix(ocelot, (__force u32)cpu_to_be32(ifh[i]),
+				 QS_INJ_WR, grp);
 
 	count = (skb->len + 3) / 4;
 	last = skb->len % 4;
-- 
2.17.1

