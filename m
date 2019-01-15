Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38722C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C012054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570335;
	bh=WeCkk4n1fVMDf8UFp0B6h5kL+b+aJenhZUHz0i+xZGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZbrY9BwbehFVEoKB4w9cN4tR6lQbXAXaWok/0oVt9MZbt1zYsSdGEIupcsJLuqhO
	 Mt3j1NkmcSjkcxHd3uA/TTdMgYkTU/U6zWLmRqjFh1IxjsL/BUuFH+jbvoli/mGbck
	 fqPZxi8wNOGXE0Ksk8DVWXbkJxY6estNH4f/PZds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfAOQix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbfAOQiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D0620859;
        Tue, 15 Jan 2019 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570329;
        bh=WeCkk4n1fVMDf8UFp0B6h5kL+b+aJenhZUHz0i+xZGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWanbG9PVR3SRyT9ajILHEOr4aDidI44G63EUSWzfGRBEeUIujwUd/yi/4mURx0eG
         YTmT36O9csgOws/6uDOmFWzT6Sacdxzm0pAMvHdLnzeWIL454TsvK/dEQquoAKa/kt
         M0HA+S+D2oLP/EC3ypUrDXVDuRUSJBUUAozcn05I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.4 51/51] sunrpc: use-after-free in svc_process_common()
Date:   Tue, 15 Jan 2019 17:35:47 +0100
Message-Id: <20190115154854.340253552@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit d4b09acf924b84bae77cad090a9d108e70b43643 upstream.

if node have NFSv41+ mounts inside several net namespaces
it can lead to use-after-free in svc_process_common()

svc_process_common()
        /* Setup reply header */
        rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr(rqstp); <<< HERE

svc_process_common() can use incorrect rqstp->rq_xprt,
its caller function bc_svc_process() takes it from serv->sv_bc_xprt.
The problem is that serv is global structure but sv_bc_xprt
is assigned per-netnamespace.

According to Trond, the whole "let's set up rqstp->rq_xprt
for the back channel" is nothing but a giant hack in order
to work around the fact that svc_process_common() uses it
to find the xpt_ops, and perform a couple of (meaningless
for the back channel) tests of xpt_flags.

All we really need in svc_process_common() is to be able to run
rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr()

Bruce J Fields points that this xpo_prep_reply_hdr() call
is an awfully roundabout way just to do "svc_putnl(resv, 0);"
in the tcp case.

This patch does not initialiuze rqstp->rq_xprt in bc_svc_process(),
now it calls svc_process_common() with rqstp->rq_xprt = NULL.

To adjust reply header svc_process_common() just check
rqstp->rq_prot and calls svc_tcp_prep_reply_hdr() for tcp case.

To handle rqstp->rq_xprt = NULL case in functions called from
svc_process_common() patch intruduces net namespace pointer
svc_rqst->rq_bc_net and adjust SVC_NET() definition.
Some other function was also adopted to properly handle described case.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Cc: stable@vger.kernel.org
Fixes: 23c20ecd4475 ("NFS: callback up - users counting cleanup")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
v2: - added lost extern svc_tcp_prep_reply_hdr()
    - dropped trace_svc_process() changes
    - context fixes in svc_process_common()
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sunrpc/svc.h |    5 ++++-
 net/sunrpc/svc.c           |   10 +++++++---
 net/sunrpc/svc_xprt.c      |    5 +++--
 net/sunrpc/svcsock.c       |    2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -290,9 +290,12 @@ struct svc_rqst {
 	struct svc_cacherep *	rq_cacherep;	/* cache info */
 	struct task_struct	*rq_task;	/* service thread */
 	spinlock_t		rq_lock;	/* per-request lock */
+	struct net		*rq_bc_net;	/* pointer to backchannel's
+						 * net namespace
+						 */
 };
 
-#define SVC_NET(svc_rqst)	(svc_rqst->rq_xprt->xpt_net)
+#define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
 
 /*
  * Rigorous type checking on sockaddr type conversions
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1062,6 +1062,8 @@ void svc_printk(struct svc_rqst *rqstp,
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
 #endif
 
+extern void svc_tcp_prep_reply_hdr(struct svc_rqst *);
+
 /*
  * Common routine for processing the RPC request.
  */
@@ -1091,7 +1093,8 @@ svc_process_common(struct svc_rqst *rqst
 	clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	/* Setup reply header */
-	rqstp->rq_xprt->xpt_ops->xpo_prep_reply_hdr(rqstp);
+	if (rqstp->rq_prot == IPPROTO_TCP)
+		svc_tcp_prep_reply_hdr(rqstp);
 
 	svc_putu32(resv, rqstp->rq_xid);
 
@@ -1138,7 +1141,8 @@ svc_process_common(struct svc_rqst *rqst
 	case SVC_DENIED:
 		goto err_bad_auth;
 	case SVC_CLOSE:
-		if (test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
+		if (rqstp->rq_xprt &&
+		    test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
 			svc_close_xprt(rqstp->rq_xprt);
 	case SVC_DROP:
 		goto dropit;
@@ -1360,10 +1364,10 @@ bc_svc_process(struct svc_serv *serv, st
 	dprintk("svc: %s(%p)\n", __func__, req);
 
 	/* Build the svc_rqst used by the common processing routine */
-	rqstp->rq_xprt = serv->sv_bc_xprt;
 	rqstp->rq_xid = req->rq_xid;
 	rqstp->rq_prot = req->rq_xprt->prot;
 	rqstp->rq_server = serv;
+	rqstp->rq_bc_net = req->rq_xprt->xprt_net;
 
 	rqstp->rq_addrlen = sizeof(req->rq_xprt->addr);
 	memcpy(&rqstp->rq_addr, &req->rq_xprt->addr, rqstp->rq_addrlen);
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -454,10 +454,11 @@ out:
  */
 void svc_reserve(struct svc_rqst *rqstp, int space)
 {
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+
 	space += rqstp->rq_res.head[0].iov_len;
 
-	if (space < rqstp->rq_reserved) {
-		struct svc_xprt *xprt = rqstp->rq_xprt;
+	if (xprt && space < rqstp->rq_reserved) {
 		atomic_sub((rqstp->rq_reserved - space), &xprt->xpt_reserved);
 		rqstp->rq_reserved = space;
 
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1240,7 +1240,7 @@ static int svc_tcp_sendto(struct svc_rqs
 /*
  * Setup response header. TCP has a 4B record length field.
  */
-static void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
+void svc_tcp_prep_reply_hdr(struct svc_rqst *rqstp)
 {
 	struct kvec *resv = &rqstp->rq_res.head[0];
 


