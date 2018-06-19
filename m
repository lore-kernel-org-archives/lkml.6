Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A8A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966771AbeFSPjd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:39:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:39:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MWSUM-1fguOF0BgY-00XeGp; Tue, 19 Jun 2018 17:39:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: use timespec64 directly for timestamp conversion
Date:   Tue, 19 Jun 2018 17:38:59 +0200
Message-Id: <20180619153914.3639387-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:btCJHTqpULYjDpINKBVQxNx40O7+oRy0dcqAl0XCQZRjNyZNqzc
 +I3apBQh03hcMAwxf58MVKu1WiDVPVbgwdcx1x6WQaED9sKzNU9cROw+rbSvBsWfUxjJsEO
 qaYS1Fv2wiM2HH2f+4xs7SW0bs5jfQTNSBTF9Jd9Fyp1drlGyYO9MBhNfaa6wQmCeRMkFFc
 TkyNdPyq+fARqFefoU8KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nedDJPS1liw=:5+oqXGp3Pf9bfjgO5rdGvm
 TtqknuEl704IcGH8lLdv1skifiMS3Pg1bMQff8nLFQUoc6RfLBHfyRURq0vnvuVL/ErQXT4aN
 AKS1kNKogO3EPNYW6aF7ATm6ywiOIIUiGiiruPAixiSQMxiogtYKQQiMSBlA34MVGcjB6p8cy
 2AY1n8bxQ4knTUkzX3kjicwE470Yy23tN9DoDHh2IKFi357Ewgzfhit2WhNQFhmtKntv8xT0/
 8JAos15fv4k9VKYLj/LdbcZx2EDhllpKCuBa9cXcWz8lOf/QrLp2OqjG3AmgWYrnZPPF1iv/d
 cq4tIwDL/4tk4yTj2qAnWznZgeRZyY+XBXu1JShPN5NtPnG+LYQk7IbnkwGV0jm+MwhZjunYV
 zRw73LvMineglsji3N6AZEGS/w9cWFbnccteKzG1snlDRCPxeXAm7T/sm1VUa6Y2J8ICgAlpg
 CxHQHRH8SSqCpaQA1myCV1VI7HSEHELQZePCwo1bs8L8k1mCF24Nhb09dvHutmkgw2EbgIJJd
 AGsbpgKcnsn2753ZaJoauyv9L1j+TghEr+rZLxZTcD7tjVJB/XFfe2sK2zKMHZRBL2owhqPIk
 RKOkeP2E3ydqZL6WFjfDM8QQjNvnG+wGhjWCLi3VXcN6uCh7x440c6Jb/wDO+5Ides/wK+tQG
 rVaVMwQrdHu5BXj1ThUdsF4uLSqkXItPmCIZ52qQff2w6nkw+znUuj7s3dImcNrClvgM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the VFS has been converted from timespec to timespec64
timestamps, only the conversion to/from ntfs timestamps uses 32-bit
seconds.

This changes that last missing piece to get the ntfs implementation
y2038 safe on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ntfs/inode.c | 12 ++++++------
 fs/ntfs/time.h  | 27 +++++++++++++++------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index decaf75d1cd5..bd3221cbdd95 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -667,18 +667,18 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 * mtime is the last change of the data within the file. Not changed
 	 * when only metadata is changed, e.g. a rename doesn't affect mtime.
 	 */
-	vi->i_mtime = timespec_to_timespec64(ntfs2utc(si->last_data_change_time));
+	vi->i_mtime = ntfs2utc(si->last_data_change_time);
 	/*
 	 * ctime is the last change of the metadata of the file. This obviously
 	 * always changes, when mtime is changed. ctime can be changed on its
 	 * own, mtime is then not changed, e.g. when a file is renamed.
 	 */
-	vi->i_ctime = timespec_to_timespec64(ntfs2utc(si->last_mft_change_time));
+	vi->i_ctime = ntfs2utc(si->last_mft_change_time);
 	/*
 	 * Last access to the data within the file. Not changed during a rename
 	 * for example but changed whenever the file is written to.
 	 */
-	vi->i_atime = timespec_to_timespec64(ntfs2utc(si->last_access_time));
+	vi->i_atime = ntfs2utc(si->last_access_time);
 
 	/* Find the attribute list attribute if present. */
 	ntfs_attr_reinit_search_ctx(ctx);
@@ -2997,7 +2997,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 	/* Update the access times if they have changed. */
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_mtime));
+	nt = utc2ntfs(vi->i_mtime);
 	if (si->last_data_change_time != nt) {
 		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3006,7 +3006,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_data_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_ctime));
+	nt = utc2ntfs(vi->i_ctime);
 	if (si->last_mft_change_time != nt) {
 		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino, (long long)
@@ -3015,7 +3015,7 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 		si->last_mft_change_time = nt;
 		modified = true;
 	}
-	nt = utc2ntfs(timespec64_to_timespec(vi->i_atime));
+	nt = utc2ntfs(vi->i_atime);
 	if (si->last_access_time != nt) {
 		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
diff --git a/fs/ntfs/time.h b/fs/ntfs/time.h
index 01233989d5d1..24cd719f1fd2 100644
--- a/fs/ntfs/time.h
+++ b/fs/ntfs/time.h
@@ -36,16 +36,16 @@
  * Convert the Linux UTC time @ts to its corresponding NTFS time and return
  * that in little endian format.
  *
- * Linux stores time in a struct timespec consisting of a time_t (long at
- * present) tv_sec and a long tv_nsec where tv_sec is the number of 1-second
- * intervals since 1st January 1970, 00:00:00 UTC and tv_nsec is the number of
- * 1-nano-second intervals since the value of tv_sec.
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
  *
  * NTFS uses Microsoft's standard time format which is stored in a s64 and is
  * measured as the number of 100-nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline sle64 utc2ntfs(const struct timespec ts)
+static inline sle64 utc2ntfs(const struct timespec64 ts)
 {
 	/*
 	 * Convert the seconds to 100ns intervals, add the nano-seconds
@@ -63,7 +63,10 @@ static inline sle64 utc2ntfs(const struct timespec ts)
  */
 static inline sle64 get_current_ntfs_time(void)
 {
-	return utc2ntfs(current_kernel_time());
+	struct timespec64 ts;
+
+	ktime_get_coarse_real_ts64(&ts);
+	return utc2ntfs(ts);
 }
 
 /**
@@ -73,18 +76,18 @@ static inline sle64 get_current_ntfs_time(void)
  * Convert the little endian NTFS time @time to its corresponding Linux UTC
  * time and return that in cpu format.
  *
- * Linux stores time in a struct timespec consisting of a time_t (long at
- * present) tv_sec and a long tv_nsec where tv_sec is the number of 1-second
- * intervals since 1st January 1970, 00:00:00 UTC and tv_nsec is the number of
- * 1-nano-second intervals since the value of tv_sec.
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
  *
  * NTFS uses Microsoft's standard time format which is stored in a s64 and is
  * measured as the number of 100 nano-second intervals since 1st January 1601,
  * 00:00:00 UTC.
  */
-static inline struct timespec ntfs2utc(const sle64 time)
+static inline struct timespec64 ntfs2utc(const sle64 time)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 
 	/* Subtract the NTFS time offset. */
 	u64 t = (u64)(sle64_to_cpu(time) - NTFS_TIME_OFFSET);
-- 
2.9.0

