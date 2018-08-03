Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A801C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB87621775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB87621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeHCSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:03:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbeHCSDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61CEC7DAC3;
        Fri,  3 Aug 2018 16:06:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC13D1D089;
        Fri,  3 Aug 2018 16:06:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] rxrpc: Push iov_iter up from
 rxrpc_kernel_recv_data() to caller
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 17:06:56 +0100
Message-ID: <153331241619.5289.329306820096612046.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 16:06:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 03 Aug 2018 16:06:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Push iov_iter up from rxrpc_kernel_recv_data() to its caller to allow
non-contiguous iovs to be passed down, thereby permitting file reading to
be simplified in the AFS filesystem in a future patch.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rxrpc.c         |   28 +++++++++++++++++-----------
 include/net/af_rxrpc.h |    2 +-
 net/rxrpc/recvmsg.c    |   33 +++++++++++----------------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a1b18082991b..19db5f672a9d 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -346,7 +346,6 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
-	size_t offset;
 	s64 tx_total_len;
 	int ret;
 
@@ -433,10 +432,10 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret, "KSD");
 	} else {
-		offset = 0;
-		rxrpc_kernel_recv_data(call->net->socket, rxcall, NULL,
-				       0, &offset, false, &call->abort_code,
-				       &call->service_id);
+		iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, NULL, 0, 0);
+		rxrpc_kernel_recv_data(call->net->socket, rxcall,
+				       &msg.msg_iter, false,
+				       &call->abort_code, &call->service_id);
 		ac->abort_code = call->abort_code;
 		ac->responded = true;
 	}
@@ -467,13 +466,14 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       state == AFS_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
-			size_t offset = 0;
+			struct iov_iter iter;
+
+			iov_iter_kvec(&iter, READ | ITER_KVEC, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
-						     call->rxcall,
-						     NULL, 0, &offset, false,
+						     call->rxcall, &iter, false,
 						     &remote_abort,
 						     &call->service_id);
-			trace_afs_recv_data(call, 0, offset, false, ret);
+			trace_afs_recv_data(call, 0, 0, false, ret);
 
 			if (ret == -EINPROGRESS || ret == -EAGAIN)
 				return;
@@ -894,6 +894,8 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 		     bool want_more)
 {
 	struct afs_net *net = call->net;
+	struct iov_iter iter;
+	struct kvec iov;
 	enum afs_call_state state;
 	u32 remote_abort = 0;
 	int ret;
@@ -903,10 +905,14 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 
 	ASSERTCMP(call->offset, <=, count);
 
-	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall,
-				     buf, count, &call->offset,
+	iov.iov_base = buf + call->offset;
+	iov.iov_len = count - call->offset;
+	iov_iter_kvec(&iter, ITER_KVEC | READ, &iov, 1, count - call->offset);
+
+	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, &iter,
 				     want_more, &remote_abort,
 				     &call->service_id);
+	call->offset += (count - call->offset) - iov_iter_count(&iter);
 	trace_afs_recv_data(call, count, call->offset, want_more, ret);
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 8ae8ee004258..f53edb3754bc 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -61,7 +61,7 @@ int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
 			   struct msghdr *, size_t,
 			   rxrpc_notify_end_tx_t);
 int rxrpc_kernel_recv_data(struct socket *, struct rxrpc_call *,
-			   void *, size_t, size_t *, bool, u32 *, u16 *);
+			   struct iov_iter *, bool, u32 *, u16 *);
 bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
 			     u32, int, const char *);
 void rxrpc_kernel_end_call(struct socket *, struct rxrpc_call *);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index a57ea96c84ea..816b19a78809 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -611,9 +611,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * rxrpc_kernel_recv_data - Allow a kernel service to receive data/info
  * @sock: The socket that the call exists on
  * @call: The call to send data through
- * @buf: The buffer to receive into
- * @size: The size of the buffer, including data already read
- * @_offset: The running offset into the buffer.
+ * @iter: The buffer to receive into
  * @want_more: True if more data is expected to be read
  * @_abort: Where the abort code is stored if -ECONNABORTED is returned
  * @_service: Where to store the actual service ID (may be upgraded)
@@ -626,39 +624,30 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * Note that we may return -EAGAIN to drain empty packets at the end of the
  * data, even if we've already copied over the requested data.
  *
- * This function adds the amount it transfers to *_offset, so this should be
- * precleared as appropriate.  Note that the amount remaining in the buffer is
- * taken to be size - *_offset.
- *
  * *_abort should also be initialised to 0.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
-			   void *buf, size_t size, size_t *_offset,
+			   struct iov_iter *iter,
 			   bool want_more, u32 *_abort, u16 *_service)
 {
-	struct iov_iter iter;
-	struct kvec iov;
+	size_t offset = 0;
 	int ret;
 
-	_enter("{%d,%s},%zu/%zu,%d",
+	_enter("{%d,%s},%zu,%d",
 	       call->debug_id, rxrpc_call_states[call->state],
-	       *_offset, size, want_more);
+	       iov_iter_count(iter), want_more);
 
-	ASSERTCMP(*_offset, <=, size);
 	ASSERTCMP(call->state, !=, RXRPC_CALL_SERVER_ACCEPTING);
 
-	iov.iov_base = buf + *_offset;
-	iov.iov_len = size - *_offset;
-	iov_iter_kvec(&iter, ITER_KVEC | READ, &iov, 1, size - *_offset);
-
 	mutex_lock(&call->user_mutex);
 
 	switch (READ_ONCE(call->state)) {
 	case RXRPC_CALL_CLIENT_RECV_REPLY:
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
-		ret = rxrpc_recvmsg_data(sock, call, NULL, &iter, size, 0,
-					 _offset);
+		ret = rxrpc_recvmsg_data(sock, call, NULL, iter,
+					 iov_iter_count(iter), 0,
+					 &offset);
 		if (ret < 0)
 			goto out;
 
@@ -667,7 +656,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 		 * full buffer or have been given -EAGAIN.
 		 */
 		if (ret == 1) {
-			if (*_offset < size)
+			if (iov_iter_count(iter) > 0)
 				goto short_data;
 			if (!want_more)
 				goto read_phase_complete;
@@ -704,7 +693,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	if (_service)
 		*_service = call->service_id;
 	mutex_unlock(&call->user_mutex);
-	_leave(" = %d [%zu,%d]", ret, *_offset, *_abort);
+	_leave(" = %d [%zu,%d]", ret, iov_iter_count(iter), *_abort);
 	return ret;
 
 short_data:
@@ -720,7 +709,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	ret = call->error;
 	if (call->completion == RXRPC_CALL_SUCCEEDED) {
 		ret = 1;
-		if (size > 0)
+		if (iov_iter_count(iter) > 0)
 			ret = -ECONNRESET;
 	}
 	goto out;

