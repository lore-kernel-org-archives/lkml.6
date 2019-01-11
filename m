Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FB321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217877;
	bh=TgWBEtLBo2VtgxQPc9vVWzdUavezxKIu3LXmsmELZdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ICTzoY5Tu0K549QNEXwdjzWCrVkWSLORmVTXv/uyzkZQeVzhcpduWbQwArMjB1mAj
	 QPWVVU2xO56oLogT/mqlYGuuXwi8ypWy3ZKLUhLHD7URPJKJHpMw3SsK2tk9ciIuG/
	 KsLULW8u93VvgO6wl+8xJ1BX34CwNbAC1INDlcnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391395AbfAKOog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404622AbfAKOob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F68206B6;
        Fri, 11 Jan 2019 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217870;
        bh=TgWBEtLBo2VtgxQPc9vVWzdUavezxKIu3LXmsmELZdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlXSWIxI462QBIV01+xUYwV+fdBp6c5tmVKhpvOjOseuKMXW8A1JP7bBymrH5T8Wa
         uPHxxod39iwVMt7ZSnbeZdr2hLh2G/zRq/1yRRJvQRmWW0lpbuUl8ari4s0uu7WX5g
         jERisM06Ra2LJx+wZKRGUWI3FTaRf+wtFiUOjC/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.20 39/65] xprtrdma: Yet another double DMA-unmap
Date:   Fri, 11 Jan 2019 15:15:25 +0100
Message-Id: <20190111131101.964250236@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit e2f34e26710bfaa545a9d9cd0c70137406401467 upstream.

While chasing yet another set of DMAR fault reports, I noticed that
the frwr recycler conflates whether or not an MR has been DMA
unmapped with frwr->fr_state. Actually the two have only an indirect
relationship. It's in fact impossible to guess reliably whether the
MR has been DMA unmapped based on its fr_state field, especially as
the surrounding code and its assumptions have changed over time.

A better approach is to track the DMA mapping status explicitly so
that the recycler is less brittle to unexpected situations, and
attempts to DMA-unmap a second time are prevented.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.20
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/frwr_ops.c |    6 ++++--
 net/sunrpc/xprtrdma/verbs.c    |    9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -117,15 +117,15 @@ static void
 frwr_mr_recycle_worker(struct work_struct *work)
 {
 	struct rpcrdma_mr *mr = container_of(work, struct rpcrdma_mr, mr_recycle);
-	enum rpcrdma_frwr_state state = mr->frwr.fr_state;
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
 
 	trace_xprtrdma_mr_recycle(mr);
 
-	if (state != FRWR_FLUSHED_LI) {
+	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
 		ib_dma_unmap_sg(r_xprt->rx_ia.ri_device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
+		mr->mr_dir = DMA_NONE;
 	}
 
 	spin_lock(&r_xprt->rx_buf.rb_mrlock);
@@ -150,6 +150,8 @@ frwr_op_init_mr(struct rpcrdma_ia *ia, s
 	if (!mr->mr_sg)
 		goto out_list_err;
 
+	frwr->fr_state = FRWR_IS_INVALID;
+	mr->mr_dir = DMA_NONE;
 	INIT_LIST_HEAD(&mr->mr_list);
 	INIT_WORK(&mr->mr_recycle, frwr_mr_recycle_worker);
 	sg_init_table(mr->mr_sg, depth);
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1329,9 +1329,12 @@ rpcrdma_mr_unmap_and_put(struct rpcrdma_
 {
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
 
-	trace_xprtrdma_mr_unmap(mr);
-	ib_dma_unmap_sg(r_xprt->rx_ia.ri_device,
-			mr->mr_sg, mr->mr_nents, mr->mr_dir);
+	if (mr->mr_dir != DMA_NONE) {
+		trace_xprtrdma_mr_unmap(mr);
+		ib_dma_unmap_sg(r_xprt->rx_ia.ri_device,
+				mr->mr_sg, mr->mr_nents, mr->mr_dir);
+		mr->mr_dir = DMA_NONE;
+	}
 	__rpcrdma_mr_put(&r_xprt->rx_buf, mr);
 }
 


