Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeERMfL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeERMe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:27 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 11/11] vfs: have call_sync_fs op report writeback errors when passed a since pointer
Date: Fri, 18 May 2018 08:34:15 -0400
Message-Id: <20180518123415.28181-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

...on filesystems that don't define a ->sync_fs operation.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/fs.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

NB: I'm not sure this is something we really want to do. It's a bit
cavalier and some filesystems might not like it if they are tracking
errors in other ways. An alternative here is to add a simple_sync_fs
helper that does this and add that to a whole swath of different fs'.

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fecd29325f36..1ff9d4d119cb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2505,9 +2505,18 @@ extern const struct file_operations def_chr_fops;
 static inline int call_sync_fs(struct super_block *sb, int wait,
 			       errseq_t *since)
 {
+	int ret;
+
 	if (sb->s_op->sync_fs)
 		return sb->s_op->sync_fs(sb, wait, since);
-	return __sync_blockdev(sb->s_bdev, wait);
+
+	ret = __sync_blockdev(sb->s_bdev, wait);
+	if (since) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
 }
 
 #ifdef CONFIG_BLOCK
-- 
2.17.0
