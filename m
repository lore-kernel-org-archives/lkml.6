Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeBMCN5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeBMCN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:13:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5922221779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
From: Stefano Stabellini <sstabellini@kernel.org>
To: boris.ostrovsky@oracle.com, jgross@suse.com
Cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Stefano Stabellini <stefano@aporeto.com>
Subject: [PATCH v2 1/2] pvcalls-front: introduce a per sock_mapping refcount
Date: Mon, 12 Feb 2018 18:13:46 -0800
Message-Id: <1518488027-22386-1-git-send-email-sstabellini@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <alpine.DEB.2.10.1802121812500.3704@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802121812500.3704@sstabellini-ThinkPad-X260>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per sock_mapping refcount, in addition to the existing
global refcount. Thanks to the sock_mapping refcount, we can safely wait
for it to be 1 in pvcalls_front_release before freeing an active socket,
instead of waiting for the global refcount to be 1.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

---
Changes in v2:
- fix code style
- nicer checks in pvcalls_front_release
- fix check in pvcalls_enter_sock
---
 drivers/xen/pvcalls-front.c | 193 +++++++++++++++++++-------------------------
 1 file changed, 81 insertions(+), 112 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 4c789e6..163bf8c 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -60,6 +60,7 @@ struct sock_mapping {
 	bool active_socket;
 	struct list_head list;
 	struct socket *sock;
+	atomic_t refcount;
 	union {
 		struct {
 			int irq;
@@ -93,6 +94,34 @@ struct sock_mapping {
 	};
 };
 
+static inline struct sock_mapping *pvcalls_enter_sock(struct socket *sock)
+{
+	struct sock_mapping *map = NULL;
+
+	if (!pvcalls_front_dev ||
+		dev_get_drvdata(&pvcalls_front_dev->dev) == NULL)
+		return ERR_PTR(-ENOTCONN);
+
+	pvcalls_enter();
+	map = (struct sock_mapping *)sock->sk->sk_send_head;
+	if (map == NULL) {
+		pvcalls_exit()
+		return ERR_PTR(-ENOTSOCK);
+	}
+
+	atomic_inc(&map->refcount);
+	return map;
+}
+
+static inline void pvcalls_exit_sock(struct socket *sock)
+{
+	struct sock_mapping *map = NULL;
+
+	map = (struct sock_mapping *)sock->sk->sk_send_head;
+	atomic_dec(&map->refcount);
+	pvcalls_exit();
+}
+
 static inline int get_request(struct pvcalls_bedata *bedata, int *req_id)
 {
 	*req_id = bedata->ring.req_prod_pvt & (RING_SIZE(&bedata->ring) - 1);
@@ -369,31 +398,23 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
 	if (addr->sa_family != AF_INET || sock->type != SOCK_STREAM)
 		return -EOPNOTSUPP;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *)sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	spin_lock(&bedata->socket_lock);
 	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	ret = create_active(map, &evtchn);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 
@@ -423,7 +444,7 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
 	smp_rmb();
 	ret = bedata->rsp[req_id].ret;
 	bedata->rsp[req_id].req_id = PVCALLS_INVALID_ID;
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return ret;
 }
 
@@ -488,23 +509,15 @@ int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (flags & (MSG_CONFIRM|MSG_DONTROUTE|MSG_EOR|MSG_OOB))
 		return -EOPNOTSUPP;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	mutex_lock(&map->active.out_mutex);
 	if ((flags & MSG_DONTWAIT) && !pvcalls_front_write_todo(map)) {
 		mutex_unlock(&map->active.out_mutex);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -EAGAIN;
 	}
 	if (len > INT_MAX)
@@ -526,7 +539,7 @@ int pvcalls_front_sendmsg(struct socket *sock, struct msghdr *msg,
 		tot_sent = sent;
 
 	mutex_unlock(&map->active.out_mutex);
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return tot_sent;
 }
 
@@ -591,19 +604,11 @@ int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & (MSG_CMSG_CLOEXEC|MSG_ERRQUEUE|MSG_OOB|MSG_TRUNC))
 		return -EOPNOTSUPP;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	mutex_lock(&map->active.in_mutex);
 	if (len > XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER))
 		len = XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
@@ -623,7 +628,7 @@ int pvcalls_front_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		ret = 0;
 
 	mutex_unlock(&map->active.in_mutex);
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return ret;
 }
 
@@ -637,24 +642,16 @@ int pvcalls_front_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	if (addr->sa_family != AF_INET || sock->type != SOCK_STREAM)
 		return -EOPNOTSUPP;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (map == NULL) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	spin_lock(&bedata->socket_lock);
 	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	req = RING_GET_REQUEST(&bedata->ring, req_id);
@@ -684,7 +681,7 @@ int pvcalls_front_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	bedata->rsp[req_id].req_id = PVCALLS_INVALID_ID;
 
 	map->passive.status = PVCALLS_STATUS_BIND;
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return 0;
 }
 
