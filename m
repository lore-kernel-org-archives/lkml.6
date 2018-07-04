Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB8C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077F208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3077F208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeGDMmk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58639 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeGDMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:28 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dL-9P; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Yq-Ds; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 03/25] ubifs: pass ubifs_zbranch to read_znode()
Date:   Wed,  4 Jul 2018 14:41:15 +0200
Message-Id: <20180704124137.13396-4-s.hauer@pengutronix.de>
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

read_znode() takes len, lnum and offs arguments which the caller all
extracts from the same struct ubifs_zbranch *. When adding authentication
support we would have to add a pointer to a hash to the arguments which
is also part of struct ubifs_zbranch. Pass the ubifs_zbranch * instead
so that we do not have to add another argument.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/tnc_misc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 93f5b7859e6f..7e18d459906c 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -259,9 +259,7 @@ long ubifs_destroy_tnc_subtree(struct ubifs_znode *znode)
 /**
  * read_znode - read an indexing node from flash and fill znode.
  * @c: UBIFS file-system description object
- * @lnum: LEB of the indexing node to read
- * @offs: node offset
- * @len: node length
+ * @zbr: the zbranch describing the node to read
  * @znode: znode to read to
  *
  * This function reads an indexing node from the flash media and fills znode
@@ -270,9 +268,12 @@ long ubifs_destroy_tnc_subtree(struct ubifs_znode *znode)
  * is wrong with it, this function prints complaint messages and returns
  * %-EINVAL.
  */
-static int read_znode(struct ubifs_info *c, int lnum, int offs, int len,
+static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 		      struct ubifs_znode *znode)
 {
+	int lnum = zzbr->lnum;
+	int offs = zzbr->offs;
+	int len = zzbr->len;
 	int i, err, type, cmp;
 	struct ubifs_idx_node *idx;
 
@@ -419,7 +420,7 @@ struct ubifs_znode *ubifs_load_znode(struct ubifs_info *c,
 	if (!znode)
 		return ERR_PTR(-ENOMEM);
 
-	err = read_znode(c, zbr->lnum, zbr->offs, zbr->len, znode);
+	err = read_znode(c, zbr, znode);
 	if (err)
 		goto out;
 
-- 
2.18.0

