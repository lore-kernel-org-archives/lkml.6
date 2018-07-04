Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82493C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E6208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4E6208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeGDMpa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:45:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41143 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934696AbeGDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dX-Qp; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Zv-KT; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 15/25] ubifs: Add auth nodes to garbage collector journal head
Date:   Wed,  4 Jul 2018 14:41:27 +0200
Message-Id: <20180704124137.13396-16-s.hauer@pengutronix.de>
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

To be able to authenticate the garbage collector journal head add
authentication nodes to the buds the garbage collector creates.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/gc.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index ac3a3f7c6a6e..8feeeb12b6ed 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -365,12 +365,13 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
 
 	/* Write nodes to their new location. Use the first-fit strategy */
 	while (1) {
-		int avail;
+		int avail, moved = 0;
 		struct ubifs_scan_node *snod, *tmp;
 
 		/* Move data nodes */
 		list_for_each_entry_safe(snod, tmp, &sleb->nodes, list) {
-			avail = c->leb_size - wbuf->offs - wbuf->used;
+			avail = c->leb_size - wbuf->offs - wbuf->used -
+					ubifs_auth_node_sz(c);
 			if  (snod->len > avail)
 				/*
 				 * Do not skip data nodes in order to optimize
@@ -378,14 +379,19 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
 				 */
 				break;
 
+			ubifs_shash_update(c, c->jheads[GCHD].log_hash,
+					   snod->node, snod->len);
+
 			err = move_node(c, sleb, snod, wbuf);
 			if (err)
 				goto out;
+			moved = 1;
 		}
 
 		/* Move non-data nodes */
 		list_for_each_entry_safe(snod, tmp, &nondata, list) {
-			avail = c->leb_size - wbuf->offs - wbuf->used;
+			avail = c->leb_size - wbuf->offs - wbuf->used -
+					ubifs_auth_node_sz(c);
 			if (avail < min)
 				break;
 
@@ -403,7 +409,32 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
 				continue;
 			}
 
+			ubifs_shash_update(c, c->jheads[GCHD].log_hash,
+					   snod->node, snod->len);
+
 			err = move_node(c, sleb, snod, wbuf);
+			if (err)
+				goto out;
+			moved = 1;
+		}
+
+		if (ubifs_authenticated(c) && moved) {
+			struct ubifs_auth_node *auth;
+
+			auth = kmalloc(ubifs_auth_node_sz(c), GFP_NOFS);
+			if (!auth) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			ubifs_prepare_auth_node(c, auth,
+						c->jheads[GCHD].log_hash);
+
+			err = ubifs_wbuf_write_nolock(wbuf, auth,
+						      ubifs_auth_node_sz(c));
+
+			kfree(auth);
+
 			if (err)
 				goto out;
 		}
-- 
2.18.0

