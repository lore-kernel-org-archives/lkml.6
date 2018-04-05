Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeDEUfb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:35:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752563AbeDEUav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:51 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/20] afs: Keep track of invalid-before version for dentry
 coherency
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:49 +0100
Message-ID: <152296024964.31027.13866165509723122881.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each afs dentry is tagged with the version that the parent directory was at
last time it was validated and, currently, if this differs, the directory
is scanned and the dentry is refreshed.

However, this leads to an excessive amount of revalidation on directories
that get modified on the client without conflict with another client.  We
know there's no conflict because the parent directory's data version number
got incremented by exactly 1 on any create, mkdir, unlink, etc., therefore
we can trust the current state of the unaffected dentries when we perform a
local directory modification.

Optimise by keeping track of the last version of the parent directory that
was changed outside of the client in the parent directory's vnode and using
that to validate the dentries rather than the current version.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |   20 +++++++++++++++-----
 fs/afs/fsclient.c |    1 +
 fs/afs/inode.c    |    1 +
 fs/afs/internal.h |    1 +
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 0e4945948a41..3c7fcd6ad9b7 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1035,7 +1035,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
-	void *dir_version;
+	long dir_version, de_version;
 	int ret;
 
 	if (flags & LOOKUP_RCU)
@@ -1079,9 +1079,19 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_bad_parent;
 	}
 
-	dir_version = (void *) (unsigned long) dir->status.data_version;
-	if (dentry->d_fsdata == dir_version)
-		goto out_valid; /* the dir contents are unchanged */
+	/* We only need to invalidate a dentry if the server's copy changed
+	 * behind our back.  If we made the change, it's no problem.  Note that
+	 * on a 32-bit system, we only have 32 bits in the dentry to store the
+	 * version.
+	 */
+	dir_version = (long)dir->status.data_version;
+	de_version = (long)dentry->d_fsdata;
+	if (de_version == dir_version)
+		goto out_valid;
+
+	dir_version = (long)dir->invalid_before;
+	if (de_version - dir_version >= 0)
+		goto out_valid;
 
 	_debug("dir modified");
 	afs_stat_v(dir, n_reval);
@@ -1140,7 +1150,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 out_valid:
-	dentry->d_fsdata = dir_version;
+	dentry->d_fsdata = (void *)dir_version;
 	dput(parent);
 	key_put(key);
 	_leave(" = 1 [valid]");
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index ff87fc6bb27f..f7570d229dcc 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -100,6 +100,7 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 			       (unsigned long long) status->data_version,
 			       vnode->fid.vid, vnode->fid.vnode,
 			       (unsigned long long) *expected_version);
+			vnode->invalid_before = status->data_version;
 			set_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
 		}
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 2e32d475ec11..07f450513f3e 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -83,6 +83,7 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 
 	inode->i_blocks		= 0;
 	inode->i_mapping->a_ops	= &afs_fs_aops;
+	vnode->invalid_before	= vnode->status.data_version;
 
 	read_sequnlock_excl(&vnode->cb_lock);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8eb0b663b86e..967acc096f3d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -477,6 +477,7 @@ struct afs_vnode {
 	struct afs_volume	*volume;	/* volume on which vnode resides */
 	struct afs_fid		fid;		/* the file identifier for this inode */
 	struct afs_file_status	status;		/* AFS status info for this file */
+	afs_dataversion_t	invalid_before;	/* Child dentries are invalid before this */
 #ifdef CONFIG_AFS_FSCACHE
 	struct fscache_cookie	*cache;		/* caching cookie */
 #endif
