Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F3AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E503F2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E503F2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeIQDWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 23:22:06 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:37540 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbeIQDWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 23:22:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 50EB718023C41;
        Sun, 16 Sep 2018 23:57:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, koen.vandeputte@ncentric.com,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org
Subject: [PATCH] Revert "ubifs: xattr: Don't operate on deleted inodes"
Date:   Sun, 16 Sep 2018 23:57:35 +0200
Message-Id: <20180916215735.31393-1-richard@nod.at>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52.
UBIFS wants to assert that xattr operations are only issued on files
with positive link count. The said patch made this operations return
-ENOENT for unlinked files such that the asserts will no longer trigger.
This was wrong since xattr operations are perfectly fine on unlinked
files.
Instead the assertions need to be fixed/removed.

Cc: <stable@vger.kernel.org>
Fixes: 11a6fc3dc743 ("ubifs: xattr: Don't operate on deleted inodes")
Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/xattr.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 61afdfee4b28..f5ad1ede7990 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -152,12 +152,6 @@ static int create_xattr(struct ubifs_info *c, struct=
 inode *host,
 	ui->data_len =3D size;
=20
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err =3D -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime =3D current_time(host);
 	host_ui->xattr_cnt +=3D 1;
 	host_ui->xattr_size +=3D CALC_DENT_SIZE(fname_len(nm));
@@ -190,7 +184,6 @@ static int create_xattr(struct ubifs_info *c, struct =
inode *host,
 	host_ui->xattr_size -=3D CALC_XATTR_BYTES(size);
 	host_ui->xattr_names -=3D fname_len(nm);
 	host_ui->flags &=3D ~UBIFS_CRYPT_FL;
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 out_free:
 	make_bad_inode(inode);
@@ -242,12 +235,6 @@ static int change_xattr(struct ubifs_info *c, struct=
 inode *host,
 	mutex_unlock(&ui->ui_mutex);
=20
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err =3D -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime =3D current_time(host);
 	host_ui->xattr_size -=3D CALC_XATTR_BYTES(old_size);
 	host_ui->xattr_size +=3D CALC_XATTR_BYTES(size);
@@ -269,7 +256,6 @@ static int change_xattr(struct ubifs_info *c, struct =
inode *host,
 out_cancel:
 	host_ui->xattr_size -=3D CALC_XATTR_BYTES(size);
 	host_ui->xattr_size +=3D CALC_XATTR_BYTES(old_size);
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	make_bad_inode(inode);
 out_free:
@@ -496,12 +482,6 @@ static int remove_xattr(struct ubifs_info *c, struct=
 inode *host,
 		return err;
=20
 	mutex_lock(&host_ui->ui_mutex);
-
-	if (!host->i_nlink) {
-		err =3D -ENOENT;
-		goto out_noent;
-	}
-
 	host->i_ctime =3D current_time(host);
 	host_ui->xattr_cnt -=3D 1;
 	host_ui->xattr_size -=3D CALC_DENT_SIZE(fname_len(nm));
@@ -521,7 +501,6 @@ static int remove_xattr(struct ubifs_info *c, struct =
inode *host,
 	host_ui->xattr_size +=3D CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size +=3D CALC_XATTR_BYTES(ui->data_len);
 	host_ui->xattr_names +=3D fname_len(nm);
-out_noent:
 	mutex_unlock(&host_ui->ui_mutex);
 	ubifs_release_budget(c, &req);
 	make_bad_inode(inode);
@@ -561,9 +540,6 @@ static int ubifs_xattr_remove(struct inode *host, con=
st char *name)
=20
 	ubifs_assert(c, inode_is_locked(host));
=20
-	if (!host->i_nlink)
-		return -ENOENT;
-
 	if (fname_len(&nm) > UBIFS_MAX_NLEN)
 		return -ENAMETOOLONG;
=20
--=20
2.19.0

