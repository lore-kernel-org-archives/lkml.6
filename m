Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A9C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F64208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F64208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934808AbeGDMm4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934735AbeGDMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:27 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6n-0001de-0f; Wed, 04 Jul 2018 14:42:09 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005bH-OK; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 22/25] ubifs: do not update inode size in-place in authenticated mode
Date:   Wed,  4 Jul 2018 14:41:34 +0200
Message-Id: <20180704124137.13396-23-s.hauer@pengutronix.de>
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

In authenticated mode we cannot fixup the inode sizes in-place
during recovery as this would invalidate the hashes and HMACs
we stored for this inode.

Instead, we just write the updated inodes to the journal. We can
only do this after ubifs_rcvry_gc_commit() is done though, so for
authenticated mode call ubifs_recover_size() after
ubifs_rcvry_gc_commit() and not vice versa as normally done.

Calling ubifs_recover_size() after ubifs_rcvry_gc_commit() has the
drawback that after a commit the size fixup information is gone, so
when a powercut happens while recovering from another powercut
we may lose some data written right before the first powercut.
This is why we only do this in authenticated mode and leave the
behaviour for unauthenticated mode untouched.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/recovery.c | 111 +++++++++++++++++++++++++++++++++-----------
 fs/ubifs/super.c    |  38 +++++++++++----
 fs/ubifs/ubifs.h    |   2 +-
 3 files changed, 113 insertions(+), 38 deletions(-)

diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 3fa7c2cd96b9..293f4ff10c13 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -1460,16 +1460,82 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
 	return err;
 }
 
+/**
+ * inode_fix_size - fix inode size
+ * @c: UBIFS file-system description object
+ * @e: inode size information for recovery
+ */
+static int inode_fix_size(struct ubifs_info *c, struct size_entry *e)
+{
+	struct inode *inode;
+	struct ubifs_inode *ui;
+	int err;
+
+	if (c->ro_mount)
+		ubifs_assert(!e->inode);
+
+	if (e->inode) {
+		/* Remounting rw, pick up inode we stored earlier */
+		inode = e->inode;
+	} else {
+		inode = ubifs_iget(c->vfs_sb, e->inum);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+
+		if (inode->i_size >= e->d_size) {
+			/*
+			 * The original inode in the index already has a size
+			 * big enough, nothing to do
+			 */
+			iput(inode);
+			return 0;
+		}
+
+		dbg_rcvry("ino %lu size %lld -> %lld",
+			  (unsigned long)e->inum,
+			  inode->i_size, e->d_size);
+
+		ui = ubifs_inode(inode);
+
+		inode->i_size = e->d_size;
+		ui->ui_size = e->d_size;
+		ui->synced_i_size = e->d_size;
+
+		e->inode = inode;
+	}
+
+	/*
+	 * In readonly mode just keep the inode pinned in memory until we go
+	 * readwrite. In readwrite mode write the inode to the journal with the
+	 * fixed size.
+	 */
+	if (c->ro_mount)
+		return 0;
+
+	err = ubifs_jnl_write_inode(c, inode);
+
+	iput(inode);
+
+	if (err)
+		return err;
+
+	rb_erase(&e->rb, &c->size_tree);
+	kfree(e);
+
+	return 0;
+}
+
 /**
  * ubifs_recover_size - recover inode size.
  * @c: UBIFS file-system description object
+ * @in_place: If true, do a in-place size fixup
  *
  * This function attempts to fix inode size discrepancies identified by the
  * 'ubifs_recover_size_accum()' function.
  *
  * This functions returns %0 on success and a negative error code on failure.
  */
