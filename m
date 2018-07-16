Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342520858
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2342520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeGPDxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 23:53:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbeGPDxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 23:53:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99BC4401EF04;
        Mon, 16 Jul 2018 03:28:28 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DA022026D76;
        Mon, 16 Jul 2018 03:28:23 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wexu@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com
Subject: [PATCH net-next V2 1/8] vhost: move get_rx_bufs to vhost.c
Date:   Mon, 16 Jul 2018 11:28:04 +0800
Message-Id: <1531711691-6769-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 03:28:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 03:28:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_rx_bufs() to vhost.c and rename it to
vhost_get_bufs(). This helps to hide vring internal layout from
specific device implementation. Packed ring implementation will
benefit from this.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 83 ++-------------------------------------------------
 drivers/vhost/vhost.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h |  7 +++++
 3 files changed, 88 insertions(+), 80 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b224036..03dd1de 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -702,83 +702,6 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 	return len;
 }
 
-/* This is a multi-buffer version of vhost_get_desc, that works if
- *	vq has read descriptors only.
- * @vq		- the relevant virtqueue
- * @datalen	- data length we'll be reading
- * @iovcount	- returned count of io vectors we fill
- * @log		- vhost log
- * @log_num	- log offset
- * @quota       - headcount quota, 1 for big buffer
- *	returns number of buffer heads allocated, negative on error
- */
-static int get_rx_bufs(struct vhost_virtqueue *vq,
-		       struct vring_used_elem *heads,
-		       int datalen,
-		       unsigned *iovcount,
-		       struct vhost_log *log,
-		       unsigned *log_num,
-		       unsigned int quota)
-{
-	unsigned int out, in;
-	int seg = 0;
-	int headcount = 0;
-	unsigned d;
-	int r, nlogs = 0;
-	/* len is always initialized before use since we are always called with
-	 * datalen > 0.
-	 */
-	u32 uninitialized_var(len);
-
-	while (datalen > 0 && headcount < quota) {
-		if (unlikely(seg >= UIO_MAXIOV)) {
-			r = -ENOBUFS;
-			goto err;
-		}
-		r = vhost_get_vq_desc(vq, vq->iov + seg,
-				      ARRAY_SIZE(vq->iov) - seg, &out,
-				      &in, log, log_num);
-		if (unlikely(r < 0))
-			goto err;
-
-		d = r;
-		if (d == vq->num) {
-			r = 0;
-			goto err;
-		}
-		if (unlikely(out || in <= 0)) {
-			vq_err(vq, "unexpected descriptor format for RX: "
-				"out %d, in %d\n", out, in);
-			r = -EINVAL;
-			goto err;
-		}
-		if (unlikely(log)) {
-			nlogs += *log_num;
-			log += *log_num;
-		}
-		heads[headcount].id = cpu_to_vhost32(vq, d);
-		len = iov_length(vq->iov + seg, in);
-		heads[headcount].len = cpu_to_vhost32(vq, len);
-		datalen -= len;
-		++headcount;
-		seg += in;
-	}
-	heads[headcount - 1].len = cpu_to_vhost32(vq, len + datalen);
-	*iovcount = seg;
-	if (unlikely(log))
-		*log_num = nlogs;
-
-	/* Detect overrun */
-	if (unlikely(datalen > 0)) {
-		r = UIO_MAXIOV + 1;
-		goto err;
-	}
-	return headcount;
-err:
-	vhost_discard_vq_desc(vq, headcount);
-	return r;
-}
-
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_rx(struct vhost_net *net)
@@ -831,9 +754,9 @@ static void handle_rx(struct vhost_net *net)
 						      &busyloop_intr))) {
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
-		headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
-					vhost_len, &in, vq_log, &log,
-					likely(mergeable) ? UIO_MAXIOV : 1);
+		headcount = vhost_get_bufs(vq, vq->heads + nvq->done_idx,
+					   vhost_len, &in, vq_log, &log,
+					   likely(mergeable) ? UIO_MAXIOV : 1);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a502f1a..8814e5b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2104,6 +2104,84 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
+/* This is a multi-buffer version of vhost_get_desc, that works if
+ *	vq has read descriptors only.
+ * @vq		- the relevant virtqueue
+ * @datalen	- data length we'll be reading
+ * @iovcount	- returned count of io vectors we fill
+ * @log		- vhost log
+ * @log_num	- log offset
+ * @quota       - headcount quota, 1 for big buffer
+ *	returns number of buffer heads allocated, negative on error
+ */
+int vhost_get_bufs(struct vhost_virtqueue *vq,
+		   struct vring_used_elem *heads,
+		   int datalen,
+		   unsigned *iovcount,
+		   struct vhost_log *log,
+		   unsigned *log_num,
+		   unsigned int quota)
+{
+	unsigned int out, in;
+	int seg = 0;
+	int headcount = 0;
+	unsigned d;
+	int r, nlogs = 0;
+	/* len is always initialized before use since we are always called with
+	 * datalen > 0.
+	 */
+	u32 uninitialized_var(len);
+
+	while (datalen > 0 && headcount < quota) {
+		if (unlikely(seg >= UIO_MAXIOV)) {
+			r = -ENOBUFS;
+			goto err;
+		}
+		r = vhost_get_vq_desc(vq, vq->iov + seg,
+				      ARRAY_SIZE(vq->iov) - seg, &out,
+				      &in, log, log_num);
+		if (unlikely(r < 0))
+			goto err;
+
+		d = r;
+		if (d == vq->num) {
+			r = 0;
+			goto err;
+		}
+		if (unlikely(out || in <= 0)) {
+			vq_err(vq, "unexpected descriptor format for RX: "
+				"out %d, in %d\n", out, in);
+			r = -EINVAL;
+			goto err;
+		}
+		if (unlikely(log)) {
+			nlogs += *log_num;
+			log += *log_num;
+		}
+		heads[headcount].id = cpu_to_vhost32(vq, d);
+		len = iov_length(vq->iov + seg, in);
+		heads[headcount].len = cpu_to_vhost32(vq, len);
+		datalen -= len;
+		++headcount;
+		seg += in;
+	}
+	heads[headcount - 1].len = cpu_to_vhost32(vq, len + datalen);
+	*iovcount = seg;
+	if (unlikely(log))
+		*log_num = nlogs;
+
+	/* Detect overrun */
+	if (unlikely(datalen > 0)) {
+		r = UIO_MAXIOV + 1;
+		goto err;
+	}
+	return headcount;
+err:
+	vhost_discard_vq_desc(vq, headcount);
+	return r;
+}
+EXPORT_SYMBOL_GPL(vhost_get_bufs);
+
 /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
 void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 6c844b9..52edd242 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -185,6 +185,13 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct iovec iov[], unsigned int iov_count,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num);
+int vhost_get_bufs(struct vhost_virtqueue *vq,
+		   struct vring_used_elem *heads,
+		   int datalen,
+		   unsigned *iovcount,
+		   struct vhost_log *log,
+		   unsigned *log_num,
+		   unsigned int quota);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.7.4

