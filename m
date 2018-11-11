Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBAEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABFB214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABFB214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeKLFsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49496 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729532AbeKLFsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:06 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000l6-64; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Un-MY; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "syzbot" <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>,
        "Miklos Szeredi" <mszeredi@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.662417516@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 100/366] fuse: fix control dir setup and teardown
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 6becdb601bae2a043d7fb9762c4d48699528ea6e upstream.

syzbot is reporting NULL pointer dereference at fuse_ctl_remove_conn() [1].
Since fc->ctl_ndents is incremented by fuse_ctl_add_conn() when new_inode()
failed, fuse_ctl_remove_conn() reaches an inode-less dentry and tries to
clear d_inode(dentry)->i_private field.

Fix by only adding the dentry to the array after being fully set up.

When tearing down the control directory, do d_invalidate() on it to get rid
of any mounts that might have been added.

[1] https://syzkaller.appspot.com/bug?id=f396d863067238959c91c0b7cfc10b163638cac6
Reported-by: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>
Fixes: bafa96541b25 ("[PATCH] fuse: add control filesystem")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/control.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -211,10 +211,11 @@ static struct dentry *fuse_ctl_add_dentr
 	if (!dentry)
 		return NULL;
 
-	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 	inode = new_inode(fuse_control_sb);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return NULL;
+	}
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
@@ -228,6 +229,9 @@ static struct dentry *fuse_ctl_add_dentr
 	set_nlink(inode, nlink);
 	inode->i_private = fc;
 	d_add(dentry, inode);
+
+	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
+
 	return dentry;
 }
 
@@ -284,7 +288,10 @@ void fuse_ctl_remove_conn(struct fuse_co
 	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
 		struct dentry *dentry = fc->ctl_dentry[i];
 		dentry->d_inode->i_private = NULL;
-		d_drop(dentry);
+		if (!i) {
+			/* Get rid of submounts: */
+			d_invalidate(dentry);
+		}
 		dput(dentry);
 	}
 	drop_nlink(fuse_control_sb->s_root->d_inode);

