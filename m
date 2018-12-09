Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B33520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B33520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeLIWGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37024 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbeLIWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:58 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002iq-IJ; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Hz-Nu; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Miklos Szeredi" <mszeredi@redhat.com>,
        "syzbot" <syzbot+b62f08f4d5857755e3bc@syzkaller.appspotmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.892501765@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 073/328] fuse: Fix oops at process_init_reply()
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
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16:
 - Drop second argument to fuse_abort_conn()
 - fuse_wait_aborted() is not needed]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -380,9 +380,6 @@ static void fuse_put_super(struct super_
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	fuse_send_destroy(fc);
-
-	fuse_abort_conn(fc);
 	mutex_lock(&fuse_mutex);
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);
@@ -1124,16 +1121,24 @@ static struct dentry *fuse_mount(struct
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
 
@@ -1156,14 +1161,7 @@ static struct dentry *fuse_mount_blk(str
 
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
 

