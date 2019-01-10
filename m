Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067E920879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfAJNpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:45:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:38506 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfAJNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:44:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 05:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="290498312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2019 05:41:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3C8F108; Thu, 10 Jan 2019 15:41:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] fs/jfs: Switch to use new generic UUID API
Date:   Thu, 10 Jan 2019 15:41:53 +0200
Message-Id: <20190110134153.83901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

- not tested on real FS

 fs/jfs/jfs_incore.h     |  6 ++++--
 fs/jfs/jfs_logmgr.c     | 17 ++++++++---------
 fs/jfs/jfs_logmgr.h     | 10 +++++-----
 fs/jfs/jfs_mount.c      |  4 ++--
 fs/jfs/jfs_superblock.h |  7 ++++---
 fs/jfs/super.c          |  5 +++--
 6 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 912a3af2393e..340eb8e4f716 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -23,6 +23,8 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/uuid.h>
+
 #include "jfs_types.h"
 #include "jfs_xtree.h"
 #include "jfs_dtree.h"
@@ -178,8 +180,8 @@ struct jfs_sb_info {
 	pxd_t		logpxd;		/* pxd describing log	*/
 	pxd_t		fsckpxd;	/* pxd describing fsck wkspc */
 	pxd_t		ait2;		/* pxd describing AIT copy	*/
-	char		uuid[16];	/* 128-bit uuid for volume	*/
-	char		loguuid[16];	/* 128-bit uuid for log	*/
+	uuid_t		uuid;		/* 128-bit uuid for volume	*/
+	uuid_t		loguuid;	/* 128-bit uuid for log	*/
 	/*
 	 * commit_state is used for synchronization of the jfs_commit
 	 * threads.  It is protected by LAZY_LOCK().
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 6b68df395892..6361fa4d85db 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1092,8 +1092,7 @@ int lmLogOpen(struct super_block *sb)
 	mutex_lock(&jfs_log_mutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
 		if (log->bdev->bd_dev == sbi->logdev) {
-			if (memcmp(log->uuid, sbi->loguuid,
-				   sizeof(log->uuid))) {
+			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
 				mutex_unlock(&jfs_log_mutex);
 				return -EINVAL;
@@ -1130,7 +1129,7 @@ int lmLogOpen(struct super_block *sb)
 	}
 
 	log->bdev = bdev;
-	memcpy(log->uuid, sbi->loguuid, sizeof(log->uuid));
+	uuid_copy(&log->uuid, &sbi->loguuid);
 
 	/*
 	 * initialize log:
@@ -1336,7 +1335,7 @@ int lmLogInit(struct jfs_log * log)
 			jfs_info("lmLogInit: inline log:0x%p base:0x%Lx size:0x%x",
 				 log, (unsigned long long)log->base, log->size);
 		} else {
-			if (memcmp(logsuper->uuid, log->uuid, 16)) {
+			if (!uuid_equal(&logsuper->uuid, &log->uuid)) {
 				jfs_warn("wrong uuid on JFS log device");
 				goto errout20;
 			}
@@ -1732,7 +1731,7 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
 	int i;
 	struct logsuper *logsuper;
 	struct lbuf *bpsuper;
-	char *uuid = sbi->uuid;
+	uuid_t *uuid = &sbi->uuid;
 
 	/*
 	 * insert/remove file system device to log active file system list.
@@ -1743,8 +1742,8 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
 	logsuper = (struct logsuper *) bpsuper->l_ldata;
 	if (activate) {
 		for (i = 0; i < MAX_ACTIVE; i++)
-			if (!memcmp(logsuper->active[i].uuid, NULL_UUID, 16)) {
-				memcpy(logsuper->active[i].uuid, uuid, 16);
+			if (uuid_is_null(&logsuper->active[i].uuid)) {
+				uuid_copy(&logsuper->active[i].uuid, uuid);
 				sbi->aggregate = i;
 				break;
 			}
@@ -1755,8 +1754,8 @@ static int lmLogFileSystem(struct jfs_log * log, struct jfs_sb_info *sbi,
 		}
 	} else {
 		for (i = 0; i < MAX_ACTIVE; i++)
-			if (!memcmp(logsuper->active[i].uuid, uuid, 16)) {
-				memcpy(logsuper->active[i].uuid, NULL_UUID, 16);
+			if (uuid_equal(&logsuper->active[i].uuid, uuid)) {
+				uuid_copy(&logsuper->active[i].uuid, &uuid_null);
 				break;
 			}
 		if (i == MAX_ACTIVE) {
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index e38c21598850..870fc22360e7 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -19,6 +19,8 @@
 #ifndef	_H_JFS_LOGMGR
 #define _H_JFS_LOGMGR
 
+#include <linux/uuid.h>
+
 #include "jfs_filsys.h"
 #include "jfs_lock.h"
 
@@ -73,15 +75,13 @@ struct logsuper {
 	__le32 state;		/* 4: state - see below */
 
 	__le32 end;		/* 4: addr of last log record set by logredo */
-	char uuid[16];		/* 16: 128-bit journal uuid */
+	uuid_t uuid;		/* 16: 128-bit journal uuid */
 	char label[16];		/* 16: journal label */
 	struct {
-		char uuid[16];
+		uuid_t uuid;
 	} active[MAX_ACTIVE];	/* 2048: active file systems list */
 };
 
