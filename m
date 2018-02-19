Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeBSPUi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:20:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752934AbeBSPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:20:37 -0500
From: Nikolay Borisov <nborisov@suse.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] fs: Improve comment of inode_dio_begin
Date: Mon, 19 Feb 2018 17:20:29 +0200
Message-Id: <1519053629-14114-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the description of the function was a direct copy/paste of
inode_dio_end and as such made no sense. So rewrite it to correctly
state this is used before starting an io. Also document the locking
requirements, since currently one has to look at the definition of
inode_dio_wait to see the requirement of a lock being held while
bumping i_dio_count.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/linux/fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 511fbaabf624..90ac851930ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3015,8 +3015,10 @@ void inode_dio_wait(struct inode *inode);
  * inode_dio_begin - signal start of a direct I/O requests
  * @inode: inode the direct I/O happens on
  *
- * This is called once we've finished processing a direct I/O request,
- * and is used to wake up callers waiting for direct I/O to be quiesced.
+ * This is called before we begin processing a direct I/O request,
+ * and is used to quiesce callers of inode_dio_wait. It must be
+ * called under a lock that serialising getting a reference to
+ * ->i_dio_count (usually the inode_lock)
  */
 static inline void inode_dio_begin(struct inode *inode)
 {
-- 
2.7.4
