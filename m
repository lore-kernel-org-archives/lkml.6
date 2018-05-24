Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032684AbeEXUU2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:20:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968892AbeEXUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:20:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] fuse: fix NULL dereference when new_inode() fails
Date: Thu, 24 May 2018 21:20:04 +0100
Message-Id: <20180524202004.7813-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse_ctl_remove_conn() dereferences d_inode(fc->ctl_dentry[i]).  If
fuse_ctl_add_dentry() failed to allocate the inode then this field is
NULL and it's not safe to call fuse_ctl_remove_conn().

This patch frees partially initialized dentries in the
fuse_ctl_add_dentry() error case to solve the NULL dereference.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I spotted this when reading the code.  Compile-tested only.

 fs/fuse/control.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index b9ea99c5b5b3..ef3af9c32147 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -211,10 +211,13 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 	if (!dentry)
 		return NULL;
 
-	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 	inode = new_inode(fuse_control_sb);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return NULL;
+	}
+
+	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-- 
2.17.0
