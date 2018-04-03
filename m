Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbeDCI7h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:59:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54824 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754969AbeDCI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:59:35 -0400
X-Google-Smtp-Source: AIpwx4/Ony4XtXjH67YrCPPn96DcU28ST3yiXwrWNBk8IO37oPMRZfitTsXl0Q0bf5dTGoul/a8gzQ==
Date: Tue, 3 Apr 2018 09:59:32 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: dushistov@mail.ru
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: ufs: Convert ufs_set_de_type to use lookup table
Message-ID: <20180403085932.GA2710@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify ufs_set_de_type function in fs/ufs/util.h to use a lookup
table rather than a switch statement, as per the TODO comment.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/ufs/util.h | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1907be6d5808..1edf4c6454e3 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -155,37 +155,31 @@ ufs_set_de_namlen(struct super_block *sb, struct ufs_dir_entry *de, u16 value)
 static inline void
 ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 {
+	/* type lookup table, DT_UNKNOWN is default type if no case holds */
+	const int mode_table[] = {
+		DT_UNKNOWN,
+		DT_FIFO,	/* mode & S_IFMT == S_IFIFO case */
+		DT_CHR,		/* mode & S_IFMT == S_IFCHR case */
+		DT_UNKNOWN,
+		DT_DIR,		/* mode & S_IFMT == S_IFDIR case */
+		DT_UNKNOWN,
+		DT_BLK,		/* mode & S_IFMT == S_IFBLK case */
+		DT_UNKNOWN,
+		DT_REG,		/* mode & S_IFMT == S_IFREG case */
+		DT_UNKNOWN,
+		DT_LNK,		/* mode & S_IFMT == S_IFLNK case */
+		DT_UNKNOWN,
+		DT_SOCK,	/* mode & S_IFMT == S_IFSOCK case */
+		DT_UNKNOWN,
+		DT_UNKNOWN,
+		DT_UNKNOWN
+	};
+
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	/* shift (mode & S_IFMT) right 12 bits to index into table */
+	de->d_u.d_44.d_type = mode_table[(mode & S_IFMT) >> 12];
 }
 
 static inline u32
-- 
2.14.3
