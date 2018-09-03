Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38958C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A7D20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A7D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeICVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:46:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeICVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:46:35 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D78CD24;
        Mon,  3 Sep 2018 17:25:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 119/165] fuse: fix initial parallel dirops
Date:   Mon,  3 Sep 2018 18:56:45 +0200
Message-Id: <20180903165701.510565209@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 63576c13bd17848376c8ba4a98f5d5151140c4ac upstream.

If parallel dirops are enabled in FUSE_INIT reply, then first operation may
leave fi->mutex held.

Reported-by: syzbot <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com>
Fixes: 5c672ab3f0ee ("fuse: serialize dirops by default")
Cc: <stable@vger.kernel.org> # v4.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dir.c    |   10 ++++++----
 fs/fuse/fuse_i.h |    4 ++--
 fs/fuse/inode.c  |   14 ++++++++++----
 3 files changed, 18 insertions(+), 10 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -355,11 +355,12 @@ static struct dentry *fuse_lookup(struct
 	struct inode *inode;
 	struct dentry *newent;
 	bool outarg_valid = true;
+	bool locked;
 
-	fuse_lock_inode(dir);
+	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
 			       &outarg, &inode);
-	fuse_unlock_inode(dir);
+	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
 		err = 0;
@@ -1332,6 +1333,7 @@ static int fuse_readdir(struct file *fil
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req;
 	u64 attr_version = 0;
+	bool locked;
 
 	if (is_bad_inode(inode))
 		return -EIO;
@@ -1359,9 +1361,9 @@ static int fuse_readdir(struct file *fil
 		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
 			       FUSE_READDIR);
 	}
-	fuse_lock_inode(inode);
+	locked = fuse_lock_inode(inode);
 	fuse_request_send(fc, req);
-	fuse_unlock_inode(inode);
+	fuse_unlock_inode(inode, locked);
 	nbytes = req->out.args[0].size;
 	err = req->out.h.error;
 	fuse_put_request(fc, req);
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -964,8 +964,8 @@ int fuse_do_setattr(struct dentry *dentr
 
 void fuse_set_initialized(struct fuse_conn *fc);
 
-void fuse_unlock_inode(struct inode *inode);
-void fuse_lock_inode(struct inode *inode);
+void fuse_unlock_inode(struct inode *inode, bool locked);
+bool fuse_lock_inode(struct inode *inode);
 
 int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 		  size_t size, int flags);
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -357,15 +357,21 @@ int fuse_reverse_inval_inode(struct supe
 	return 0;
 }
 
-void fuse_lock_inode(struct inode *inode)
+bool fuse_lock_inode(struct inode *inode)
 {
-	if (!get_fuse_conn(inode)->parallel_dirops)
+	bool locked = false;
+
+	if (!get_fuse_conn(inode)->parallel_dirops) {
 		mutex_lock(&get_fuse_inode(inode)->mutex);
+		locked = true;
+	}
+
+	return locked;
 }
 
-void fuse_unlock_inode(struct inode *inode)
+void fuse_unlock_inode(struct inode *inode, bool locked)
 {
-	if (!get_fuse_conn(inode)->parallel_dirops)
+	if (locked)
 		mutex_unlock(&get_fuse_inode(inode)->mutex);
 }
 


