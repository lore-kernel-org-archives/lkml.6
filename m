Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0971C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5828D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5828D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeIGRTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46251 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeIGRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007bt-J5; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-000620-De; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 08/25] ubifs: Store read superblock node
Date:   Fri,  7 Sep 2018 14:36:29 +0200
Message-Id: <20180907123646.12688-9-s.hauer@pengutronix.de>
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
index cf7ee2880c57..7e08c8143316 100644
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
 
+	c->sup_node = sup;
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
+	struct ubifs_sb_node *sup = c->sup_node;
 
 	ubifs_assert(c, c->space_fixup);
 	ubifs_assert(c, !c->ro_mount);
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
+	struct ubifs_sb_node *sup = c->sup_node;
 
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
index 23e7042666a7..c197492802c2 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1605,16 +1605,10 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		goto out;
 
 	if (c->old_leb_cnt != c->leb_cnt) {
-		struct ubifs_sb_node *sup;
+		struct ubifs_sb_node *sup = c->sup_node;
 
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
index 306cc7a4f725..93e1c34c097f 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -983,6 +983,7 @@ struct ubifs_debug_info;
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
  * @vfs_sb: VFS @struct super_block object
+ * @sup_node: The super block node as read from the device
  *
  * @highest_inum: highest used inode number
  * @max_sqnum: current global sequence number
@@ -1230,6 +1231,7 @@ struct ubifs_debug_info;
  */
 struct ubifs_info {
 	struct super_block *vfs_sb;
+	struct ubifs_sb_node *sup_node;
 
 	ino_t highest_inum;
 	unsigned long long max_sqnum;
@@ -1664,7 +1666,6 @@ int ubifs_write_master(struct ubifs_info *c);
 
 /* sb.c */
 int ubifs_read_superblock(struct ubifs_info *c);
-struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c);
 int ubifs_write_sb_node(struct ubifs_info *c, struct ubifs_sb_node *sup);
 int ubifs_fixup_free_space(struct ubifs_info *c);
 int ubifs_enable_encryption(struct ubifs_info *c);
-- 
2.18.0

