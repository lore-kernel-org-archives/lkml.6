Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBED208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBED208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934740AbeGDMm1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dN-Ep; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Yy-Ey; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/25] ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
Date:   Wed,  4 Jul 2018 14:41:17 +0200
Message-Id: <20180704124137.13396-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704124137.13396-1-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ubifs_lpt_lookup() starts by looking up the nth pnode in the LPT. We
already have this functionality in ubifs_pnode_lookup(). Use this
function rather than open coding its functionality.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/lpt.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 6cd6f23d4512..cde7b9484157 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1478,27 +1478,11 @@ struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
  */
 struct ubifs_lprops *ubifs_lpt_lookup(struct ubifs_info *c, int lnum)
 {
-	int err, i, h, iip, shft;
-	struct ubifs_nnode *nnode;
+	int i, iip;
 	struct ubifs_pnode *pnode;
 
-	if (!c->nroot) {
-		err = ubifs_read_nnode(c, NULL, 0);
-		if (err)
-			return ERR_PTR(err);
-	}
-	nnode = c->nroot;
 	i = lnum - c->main_first;
-	shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
-	for (h = 1; h < c->lpt_hght; h++) {
-		iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
-		shft -= UBIFS_LPT_FANOUT_SHIFT;
-		nnode = ubifs_get_nnode(c, nnode, iip);
-		if (IS_ERR(nnode))
-			return ERR_CAST(nnode);
-	}
-	iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
-	pnode = ubifs_get_pnode(c, nnode, iip);
+	pnode = ubifs_pnode_lookup(c, i);
 	if (IS_ERR(pnode))
 		return ERR_CAST(pnode);
 	iip = (i & (UBIFS_LPT_FANOUT - 1));
-- 
2.18.0

