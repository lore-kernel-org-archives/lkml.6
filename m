Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeELFB3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36741 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeELFBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:24 -0400
X-Google-Smtp-Source: AB8JxZpqyW9eeTNT7xN+q0Yiz0Dwxm0AFM2vkyuY7R1p8yxHj3qtkHSXSiw9ogaNmlyWq51GaicTiw==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, zyan@redhat.com,
        ceph-devel@vger.kernel.org
Subject: [PATCH 3/6] ceph: make inode time prints to be long long
Date: Fri, 11 May 2018 21:59:18 -0700
Message-Id: <20180512045921.18311-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches in the series convert inode timestamps
to use struct timespec64 instead of struct timespec as
part of solving the y2038 problem.

Convert these print formats to use long long types to
avoid warnings and errors on conversion.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: zyan@redhat.com
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/inode.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ae056927080d..676065a1ea62 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -671,18 +671,18 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
 		    timespec_compare(ctime, &inode->i_ctime) > 0) {
-			dout("ctime %ld.%09ld -> %ld.%09ld inc w/ cap\n",
-			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-			     ctime->tv_sec, ctime->tv_nsec);
+			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
+			     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			     (long long)ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime = *ctime;
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
-			dout("mtime %ld.%09ld -> %ld.%09ld "
+			dout("mtime %lld.%09ld -> %lld.%09ld "
 			     "tw %d -> %d\n",
-			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-			     mtime->tv_sec, mtime->tv_nsec,
+			     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			     (long long)mtime->tv_sec, mtime->tv_nsec,
 			     ci->i_time_warp_seq, (int)time_warp_seq);
 
 			inode->i_mtime = *mtime;
@@ -691,17 +691,17 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
 			if (timespec_compare(mtime, &inode->i_mtime) > 0) {
-				dout("mtime %ld.%09ld -> %ld.%09ld inc\n",
-				     inode->i_mtime.tv_sec,
+				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
+				     (long long)inode->i_mtime.tv_sec,
 				     inode->i_mtime.tv_nsec,
-				     mtime->tv_sec, mtime->tv_nsec);
+				     (long long)mtime->tv_sec, mtime->tv_nsec);
 				inode->i_mtime = *mtime;
 			}
 			if (timespec_compare(atime, &inode->i_atime) > 0) {
-				dout("atime %ld.%09ld -> %ld.%09ld inc\n",
-				     inode->i_atime.tv_sec,
+				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
+				     (long long)inode->i_atime.tv_sec,
 				     inode->i_atime.tv_nsec,
-				     atime->tv_sec, atime->tv_nsec);
+				     (long long)atime->tv_sec, atime->tv_nsec);
 				inode->i_atime = *atime;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
@@ -2015,9 +2015,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	}
 
 	if (ia_valid & ATTR_ATIME) {
-		dout("setattr %p atime %ld.%ld -> %ld.%ld\n", inode,
-		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
-		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
+		     (long long)inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
+		     (long long)attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_atime = attr->ia_atime;
@@ -2037,9 +2037,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
-		dout("setattr %p mtime %ld.%ld -> %ld.%ld\n", inode,
-		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
+		     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+		     (long long)attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_mtime = attr->ia_mtime;
@@ -2082,9 +2082,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (ia_valid & ATTR_CTIME) {
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
-		dout("setattr %p ctime %ld.%ld -> %ld.%ld (%s)\n", inode,
-		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
+		     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+		     (long long)attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
 			/*
-- 
2.17.0
