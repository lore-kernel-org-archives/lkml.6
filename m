Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeELFBp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35963 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeELFBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:42 -0400
X-Google-Smtp-Source: AB8JxZqY2Cy5Wny0howGls/IMpXvfnI4inoxN3fkbL7y+ymi1UZUjhK8dCru+L898JSOygUeX0wfrw==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, jack@suse.com
Subject: [PATCH 5/6] udf: Simplify calls to udf_disk_stamp_to_time
Date: Fri, 11 May 2018 21:59:20 -0700
Message-Id: <20180512045921.18311-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches in the series convert inode timestamps
to use struct timespec64 instead of struct timespec as
part of solving the y2038 problem.

commit fd3cfad374d4 ("udf: Convert udf_disk_stamp_to_time() to use mktime64()")
eliminated the NULL return condition from udf_disk_stamp_to_time().
udf_time_to_disk_time() is always called with a valid dest pointer and
the return value is ignored.
Further, caller can as well check the dest pointer being passed in rather
than return argument.
Make both the functions return void.

This will make the inode timestamp conversion simpler.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: jack@suse.com
---
 fs/udf/inode.c   | 28 +++++++---------------------
 fs/udf/super.c   | 16 +++++++++-------
 fs/udf/udfdecl.h |  4 ++--
 fs/udf/udftime.c |  9 ++-------
 4 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c80765d62f7e..df2378d6ebb4 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1443,15 +1443,9 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(fe->logicalBlocksRecorded) <<
 			(inode->i_sb->s_blocksize_bits - 9);
 
-		if (!udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime))
-			inode->i_atime = sbi->s_record_time;
-
-		if (!udf_disk_stamp_to_time(&inode->i_mtime,
-					    fe->modificationTime))
-			inode->i_mtime = sbi->s_record_time;
-
-		if (!udf_disk_stamp_to_time(&inode->i_ctime, fe->attrTime))
-			inode->i_ctime = sbi->s_record_time;
+		udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime);
+		udf_disk_stamp_to_time(&inode->i_mtime, fe->modificationTime);
+		udf_disk_stamp_to_time(&inode->i_ctime, fe->attrTime);
 
 		iinfo->i_unique = le64_to_cpu(fe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
@@ -1461,18 +1455,10 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
 		    (inode->i_sb->s_blocksize_bits - 9);
 
-		if (!udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime))
-			inode->i_atime = sbi->s_record_time;
-
-		if (!udf_disk_stamp_to_time(&inode->i_mtime,
-					    efe->modificationTime))
-			inode->i_mtime = sbi->s_record_time;
-
-		if (!udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime))
-			iinfo->i_crtime = sbi->s_record_time;
-
-		if (!udf_disk_stamp_to_time(&inode->i_ctime, efe->attrTime))
-			inode->i_ctime = sbi->s_record_time;
+		udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime);
+		udf_disk_stamp_to_time(&inode->i_mtime, efe->modificationTime);
+		udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime);
+		udf_disk_stamp_to_time(&inode->i_ctime, efe->attrTime);
 
 		iinfo->i_unique = le64_to_cpu(efe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 0d27d41f5c6e..bd0ae64bc31c 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -862,6 +862,9 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 	struct buffer_head *bh;
 	uint16_t ident;
 	int ret = -ENOMEM;
+#ifdef UDFFS_DEBUG
+	struct timestamp *ts;
+#endif
 
 	outstr = kmalloc(128, GFP_NOFS);
 	if (!outstr)
@@ -880,15 +883,14 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 
 	pvoldesc = (struct primaryVolDesc *)bh->b_data;
 
-	if (udf_disk_stamp_to_time(&UDF_SB(sb)->s_record_time,
-			      pvoldesc->recordingDateAndTime)) {
+	udf_disk_stamp_to_time(&UDF_SB(sb)->s_record_time,
+			      pvoldesc->recordingDateAndTime);
 #ifdef UDFFS_DEBUG
-		struct timestamp *ts = &pvoldesc->recordingDateAndTime;
-		udf_debug("recording time %04u/%02u/%02u %02u:%02u (%x)\n",
-			  le16_to_cpu(ts->year), ts->month, ts->day, ts->hour,
-			  ts->minute, le16_to_cpu(ts->typeAndTimezone));
+	*ts = &pvoldesc->recordingDateAndTime;
+	udf_debug("recording time %04u/%02u/%02u %02u:%02u (%x)\n",
+		  le16_to_cpu(ts->year), ts->month, ts->day, ts->hour,
+		  ts->minute, le16_to_cpu(ts->typeAndTimezone));
 #endif
-	}
 
 	ret = udf_dstrCS0toChar(sb, outstr, 31, pvoldesc->volIdent, 32);
 	if (ret < 0)
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index fc8d1b3384d2..bae311b59400 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -253,8 +253,8 @@ extern struct long_ad *udf_get_filelongad(uint8_t *, int, uint32_t *, int);
 extern struct short_ad *udf_get_fileshortad(uint8_t *, int, uint32_t *, int);
 
 /* udftime.c */
-extern struct timespec *udf_disk_stamp_to_time(struct timespec *dest,
+extern void udf_disk_stamp_to_time(struct timespec *dest,
 						struct timestamp src);
-extern struct timestamp *udf_time_to_disk_stamp(struct timestamp *dest, struct timespec src);
+extern void udf_time_to_disk_stamp(struct timestamp *dest, struct timespec src);
 
 #endif				/* __UDF_DECL_H */
diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index 0927a4b2ecaf..67b33ac5d41b 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -40,7 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 
-struct timespec *
+void
 udf_disk_stamp_to_time(struct timespec *dest, struct timestamp src)
 {
 	u16 typeAndTimezone = le16_to_cpu(src.typeAndTimezone);
@@ -67,10 +67,9 @@ udf_disk_stamp_to_time(struct timespec *dest, struct timestamp src)
 	 * recorded with bogus sub-second values.
 	 */
 	dest->tv_nsec %= NSEC_PER_SEC;
-	return dest;
 }
 
-struct timestamp *
+void
 udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
 {
 	long seconds;
@@ -79,9 +78,6 @@ udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
 
 	offset = -sys_tz.tz_minuteswest;
 
-	if (!dest)
-		return NULL;
-
 	dest->typeAndTimezone = cpu_to_le16(0x1000 | (offset & 0x0FFF));
 
 	seconds = ts.tv_sec + offset * 60;
@@ -97,7 +93,6 @@ udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
 					dest->centiseconds * 10000) / 100;
 	dest->microseconds = (ts.tv_nsec / 1000 - dest->centiseconds * 10000 -
 			      dest->hundredsOfMicroseconds * 100);
-	return dest;
 }
 
 /* EOF */
-- 
2.17.0
