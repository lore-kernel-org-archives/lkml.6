Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D585C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A3020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A3020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeFRIWA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965094AbeFRIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73F5DC7F;
        Mon, 18 Jun 2018 08:21:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 147/279] xprtrdma: Fix list corruption / DMAR errors during MR recovery
Date:   Mon, 18 Jun 2018 10:12:12 +0200
Message-Id: <20180618080614.902591107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 054f155721d7af1f343ed52bea246626d8450ca8 ]

The ro_release_mr methods check whether mr->mr_list is empty.
Therefore, be sure to always use list_del_init when removing an MR
linked into a list using that field. Otherwise, when recovering from
transport failures or device removal, list corruption can result, or
MRs can get mapped or unmapped an odd number of times, resulting in
IOMMU-related failures.

In general this fix is appropriate back to v4.8. However, code
changes since then make it impossible to apply this patch directly
to stable kernels. The fix would have to be applied by hand or
reworked for kernels earlier than v4.16.

Backport guidance -- there are several cases:
- When creating an MR, initialize mr_list so that using list_empty
  on an as-yet-unused MR is safe.
- When an MR is being handled by the remote invalidation path,
  ensure that mr_list is reinitialized when it is removed from
  rl_registered.
- When an MR is being handled by rpcrdma_destroy_mrs, it is removed
  from mr_all, but it may still be on an rl_registered list. In
  that case, the MR needs to be removed from that list before being
  released.
- Other cases are covered by using list_del_init in rpcrdma_mr_pop.

Fixes: 9d6b04097882 ('xprtrdma: Place registered MWs on a ... ')
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/fmr_ops.c   |    5 +----
 net/sunrpc/xprtrdma/frwr_ops.c  |    9 +++------
 net/sunrpc/xprtrdma/verbs.c     |    5 +++++
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

--- a/net/sunrpc/xprtrdma/fmr_ops.c
+++ b/net/sunrpc/xprtrdma/fmr_ops.c
@@ -72,6 +72,7 @@ fmr_op_init_mr(struct rpcrdma_ia *ia, st
 	if (IS_ERR(mr->fmr.fm_mr))
 		goto out_fmr_err;
 
+	INIT_LIST_HEAD(&mr->mr_list);
 	return 0;
 
 out_fmr_err:
@@ -102,10 +103,6 @@ fmr_op_release_mr(struct rpcrdma_mr *mr)
 	LIST_HEAD(unmap_list);
 	int rc;
 
-	/* Ensure MW is not on any rl_registered list */
-	if (!list_empty(&mr->mr_list))
-		list_del(&mr->mr_list);
-
 	kfree(mr->fmr.fm_physaddrs);
 	kfree(mr->mr_sg);
 
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -110,6 +110,7 @@ frwr_op_init_mr(struct rpcrdma_ia *ia, s
 	if (!mr->mr_sg)
 		goto out_list_err;
 
+	INIT_LIST_HEAD(&mr->mr_list);
 	sg_init_table(mr->mr_sg, depth);
 	init_completion(&frwr->fr_linv_done);
 	return 0;
@@ -133,10 +134,6 @@ frwr_op_release_mr(struct rpcrdma_mr *mr
 {
 	int rc;
 
-	/* Ensure MR is not on any rl_registered list */
-	if (!list_empty(&mr->mr_list))
-		list_del(&mr->mr_list);
-
 	rc = ib_dereg_mr(mr->frwr.fr_mr);
 	if (rc)
 		pr_err("rpcrdma: final ib_dereg_mr for %p returned %i\n",
@@ -195,7 +192,7 @@ frwr_op_recover_mr(struct rpcrdma_mr *mr
 	return;
 
 out_release:
-	pr_err("rpcrdma: FRWR reset failed %d, %p release\n", rc, mr);
+	pr_err("rpcrdma: FRWR reset failed %d, %p released\n", rc, mr);
 	r_xprt->rx_stats.mrs_orphaned++;
 
 	spin_lock(&r_xprt->rx_buf.rb_mrlock);
@@ -458,7 +455,7 @@ frwr_op_reminv(struct rpcrdma_rep *rep,
 
 	list_for_each_entry(mr, mrs, mr_list)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
-			list_del(&mr->mr_list);
+			list_del_init(&mr->mr_list);
 			trace_xprtrdma_remoteinv(mr);
 			mr->frwr.fr_state = FRWR_IS_INVALID;
 			rpcrdma_mr_unmap_and_put(mr);
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1244,6 +1244,11 @@ rpcrdma_mrs_destroy(struct rpcrdma_buffe
 		list_del(&mr->mr_all);
 
 		spin_unlock(&buf->rb_mrlock);
+
+		/* Ensure MW is not on any rl_registered list */
+		if (!list_empty(&mr->mr_list))
+			list_del(&mr->mr_list);
+
 		ia->ri_ops->ro_release_mr(mr);
 		count++;
 		spin_lock(&buf->rb_mrlock);
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -381,7 +381,7 @@ rpcrdma_mr_pop(struct list_head *list)
 	struct rpcrdma_mr *mr;
 
 	mr = list_first_entry(list, struct rpcrdma_mr, mr_list);
-	list_del(&mr->mr_list);
+	list_del_init(&mr->mr_list);
 	return mr;
 }
 


