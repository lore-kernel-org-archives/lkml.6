Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24590C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22B208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE22B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbeHWLup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:50:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeHWLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:50:44 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF4D68B1;
        Thu, 23 Aug 2018 08:22:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 050/217] pNFS: Always free the session slot on error in nfs4_layoutget_handle_exception
Date:   Thu, 23 Aug 2018 09:52:43 +0200
Message-Id: <20180823075507.794433857@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 2dbf8dffbf35fd8f611083b9d9fe74fdccf912a3 ]

Right now, we can call nfs_commit_inode() while holding the session slot,
which could lead to NFSv4 deadlocks. Ensure we only keep the slot if
the server returned a layout that we have to process.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8429,6 +8429,8 @@ nfs4_layoutget_handle_exception(struct r
 
 	dprintk("--> %s tk_status => %d\n", __func__, -task->tk_status);
 
+	nfs4_sequence_free_slot(&lgp->res.seq_res);
+
 	switch (nfs4err) {
 	case 0:
 		goto out;
@@ -8493,7 +8495,6 @@ nfs4_layoutget_handle_exception(struct r
 		goto out;
 	}
 
-	nfs4_sequence_free_slot(&lgp->res.seq_res);
 	err = nfs4_handle_exception(server, nfs4err, exception);
 	if (!status) {
 		if (exception->retry)
@@ -8619,20 +8620,22 @@ nfs4_proc_layoutget(struct nfs4_layoutge
 	if (IS_ERR(task))
 		return ERR_CAST(task);
 	status = rpc_wait_for_completion_task(task);
-	if (status == 0) {
+	if (status != 0)
+		goto out;
+
+	/* if layoutp->len is 0, nfs4_layoutget_prepare called rpc_exit */
+	if (task->tk_status < 0 || lgp->res.layoutp->len == 0) {
 		status = nfs4_layoutget_handle_exception(task, lgp, &exception);
 		*timeout = exception.timeout;
-	}
-
+	} else
+		lseg = pnfs_layout_process(lgp);
+out:
 	trace_nfs4_layoutget(lgp->args.ctx,
 			&lgp->args.range,
 			&lgp->res.range,
 			&lgp->res.stateid,
 			status);
 
-	/* if layoutp->len is 0, nfs4_layoutget_prepare called rpc_exit */
-	if (status == 0 && lgp->res.layoutp->len)
-		lseg = pnfs_layout_process(lgp);
 	rpc_put_task(task);
 	dprintk("<-- %s status=%d\n", __func__, status);
 	if (status)


