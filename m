Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZqg7uNnI12ccfyH2zUKU4hk94qEKWRF3m58BXeGX0VZiT+TceIS7WMBFEVExHzD6SzIfkzH
ARC-Seal: i=1; a=rsa-sha256; t=1524652752; cv=none;
        d=google.com; s=arc-20160816;
        b=HfRDKDXnnPpMZ9sPCIHrncFmWKMZOO39w6dV29utBP4bG6epn4f1o4vYkRtd3kByrZ
         u9Y3JL3aOvO5svUCNGoziArcBf063jH4JYneYf4t5vLJOZ5iy/w63MluOnXu0zeGihX/
         3ngOmdWGNrNffwVLCX7gBcyp8Jegyk2iCfrUgGHN5fJFuAhNf6eOs2fheMdVJUEB8mpf
         Mtu5dcnC9z3ol53Axwx+Ab5P0YUTrA2nFUmLc3KfT536Ash4EWNHz+Sxhko/RInR2Ib5
         01thcnuIG93O4SE3HRZa51yeredRh68byAnsjiuRfXGFmnO02RGgsyNKvxf3Yr7p+VeC
         CTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EhAYnrV1dcVN7HuVcT18xe1MgTvQntI9Gi3+XArsMYs=;
        b=mSPNxrokuqFJKOlrJcHpfxXATJS7AvLqhcMiP+YL1uhuxAJvPn6g/WfBBV9naZYBIS
         /NxHdhYXtt1BJCHdqXkoMT6fLwjlAPdVFwMEpR2Ve5YVJEP57ePoh9qb7czQdWU9gNYJ
         pEe0hAJiC1N1hyEHE8UWAvGToD35x1PwXk0CLsocucmfY/+OlokwGsHVZ/QKK1er2Akw
         ZqVWe0lQkxqpuVEeN2vBbu3ze0Bti35icnkCH2MCl8vDw+h+U1cUX7G2xqQN22E2thOq
         zblMIoQ7ZIkJ7Q4EqEa1B6U4oVnsZ10LtvUNVGWA1xHsFnrLIZFiLRSZte9mLXmml7yk
         lt4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 029/183] xprtrdma: Fix backchannel allocation of extra rpcrdma_reps
Date: Wed, 25 Apr 2018 12:34:09 +0200
Message-Id: <20180425103243.761742489@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714284740713566?=
X-GMAIL-MSGID: =?utf-8?q?1598714284740713566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>


[ Upstream commit d698c4a02ee02053bbebe051322ff427a2dad56a ]

The backchannel code uses rpcrdma_recv_buffer_put to add new reps
to the free rep list. This also decrements rb_recv_count, which
spoofs the receive overrun logic in rpcrdma_buffer_get_rep.

Commit 9b06688bc3b9 ("xprtrdma: Fix additional uses of
spin_lock_irqsave(rb_lock)") replaced the original open-coded
list_add with a call to rpcrdma_recv_buffer_put(), but then a year
later, commit 05c974669ece ("xprtrdma: Fix receive buffer
accounting") added rep accounting to rpcrdma_recv_buffer_put.
It was an oversight to let the backchannel continue to use this
function.

The fix this, let's combine the "add to free list" logic with
rpcrdma_create_rep.

Also, do not allocate RPCRDMA_MAX_BC_REQUESTS rpcrdma_reps in
rpcrdma_buffer_create and then allocate additional rpcrdma_reps in
rpcrdma_bc_setup_reps. Allocating the extra reps during backchannel
set-up is sufficient.

Fixes: 05c974669ece ("xprtrdma: Fix receive buffer accounting")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/backchannel.c |   12 ++----------
 net/sunrpc/xprtrdma/verbs.c       |   32 +++++++++++++++++++-------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    2 +-
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -74,21 +74,13 @@ out_fail:
 static int rpcrdma_bc_setup_reps(struct rpcrdma_xprt *r_xprt,
 				 unsigned int count)
 {
-	struct rpcrdma_rep *rep;
 	int rc = 0;
 
 	while (count--) {
-		rep = rpcrdma_create_rep(r_xprt);
-		if (IS_ERR(rep)) {
-			pr_err("RPC:       %s: reply buffer alloc failed\n",
-			       __func__);
-			rc = PTR_ERR(rep);
+		rc = rpcrdma_create_rep(r_xprt);
+		if (rc)
 			break;
-		}
-
-		rpcrdma_recv_buffer_put(rep);
 	}
-
 	return rc;
 }
 
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -951,10 +951,17 @@ rpcrdma_create_req(struct rpcrdma_xprt *
 	return req;
 }
 
-struct rpcrdma_rep *
+/**
+ * rpcrdma_create_rep - Allocate an rpcrdma_rep object
+ * @r_xprt: controlling transport
+ *
+ * Returns 0 on success or a negative errno on failure.
+ */
+int
 rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_create_data_internal *cdata = &r_xprt->rx_data;
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 	int rc;
 
@@ -979,12 +986,18 @@ rpcrdma_create_rep(struct rpcrdma_xprt *
 	rep->rr_recv_wr.wr_cqe = &rep->rr_cqe;
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
-	return rep;
+
+	spin_lock(&buf->rb_lock);
+	list_add(&rep->rr_list, &buf->rb_recv_bufs);
+	spin_unlock(&buf->rb_lock);
+	return 0;
 
 out_free:
 	kfree(rep);
 out:
-	return ERR_PTR(rc);
+	dprintk("RPC:       %s: reply buffer %d alloc failed\n",
+		__func__, rc);
+	return rc;
 }
 
 int
@@ -1027,17 +1040,10 @@ rpcrdma_buffer_create(struct rpcrdma_xpr
 	}
 
 	INIT_LIST_HEAD(&buf->rb_recv_bufs);
-	for (i = 0; i < buf->rb_max_requests + RPCRDMA_MAX_BC_REQUESTS; i++) {
-		struct rpcrdma_rep *rep;
-
-		rep = rpcrdma_create_rep(r_xprt);
-		if (IS_ERR(rep)) {
-			dprintk("RPC:       %s: reply buffer %d alloc failed\n",
-				__func__, i);
-			rc = PTR_ERR(rep);
+	for (i = 0; i <= buf->rb_max_requests; i++) {
+		rc = rpcrdma_create_rep(r_xprt);
+		if (rc)
 			goto out;
-		}
-		list_add(&rep->rr_list, &buf->rb_recv_bufs);
 	}
 
 	return 0;
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -550,8 +550,8 @@ int rpcrdma_ep_post_recv(struct rpcrdma_
  * Buffer calls - xprtrdma/verbs.c
  */
 struct rpcrdma_req *rpcrdma_create_req(struct rpcrdma_xprt *);
-struct rpcrdma_rep *rpcrdma_create_rep(struct rpcrdma_xprt *);
 void rpcrdma_destroy_req(struct rpcrdma_req *);
+int rpcrdma_create_rep(struct rpcrdma_xprt *r_xprt);
 int rpcrdma_buffer_create(struct rpcrdma_xprt *);
 void rpcrdma_buffer_destroy(struct rpcrdma_buffer *);
 
