Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E15BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5772085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeKFTIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:59846 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:05 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxtd-00035K-MY; Tue, 06 Nov 2018 12:43:41 +0300
Subject: [PATCH 1/6] fuse: Change argument of fuse_flush_writepages()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:43:41 +0300
Message-ID: <154149742122.18189.7228444587279544540.stgit@localhost.localdomain>
In-Reply-To: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patches introduce fuse_inode::lock, which will be used
in __releases() and __acquires() instead of fc->lock.
This patch makes this function to use argument fuse_inode
instead of inode as preparation for that.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dir.c    |    2 +-
 fs/fuse/file.c   |    8 ++++----
 fs/fuse/fuse_i.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 47395b0c3b35..c71f7e9ee0f7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1360,7 +1360,7 @@ static void __fuse_release_nowrite(struct inode *inode)
 
 	BUG_ON(fi->writectr != FUSE_NOWRITE);
 	fi->writectr = 0;
-	fuse_flush_writepages(inode);
+	fuse_flush_writepages(fi);
 }
 
 void fuse_release_nowrite(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cc2121b37bf5..d5bd29610875 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1522,12 +1522,12 @@ __acquires(fc->lock)
  *
  * Called with fc->lock
  */
-void fuse_flush_writepages(struct inode *inode)
+void fuse_flush_writepages(struct fuse_inode *fi)
 __releases(fc->lock)
 __acquires(fc->lock)
 {
+	struct inode *inode = &fi->inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	size_t crop = i_size_read(inode);
 	struct fuse_req *req;
 
@@ -1670,7 +1670,7 @@ static int fuse_writepage_locked(struct page *page)
 	spin_lock(&fc->lock);
 	list_add(&req->writepages_entry, &fi->writepages);
 	list_add_tail(&req->list, &fi->queued_writes);
-	fuse_flush_writepages(inode);
+	fuse_flush_writepages(fi);
 	spin_unlock(&fc->lock);
 
 	end_page_writeback(page);
@@ -1728,7 +1728,7 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	req->ff = fuse_file_get(data->ff);
 	spin_lock(&fc->lock);
 	list_add_tail(&req->list, &fi->queued_writes);
-	fuse_flush_writepages(inode);
+	fuse_flush_writepages(fi);
 	spin_unlock(&fc->lock);
 
 	for (i = 0; i < num_pages; i++)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e9f712e81c7d..38bd7ca1908a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -995,7 +995,7 @@ void fuse_update_ctime(struct inode *inode);
 
 int fuse_update_attributes(struct inode *inode, struct file *file);
 
-void fuse_flush_writepages(struct inode *inode);
+void fuse_flush_writepages(struct fuse_inode *fi);
 
 void fuse_set_nowrite(struct inode *inode);
 void fuse_release_nowrite(struct inode *inode);

