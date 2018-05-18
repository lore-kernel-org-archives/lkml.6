Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeERMeb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbeERMeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:21 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 04/11] vfs: add errseq_t pointer to __sync_filesystem
Date: Fri, 18 May 2018 08:34:08 -0400
Message-Id: <20180518123415.28181-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

...and pass that to the sync_fs operation. Also, have __sync_filesystem
return the error from sync_fs (if there is one).

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/sync.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index fc0b7bd51ae6..c876fa414cae 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -28,14 +28,16 @@
  * wait == 1 case since in that case write_inode() functions do
  * sync_dirty_buffer() and thus effectively write one block at a time.
  */
-static int __sync_filesystem(struct super_block *sb, int wait)
+static int __sync_filesystem(struct super_block *sb, int wait, errseq_t *since)
 {
+	int ret = 0;
+
 	if (wait)
 		sync_inodes_sb(sb);
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
-	return call_sync_fs(sb, wait, NULL);
+	return call_sync_fs(sb, wait, since);
 }
 
 /*
@@ -59,10 +61,10 @@ int sync_filesystem(struct super_block *sb, errseq_t *since)
 	if (sb_rdonly(sb))
 		return 0;
 
-	ret = __sync_filesystem(sb, 0);
+	ret = __sync_filesystem(sb, 0, since);
 	if (ret < 0)
 		return ret;
-	return __sync_filesystem(sb, 1);
+	return __sync_filesystem(sb, 1, since);
 }
 EXPORT_SYMBOL(sync_filesystem);
 
-- 
2.17.0
