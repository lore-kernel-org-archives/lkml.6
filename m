Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5ADC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427D321848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548248463;
	bh=9FpuG3EiRWrVFCpAxKKYAyFwAPeZ/c9oQj4gKTbmUjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uxQtc1fo8LYe6CXo3RoREe/Kqrag9CP7l0wqvkpaqdkdp3kO6l84rVPD7qiTp6njz
	 rZuqTXaZkSvT+D0+iUrCVIKNiOlFqvYwyDXpiXvpW42Ar1sRfz/nhPoNFaT/ONkQ00
	 Crks7gj4FkPFaJsN2eBPaVYpqSLiDV0QalK+ZKgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfAWNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfAWNBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:01:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0083421848;
        Wed, 23 Jan 2019 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548248459;
        bh=9FpuG3EiRWrVFCpAxKKYAyFwAPeZ/c9oQj4gKTbmUjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr2uMj9HnLhwH1p4k12QcmWjTtUbUnDZfbK/Xwe8PbSgg1p0iqDJdVOosBIJALEt0
         ETCo+j7+9Gt0XQMd4qHwj4n+HHMub89Em7BQoOEKGIQZyIJTRM73l+bgBiklFSTR64
         P5nBDFVY3aPjQLN0/8u/ZiIIvivfhRq/I6XKR88w=
Date:   Wed, 23 Jan 2019 14:00:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123130057.GB21318@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
 <20190123115535.GA31237@kroah.com>
 <20190123121350.GX4087@dhcp22.suse.cz>
 <20190123122626.GA27968@kroah.com>
 <20190123124024.GY4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123124024.GY4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:40:24PM +0100, Michal Hocko wrote:
> On Wed 23-01-19 13:26:26, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 01:13:50PM +0100, Michal Hocko wrote:
> > > On Wed 23-01-19 12:55:35, Greg KH wrote:
> > > > On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> > > > > On Wed 23-01-19 11:28:14, Greg KH wrote:
> > > > > > When an error happens, debugfs should return an error pointer value, not
> > > > > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > > > > call fails due to lack of memory, returning NULL, and that dentry value
> > > > > > is then passed to another debugfs call, which would end up succeeding,
> > > > > > creating a file at the root of the debugfs tree, but would then be
> > > > > > impossible to remove (because you can not remove the directory NULL).
> > > > > > 
> > > > > > So, to make everyone happy, always return errors, this makes the users
> > > > > > of debugfs much simpler (they do not have to ever check the return
> > > > > > value), and everyone can rest easy.
> > > > > 
> > > > > How come this is safe at all? Say you are creating a directory by
> > > > > debugfs_create_dir and then feed the return value to debugfs_create_files
> > > > > as a parent. In case of error you are giving it an invalid pointer and
> > > > > likely blow up unless I miss something.
> > > > 
> > > > debugfs_create_files checks for invalid parents and will just refuse to
> > > > create the file.  It's always done that.
> > > 
> > > I must be missing something because debugfs_create_files does
> > > 	d_inode(parent)->i_private = data;
> > > as the very first thing and that means that it dereferences an invalid
> > > pointer right there.
> > 
> > debugfs_create_file() -> __debugfs_create_file() -> start_creating()
> > and that function checks if parent is an error, which it aborts on, or
> > if it is NULL, it sets parent to a valid value:
> > 
> >         /* If the parent is not specified, we create it in the root.
> >          * We need the root dentry to do this, which is in the super
> >          * block. A pointer to that is in the struct vfsmount that we
> >          * have around.
> >          */
> >         if (!parent)
> >                 parent = debugfs_mount->mnt_root;
> > 
> > I don't see any line that looks like:
> > >       d_inode(parent)->i_private = data;
> > in Linus's tree right now, what kernel version are you referring to?
> 
> Ohh, my bad. I have looked at debugfs_create_files which is a mq helper
> around debugfs_create_file. But that is a good example why this patch is
> dangerous anyway. blk_mq_debugfs_register simply checks for NULL and
> debugfs_create_files doesn't expect ERR_PTR here. So you would have to
> check each and every user to make sure you can do that.

Ah, I already have that patch in my "to add a proper changelog" queue,
it's below and fixes that problem.

Might as well just send the "don't do that with a dentry" portion right
now, as that's not a good thing to be doing no matter what.

thanks,

greg k-h

From 62794189261d5df4ef0d37e4b8172d1c85d0c8df Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 4 Jan 2019 14:06:22 +0100
Subject: [PATCH 108/119] blk-mq: fix changelog

---
 block/blk-mq-debugfs.c | 149 +++++++++--------------------------------
 block/blk-mq-debugfs.h |  36 +++++-----
 2 files changed, 48 insertions(+), 137 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 90d68760af08..39ff9f82278d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -835,35 +835,28 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static bool debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct dentry *parent, void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	if (IS_ERR_OR_NULL(parent))
+		return;
+
 	d_inode(parent)->i_private = data;
 
-	for (; attr->name; attr++) {
-		if (!debugfs_create_file(attr->name, attr->mode, parent,
-					 (void *)attr, &blk_mq_debugfs_fops))
-			return false;
-	}
-	return true;
+	for (; attr->name; attr++)
+		debugfs_create_file(attr->name, attr->mode, parent,
+				    (void *)attr, &blk_mq_debugfs_fops);
 }
 
-int blk_mq_debugfs_register(struct request_queue *q)
+void blk_mq_debugfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	if (!blk_debugfs_root)
-		return -ENOENT;
-
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
-	if (!q->debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(q->debugfs_dir, q,
-				  blk_mq_debugfs_queue_attrs))
-		goto err;
+	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
 	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
