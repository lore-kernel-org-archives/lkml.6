Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56579ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0CC208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0CC208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeGMPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:13:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35856 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbeGMPNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:13:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 687C9207AB; Fri, 13 Jul 2018 16:58:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3BDE320731;
        Fri, 13 Jul 2018 16:58:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, f.fainelli@gmail.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: [PATCH net-next] net: mscc: simplify retrieving the tag type from the frame header
Date:   Fri, 13 Jul 2018 16:57:57 +0200
Message-Id: <20180713145757.3574-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tag type in the frame extraction header is only a bit wide. There's
no need to use GENMASK when retrieving the information. This patch
simplify the code by dropping GENMASK and using BIT instead.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 18df7d934e81..26bb3b18f3be 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -29,7 +29,7 @@ static int ocelot_parse_ifh(u32 *ifh, struct frame_info *info)
 	info->port = (ifh[2] & GENMASK(14, 11)) >> 11;
 
 	info->cpuq = (ifh[3] & GENMASK(27, 20)) >> 20;
-	info->tag_type = (ifh[3] & GENMASK(16, 16)) >> 16;
+	info->tag_type = (ifh[3] & BIT(16)) >> 16;
 	info->vid = ifh[3] & GENMASK(11, 0);
 
 	return 0;
-- 
2.17.1

