Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96026C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD34208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD34208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbeGKC0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:26:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45634 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbeGKCYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lc-0003K4-SI; Wed, 11 Jul 2018 02:22:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 25/42] document ->atomic_open() changes
Date:   Wed, 11 Jul 2018 03:21:49 +0100
Message-Id: <20180711022206.12571-25-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/Locking |  2 +-
 Documentation/filesystems/porting |  8 ++++++++
 Documentation/filesystems/vfs.txt | 18 ++++++++++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 2c391338c675..04c867981375 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -64,7 +64,7 @@ prototypes:
 	void (*update_time)(struct inode *, struct timespec *, int);
 	int (*atomic_open)(struct inode *, struct dentry *,
 				struct file *, unsigned open_flag,
-				umode_t create_mode, int *opened);
+				umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 
 locking rules:
diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index 17bb4dc28fae..c68ea9294b5f 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -602,3 +602,11 @@ in your dentry operations instead.
 	dentry separately, and it now has request_mask and query_flags arguments
 	to specify the fields and sync type requested by statx.  Filesystems not
 	supporting any statx-specific features may ignore the new arguments.
+--
+[mandatory]
+	->atomic_open() calling conventions have changed.  Gone is int *opened,
+	along with FILE_OPENED/FILE_CREATED.  In place of those we have
+	FMODE_OPENED/FMODE_CREATED, set in file->f_mode.  Additionally, return
+	value for 'called finish_no_open(), open it yourself' case has become
+	0, not 1.  Since finish_no_open() itself is returning 0 now, that part
+	does not need any changes in ->atomic_open() instances.
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 829a7b7857a4..d564cc44397e 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -386,7 +386,7 @@ struct inode_operations {
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	void (*update_time)(struct inode *, struct timespec *, int);
 	int (*atomic_open)(struct inode *, struct dentry *, struct file *,
-			unsigned open_flag, umode_t create_mode, int *opened);
+			unsigned open_flag, umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 };
 
@@ -496,13 +496,15 @@ otherwise noted.
 
   atomic_open: called on the last component of an open.  Using this optional
   	method the filesystem can look up, possibly create and open the file in
-  	one atomic operation.  If it cannot perform this (e.g. the file type
-  	turned out to be wrong) it may signal this by returning 1 instead of
-	usual 0 or -ve .  This method is only called if the last component is
-	negative or needs lookup.  Cached positive dentries are still handled by
-	f_op->open().  If the file was created, the FILE_CREATED flag should be
-	set in "opened".  In case of O_EXCL the method must only succeed if the
-	file didn't exist and hence FILE_CREATED shall always be set on success.
+	one atomic operation.  If it wants to leave actual opening to the
+	caller (e.g. if the file turned out to be a symlink, device, or just
+	something filesystem won't do atomic open for), it may signal this by
+	returning finish_no_open(file, dentry).  This method is only called if
+	the last component is negative or needs lookup.  Cached positive dentries
+	are still handled by f_op->open().  If the file was created,
+	FMODE_CREATED flag should be set in file->f_mode.  In case of O_EXCL
+	the method must only succeed if the file didn't exist and hence FMODE_CREATED
+	shall always be set on success.
 
   tmpfile: called in the end of O_TMPFILE open().  Optional, equivalent to
 	atomically creating, opening and unlinking a file in given directory.
-- 
2.11.0

