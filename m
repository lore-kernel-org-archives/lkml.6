Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeCOMil (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:38:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCOMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:38 -0400
Message-Id: <20180315123202.683132967@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 07/11] sched/wait,nfs: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-7.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Cc: Anna Schumaker <anna.schumaker@netapp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/nfs/inode.c    |    5 -----
 fs/nfs/pagelist.c |    6 +++---
 fs/nfs/pnfs_nfs.c |    2 +-
 fs/nfs/write.c    |    6 +++---
 4 files changed, 7 insertions(+), 12 deletions(-)

--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -85,11 +85,6 @@ int nfs_wait_bit_killable(struct wait_bi
 }
 EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
-int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode)
-{
-	return nfs_wait_killable(mode);
-}
-
 /**
  * nfs_compat_user_ino64 - returns the user-visible inode number
  * @fileid: 64-bit fileid
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -98,8 +98,8 @@ nfs_page_free(struct nfs_page *p)
 int
 nfs_iocounter_wait(struct nfs_lock_context *l_ctx)
 {
-	return wait_on_atomic_t(&l_ctx->io_count, nfs_wait_atomic_killable,
-			TASK_KILLABLE);
+	return wait_var_event_killable(&l_ctx->io_count,
+				       !atomic_read(&l_ctx->io_count));
 }
 
 /**
@@ -395,7 +395,7 @@ static void nfs_clear_request(struct nfs
 	}
 	if (l_ctx != NULL) {
 		if (atomic_dec_and_test(&l_ctx->io_count)) {
-			wake_up_atomic_t(&l_ctx->io_count);
+			wake_up_var(&l_ctx->io_count);
 			if (test_bit(NFS_CONTEXT_UNLOCK, &ctx->flags))
 				rpc_wake_up(&NFS_SERVER(d_inode(ctx->dentry))->uoc_rpcwaitq);
 		}
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -245,7 +245,7 @@ pnfs_generic_commit_cancel_empty_pagelis
 {
 	if (list_empty(pages)) {
 		if (atomic_dec_and_test(&cinfo->mds->rpcs_out))
-			wake_up_atomic_t(&cinfo->mds->rpcs_out);
+			wake_up_var(&cinfo->mds->rpcs_out);
 		/* don't call nfs_commitdata_release - it tries to put
 		 * the open_context which is not acquired until nfs_init_commit
 		 * which has not been called on @data */
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1620,8 +1620,8 @@ static void nfs_writeback_result(struct
 
 static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 {
-	return wait_on_atomic_t(&cinfo->rpcs_out,
-			nfs_wait_atomic_killable, TASK_KILLABLE);
+	return wait_var_event_killable(&cinfo->rpcs_out,
+				       !atomic_read(&cinfo->rpcs_out));
 }
 
 static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
@@ -1632,7 +1632,7 @@ static void nfs_commit_begin(struct nfs_
 static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
 	if (atomic_dec_and_test(&cinfo->rpcs_out))
-		wake_up_atomic_t(&cinfo->rpcs_out);
+		wake_up_var(&cinfo->rpcs_out);
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
