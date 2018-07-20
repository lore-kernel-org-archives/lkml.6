Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6EBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeGTNOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B740BC1;
        Fri, 20 Jul 2018 12:26:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4349872271ece473a7c91190b68b4bac7c5dbc87@syzkaller.appspotmail.com,
        syzbot+40bd32c4d9a3cc12a339@syzkaller.appspotmail.com,
        syzbot+769c54e66f994b041be7@syzkaller.appspotmail.com,
        syzbot+0a89a9ce473936c57065@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3.18 09/29] loop: add recursion validation to LOOP_CHANGE_FD
Date:   Fri, 20 Jul 2018 14:11:04 +0200
Message-Id: <20180720115159.309929348@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit d2ac838e4cd7e5e9891ecc094d626734b0245c99 upstream.

Refactor the validation code used in LOOP_SET_FD so it is also used in
LOOP_CHANGE_FD.  Otherwise it is possible to construct a set of loop
devices that all refer to each other.  This can lead to a infinite
loop in starting with "while (is_loop_device(f)) .." in loop_set_fd().

Fix this by refactoring out the validation code and using it for
LOOP_CHANGE_FD as well as LOOP_SET_FD.

Reported-by: syzbot+4349872271ece473a7c91190b68b4bac7c5dbc87@syzkaller.appspotmail.com
Reported-by: syzbot+40bd32c4d9a3cc12a339@syzkaller.appspotmail.com
Reported-by: syzbot+769c54e66f994b041be7@syzkaller.appspotmail.com
Reported-by: syzbot+0a89a9ce473936c57065@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   68 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -628,6 +628,36 @@ out:
 }
 
 
+static inline int is_loop_device(struct file *file)
+{
+	struct inode *i = file->f_mapping->host;
+
+	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
+}
+
+static int loop_validate_file(struct file *file, struct block_device *bdev)
+{
+	struct inode	*inode = file->f_mapping->host;
+	struct file	*f = file;
+
+	/* Avoid recursion */
+	while (is_loop_device(f)) {
+		struct loop_device *l;
+
+		if (f->f_mapping->host->i_bdev == bdev)
+			return -EBADF;
+
+		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		if (l->lo_state == Lo_unbound) {
+			return -EINVAL;
+		}
+		f = l->lo_backing_file;
+	}
+	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -657,14 +687,15 @@ static int loop_change_fd(struct loop_de
 	if (!file)
 		goto out;
 
+	error = loop_validate_file(file, bdev);
+	if (error)
+		goto out_putf;
+
 	inode = file->f_mapping->host;
 	old_file = lo->lo_backing_file;
 
 	error = -EINVAL;
 
-	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
-		goto out_putf;
-
 	/* size of the new backing store needs to be the same */
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
 		goto out_putf;
@@ -685,13 +716,6 @@ static int loop_change_fd(struct loop_de
 	return error;
 }
 
-static inline int is_loop_device(struct file *file)
-{
-	struct inode *i = file->f_mapping->host;
-
-	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
-}
-
 /* loop sysfs attributes */
 
 static ssize_t loop_attr_show(struct device *dev, char *page,
@@ -823,7 +847,7 @@ static void loop_config_discard(struct l
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
-	struct file	*file, *f;
+	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
 	unsigned lo_blocksize;
@@ -843,29 +867,13 @@ static int loop_set_fd(struct loop_devic
 	if (lo->lo_state != Lo_unbound)
 		goto out_putf;
 
-	/* Avoid recursion */
-	f = file;
-	while (is_loop_device(f)) {
-		struct loop_device *l;
-
-		if (f->f_mapping->host->i_bdev == bdev)
-			goto out_putf;
-
-		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
-		if (l->lo_state == Lo_unbound) {
-			error = -EINVAL;
-			goto out_putf;
-		}
-		f = l->lo_backing_file;
-	}
+	error = loop_validate_file(file, bdev);
+	if (error)
+		goto out_putf;
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
-	error = -EINVAL;
-	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
-		goto out_putf;
-
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
 	    !file->f_op->write)
 		lo_flags |= LO_FLAGS_READ_ONLY;


