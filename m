Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC66DC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379D2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026822;
	bh=9qI/NXEgPWJzgt3d094sYQNWqoi3Gb7gODYM9YC3Rko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGgMmXAp/s8lUyMWwGTDeqjz0XfSpigX/gFIq0rmsSSR0MQgXRDWGexE+dnZ6UnRm
	 4cYj/eJcMKj4YNlQkV8nZC8/KQRjtlCVj3JE8VyXth+XoSCXSqtB11tGrAgUSWOyfH
	 r9edSsLxTJ135rHD0oNrvr0Fmbi1BRAcQwf1lups=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfBMDAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732015AbfBMCfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1EE222CA;
        Wed, 13 Feb 2019 02:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025336;
        bh=9qI/NXEgPWJzgt3d094sYQNWqoi3Gb7gODYM9YC3Rko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeAL9P8jZiQ327fkYzVQixWsB7nErlpbUBw4gbbmG0KGgQex59WT8gVAx8UWyONyx
         Kr6NfwcAojlwlR79RmtnGnwvb13lMajp/MJ0TQZDizvjCQ+jNXAIEZCipZNAFsIQ/2
         LWXy0CooVs7WF32UFnqMd0wVc132dnEpDeaMF2Sc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trondmy@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 076/105] SUNRPC: Ensure we respect the RPCSEC_GSS sequence number limit
Date:   Tue, 12 Feb 2019 21:33:07 -0500
Message-Id: <20190213023336.19019-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit 97b78ae96ba76f4ca2d8f5afee6a2e567ccb8f45 ]

According to RFC2203, the RPCSEC_GSS sequence numbers are bounded to
an upper limit of MAXSEQ = 0x80000000. Ensure that we handle that
correctly.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/auth_gss.c | 12 +++++++++---
 net/sunrpc/clnt.c              | 19 ++++++++++++-------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index ba765473d1f0..efeee5586b2a 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1563,8 +1563,10 @@ gss_marshal(struct rpc_task *task, __be32 *p)
 	cred_len = p++;
 
 	spin_lock(&ctx->gc_seq_lock);
-	req->rq_seqno = ctx->gc_seq++;
+	req->rq_seqno = (ctx->gc_seq < MAXSEQ) ? ctx->gc_seq++ : MAXSEQ;
 	spin_unlock(&ctx->gc_seq_lock);
+	if (req->rq_seqno == MAXSEQ)
+		goto out_expired;
 
 	*p++ = htonl((u32) RPC_GSS_VERSION);
 	*p++ = htonl((u32) ctx->gc_proc);
@@ -1586,14 +1588,18 @@ gss_marshal(struct rpc_task *task, __be32 *p)
 	mic.data = (u8 *)(p + 1);
 	maj_stat = gss_get_mic(ctx->gc_gss_ctx, &verf_buf, &mic);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED) {
-		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
+		goto out_expired;
 	} else if (maj_stat != 0) {
-		printk("gss_marshal: gss_get_mic FAILED (%d)\n", maj_stat);
+		pr_warn("gss_marshal: gss_get_mic FAILED (%d)\n", maj_stat);
+		task->tk_status = -EIO;
 		goto out_put_ctx;
 	}
 	p = xdr_encode_opaque(p, NULL, mic.len);
 	gss_put_ctx(ctx);
 	return p;
+out_expired:
+	clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
+	task->tk_status = -EKEYEXPIRED;
 out_put_ctx:
 	gss_put_ctx(ctx);
 	return NULL;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2189fbc4c570..1ee04e0ec4bc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1740,11 +1740,8 @@ rpc_xdr_encode(struct rpc_task *task)
 		     req->rq_rcvsize);
 
 	p = rpc_encode_header(task);
-	if (p == NULL) {
-		printk(KERN_INFO "RPC: couldn't encode RPC header, exit EIO\n");
-		rpc_exit(task, -EIO);
+	if (p == NULL)
 		return;
-	}
 
 	encode = task->tk_msg.rpc_proc->p_encode;
 	if (encode == NULL)
@@ -1769,10 +1766,17 @@ call_encode(struct rpc_task *task)
 	/* Did the encode result in an error condition? */
 	if (task->tk_status != 0) {
 		/* Was the error nonfatal? */
-		if (task->tk_status == -EAGAIN || task->tk_status == -ENOMEM)
+		switch (task->tk_status) {
+		case -EAGAIN:
+		case -ENOMEM:
 			rpc_delay(task, HZ >> 4);
-		else
+			break;
+		case -EKEYEXPIRED:
+			task->tk_action = call_refresh;
+			break;
+		default:
 			rpc_exit(task, task->tk_status);
+		}
 		return;
 	}
 
@@ -2334,7 +2338,8 @@ rpc_encode_header(struct rpc_task *task)
 	*p++ = htonl(clnt->cl_vers);	/* program version */
 	*p++ = htonl(task->tk_msg.rpc_proc->p_proc);	/* procedure */
 	p = rpcauth_marshcred(task, p);
-	req->rq_slen = xdr_adjust_iovec(&req->rq_svec[0], p);
+	if (p)
+		req->rq_slen = xdr_adjust_iovec(&req->rq_svec[0], p);
 	return p;
 }
 
-- 
2.19.1

