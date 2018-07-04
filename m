Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C090C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AC6208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AC6208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeGDMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:47:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36905 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934537AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dO-CV; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Z1-FS; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 06/25] ubifs: drop write_node
Date:   Wed,  4 Jul 2018 14:41:18 +0200
Message-Id: <20180704124137.13396-7-s.hauer@pengutronix.de>
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

write_node() is used only once and can easily be replaced with calls
to ubifs_prepare_node()/write_head() which makes the code a bit shorter.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/journal.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 07b4956e0425..754d969eb27e 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -228,36 +228,6 @@ static int reserve_space(struct ubifs_info *c, int jhead, int len)
 	return err;
 }
 
-/**
- * write_node - write node to a journal head.
- * @c: UBIFS file-system description object
- * @jhead: journal head
- * @node: node to write
- * @len: node length
- * @lnum: LEB number written is returned here
- * @offs: offset written is returned here
- *
- * This function writes a node to reserved space of journal head @jhead.
- * Returns zero in case of success and a negative error code in case of
- * failure.
- */
-static int write_node(struct ubifs_info *c, int jhead, void *node, int len,
-		      int *lnum, int *offs)
-{
-	struct ubifs_wbuf *wbuf = &c->jheads[jhead].wbuf;
-
-	ubifs_assert(jhead != GCHD);
-
-	*lnum = c->jheads[jhead].wbuf.lnum;
-	*offs = c->jheads[jhead].wbuf.offs + c->jheads[jhead].wbuf.used;
-
-	dbg_jnl("jhead %s, LEB %d:%d, len %d",
-		dbg_jhead(jhead), *lnum, *offs, len);
-	ubifs_prepare_node(c, node, len, 0);
-
-	return ubifs_wbuf_write_nolock(wbuf, node, len);
-}
-
 /**
  * write_head - write data to a journal head.
  * @c: UBIFS file-system description object
@@ -268,9 +238,9 @@ static int write_node(struct ubifs_info *c, int jhead, void *node, int len,
  * @offs: offset written is returned here
  * @sync: non-zero if the write-buffer has to by synchronized
  *
- * This function is the same as 'write_node()' but it does not assume the
- * buffer it is writing is a node, so it does not prepare it (which means
- * initializing common header and calculating CRC).
+ * This function writes data to the reserved space of journal head @jhead.
+ * Returns zero in case of success and a negative error code in case of
+ * failure.
  */
 static int write_head(struct ubifs_info *c, int jhead, void *buf, int len,
 		      int *lnum, int *offs, int sync)
@@ -758,7 +728,8 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	if (err)
 		goto out_free;
 
-	err = write_node(c, DATAHD, data, dlen, &lnum, &offs);
+	ubifs_prepare_node(c, data, dlen, 0);
+	err = write_head(c, DATAHD, data, dlen, &lnum, &offs, 0);
 	if (err)
 		goto out_release;
 	ubifs_wbuf_add_ino_nolock(&c->jheads[DATAHD].wbuf, key_inum(c, key));
-- 
2.18.0

