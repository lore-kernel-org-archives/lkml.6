Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeDIMeY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:34:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35150 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDIMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:34:16 -0400
X-Google-Smtp-Source: AIpwx4+vLEtP+UWhVBBj2lQ1b38bgIxU6xcf9HV0bXaPpRZsR+OzyDyfcJr38NTMkBXir/se9h8cFQ==
From: Geliang Tang <geliangtang@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs-tools: Add posix acl support
Date: Mon,  9 Apr 2018 20:34:04 +0800
Message-Id: <711ddb81a0b0e58ca6ee1dd515d85e69b0294234.1523277042.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <af77c1f80e2725c4cf1bf106d6add820b3b0eed5.1523276963.git.geliangtang@gmail.com>
References: <af77c1f80e2725c4cf1bf106d6add820b3b0eed5.1523276963.git.geliangtang@gmail.com>
In-Reply-To: <af77c1f80e2725c4cf1bf106d6add820b3b0eed5.1523276963.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add posix acl (Access Control Lists) support for mksquashfs and
unsquashfs tools.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 squashfs-tools/read_xattrs.c      |  2 ++
 squashfs-tools/squashfs_fs.h      | 12 +++++++-----
 squashfs-tools/unsquashfs_xattr.c |  4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/squashfs-tools/read_xattrs.c b/squashfs-tools/read_xattrs.c
index 42106f5..8ef8291 100644
--- a/squashfs-tools/read_xattrs.c
+++ b/squashfs-tools/read_xattrs.c
@@ -64,6 +64,8 @@ static long long xattr_table_start;
  */
 struct prefix prefix_table[] = {
 	{ "user.", SQUASHFS_XATTR_USER },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_ACCESS },
+	{ "system.", SQUASHFS_XATTR_POSIX_ACL_DEFAULT },
 	{ "trusted.", SQUASHFS_XATTR_TRUSTED },
 	{ "security.", SQUASHFS_XATTR_SECURITY },
 	{ "", -1 }
diff --git a/squashfs-tools/squashfs_fs.h b/squashfs-tools/squashfs_fs.h
index afca918..040035c 100644
--- a/squashfs-tools/squashfs_fs.h
+++ b/squashfs-tools/squashfs_fs.h
@@ -122,11 +122,13 @@
 #define SQUASHFS_LSOCKET_TYPE		14
 
 /* Xattr types */
-#define SQUASHFS_XATTR_USER		0
-#define SQUASHFS_XATTR_TRUSTED		1
-#define SQUASHFS_XATTR_SECURITY		2
-#define SQUASHFS_XATTR_VALUE_OOL	256
-#define SQUASHFS_XATTR_PREFIX_MASK	0xff
+#define SQUASHFS_XATTR_USER			0
+#define SQUASHFS_XATTR_POSIX_ACL_ACCESS		1
+#define SQUASHFS_XATTR_POSIX_ACL_DEFAULT	2
+#define SQUASHFS_XATTR_TRUSTED			3
+#define SQUASHFS_XATTR_SECURITY			4
+#define SQUASHFS_XATTR_VALUE_OOL		256
+#define SQUASHFS_XATTR_PREFIX_MASK		0xff
 
 /* Flag whether block is compressed or uncompressed, bit is set if block is
  * uncompressed */
diff --git a/squashfs-tools/unsquashfs_xattr.c b/squashfs-tools/unsquashfs_xattr.c
index 59f4aae..34aae84 100644
--- a/squashfs-tools/unsquashfs_xattr.c
+++ b/squashfs-tools/unsquashfs_xattr.c
@@ -57,7 +57,9 @@ void write_xattr(char *pathname, unsigned int xattr)
 		if(user_xattrs && prefix != SQUASHFS_XATTR_USER)
 			continue;
 
-		if(root_process || prefix == SQUASHFS_XATTR_USER) {
+		if(root_process || prefix == SQUASHFS_XATTR_USER
+				|| prefix == SQUASHFS_XATTR_POSIX_ACL_ACCESS
+				|| prefix == SQUASHFS_XATTR_POSIX_ACL_DEFAULT) {
 			int res = lsetxattr(pathname, xattr_list[i].full_name,
 				xattr_list[i].value, xattr_list[i].vsize, 0);
 
-- 
2.14.1
