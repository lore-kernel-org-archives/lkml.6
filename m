Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1106C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E79220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E79220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeIGRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:21:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeIGRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007bo-79; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00061k-BE; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 03/25] ubifs: pass ubifs_zbranch to try_read_node()
Date:   Fri,  7 Sep 2018 14:36:24 +0200
Message-Id: <20180907123646.12688-4-s.hauer@pengutronix.de>
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

try_read_node() takes len, lnum and offs arguments which the caller all
extracts from the same struct ubifs_zbranch *. When adding authentication
support we would have to add a pointer to a hash to the arguments which
is also part of struct ubifs_zbranch. Pass the ubifs_zbranch * instead
so that we do not have to add another argument.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/tnc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index bf416e512743..8502c07c1e0a 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -35,7 +35,7 @@
 #include "ubifs.h"
 
 static int try_read_node(const struct ubifs_info *c, void *buf, int type,
-			 int len, int lnum, int offs);
+			 struct ubifs_zbranch *zbr);
 static int fallible_read_node(struct ubifs_info *c, const union ubifs_key *key,
 			      struct ubifs_zbranch *zbr, void *node);
 
@@ -433,9 +433,7 @@ static int tnc_read_hashed_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
  * @c: UBIFS file-system description object
  * @buf: buffer to read to
  * @type: node type
- * @len: node length (not aligned)
- * @lnum: LEB number of node to read
- * @offs: offset of node to read
+ * @zbr: the zbranch describing the node to read
  *
  * This function tries to read a node of known type and length, checks it and
  * stores it in @buf. This function returns %1 if a node is present and %0 if
@@ -453,8 +451,11 @@ static int tnc_read_hashed_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
  * journal nodes may potentially be corrupted, so checking is required.
  */
 static int try_read_node(const struct ubifs_info *c, void *buf, int type,
-			 int len, int lnum, int offs)
+			 struct ubifs_zbranch *zbr)
 {
+	int len = zbr->len;
+	int lnum = zbr->lnum;
+	int offs = zbr->offs;
 	int err, node_len;
 	struct ubifs_ch *ch = buf;
 	uint32_t crc, node_crc;
@@ -507,8 +508,7 @@ static int fallible_read_node(struct ubifs_info *c, const union ubifs_key *key,
 
 	dbg_tnck(key, "LEB %d:%d, key ", zbr->lnum, zbr->offs);
 
-	ret = try_read_node(c, node, key_type(c, key), zbr->len, zbr->lnum,
-			    zbr->offs);
+	ret = try_read_node(c, node, key_type(c, key), zbr);
 	if (ret == 1) {
 		union ubifs_key node_key;
 		struct ubifs_dent_node *dent = node;
-- 
2.18.0

