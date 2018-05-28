Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425084AbeE1NTR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163240AbeE1Ktm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 191/496] btrfs: use kvzalloc to allocate btrfs_fs_info
Date: Mon, 28 May 2018 11:59:36 +0200
Message-Id: <20180528100327.993313441@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

[ Upstream commit a8fd1f71749387c9a1053a83ff1c16287499a4e7 ]

The srcu_struct in btrfs_fs_info scales in size with NR_CPUS.  On
kernels built with NR_CPUS=8192, this can result in kmalloc failures
that prevent mounting.

There is work in progress to try to resolve this for every user of
srcu_struct but using kvzalloc will work around the failures until
that is complete.

As an example with NR_CPUS=512 on x86_64: the overall size of
subvol_srcu is 3460 bytes, fs_info is 6496.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h |    2 +-
 fs/btrfs/super.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2969,7 +2969,7 @@ static inline void free_fs_info(struct b
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	security_free_mnt_opts(&fs_info->security_opts);
-	kfree(fs_info);
+	kvfree(fs_info);
 }
 
 /* tree mod log functions from ctree.c */
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1581,7 +1581,7 @@ static struct dentry *btrfs_mount(struct
 	 * it for searching for existing supers, so this lets us do that and
 	 * then open_ctree will properly initialize everything later.
 	 */
-	fs_info = kzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
+	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
 	if (!fs_info) {
 		error = -ENOMEM;
 		goto error_sec_opts;
