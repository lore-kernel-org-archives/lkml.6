Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE7220661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE7220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbeICVqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:46:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45776 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeICVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:46:47 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 41233D24;
        Mon,  3 Sep 2018 17:25:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+b62f08f4d5857755e3bc@syzkaller.appspotmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 123/165] fuse: Fix oops at process_init_reply()
Date:   Mon,  3 Sep 2018 18:56:49 +0200
Message-Id: <20180903165701.721757383@linuxfoundation.org>
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

commit e8f3bd773d22f488724dffb886a1618da85c2966 upstream.

syzbot is hitting NULL pointer dereference at process_init_reply().
This is because deactivate_locked_super() is called before response for
initial request is processed.

Fix this by aborting and waiting for all requests (including FUSE_INIT)
before resetting fc->sb.

Original patch by Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>.

Reported-by: syzbot <syzbot+b62f08f4d5857755e3bc@syzkaller.appspotmail.com>
Fixes: e27c9d3877a0 ("fuse: fuse: add time_gran to INIT_OUT")
Cc: <stable@vger.kernel.org> # v3.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/inode.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -397,11 +397,6 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	fuse_send_destroy(fc);
-
-	fuse_abort_conn(fc);
-	fuse_wait_aborted(fc);
-
 	mutex_lock(&fuse_mutex);
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);
@@ -1198,16 +1193,25 @@ static struct dentry *fuse_mount(struct
 	return mount_nodev(fs_type, flags, raw_data, fuse_fill_super);
 }
 
-static void fuse_kill_sb_anon(struct super_block *sb)
+static void fuse_sb_destroy(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
 	if (fc) {
+		fuse_send_destroy(fc);
+
+		fuse_abort_conn(fc);
+		fuse_wait_aborted(fc);
+
 		down_write(&fc->killsb);
 		fc->sb = NULL;
 		up_write(&fc->killsb);
 	}
+}
 
+static void fuse_kill_sb_anon(struct super_block *sb)
+{
+	fuse_sb_destroy(sb);
 	kill_anon_super(sb);
 }
 
@@ -1230,14 +1234,7 @@ static struct dentry *fuse_mount_blk(str
 
 static void fuse_kill_sb_blk(struct super_block *sb)
 {
-	struct fuse_conn *fc = get_fuse_conn_super(sb);
-
-	if (fc) {
-		down_write(&fc->killsb);
-		fc->sb = NULL;
-		up_write(&fc->killsb);
-	}
-
+	fuse_sb_destroy(sb);
 	kill_block_super(sb);
 }
 


