Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeE1QGM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965861AbeE1KOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:14:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 019/268] NFSv4: always set NFS_LOCK_LOST when a lock is lost.
Date: Mon, 28 May 2018 11:59:53 +0200
Message-Id: <20180528100204.273457878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

[ Upstream commit dce2630c7da73b0634686bca557cc8945cc450c8 ]

There are 2 comments in the NFSv4 code which suggest that
SIGLOST should possibly be sent to a process.  In these
cases a lock has been lost.
The current practice is to set NFS_LOCK_LOST so that
read/write returns EIO when a lock is lost.
So change these comments to code when sets NFS_LOCK_LOST.

One case is when lock recovery after apparent server restart
fails with NFS4ERR_DENIED, NFS4ERR_RECLAIM_BAD, or
NFS4ERRO_RECLAIM_CONFLICT.  The other case is when a lock
attempt as part of lease recovery fails with NFS4ERR_DENIED.

In an ideal world, these should not happen.  However I have
a packet trace showing an NFSv4.1 session getting
NFS4ERR_BADSESSION after an extended network parition.  The
NFSv4.1 client treats this like server reboot until/unless
it get NFS4ERR_NO_GRACE, in which case it switches over to
"nograce" recovery mode.  In this network trace, the client
attempts to recover a lock and the server (incorrectly)
reports NFS4ERR_DENIED rather than NFS4ERR_NO_GRACE.  This
leads to the ineffective comment and the client then
continues to write using the OPEN stateid.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c  |   12 ++++++++----
 fs/nfs/nfs4state.c |    5 ++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1780,7 +1780,7 @@ static int nfs4_open_reclaim(struct nfs4
 	return ret;
 }
 
-static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, int err)
+static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, struct file_lock *fl, int err)
 {
 	switch (err) {
 		default:
@@ -1827,7 +1827,11 @@ static int nfs4_handle_delegation_recall
 			return -EAGAIN;
 		case -ENOMEM:
 		case -NFS4ERR_DENIED:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			if (fl) {
+				struct nfs4_lock_state *lsp = fl->fl_u.nfs4_fl.owner;
+				if (lsp)
+					set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
+			}
 			return 0;
 	}
 	return err;
@@ -1863,7 +1867,7 @@ int nfs4_open_delegation_recall(struct n
 		err = nfs4_open_recover_helper(opendata, FMODE_READ);
 	}
 	nfs4_opendata_put(opendata);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, NULL, err);
 }
 
 static void nfs4_open_confirm_prepare(struct rpc_task *task, void *calldata)
@@ -6157,7 +6161,7 @@ int nfs4_lock_delegation_recall(struct f
 	if (err != 0)
 		return err;
 	err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-	return nfs4_handle_delegation_recall_error(server, state, stateid, err);
+	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
 struct nfs_release_lockowner_data {
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1386,6 +1386,7 @@ static int nfs4_reclaim_locks(struct nfs
 	struct inode *inode = state->inode;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct file_lock *fl;
+	struct nfs4_lock_state *lsp;
 	int status = 0;
 	struct file_lock_context *flctx = inode->i_flctx;
 	struct list_head *list;
@@ -1426,7 +1427,9 @@ restart:
 		case -NFS4ERR_DENIED:
 		case -NFS4ERR_RECLAIM_BAD:
 		case -NFS4ERR_RECLAIM_CONFLICT:
-			/* kill_proc(fl->fl_pid, SIGLOST, 1); */
+			lsp = fl->fl_u.nfs4_fl.owner;
+			if (lsp)
+				set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
 			status = 0;
 		}
 		spin_lock(&flctx->flc_lock);