@@ -695,21 +692,13 @@ int pvcalls_front_listen(struct socket *sock, int backlog)
 	struct xen_pvcalls_request *req;
 	int notify, req_id, ret;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	if (map->passive.status != PVCALLS_STATUS_BIND) {
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -EOPNOTSUPP;
 	}
 
@@ -717,7 +706,7 @@ int pvcalls_front_listen(struct socket *sock, int backlog)
 	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	req = RING_GET_REQUEST(&bedata->ring, req_id);
@@ -741,7 +730,7 @@ int pvcalls_front_listen(struct socket *sock, int backlog)
 	bedata->rsp[req_id].req_id = PVCALLS_INVALID_ID;
 
 	map->passive.status = PVCALLS_STATUS_LISTEN;
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return ret;
 }
 
@@ -753,21 +742,13 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 	struct xen_pvcalls_request *req;
 	int notify, req_id, ret, evtchn, nonblock;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -ENOTCONN;
-	}
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return -ENOTSOCK;
-	}
-
 	if (map->passive.status != PVCALLS_STATUS_LISTEN) {
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -EINVAL;
 	}
 
@@ -785,13 +766,13 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 			goto received;
 		}
 		if (nonblock) {
-			pvcalls_exit();
+			pvcalls_exit_sock(sock);
 			return -EAGAIN;
 		}
 		if (wait_event_interruptible(map->passive.inflight_accept_req,
 			!test_and_set_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 					  (void *)&map->passive.flags))) {
-			pvcalls_exit();
+			pvcalls_exit_sock(sock);
 			return -EINTR;
 		}
 	}
@@ -802,7 +783,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	map2 = kzalloc(sizeof(*map2), GFP_ATOMIC);
@@ -810,7 +791,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -ENOMEM;
 	}
 	ret = create_active(map2, &evtchn);
@@ -819,7 +800,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	list_add_tail(&map2->list, &bedata->socket_mappings);
@@ -841,13 +822,13 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 	/* We could check if we have received a response before returning. */
 	if (nonblock) {
 		WRITE_ONCE(map->passive.inflight_req_id, req_id);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -EAGAIN;
 	}
 
 	if (wait_event_interruptible(bedata->inflight_req,
 		READ_ONCE(bedata->rsp[req_id].req_id) == req_id)) {
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -EINTR;
 	}
 	/* read req_id, then the content */
@@ -862,7 +843,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		pvcalls_front_free_map(bedata, map2);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return -ENOMEM;
 	}
 	newsock->sk->sk_send_head = (void *)map2;
@@ -874,7 +855,7 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 	clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT, (void *)&map->passive.flags);
 	wake_up(&map->passive.inflight_accept_req);
 
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return ret;
 }
 
@@ -965,23 +946,16 @@ unsigned int pvcalls_front_poll(struct file *file, struct socket *sock,
 	struct sock_mapping *map;
 	int ret;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map))
 		return POLLNVAL;
-	}
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (!map) {
-		pvcalls_exit();
-		return POLLNVAL;
-	}
 	if (map->active_socket)
 		ret = pvcalls_front_poll_active(file, bedata, map, wait);
 	else
 		ret = pvcalls_front_poll_passive(file, bedata, map, wait);
-	pvcalls_exit();
+	pvcalls_exit_sock(sock);
 	return ret;
 }
 
@@ -995,25 +969,20 @@ int pvcalls_front_release(struct socket *sock)
 	if (sock->sk == NULL)
 		return 0;
 
-	pvcalls_enter();
-	if (!pvcalls_front_dev) {
-		pvcalls_exit();
-		return -EIO;
+	map = pvcalls_enter_sock(sock);
+	if (IS_ERR(map)) {
+		if (PTR_ERR(map) == -ENOTCONN)
+			return -EIO;
+		else
+			return 0;
 	}
-
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
 
-	map = (struct sock_mapping *) sock->sk->sk_send_head;
-	if (map == NULL) {
-		pvcalls_exit();
-		return 0;
-	}
-
 	spin_lock(&bedata->socket_lock);
 	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
-		pvcalls_exit();
+		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	sock->sk->sk_send_head = NULL;
@@ -1043,10 +1012,10 @@ int pvcalls_front_release(struct socket *sock)
 		/*
 		 * We need to make sure that sendmsg/recvmsg on this socket have
 		 * not started before we've cleared sk_send_head here. The
-		 * easiest (though not optimal) way to guarantee this is to see
-		 * that no pvcall (other than us) is in progress.
+		 * easiest way to guarantee this is to see that no pvcalls
+		 * (other than us) is in progress on this socket.
 		 */
-		while (atomic_read(&pvcalls_refcount) > 1)
+		while (atomic_read(&map->refcount) > 1)
 			cpu_relax();
 
 		pvcalls_front_free_map(bedata, map);
-- 
1.9.1
