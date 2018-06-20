Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679D920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679D920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754370AbeFTI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:29:37 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeFTI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:33 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lnlkd-1g7uy60Ccx-00hwzU; Wed, 20 Jun 2018 10:15:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jan Kara <jack@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Steve Magnani <steve.magnani@digidescorp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] udf: convert inode stamps to timespec64
Date:   Wed, 20 Jun 2018 10:15:13 +0200
Message-Id: <20180620081535.207936-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:nCvCqCT+yS6Hw/7PcDj5jKPMcqdGu7S0sa2SvtulFDwn7Ovx5b3
 2dFj3dqZaz6qP7zJGLzpX5EuFVnHaEomhjpZPSCsBLaz3rarT7locuaJ9mm8D3wIsZbykw0
 bwnoLDHWEH/InoPvEcoDIRpLbGJveMTAM0+FszjYTwQ1jb7s6PveGkUu2mx5RAZd6NcOBMx
 OW427/nDjDEa2KJ/dijwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BbhYqiY9xGg=:cM+c7WMHdnmfzi78dY7yB8
 cM+pVioGgSEOGJxkWDk+AHz/xQ4SzPTLqVu4S6dzOAjNoVdhpUxmDh+gnKgG4F3rhnxj+9dek
 JSP11FSdfZmQyocDa3UoIu/ClZTcA84zz/ku8liMDNnQTVvHGToSwanxXpt8nltOGYGpjPdIn
 O1cd2tiBXhC/8KwUfaNGw5RcKnatJdpnnCHAPzaKuS+jLTLHVI4myaoPTi+s/Yqb8iRjAfwrK
 u29AFHoUO6VNz8wVtIrGRI0ZleqTDaB45WvswpfPMMJDPAzAW4Tt09kVk0tlyoPxHKdu+aDSA
 byjc/c/bojOM4blXev0zJx15pxIdG7SkLi830RYaoOeNNqzgecsp+Q3HzE/KRez4o07vuX6R0
 2Mh9i5C4TgJNPVqmqNfCs6i+DPDDkyVSGKJDBhUjmZcUJIZPIDcxPdR4/xozvRPlxu/gJNz58
 9FsNsy4Dax+16MLiS27qvVdEQkfA+GbTiYF0ZZTyW2nbhmMujVijg1F9eOjJBJP1ek6AoYxQ2
 zmx4AncTFvNdSq1mBOBKQxQyaihjk9Yh4YEiYZzLxbl381f1pgSwNlnWWvjdLR0pL4COxQg1l
 iPKhlPmWQxByzvk4t5GteUQrg3e1iNNd2AYW+AI9r4fxe3s13mMU/IXUBzsxPXUcXRoUfONfg
 pjG70LQGtNZxgLXi8Iu6z1h7qYrRvn22+A/M6XOFj/O9e3tIn40geeScw8SOkpZB9lfE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFS structures are finally converted to always use 64-bit timestamps,
and this file system can represent a long range of on-disk timestamps
already, so now let's fit in the missing bits for udf.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/udf/ialloc.c  |  2 +-
 fs/udf/inode.c   | 45 ++++++++++++++++-----------------------------
 fs/udf/super.c   |  8 ++++----
 fs/udf/udf_i.h   |  2 +-
 fs/udf/udf_sb.h  |  2 +-
 fs/udf/udfdecl.h |  4 ++--
 fs/udf/udftime.c |  4 ++--
 7 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 56569023783b..f8e5872f7cc2 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -125,7 +125,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	iinfo->i_crtime = timespec64_to_timespec(inode->i_mtime);
