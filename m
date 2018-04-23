Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeDWFfT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:35:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeDWFfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:14 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 1/8] vhost: move get_rx_bufs to vhost.c
Date: Mon, 23 Apr 2018 13:34:53 +0800
Message-Id: <1524461700-5469-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_rx_bufs() to vhost.c and rename it to
vhost_get_rx_bufs(). This helps to hide vring internal layout from
specific device implementation. Packed ring implementation will
benefit from this.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 83 ++-------------------------------------------------
 drivers/vhost/vhost.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h |  7 +++++
 3 files changed, 88 insertions(+), 80 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..762aa81 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -664,83 +664,6 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
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
@@ -790,9 +713,9 @@ static void handle_rx(struct vhost_net *net)
 	while ((sock_len = vhost_net_rx_peek_head_len(net, sock->sk))) {
 		sock_len += sock_hlen;
 		vhost_len = sock_len + vhost_hlen;
-		headcount = get_rx_bufs(vq, vq->heads + nheads, vhost_len,
-					&in, vq_log, &log,
-					likely(mergeable) ? UIO_MAXIOV : 1);
+		headcount = vhost_get_bufs(vq, vq->heads + nheads, vhost_len,
+					   &in, vq_log, &log,
+					   likely(mergeable) ? UIO_MAXIOV : 1);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(headcount < 0))
 			goto out;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f3bd8e9..6b455f6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2097,6 +2097,84 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
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
