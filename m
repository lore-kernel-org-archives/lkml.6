Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937626AbeE1NrM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937507AbeE1Kmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:42:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 005/496] affs_lookup(): close a race with affs_remove_link()
Date: Mon, 28 May 2018 11:56:30 +0200
Message-Id: <20180528100319.764203737@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30da870ce4a4e007c901858a96e9e394a1daa74a upstream.

we unlock the directory hash too early - if we are looking at secondary
link and primary (in another directory) gets removed just as we unlock,
we could have the old primary moved in place of the secondary, leaving
us to look into freed entry (and leaving our dentry with ->d_fsdata
pointing to a freed entry).

Cc: stable@vger.kernel.org # 2.4.4+
Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/affs/namei.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -206,9 +206,10 @@ affs_lookup(struct inode *dir, struct de
 
 	affs_lock_dir(dir);
 	bh = affs_find_entry(dir, dentry);
-	affs_unlock_dir(dir);
-	if (IS_ERR(bh))
+	if (IS_ERR(bh)) {
+		affs_unlock_dir(dir);
 		return ERR_CAST(bh);
+	}
 	if (bh) {
 		u32 ino = bh->b_blocknr;
 
@@ -222,10 +223,13 @@ affs_lookup(struct inode *dir, struct de
 		}
 		affs_brelse(bh);
 		inode = affs_iget(sb, ino);
-		if (IS_ERR(inode))
+		if (IS_ERR(inode)) {
+			affs_unlock_dir(dir);
 			return ERR_CAST(inode);
+		}
 	}
 	d_add(dentry, inode);
+	affs_unlock_dir(dir);
 	return NULL;
 }
 