+	iinfo->i_crtime = inode->i_mtime;
 	if (unlikely(insert_inode_locked(inode) < 0)) {
 		make_bad_inode(inode);
 		iput(inode);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7f39d17352c9..75e0b2683e47 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1271,7 +1271,6 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
 	struct kernel_lb_addr *iloc = &iinfo->i_location;
-	struct timespec ts;
 	unsigned int link_count;
 	unsigned int indirections = 0;
 	int bs = inode->i_sb->s_blocksize;
@@ -1444,12 +1443,9 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(fe->logicalBlocksRecorded) <<
 			(inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&ts, fe->accessTime);
-		inode->i_atime = timespec_to_timespec64(ts);
-		udf_disk_stamp_to_time(&ts, fe->modificationTime);
-		inode->i_mtime = timespec_to_timespec64(ts);
-		udf_disk_stamp_to_time(&ts, fe->attrTime);
-		inode->i_ctime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime);
+		udf_disk_stamp_to_time(&inode->i_mtime, fe->modificationTime);
+		udf_disk_stamp_to_time(&inode->i_ctime, fe->attrTime);
 
 		iinfo->i_unique = le64_to_cpu(fe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
@@ -1459,13 +1455,10 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
 		    (inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&ts, efe->accessTime);
-		inode->i_atime = timespec_to_timespec64(ts);
-		udf_disk_stamp_to_time(&ts, efe->modificationTime);
-		inode->i_mtime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime);
+		udf_disk_stamp_to_time(&inode->i_mtime, efe->modificationTime);
 		udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime);
-		udf_disk_stamp_to_time(&ts, efe->attrTime);
-		inode->i_ctime = timespec_to_timespec64(ts);
+		udf_disk_stamp_to_time(&inode->i_ctime, efe->attrTime);
 
 		iinfo->i_unique = le64_to_cpu(efe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
@@ -1602,7 +1595,7 @@ static int udf_sync_inode(struct inode *inode)
 	return udf_update_inode(inode, 1);
 }
 
-static void udf_adjust_time(struct udf_inode_info *iinfo, struct timespec time)
+static void udf_adjust_time(struct udf_inode_info *iinfo, struct timespec64 time)
 {
 	if (iinfo->i_crtime.tv_sec > time.tv_sec ||
 	    (iinfo->i_crtime.tv_sec == time.tv_sec &&
@@ -1715,12 +1708,9 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		       inode->i_sb->s_blocksize - sizeof(struct fileEntry));
 		fe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
-		udf_time_to_disk_stamp(&fe->accessTime,
-				       timespec64_to_timespec(inode->i_atime));
-		udf_time_to_disk_stamp(&fe->modificationTime,
-				       timespec64_to_timespec(inode->i_mtime));
-		udf_time_to_disk_stamp(&fe->attrTime,
-				       timespec64_to_timespec(inode->i_ctime));
+		udf_time_to_disk_stamp(&fe->accessTime, inode->i_atime);
+		udf_time_to_disk_stamp(&fe->modificationTime, inode->i_mtime);
+		udf_time_to_disk_stamp(&fe->attrTime, inode->i_ctime);
 		memset(&(fe->impIdent), 0, sizeof(struct regid));
 		strcpy(fe->impIdent.ident, UDF_ID_DEVELOPER);
 		fe->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
@@ -1739,17 +1729,14 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		efe->objectSize = cpu_to_le64(inode->i_size);
 		efe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
-		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_atime));
-		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_mtime));
-		udf_adjust_time(iinfo, timespec64_to_timespec(inode->i_ctime));
+		udf_adjust_time(iinfo, inode->i_atime);
+		udf_adjust_time(iinfo, inode->i_mtime);
+		udf_adjust_time(iinfo, inode->i_ctime);
 
-		udf_time_to_disk_stamp(&efe->accessTime,
-				       timespec64_to_timespec(inode->i_atime));
-		udf_time_to_disk_stamp(&efe->modificationTime,
-				       timespec64_to_timespec(inode->i_mtime));
+		udf_time_to_disk_stamp(&efe->accessTime, inode->i_atime);
+		udf_time_to_disk_stamp(&efe->modificationTime, inode->i_mtime);
 		udf_time_to_disk_stamp(&efe->createTime, iinfo->i_crtime);
-		udf_time_to_disk_stamp(&efe->attrTime,
-				       timespec64_to_timespec(inode->i_ctime));
+		udf_time_to_disk_stamp(&efe->attrTime, inode->i_ctime);
 
 		memset(&(efe->impIdent), 0, sizeof(efe->impIdent));
 		strcpy(efe->impIdent.ident, UDF_ID_DEVELOPER);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 0c504c8031d3..3040dc2a32f6 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1980,7 +1980,7 @@ static void udf_open_lvid(struct super_block *sb)
 	struct buffer_head *bh = sbi->s_lvid_bh;
 	struct logicalVolIntegrityDesc *lvid;
 	struct logicalVolIntegrityDescImpUse *lvidiu;
