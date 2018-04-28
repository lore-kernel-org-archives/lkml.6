Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759489AbeD1C35 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:29:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18342 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1C34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:29:56 -0400
Subject: Re: general protection fault in fuse_ctl_remove_conn
To: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
References: <000000000000c0a706056ad69897@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <cedce932-4275-8d7e-fa4a-d7f44b8bfd85@I-love.SAKURA.ne.jp>
Date: Sat, 28 Apr 2018 11:29:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000c0a706056ad69897@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 9f41081f8bd6762a6f629e5e23e6d07a62bba69c Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 28 Apr 2018 11:24:09 +0900
Subject: [PATCH] fuse: don't keep inode-less dentry at fuse_ctl_add_dentry().

syzbot is reporting NULL pointer dereference at fuse_ctl_remove_conn() [1].
Since fc->ctl_ndents is incremented by fuse_ctl_add_conn() when new_inode()
failed, fuse_ctl_remove_conn() reaches an inode-less dentry and tries to
clear d_inode(dentry)->i_private field. Fix this by calling dput() rather
than incrementing fc->ctl_ndents when new_inode() failed.

[1] https://syzkaller.appspot.com/bug?id=f396d863067238959c91c0b7cfc10b163638cac6

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>
Fixes: bafa96541b250a70 ("fuse: add control filesystem")
Cc: Miklos Szeredi <miklos@szeredi.hu>
---
 fs/fuse/control.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index b9ea99c..a651f8e 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -211,10 +211,12 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	if (!dentry)
 		return NULL;
 
-	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 	inode = new_inode(fuse_control_sb);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return NULL;
+	}
+	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-- 
1.8.3.1
