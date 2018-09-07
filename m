Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACBC20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACBC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeIGRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45539 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbeIGRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007br-FK; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00061u-Cg; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 06/25] ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
Date:   Fri,  7 Sep 2018 14:36:27 +0200
Message-Id: <20180907123646.12688-7-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907123646.12688-1-s.hauer@pengutronix.de>
References: <20180907123646.12688-1-s.hauer@pengutronix.de>
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
index ed0c67fe7500..5f57af224b8f 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1480,27 +1480,11 @@ struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
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
+	pnode = ubifs_pnode_lookup(c, i >> UBIFS_LPT_FANOUT_SHIFT);
 	if (IS_ERR(pnode))
 		return ERR_CAST(pnode);
 	iip = (i & (UBIFS_LPT_FANOUT - 1));
-- 
2.18.0

