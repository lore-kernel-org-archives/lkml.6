Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161953AbeE1Ken (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161940AbeE1Kej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:34:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 155/329] ceph: fix dentry leak when failing to init debugfs
Date: Mon, 28 May 2018 12:01:24 +0200
Message-Id: <20180528100255.411283035@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu519@icloud.com>

[ Upstream commit 18106734b512664a8541026519ce4b862498b6c3 ]

When failing from ceph_fs_debugfs_init() in ceph_real_mount(),
there is lack of dput of root_dentry and it causes slab errors,
so change the calling order of ceph_fs_debugfs_init() and
open_root_dentry() and do some cleanups to avoid this issue.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -816,7 +816,6 @@ static struct dentry *ceph_real_mount(st
 	int err;
 	unsigned long started = jiffies;  /* note the start time */
 	struct dentry *root;
-	int first = 0;   /* first vfsmount for this super_block */
 
 	dout("mount start %p\n", fsc);
 	mutex_lock(&fsc->client->mount_mutex);
@@ -834,17 +833,17 @@ static struct dentry *ceph_real_mount(st
 			path = fsc->mount_options->server_path + 1;
 			dout("mount opening path %s\n", path);
 		}
+
+		err = ceph_fs_debugfs_init(fsc);
+		if (err < 0)
+			goto out;
+
 		root = open_root_dentry(fsc, path, started);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto out;
 		}
 		fsc->sb->s_root = dget(root);
-		first = 1;
-
-		err = ceph_fs_debugfs_init(fsc);
-		if (err < 0)
-			goto fail;
 	} else {
 		root = dget(fsc->sb->s_root);
 	}
@@ -854,11 +853,6 @@ static struct dentry *ceph_real_mount(st
 	mutex_unlock(&fsc->client->mount_mutex);
 	return root;
 
-fail:
-	if (first) {
-		dput(fsc->sb->s_root);
-		fsc->sb->s_root = NULL;
-	}
 out:
 	mutex_unlock(&fsc->client->mount_mutex);
 	return ERR_PTR(err);
