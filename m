Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D79C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4F227365
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4F227365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965692AbeF1MnV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:43:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46882 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965482AbeF1Mmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:42:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 202C920DCD; Thu, 28 Jun 2018 14:42:51 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id BFD7820A33;
        Thu, 28 Jun 2018 14:42:40 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 3/4] net: mvpp2: prs: Drop unnecessary swab16 in vlan detection
Date:   Thu, 28 Jun 2018 14:42:06 +0200
Message-Id: <20180628124207.11635-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
References: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlan IDs must not be swapped when creating Header Parser entries. This
has no effect on little-endian systems, but is wrong for big-endian.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index af11feea681c..a882c14d7d77 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -647,7 +647,7 @@ static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, int ai)
 			continue;
 
 		mvpp2_prs_init_from_hw(priv, &pe, tid);
-		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid));
+		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid);
 		if (!match)
 			continue;
 
@@ -775,8 +775,8 @@ static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
 
 		mvpp2_prs_init_from_hw(priv, &pe, tid);
 
-		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid1)) &&
-			mvpp2_prs_tcam_data_cmp(&pe, 4, swab16(tpid2));
+		match = mvpp2_prs_tcam_data_cmp(&pe, 0, tpid1) &&
+			mvpp2_prs_tcam_data_cmp(&pe, 4, tpid2);
 
 		if (!match)
 			continue;
-- 
2.11.0