@@ -875,11 +868,10 @@ int blk_mq_debugfs_register(struct request_queue *q)
 
 	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->debugfs_dir && blk_mq_debugfs_register_hctx(q, hctx))
-			goto err;
-		if (q->elevator && !hctx->sched_debugfs_dir &&
-		    blk_mq_debugfs_register_sched_hctx(q, hctx))
-			goto err;
+		if (!hctx->debugfs_dir)
+			blk_mq_debugfs_register_hctx(q, hctx);
+		if (q->elevator && !hctx->sched_debugfs_dir)
+			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
 	if (q->rq_qos) {
@@ -890,12 +882,6 @@ int blk_mq_debugfs_register(struct request_queue *q)
 			rqos = rqos->next;
 		}
 	}
-
-	return 0;
-
-err:
-	blk_mq_debugfs_unregister(q);
-	return -ENOMEM;
 }
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
@@ -905,52 +891,32 @@ void blk_mq_debugfs_unregister(struct request_queue *q)
 	q->debugfs_dir = NULL;
 }
 
-static int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
-				       struct blk_mq_ctx *ctx)
+static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+					struct blk_mq_ctx *ctx)
 {
 	struct dentry *ctx_dir;
 	char name[20];
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
-	if (!ctx_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs))
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
 }
 
-int blk_mq_debugfs_register_hctx(struct request_queue *q,
-				 struct blk_mq_hw_ctx *hctx)
+void blk_mq_debugfs_register_hctx(struct request_queue *q,
+				  struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_ctx *ctx;
 	char name[20];
 	int i;
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
-	if (!hctx->debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(hctx->debugfs_dir, hctx,
-				  blk_mq_debugfs_hctx_attrs))
-		goto err;
+	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
 
-	hctx_for_each_ctx(hctx, ctx, i) {
-		if (blk_mq_debugfs_register_ctx(hctx, ctx))
-			goto err;
-	}
-
-	return 0;
-
-err:
-	blk_mq_debugfs_unregister_hctx(hctx);
-	return -ENOMEM;
+	hctx_for_each_ctx(hctx, ctx, i)
+		blk_mq_debugfs_register_ctx(hctx, ctx);
 }
 
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
@@ -960,17 +926,13 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 	hctx->debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (blk_mq_debugfs_register_hctx(q, hctx))
-			return -ENOMEM;
-	}
-
-	return 0;
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_debugfs_register_hctx(q, hctx);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
@@ -982,29 +944,13 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 		blk_mq_debugfs_unregister_hctx(hctx);
 }
 
-int blk_mq_debugfs_register_sched(struct request_queue *q)
+void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 	struct elevator_type *e = q->elevator->type;
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
-	if (!e->queue_debugfs_attrs)
-		return 0;
-
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
-	if (!q->sched_debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(q->sched_debugfs_dir, q,
-				  e->queue_debugfs_attrs))
-		goto err;
-
-	return 0;
-
-err:
-	blk_mq_debugfs_unregister_sched(q);
-	return -ENOMEM;
+	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -1019,36 +965,19 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	rqos->debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
-	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
-		return 0;
-
-	if (!q->rqos_debugfs_dir) {
+	if (!q->rqos_debugfs_dir)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
-		if (!q->rqos_debugfs_dir)
-			return -ENOMEM;
-	}
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name,
 					       rqos->q->rqos_debugfs_dir);
-	if (!rqos->debugfs_dir)
-		return -ENOMEM;
 
-	if (!debugfs_create_files(rqos->debugfs_dir, rqos,
-				  rqos->ops->debugfs_attrs))
-		goto err;
-	return 0;
- err:
-	blk_mq_debugfs_unregister_rqos(rqos);
-	return -ENOMEM;
+	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
@@ -1057,27 +986,15 @@ void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
 	q->rqos_debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
-				       struct blk_mq_hw_ctx *hctx)
+void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+					struct blk_mq_hw_ctx *hctx)
 {
 	struct elevator_type *e = q->elevator->type;
 
-	if (!hctx->debugfs_dir)
-		return -ENOENT;
-
-	if (!e->hctx_debugfs_attrs)
-		return 0;
-
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	if (!hctx->sched_debugfs_dir)
-		return -ENOMEM;
-
-	if (!debugfs_create_files(hctx->sched_debugfs_dir, hctx,
-				  e->hctx_debugfs_attrs))
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+			     e->hctx_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 8c9012a578c1..a68aa6041a10 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -18,74 +18,68 @@ struct blk_mq_debugfs_attr {
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
-int blk_mq_debugfs_register(struct request_queue *q);
+void blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
-int blk_mq_debugfs_register_hctx(struct request_queue *q,
-				 struct blk_mq_hw_ctx *hctx);
+void blk_mq_debugfs_register_hctx(struct request_queue *q,
+				  struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
-int blk_mq_debugfs_register_hctxs(struct request_queue *q);
+void blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
 
-int blk_mq_debugfs_register_sched(struct request_queue *q);
+void blk_mq_debugfs_register_sched(struct request_queue *q);
 void blk_mq_debugfs_unregister_sched(struct request_queue *q);
-int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
-int blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
 #else
-static inline int blk_mq_debugfs_register(struct request_queue *q)
+static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_hctx(struct request_queue *q,
-					       struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_debugfs_register_hctx(struct request_queue *q,
+						struct blk_mq_hw_ctx *hctx)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
 }
 
-static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+static inline void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_sched(struct request_queue *q)
+static inline void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
-						     struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+						      struct blk_mq_hw_ctx *hctx)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
 }
 
-static inline int blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
-	return 0;
 }
 
 static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-- 
2.20.1

