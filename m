Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3AAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58DC20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762539;
	bh=eyQAXxMnyLvHwkYhsdfz3Xue8Q2Nu1zvejM6rwHki40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p8MSkxt59ZFz91Gzeufiby9gDScWXSdCcEcjbhsJk4b11ZsDXH8yyha296aJ6Z2KK
	 OgdIR6Px0P9xHCWp3H7eUrq9r1FbHXP06kmX/ydmSFnFqxyCFk30OlUnQmgCqQKH4l
	 dm4s6vsmDYzK8qRcVUoQk3O00McASvwyjKn0xTME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfA2Ls6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfA2Lsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CB720869;
        Tue, 29 Jan 2019 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762534;
        bh=eyQAXxMnyLvHwkYhsdfz3Xue8Q2Nu1zvejM6rwHki40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcxBT/erqfRkCiqzesbS787CRxgzh75VnhyzjUrJoOvUkYD85CsTWZeIc+9xVq9ZN
         vpxE4mcAdZgcMVZPGVYSjz2/RpJnSpBvaENejNvsD2KbJV6K/Y2xzMSXXx5SxAfjRR
         HiECzh3ekLhYQhmtLLIvcH1U7j89iYnyCbjPDTQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jintack Lim <jintack@cs.columbia.edu>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/68] vhost: log dirty page correctly
Date:   Tue, 29 Jan 2019 12:35:29 +0100
Message-Id: <20190129113132.264836754@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit cc5e710759470bc7f3c61d11fd54586f15fdbdf4 ]

Vhost dirty page logging API is designed to sync through GPA. But we
try to log GIOVA when device IOTLB is enabled. This is wrong and may
lead to missing data after migration.

To solve this issue, when logging with device IOTLB enabled, we will:

1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
   get HVA, for writable descriptor, get HVA through iovec. For used
   ring update, translate its GIOVA to HVA
2) traverse the GPA->HVA mapping to get the possible GPA and log
   through GPA. Pay attention this reverse mapping is not guaranteed
   to be unique, so we should log each possible GPA in this case.

This fix the failure of scp to guest during migration. In -next, we
will probably support passing GIOVA->GPA instead of GIOVA->HVA.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Reported-by: Jintack Lim <jintack@cs.columbia.edu>
Cc: Jintack Lim <jintack@cs.columbia.edu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c   |    3 +
 drivers/vhost/vhost.c |   97 ++++++++++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |    3 +
 3 files changed, 87 insertions(+), 16 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -851,7 +851,8 @@ static void handle_rx(struct vhost_net *
 		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
 					    headcount);
 		if (unlikely(vq_log))
-			vhost_log_write(vq, vq_log, log, vhost_len);
+			vhost_log_write(vq, vq_log, log, vhost_len,
+					vq->iov, in);
 		total_len += vhost_len;
 		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
 			vhost_poll_queue(&vq->poll);
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1726,13 +1726,87 @@ static int log_write(void __user *log_ba
 	return r;
 }
 
+static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
+{
+	struct vhost_umem *umem = vq->umem;
+	struct vhost_umem_node *u;
+	u64 start, end, l, min;
+	int r;
+	bool hit = false;
+
+	while (len) {
+		min = len;
+		/* More than one GPAs can be mapped into a single HVA. So
+		 * iterate all possible umems here to be safe.
+		 */
+		list_for_each_entry(u, &umem->umem_list, link) {
+			if (u->userspace_addr > hva - 1 + len ||
+			    u->userspace_addr - 1 + u->size < hva)
+				continue;
+			start = max(u->userspace_addr, hva);
+			end = min(u->userspace_addr - 1 + u->size,
+				  hva - 1 + len);
+			l = end - start + 1;
+			r = log_write(vq->log_base,
+				      u->start + start - u->userspace_addr,
+				      l);
+			if (r < 0)
+				return r;
+			hit = true;
+			min = min(l, min);
+		}
+
+		if (!hit)
+			return -EFAULT;
+
+		len -= min;
+		hva += min;
+	}
+
+	return 0;
+}
+
+static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
+{
+	struct iovec iov[64];
+	int i, ret;
+
+	if (!vq->iotlb)
+		return log_write(vq->log_base, vq->log_addr + used_offset, len);
+
+	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
+			     len, iov, 64, VHOST_ACCESS_WO);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ret; i++) {
+		ret = log_write_hva(vq,	(uintptr_t)iov[i].iov_base,
+				    iov[i].iov_len);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-		    unsigned int log_num, u64 len)
+		    unsigned int log_num, u64 len, struct iovec *iov, int count)
 {
 	int i, r;
 
 	/* Make sure data written is seen before log. */
 	smp_wmb();
+
+	if (vq->iotlb) {
+		for (i = 0; i < count; i++) {
+			r = log_write_hva(vq, (uintptr_t)iov[i].iov_base,
+					  iov[i].iov_len);
+			if (r < 0)
+				return r;
+		}
+		return 0;
+	}
+
 	for (i = 0; i < log_num; ++i) {
 		u64 l = min(log[i].len, len);
 		r = log_write(vq->log_base, log[i].addr, l);
@@ -1762,9 +1836,8 @@ static int vhost_update_used_flags(struc
 		smp_wmb();
 		/* Log used flag write. */
 		used = &vq->used->flags;
-		log_write(vq->log_base, vq->log_addr +
-			  (used - (void __user *)vq->used),
-			  sizeof vq->used->flags);
+		log_used(vq, (used - (void __user *)vq->used),
+			 sizeof vq->used->flags);
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
@@ -1782,9 +1855,8 @@ static int vhost_update_avail_event(stru
 		smp_wmb();
 		/* Log avail event write */
 		used = vhost_avail_event(vq);
-		log_write(vq->log_base, vq->log_addr +
-			  (used - (void __user *)vq->used),
-			  sizeof *vhost_avail_event(vq));
+		log_used(vq, (used - (void __user *)vq->used),
+			 sizeof *vhost_avail_event(vq));
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
@@ -2189,10 +2261,8 @@ static int __vhost_add_used_n(struct vho
 		/* Make sure data is seen before log. */
 		smp_wmb();
 		/* Log used ring entry write. */
-		log_write(vq->log_base,
-			  vq->log_addr +
-			   ((void __user *)used - (void __user *)vq->used),
-			  count * sizeof *used);
+		log_used(vq, ((void __user *)used - (void __user *)vq->used),
+			 count * sizeof *used);
 	}
 	old = vq->last_used_idx;
 	new = (vq->last_used_idx += count);
@@ -2234,9 +2304,8 @@ int vhost_add_used_n(struct vhost_virtqu
 		/* Make sure used idx is seen before log. */
 		smp_wmb();
 		/* Log used index update. */
-		log_write(vq->log_base,
-			  vq->log_addr + offsetof(struct vring_used, idx),
-			  sizeof vq->used->idx);
+		log_used(vq, offsetof(struct vring_used, idx),
+			 sizeof vq->used->idx);
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -208,7 +208,8 @@ bool vhost_vq_avail_empty(struct vhost_d
 bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-		    unsigned int log_num, u64 len);
+		    unsigned int log_num, u64 len,
+		    struct iovec *iov, int count);
 int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
 
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);


