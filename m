Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4CF208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="I2gYSe82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4CF208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeGaOxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:53:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57166 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbeGaOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:53:46 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0BD275C03BB;
        Tue, 31 Jul 2018 15:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533042807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=k5BJzDmPTALNOj3TS1jLShgIRhWEq1vpFANB4aINJbA=;
        b=I2gYSe82ShEhByEYEFxrVQlNHVTyLxrdk1YZsuUr03km9lebmNwGA3Hw9Aj5TVc3N/d7fx
        8/Mqr0P5RYVR+YMYfHrj+T7igW4ris603szaKZx4zAlYyuYQgBnoonoUKTX5Ca7HM3HqEX
        h6eGDwkJ+In8ck4OzpJIcMfcL8x7+Vk=
From:   Stefan Agner <stefan@agner.ch>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] fs: ubifs: introduce Kconfig symbol for xattr support
Date:   Tue, 31 Jul 2018 15:13:20 +0200
Message-Id: <20180731131320.21087-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to disable extended attribute support.

This aids in reliability testing, especially since some xattr
related bugs have surfaced.

Also an embedded system might not need it, so this allows for a
slightly smaller kernel (about 4KiB).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 fs/ubifs/Kconfig  | 15 +++++++++++++--
 fs/ubifs/Makefile |  3 ++-
 fs/ubifs/dir.c    |  2 ++
 fs/ubifs/file.c   |  4 ++++
 fs/ubifs/super.c  |  2 ++
 fs/ubifs/ubifs.h  |  6 ++++++
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 83a961bf7280..bbc78549be4c 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -51,9 +51,20 @@ config UBIFS_ATIME_SUPPORT
 
 	  If unsure, say 'N'
 
+config UBIFS_FS_XATTR
+	bool "UBIFS XATTR support"
+	depends on UBIFS_FS
+	default y
+	help
+	  Saying Y here includes support for extended attributes (xattrs).
+	  Xattrs are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page).
+
+	  If unsure, say Y.
+
 config UBIFS_FS_ENCRYPTION
 	bool "UBIFS Encryption"
-	depends on UBIFS_FS && BLOCK
+	depends on UBIFS_FS && UBIFS_FS_XATTR && BLOCK
 	select FS_ENCRYPTION
 	default n
 	help
@@ -64,7 +75,7 @@ config UBIFS_FS_ENCRYPTION
 
 config UBIFS_FS_SECURITY
 	bool "UBIFS Security Labels"
-	depends on UBIFS_FS
+	depends on UBIFS_FS && UBIFS_FS_XATTR
 	default y
 	help
 	  Security labels provide an access control facility to support Linux
diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 9758f709c736..6197d7e539e4 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_UBIFS_FS) += ubifs.o
 ubifs-y += shrinker.o journal.o file.o dir.o super.o sb.o io.o
 ubifs-y += tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
 ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
-ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o xattr.o debug.o
+ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
 ubifs-y += misc.o
 ubifs-$(CONFIG_UBIFS_FS_ENCRYPTION) += crypto.o
+ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9da224d4f2da..dc875886f11f 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1647,7 +1647,9 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.rename      = ubifs_rename,
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
+#ifdef CONFIG_UBIFS_FS_XATTR
 	.listxattr   = ubifs_listxattr,
+#endif
 #ifdef CONFIG_UBIFS_ATIME_SUPPORT
 	.update_time = ubifs_update_time,
 #endif
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index fd7eb6fe9090..b8b3962eb449 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1654,7 +1654,9 @@ const struct address_space_operations ubifs_file_address_operations = {
 const struct inode_operations ubifs_file_inode_operations = {
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
+#ifdef CONFIG_UBIFS_FS_XATTR
 	.listxattr   = ubifs_listxattr,
+#endif
 #ifdef CONFIG_UBIFS_ATIME_SUPPORT
 	.update_time = ubifs_update_time,
 #endif
@@ -1664,7 +1666,9 @@ const struct inode_operations ubifs_symlink_inode_operations = {
 	.get_link    = ubifs_get_link,
 	.setattr     = ubifs_setattr,
 	.getattr     = ubifs_getattr,
+#ifdef CONFIG_UBIFS_FS_XATTR
 	.listxattr   = ubifs_listxattr,
+#endif
 #ifdef CONFIG_UBIFS_ATIME_SUPPORT
 	.update_time = ubifs_update_time,
 #endif
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c5466c70d620..564a131afc56 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2053,7 +2053,9 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	if (c->max_inode_sz > MAX_LFS_FILESIZE)
 		sb->s_maxbytes = c->max_inode_sz = MAX_LFS_FILESIZE;
 	sb->s_op = &ubifs_super_operations;
+#ifdef CONFIG_UBIFS_FS_XATTR
 	sb->s_xattr = ubifs_xattr_handlers;
+#endif
 #ifdef CONFIG_UBIFS_FS_ENCRYPTION
 	sb->s_cop = &ubifs_crypt_operations;
 #endif
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 04bf84d71e7b..6aab759f0f9d 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1755,7 +1755,13 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 		    size_t size, int flags, bool check_lock);
 ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 			size_t size);
+
+#ifdef CONFIG_UBIFS_FS_XATTR
 void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
+#else
+static inline void ubifs_evict_xattr_inode(struct ubifs_info *c,
+					   ino_t xattr_inum) { }
+#endif
 
 #ifdef CONFIG_UBIFS_FS_SECURITY
 extern int ubifs_init_security(struct inode *dentry, struct inode *inode,
-- 
2.18.0

