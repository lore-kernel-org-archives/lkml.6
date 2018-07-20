Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAECBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E48206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E48206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbeGTNXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeGTNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:33 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16393AD2;
        Fri, 20 Jul 2018 12:32:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 06/92] xprtrdma: Fix corner cases when handling device removal
Date:   Fri, 20 Jul 2018 14:13:10 +0200
Message-Id: <20180720121417.556239650@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 25524288631fc5b7d33259fca1e0dc38146be5d6 upstream.

Michal Kalderon has found some corner cases around device unload
with active NFS mounts that I didn't have the imagination to test
when xprtrdma device removal was added last year.

- The ULP device removal handler is responsible for deallocating
  the PD. That wasn't clear to me initially, and my own testing
  suggested it was not necessary, but that is incorrect.

- The transport destruction path can no longer assume that there
  is a valid ID.

- When destroying a transport, ensure that ib_free_cq() is not
  invoked on a CQ that was already released.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/verbs.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -270,7 +270,6 @@ rpcrdma_conn_upcall(struct rdma_cm_id *i
 		wait_for_completion(&ia->ri_remove_done);
 
 		ia->ri_id = NULL;
-		ia->ri_pd = NULL;
 		ia->ri_device = NULL;
 		/* Return 1 to ensure the core destroys the id. */
 		return 1;
@@ -464,7 +463,9 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 		ia->ri_id->qp = NULL;
 	}
 	ib_free_cq(ep->rep_attr.recv_cq);
+	ep->rep_attr.recv_cq = NULL;
 	ib_free_cq(ep->rep_attr.send_cq);
+	ep->rep_attr.send_cq = NULL;
 
 	/* The ULP is responsible for ensuring all DMA
 	 * mappings and MRs are gone.
@@ -477,6 +478,8 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 		rpcrdma_dma_unmap_regbuf(req->rl_recvbuf);
 	}
 	rpcrdma_destroy_mrs(buf);
+	ib_dealloc_pd(ia->ri_pd);
+	ia->ri_pd = NULL;
 
 	/* Allow waiters to continue */
 	complete(&ia->ri_remove_done);
@@ -650,14 +653,16 @@ rpcrdma_ep_destroy(struct rpcrdma_ep *ep
 
 	cancel_delayed_work_sync(&ep->rep_connect_worker);
 
-	if (ia->ri_id->qp) {
+	if (ia->ri_id && ia->ri_id->qp) {
 		rpcrdma_ep_disconnect(ep, ia);
 		rdma_destroy_qp(ia->ri_id);
 		ia->ri_id->qp = NULL;
 	}
 
-	ib_free_cq(ep->rep_attr.recv_cq);
-	ib_free_cq(ep->rep_attr.send_cq);
+	if (ep->rep_attr.recv_cq)
+		ib_free_cq(ep->rep_attr.recv_cq);
+	if (ep->rep_attr.send_cq)
+		ib_free_cq(ep->rep_attr.send_cq);
 }
 
 /* Re-establish a connection after a device removal event.