-#define NULL_UUID "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
-
 /* log flag: commit option (see jfs_filsys.h) */
 
 /* log state */
@@ -410,7 +410,7 @@ struct jfs_log {
 	spinlock_t synclock;	/* 4: synclist lock */
 	struct lbuf *wqueue;	/* 4: log pageout queue */
 	int count;		/* 4: count */
-	char uuid[16];		/* 16: 128-bit uuid of log device */
+	uuid_t uuid;		/* 16: 128-bit uuid of log device */
 
 	int no_integrity;	/* 3: flag to disable journaling to disk */
 };
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index d8658607bf46..c9c1f16b93df 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -389,8 +389,8 @@ static int chkSuper(struct super_block *sb)
 		sbi->logpxd = j_sb->s_logpxd;
 	else {
 		sbi->logdev = new_decode_dev(le32_to_cpu(j_sb->s_logdev));
-		memcpy(sbi->uuid, j_sb->s_uuid, sizeof(sbi->uuid));
-		memcpy(sbi->loguuid, j_sb->s_loguuid, sizeof(sbi->uuid));
+		uuid_copy(&sbi->uuid, &j_sb->s_uuid);
+		uuid_copy(&sbi->loguuid, &j_sb->s_loguuid);
 	}
 	sbi->fsckpxd = j_sb->s_fsckpxd;
 	sbi->ait2 = j_sb->s_ait2;
diff --git a/fs/jfs/jfs_superblock.h b/fs/jfs/jfs_superblock.h
index 04847b8d3070..0a401f083d1a 100644
--- a/fs/jfs/jfs_superblock.h
+++ b/fs/jfs/jfs_superblock.h
@@ -18,6 +18,8 @@
 #ifndef	_H_JFS_SUPERBLOCK
 #define _H_JFS_SUPERBLOCK
 
+#include <linux/uuid.h>
+
 /*
  * make the magic number something a human could read
  */
@@ -100,10 +102,9 @@ struct jfs_superblock {
 	pxd_t s_xlogpxd;	/* 8: extendfs logpxd */
 	/* - 128 byte boundary - */
 
-	char s_uuid[16];	/* 16: 128-bit uuid for volume */
+	uuid_t s_uuid;		/* 16: 128-bit uuid for volume */
 	char s_label[16];	/* 16: volume label */
-	char s_loguuid[16];	/* 16: 128-bit uuid for log device */
-
+	uuid_t s_loguuid;	/* 16: 128-bit uuid for log device */
 };
 
 extern int readSuper(struct super_block *, struct buffer_head **);
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 65d8fc87ab11..99a43e7f6ee0 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -174,8 +174,9 @@ static int jfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = maxinodes;
 	buf->f_ffree = maxinodes - (atomic_read(&imap->im_numinos) -
 				    atomic_read(&imap->im_numfree));
-	buf->f_fsid.val[0] = (u32)crc32_le(0, sbi->uuid, sizeof(sbi->uuid)/2);
-	buf->f_fsid.val[1] = (u32)crc32_le(0, sbi->uuid + sizeof(sbi->uuid)/2,
+	buf->f_fsid.val[0] = (u32)crc32_le(0, (char *)&sbi->uuid,
+					sizeof(sbi->uuid)/2);
+	buf->f_fsid.val[1] = (u32)crc32_le(0, (char *)&sbi->uuid + sizeof(sbi->uuid)/2,
 					sizeof(sbi->uuid)/2);
 
 	buf->f_namelen = JFS_NAME_MAX;
-- 
2.20.1

