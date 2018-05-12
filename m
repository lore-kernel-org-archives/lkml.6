Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeELFBe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37608 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeELFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:29 -0400
X-Google-Smtp-Source: AB8JxZrsqfVAAfRcL3RZHK3DsIDQvaOz03LbsTeKrs7mQljGUxb53h7vbhoHhIrw1uETkzw4Bcxj3A==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        trond.myklebust@primarydata.com
Subject: [PATCH 4/6] fs: nfs: get rid of memcpys for inode times
Date: Fri, 11 May 2018 21:59:19 -0700
Message-Id: <20180512045921.18311-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches in the series convert inode timestamps
to use struct timespec64 instead of struct timespec as
part of solving the y2038 problem.
This will lead to type mismatch for memcpys.
Use regular assignments instead.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: trond.myklebust@primarydata.com
---
 fs/nfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bd15d0b57626..55b62254dd7c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1315,13 +1315,13 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_CTIME)
 			&& timespec_equal(&inode->i_ctime, &fattr->pre_ctime)) {
-		memcpy(&inode->i_ctime, &fattr->ctime, sizeof(inode->i_ctime));
+		inode->i_ctime = fattr->ctime;
 	}
 
 	if ((fattr->valid & NFS_ATTR_FATTR_PREMTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_MTIME)
 			&& timespec_equal(&inode->i_mtime, &fattr->pre_mtime)) {
-		memcpy(&inode->i_mtime, &fattr->mtime, sizeof(inode->i_mtime));
+		inode->i_mtime = fattr->mtime;
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
@@ -1667,12 +1667,12 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_CTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PRECTIME) == 0) {
-		memcpy(&fattr->pre_ctime, &inode->i_ctime, sizeof(fattr->pre_ctime));
+		fattr->pre_ctime = inode->i_ctime;
 		fattr->valid |= NFS_ATTR_FATTR_PRECTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PREMTIME) == 0) {
-		memcpy(&fattr->pre_mtime, &inode->i_mtime, sizeof(fattr->pre_mtime));
+		fattr->pre_mtime = inode->i_mtime;
 		fattr->valid |= NFS_ATTR_FATTR_PREMTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_SIZE) != 0 &&
@@ -1829,7 +1829,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
-		memcpy(&inode->i_mtime, &fattr->mtime, sizeof(inode->i_mtime));
+		inode->i_mtime = fattr->mtime;
 	} else if (server->caps & NFS_CAP_MTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_MTIME
@@ -1838,7 +1838,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
-		memcpy(&inode->i_ctime, &fattr->ctime, sizeof(inode->i_ctime));
+		inode->i_ctime = fattr->ctime;
 	} else if (server->caps & NFS_CAP_CTIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CTIME
@@ -1875,7 +1875,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-		memcpy(&inode->i_atime, &fattr->atime, sizeof(inode->i_atime));
+		inode->i_atime = fattr->atime;
 	else if (server->caps & NFS_CAP_ATIME) {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_ATIME
-- 
2.17.0