-int ubifs_recover_size(struct ubifs_info *c)
+int ubifs_recover_size(struct ubifs_info *c, bool in_place)
 {
 	struct rb_node *this = rb_first(&c->size_tree);
 
@@ -1478,6 +1544,9 @@ int ubifs_recover_size(struct ubifs_info *c)
 		int err;
 
 		e = rb_entry(this, struct size_entry, rb);
+
+		this = rb_next(this);
+
 		if (!e->exists) {
 			union ubifs_key key;
 
@@ -1501,40 +1570,26 @@ int ubifs_recover_size(struct ubifs_info *c)
 		}
 
 		if (e->exists && e->i_size < e->d_size) {
-			if (c->ro_mount) {
-				/* Fix the inode size and pin it in memory */
-				struct inode *inode;
-				struct ubifs_inode *ui;
-
-				ubifs_assert(!e->inode);
-
-				inode = ubifs_iget(c->vfs_sb, e->inum);
-				if (IS_ERR(inode))
-					return PTR_ERR(inode);
-
-				ui = ubifs_inode(inode);
-				if (inode->i_size < e->d_size) {
-					dbg_rcvry("ino %lu size %lld -> %lld",
-						  (unsigned long)e->inum,
-						  inode->i_size, e->d_size);
-					inode->i_size = e->d_size;
-					ui->ui_size = e->d_size;
-					ui->synced_i_size = e->d_size;
-					e->inode = inode;
-					this = rb_next(this);
-					continue;
-				}
-				iput(inode);
-			} else {
-				/* Fix the size in place */
+			ubifs_assert(!(c->ro_mount && in_place));
+
+			/*
+			 * We found data that is outside the found inode size,
+			 * fixup the inode size
+			 */
+
+			if (in_place) {
 				err = fix_size_in_place(c, e);
 				if (err)
 					return err;
 				iput(e->inode);
+			} else {
+				err = inode_fix_size(c, e);
+				if (err)
+					return err;
+				continue;
 			}
 		}
 
-		this = rb_next(this);
 		rb_erase(&e->rb, &c->size_tree);
 		kfree(e);
 	}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 49de06921427..de7bf613addc 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1353,12 +1353,21 @@ static int mount_ubifs(struct ubifs_info *c)
 		}
 
 		if (c->need_recovery) {
-			err = ubifs_recover_size(c);
-			if (err)
-				goto out_orphans;
+			if (!ubifs_authenticated(c)) {
+				err = ubifs_recover_size(c, true);
+				if (err)
+					goto out_orphans;
+			}
+
 			err = ubifs_rcvry_gc_commit(c);
 			if (err)
 				goto out_orphans;
+
+			if (ubifs_authenticated(c)) {
+				err = ubifs_recover_size(c, false);
+				if (err)
+					goto out_orphans;
+			}
 		} else {
 			err = take_gc_lnum(c);
 			if (err)
@@ -1377,7 +1386,7 @@ static int mount_ubifs(struct ubifs_info *c)
 		if (err)
 			goto out_orphans;
 	} else if (c->need_recovery) {
-		err = ubifs_recover_size(c);
+		err = ubifs_recover_size(c, false);
 		if (err)
 			goto out_orphans;
 	} else {
@@ -1604,9 +1613,11 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		err = ubifs_write_rcvrd_mst_node(c);
 		if (err)
 			goto out;
-		err = ubifs_recover_size(c);
-		if (err)
-			goto out;
+		if (!ubifs_authenticated(c)) {
+			err = ubifs_recover_size(c, true);
+			if (err)
+				goto out;
+		}
 		err = ubifs_clean_lebs(c, c->sbuf);
 		if (err)
 			goto out;
@@ -1672,10 +1683,19 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 			goto out;
 	}
 
-	if (c->need_recovery)
+	if (c->need_recovery) {
 		err = ubifs_rcvry_gc_commit(c);
-	else
+		if (err)
+			goto out;
+
+		if (ubifs_authenticated(c)) {
+			err = ubifs_recover_size(c, false);
+			if (err)
+				goto out;
+		}
+	} else {
 		err = ubifs_leb_unmap(c, c->gc_lnum);
+	}
 	if (err)
 		goto out;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c5f15db915a9..afe1b0904683 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1996,7 +1996,7 @@ int ubifs_clean_lebs(struct ubifs_info *c, void *sbuf);
 int ubifs_rcvry_gc_commit(struct ubifs_info *c);
 int ubifs_recover_size_accum(struct ubifs_info *c, union ubifs_key *key,
 			     int deletion, loff_t new_size);
-int ubifs_recover_size(struct ubifs_info *c);
+int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
-- 
2.18.0

