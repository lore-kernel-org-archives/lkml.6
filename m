Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDEUae (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751251AbeDEUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/20] afs: Init inode before accessing cache
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:30 +0100
Message-ID: <152296023007.31027.23954304832804479.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer parse symlinks when we get the inode to determine if this
symlink is actually a mountpoint as we detect that by examining the mode
instead (symlinks are always 0777 and mountpoints 0644).

Access the cache after mapping the status so that we don't have to manually
set the inode size now.

Note that this may need adjusting if the disconnected operation is
implemented as the file metadata may have to be obtained from the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f4e62964efcb..bcaff40b664d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -331,15 +331,12 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 		vnode->cb_expires_at += ktime_get_real_seconds();
 	}
 
-	/* set up caching before mapping the status, as map-status reads the
-	 * first page of symlinks to see if they're really mountpoints */
-	inode->i_size = vnode->status.size;
-	afs_get_inode_cache(vnode);
-
 	ret = afs_inode_map_status(vnode, key);
 	if (ret < 0)
 		goto bad_inode;
 
+	afs_get_inode_cache(vnode);
+
 	/* success */
 	clear_bit(AFS_VNODE_UNSET, &vnode->flags);
 	inode->i_flags |= S_NOATIME;
