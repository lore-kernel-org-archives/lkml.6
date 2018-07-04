Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4877C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F832208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F832208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGDMpZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:45:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56695 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934683AbeGDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dY-T0; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005a3-Ky; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 16/25] ubifs: authenticate replayed journal
Date:   Wed,  4 Jul 2018 14:41:28 +0200
Message-Id: <20180704124137.13396-17-s.hauer@pengutronix.de>
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

Make sure that during replay all buds can be authenticated. To do
this we calculate the hash chain until we find an authentication
node and check the HMAC in that node against the current status
of the hash chain.

After a power cut it can happen that some nodes have been written, but
not yet the authentication node for them. These nodes have to be
discarded during replay.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/replay.c | 116 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 07a66ae90e89..45da17d1a74e 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -34,6 +34,8 @@
 
 #include "ubifs.h"
 #include <linux/list_sort.h>
+#include <crypto/hash.h>
+#include <crypto/algapi.h>
 
 /**
  * struct replay_entry - replay list entry.
@@ -530,6 +532,79 @@ static int is_last_bud(struct ubifs_info *c, struct ubifs_bud *bud)
 	return data == 0xFFFFFFFF;
 }
 
+/**
+ * authenticate_sleb - authenticate one scan LEB
+ * @c: UBIFS file-system description object
+ * @sleb: the scan LEB to authenticate
+ * @log_hash:
+ * @is_last: if true, this is is the last LEB
+ *
+ * This function iterates over the buds of a single LEB authenticating all buds
+ * with the authentication nodes on this LEB. Authentication nodes are written
+ * after some buds and contain a HMAC covering the authentication node itself
+ * and the buds between the last authentication node and the current
+ * authentication node. It can happen that the last buds cannot be authenticated
+ * because a powercut happened when some nodes were written but not the
+ * corresponding authentication node. This function returns the number of nodes
+ * that could be authenticated or a negative error code.
+ */
+static int authenticate_sleb(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
+			     struct shash_desc *log_hash, int is_last)
+{
+	int n_not_auth = 0;
+	struct ubifs_scan_node *snod;
+	int n_nodes = 0;
+	int err;
+
+	if (!ubifs_authenticated(c))
+		return sleb->nodes_cnt;
+
+	list_for_each_entry(snod, &sleb->nodes, list) {
+
+		n_nodes++;
+
+		if (snod->type == UBIFS_AUTH_NODE) {
+			struct ubifs_auth_node *auth = snod->node;
+			SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
+			u8 hash[crypto_shash_descsize(c->hash_tfm)];
+			SHASH_DESC_ON_STACK(hmac_desc, c->hmac_tfm);
+			u8 hmac[c->hmac_desc_len];
+
+			hash_desc->tfm = c->hash_tfm;
+			hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+			ubifs_shash_copy_state(c, log_hash, hash_desc);
+			crypto_shash_final(hash_desc, hash);
+
+			hmac_desc->tfm = c->hmac_tfm;
+			hmac_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+			crypto_shash_digest(hmac_desc, hash, c->hash_len, hmac);
+
+			err = ubifs_check_hmac(c, auth->hmac, hmac);
+			if (err) {
+				err = -EPERM;
+				goto out;
+			}
+			n_not_auth = 0;
+		} else {
+			crypto_shash_update(log_hash, snod->node, snod->len);
+			n_not_auth++;
+		}
+	}
+
+	/*
+	 * A powercut can happen when some nodes were written, but not yet
+	 * the corresponding authentication node. This may only happen on
+	 * the last bud though.
+	 */
+	if (n_not_auth && !is_last)
+		err = -EPERM;
+	else
+		err = 0;
+out:
+	return err ? err : n_nodes - n_not_auth;
+}
+
 /**
  * replay_bud - replay a bud logical eraseblock.
  * @c: UBIFS file-system description object
@@ -543,6 +618,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 {
 	int is_last = is_last_bud(c, b->bud);
 	int err = 0, used = 0, lnum = b->bud->lnum, offs = b->bud->start;
+	int n_nodes, n = 0;
 	struct ubifs_scan_leb *sleb;
 	struct ubifs_scan_node *snod;
 
@@ -562,6 +638,15 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 	if (IS_ERR(sleb))
 		return PTR_ERR(sleb);
 
+	n_nodes = authenticate_sleb(c, sleb, b->bud->log_hash, is_last);
+	if (n_nodes < 0) {
+		err = n_nodes;
+		goto out;
+	}
+
+	ubifs_shash_copy_state(c, b->bud->log_hash,
+			       c->jheads[b->bud->jhead].log_hash);
+
 	/*
 	 * The bud does not have to start from offset zero - the beginning of
 	 * the 'lnum' LEB may contain previously committed data. One of the
@@ -675,6 +760,10 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 		}
 		if (err)
 			goto out;
+
+		n++;
+		if (n == n_nodes)
+			break;
 	}
 
 	ubifs_assert(ubifs_search_bud(c, lnum));
@@ -753,6 +842,7 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
 {
 	struct ubifs_bud *bud;
 	struct bud_entry *b;
+	int err;
 
 	dbg_mnt("add replay bud LEB %d:%d, head %d", lnum, offs, jhead);
 
@@ -762,13 +852,21 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
 
 	b = kmalloc(sizeof(struct bud_entry), GFP_KERNEL);
 	if (!b) {
-		kfree(bud);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
 	bud->lnum = lnum;
 	bud->start = offs;
 	bud->jhead = jhead;
+	bud->log_hash = ubifs_hash_get_desc(c);
+	if (IS_ERR(bud->log_hash)) {
+		err = PTR_ERR(bud->log_hash);
+		goto out;
+	}
+
+	ubifs_shash_copy_state(c, c->log_hash, bud->log_hash);
+
 	ubifs_add_bud(c, bud);
 
 	b->bud = bud;
@@ -776,6 +874,11 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
 	list_add_tail(&b->list, &c->replay_buds);
 
 	return 0;
+out:
+	kfree(bud);
+	kfree(b);
+
+	return err;
 }
 
 /**
@@ -881,6 +984,12 @@ static int replay_log_leb(struct ubifs_info *c, int lnum, int offs, void *sbuf)
 
 		c->cs_sqnum = le64_to_cpu(node->ch.sqnum);
 		dbg_mnt("commit start sqnum %llu", c->cs_sqnum);
+
+		if (c->authenticated) {
+			crypto_shash_init(c->log_hash);
+			crypto_shash_update(c->log_hash, (void *)node,
+					    UBIFS_CS_NODE_SZ);
+		}
 	}
 
 	if (snod->sqnum < c->cs_sqnum) {
@@ -928,6 +1037,9 @@ static int replay_log_leb(struct ubifs_info *c, int lnum, int offs, void *sbuf)
 			if (err)
 				goto out_dump;
 
+			ubifs_shash_update(c, c->log_hash, (void *)ref,
+					   UBIFS_REF_NODE_SZ);
+
 			err = add_replay_bud(c, le32_to_cpu(ref->lnum),
 					     le32_to_cpu(ref->offs),
 					     le32_to_cpu(ref->jhead),
-- 
2.18.0

