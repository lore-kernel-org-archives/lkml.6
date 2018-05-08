Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeEHSFI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeEHSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:02 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 09/76] net: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:29 -0700
Message-Id: <20180508180436.716-10-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 net/sunrpc/auth_gss/auth_gss.c | 4 ++--
 net/sunrpc/rpc_pipe.c          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 9463af4b32e8..3560956424fe 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -769,7 +769,7 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 
 static int gss_pipe_open(struct inode *inode, int new_version)
 {
-	struct net *net = inode->i_sb->s_fs_info;
+	struct net *net = inode_sb(inode)->s_fs_info;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	int ret = 0;
 
@@ -804,7 +804,7 @@ static int gss_pipe_open_v1(struct inode *inode)
 static void
 gss_pipe_release(struct inode *inode)
 {
-	struct net *net = inode->i_sb->s_fs_info;
+	struct net *net = inode_sb(inode)->s_fs_info;
 	struct rpc_pipe *pipe = RPC_I(inode)->pipe;
 	struct gss_upcall_msg *gss_msg;
 
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index fc97fc3ed637..c2851a1ee91c 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -497,10 +497,10 @@ static int __rpc_create_common(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 
 	d_drop(dentry);
-	inode = rpc_get_inode(dir->i_sb, mode);
+	inode = rpc_get_inode(inode_sb(dir), mode);
 	if (!inode)
 		goto out_err;
-	inode->i_ino = iunique(dir->i_sb, 100);
+	inode->i_ino = iunique(inode_sb(dir), 100);
 	if (i_fop)
 		inode->i_fop = i_fop;
 	if (private)
-- 
2.15.1