-	struct timespec ts;
+	struct timespec64 ts;
 
 	if (!bh)
 		return;
@@ -1992,7 +1992,7 @@ static void udf_open_lvid(struct super_block *sb)
 	mutex_lock(&sbi->s_alloc_mutex);
 	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
 	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
-	ktime_get_real_ts(&ts);
+	ktime_get_real_ts64(&ts);
 	udf_time_to_disk_stamp(&lvid->recordingDateAndTime, ts);
 	if (le32_to_cpu(lvid->integrityType) == LVID_INTEGRITY_TYPE_CLOSE)
 		lvid->integrityType = cpu_to_le32(LVID_INTEGRITY_TYPE_OPEN);
@@ -2017,7 +2017,7 @@ static void udf_close_lvid(struct super_block *sb)
 	struct buffer_head *bh = sbi->s_lvid_bh;
 	struct logicalVolIntegrityDesc *lvid;
 	struct logicalVolIntegrityDescImpUse *lvidiu;
-	struct timespec ts;
+	struct timespec64 ts;
 
 	if (!bh)
 		return;
@@ -2029,7 +2029,7 @@ static void udf_close_lvid(struct super_block *sb)
 	mutex_lock(&sbi->s_alloc_mutex);
 	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
 	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
-	ktime_get_real_ts(&ts);
+	ktime_get_real_ts64(&ts);
 	udf_time_to_disk_stamp(&lvid->recordingDateAndTime, ts);
 	if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
 		lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
diff --git a/fs/udf/udf_i.h b/fs/udf/udf_i.h
index 630426ffb775..2ef0e212f08a 100644
--- a/fs/udf/udf_i.h
+++ b/fs/udf/udf_i.h
@@ -28,7 +28,7 @@ struct udf_ext_cache {
  */
 
 struct udf_inode_info {
-	struct timespec		i_crtime;
+	struct timespec64	i_crtime;
 	/* Physical address of inode */
 	struct kernel_lb_addr		i_location;
 	__u64			i_unique;
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 9dd3e1b9619e..9424d7cab790 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -138,7 +138,7 @@ struct udf_sb_info {
 	rwlock_t		s_cred_lock;
 
 	/* Root Info */
-	struct timespec		s_record_time;
+	struct timespec64	s_record_time;
 
 	/* Fileset Info */
 	__u16			s_serial_number;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index bae311b59400..4b8e1c111340 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -253,8 +253,8 @@ extern struct long_ad *udf_get_filelongad(uint8_t *, int, uint32_t *, int);
 extern struct short_ad *udf_get_fileshortad(uint8_t *, int, uint32_t *, int);
 
 /* udftime.c */
-extern void udf_disk_stamp_to_time(struct timespec *dest,
+extern void udf_disk_stamp_to_time(struct timespec64 *dest,
 						struct timestamp src);
-extern void udf_time_to_disk_stamp(struct timestamp *dest, struct timespec src);
+extern void udf_time_to_disk_stamp(struct timestamp *dest, struct timespec64 src);
 
 #endif				/* __UDF_DECL_H */
diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index 67b33ac5d41b..784371994c2a 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -41,7 +41,7 @@
 #include <linux/time.h>
 
 void
-udf_disk_stamp_to_time(struct timespec *dest, struct timestamp src)
+udf_disk_stamp_to_time(struct timespec64 *dest, struct timestamp src)
 {
 	u16 typeAndTimezone = le16_to_cpu(src.typeAndTimezone);
 	u16 year = le16_to_cpu(src.year);
@@ -70,7 +70,7 @@ udf_disk_stamp_to_time(struct timespec *dest, struct timestamp src)
 }
 
 void
-udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
+udf_time_to_disk_stamp(struct timestamp *dest, struct timespec64 ts)
 {
 	long seconds;
 	int16_t offset;
-- 
2.9.0

