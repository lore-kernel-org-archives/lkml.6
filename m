Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD711C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD002085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbeKFTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:60018 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387498AbeKFTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:34 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxu4-00039H-UH; Tue, 06 Nov 2018 12:44:09 +0300
Subject: [PATCH 6/6] fuse: Protect fuse_file::reserved_req via corresponding
 fuse_inode::lock
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:44:08 +0300
Message-ID: <154149744887.18189.9866673230837073311.stgit@localhost.localdomain>
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

This is rather natural action after previous patches,
and it just decreases load of fc->lock.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c    |   10 ++++++----
 fs/fuse/fuse_i.h |    5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3bfc5ed61c9a..cc8b95ad5b16 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -247,17 +247,18 @@ static struct fuse_req *get_reserved_req(struct fuse_conn *fc,
 					 struct file *file)
 {
 	struct fuse_req *req = NULL;
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	struct fuse_file *ff = file->private_data;
 
 	do {
 		wait_event(fc->reserved_req_waitq, ff->reserved_req);
-		spin_lock(&fc->lock);
+		spin_lock(&fi->lock);
 		if (ff->reserved_req) {
 			req = ff->reserved_req;
 			ff->reserved_req = NULL;
 			req->stolen_file = get_file(file);
 		}
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 	} while (!req);
 
 	return req;
@@ -269,16 +270,17 @@ static struct fuse_req *get_reserved_req(struct fuse_conn *fc,
 static void put_reserved_req(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct file *file = req->stolen_file;
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	struct fuse_file *ff = file->private_data;
 
 	WARN_ON(req->max_pages);
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	memset(req, 0, sizeof(*req));
 	fuse_request_init(req, NULL, NULL, 0);
 	BUG_ON(ff->reserved_req);
 	ff->reserved_req = req;
 	wake_up_all(&fc->reserved_req_waitq);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 	fput(file);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f7442bcecbb0..10b20a24f693 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -166,7 +166,10 @@ struct fuse_file {
 	/** Fuse connection for this file */
 	struct fuse_conn *fc;
 
-	/** Request reserved for flush and release */
+	/*
+	 * Request reserved for flush and release.
+	 * Modified under relative fuse_inode::lock.
+	 */
 	struct fuse_req *reserved_req;
 
 	/** Kernel file handle guaranteed to be unique */

