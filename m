Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCE7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E126B208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E126B208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeGDMmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934481AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dP-Dv; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Z4-G3; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 07/25] ubifs: Store read superblock node
Date:   Wed,  4 Jul 2018 14:41:19 +0200
Message-Id: <20180704124137.13396-8-s.hauer@pengutronix.de>
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

The superblock node is read/modified/written several times throughout
the UBIFS code. Instead of reading it from the device each time just
keep a copy in memory and write back the modified copy when necessary.
This patch helps for authentication support, here we not only have to
read the superblock node, but also have to authenticate it, which
is easier if we do it once during initialization.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/sb.c    | 19 +++++--------------
 fs/ubifs/super.c |  8 +-------
 fs/ubifs/ubifs.h |  3 ++-
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index a32408f2f5c3..2fabd441d74a 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -497,7 +497,7 @@ static int validate_sb(struct ubifs_info *c, struct ubifs_sb_node *sup)
  * code. Note, the user of this function is responsible of kfree()'ing the
  * returned superblock buffer.
  */
-struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c)
+static struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c)
 {
 	struct ubifs_sb_node *sup;
 	int err;
@@ -554,6 +554,8 @@ int ubifs_read_superblock(struct ubifs_info *c)
 	if (IS_ERR(sup))
 		return PTR_ERR(sup);
 
+	c->superblock = sup;
+
 	c->fmt_version = le32_to_cpu(sup->fmt_version);
 	c->ro_compat_version = le32_to_cpu(sup->ro_compat_version);
 
@@ -685,7 +687,6 @@ int ubifs_read_superblock(struct ubifs_info *c)
 
 	err = validate_sb(c, sup);
 out:
-	kfree(sup);
 	return err;
 }
 
@@ -814,7 +815,7 @@ static int fixup_free_space(struct ubifs_info *c)
 int ubifs_fixup_free_space(struct ubifs_info *c)
 {
 	int err;
-	struct ubifs_sb_node *sup;
+	struct ubifs_sb_node *sup = c->superblock;
 
 	ubifs_assert(c->space_fixup);
 	ubifs_assert(!c->ro_mount);
@@ -825,16 +826,11 @@ int ubifs_fixup_free_space(struct ubifs_info *c)
 	if (err)
 		return err;
 
-	sup = ubifs_read_sb_node(c);
-	if (IS_ERR(sup))
-		return PTR_ERR(sup);
-
 	/* Free-space fixup is no longer required */
 	c->space_fixup = 0;
 	sup->flags &= cpu_to_le32(~UBIFS_FLG_SPACE_FIXUP);
 
 	err = ubifs_write_sb_node(c, sup);
-	kfree(sup);
 	if (err)
 		return err;
 
@@ -845,7 +841,7 @@ int ubifs_fixup_free_space(struct ubifs_info *c)
 int ubifs_enable_encryption(struct ubifs_info *c)
 {
 	int err;
-	struct ubifs_sb_node *sup;
+	struct ubifs_sb_node *sup = c->superblock;
 
 	if (c->encrypted)
 		return 0;
@@ -858,16 +854,11 @@ int ubifs_enable_encryption(struct ubifs_info *c)
 		return -EINVAL;
 	}
 
-	sup = ubifs_read_sb_node(c);
-	if (IS_ERR(sup))
-		return PTR_ERR(sup);
-
 	sup->flags |= cpu_to_le32(UBIFS_FLG_ENCRYPTION);
 
 	err = ubifs_write_sb_node(c, sup);
 	if (!err)
 		c->encrypted = 1;
-	kfree(sup);
 
 	return err;
 }
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c5466c70d620..9e44baec30a3 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1580,16 +1580,10 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		goto out;
 
 	if (c->old_leb_cnt != c->leb_cnt) {
-		struct ubifs_sb_node *sup;
+		struct ubifs_sb_node *sup = c->superblock;
 
-		sup = ubifs_read_sb_node(c);
-		if (IS_ERR(sup)) {
-			err = PTR_ERR(sup);
-			goto out;
-		}
 		sup->leb_cnt = cpu_to_le32(c->leb_cnt);
 		err = ubifs_write_sb_node(c, sup);
-		kfree(sup);
 		if (err)
 			goto out;
 	}
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 83c5e75ed3b6..92574045e030 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -971,6 +971,7 @@ struct ubifs_debug_info;
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
  * @vfs_sb: VFS @struct super_block object
+ * @superblock: The super block node as read from the device
  *
  * @highest_inum: highest used inode number
  * @max_sqnum: current global sequence number
@@ -1217,6 +1218,7 @@ struct ubifs_debug_info;
  */
 struct ubifs_info {
 	struct super_block *vfs_sb;
+	struct ubifs_sb_node *superblock;
 
 	ino_t highest_inum;
 	unsigned long long max_sqnum;
@@ -1647,7 +1649,6 @@ int ubifs_write_master(struct ubifs_info *c);
 
 /* sb.c */
 int ubifs_read_superblock(struct ubifs_info *c);
-struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c);
 int ubifs_write_sb_node(struct ubifs_info *c, struct ubifs_sb_node *sup);
 int ubifs_fixup_free_space(struct ubifs_info *c);
 int ubifs_enable_encryption(struct ubifs_info *c);
-- 
2.18.0

