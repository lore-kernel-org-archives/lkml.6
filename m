Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA849C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6F2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D6F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLIWJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37466 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbeLIWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:43 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002io-IL; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Hu-Mh; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Miklos Szeredi" <mszeredi@suse.cz>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.771535635@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 072/328] fuse: flush requests on umount
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@suse.cz>

commit 580640ba5d331eb5631a5de46941c98f5ed90886 upstream.

Use fuse_abort_conn() instead of fuse_conn_kill() in fuse_put_super().
This flushes and aborts requests still on any queues.  But since we've
already reset fc->connected, those requests would not be useful anyway and
would be flushed when the fuse device is closed.

Next patches will rely on requests being flushed before the superblock is
destroyed.

Use fuse_abort_conn() in cuse_process_init_reply() too, since it makes no
difference there, and we can get rid of fuse_conn_kill().

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/cuse.c   |  2 +-
 fs/fuse/fuse_i.h |  2 --
 fs/fuse/inode.c  | 16 +---------------
 3 files changed, 2 insertions(+), 18 deletions(-)

--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -415,7 +415,7 @@ err_unlock:
 err_region:
 	unregister_chrdev_region(devt, 1);
 err:
-	fuse_conn_kill(fc);
+	fuse_abort_conn(fc);
 	goto out;
 }
 
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -804,8 +804,6 @@ void fuse_invalidate_atime(struct inode
  */
 struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
 
-void fuse_conn_kill(struct fuse_conn *fc);
-
 /**
  * Initialize fuse_conn
  */
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -376,27 +376,13 @@ static void fuse_bdi_destroy(struct fuse
 		bdi_destroy(&fc->bdi);
 }
 
-void fuse_conn_kill(struct fuse_conn *fc)
-{
-	spin_lock(&fc->lock);
-	fc->connected = 0;
-	fc->blocked = 0;
-	fc->initialized = 1;
-	spin_unlock(&fc->lock);
-	/* Flush all readers on this fs */
-	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
-	wake_up_all(&fc->waitq);
-	wake_up_all(&fc->blocked_waitq);
-}
-EXPORT_SYMBOL_GPL(fuse_conn_kill);
-
 static void fuse_put_super(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
 	fuse_send_destroy(fc);
 
-	fuse_conn_kill(fc);
+	fuse_abort_conn(fc);
 	mutex_lock(&fuse_mutex);
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);

