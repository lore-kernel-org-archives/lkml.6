Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3541E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3541E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJDUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:45:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeJDUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:45:04 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D725DA6DEA;
        Thu,  4 Oct 2018 13:51:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEA63309136D;
        Thu,  4 Oct 2018 13:51:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 8/9] rxrpc: Allow the reply time to be obtained on
 a client call
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:39 +0100
Message-ID: <153866109906.27255.17015866653360172800.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Oct 2018 13:51:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the timestamp on the sk_buff holding the first DATA packet of a reply
to be queried.  This can then be used as a base for the expiry time
calculation on the callback promise duration indicated by an operation
result.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/networking/rxrpc.txt |   11 +++++++++
 include/net/af_rxrpc.h             |    3 +++
 net/rxrpc/recvmsg.c                |   43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index b5407163d53b..67879992b4c2 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -1069,6 +1069,17 @@ The kernel interface functions are as follows:
 
      This function may transmit a PING ACK.
 
+ (*) Get reply timestamp.
+
+	bool rxrpc_kernel_get_reply_time(struct socket *sock,
+					 struct rxrpc_call *call,
+					 ktime_t *_ts)
+
+     This allows the timestamp on the first DATA packet of the reply of a
+     client call to be queried, provided that it is still in the Rx ring.  If
+     successful, the timestamp will be stored into *_ts and true will be
+     returned; false will be returned otherwise.
+
 
 =======================
 CONFIGURABLE PARAMETERS
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index f53edb3754bc..c4c912554dee 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -13,6 +13,7 @@
 #define _NET_RXRPC_H
 
 #include <linux/rxrpc.h>
+#include <linux/ktime.h>
 
 struct key;
 struct sock;
@@ -77,5 +78,7 @@ int rxrpc_kernel_retry_call(struct socket *, struct rxrpc_call *,
 int rxrpc_kernel_check_call(struct socket *, struct rxrpc_call *,
 			    enum rxrpc_call_completion *, u32 *);
 u32 rxrpc_kernel_check_life(struct socket *, struct rxrpc_call *);
+bool rxrpc_kernel_get_reply_time(struct socket *, struct rxrpc_call *,
+				 ktime_t *);
 
 #endif /* _NET_RXRPC_H */
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 816b19a78809..eaf19ebaa964 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -715,3 +715,46 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	goto out;
 }
 EXPORT_SYMBOL(rxrpc_kernel_recv_data);
+
+/**
+ * rxrpc_kernel_get_reply_time - Get timestamp on first reply packet
+ * @sock: The socket that the call exists on
+ * @call: The call to query
+ * @_ts: Where to put the timestamp
+ *
+ * Retrieve the timestamp from the first DATA packet of the reply if it is
+ * in the ring.  Returns true if successful, false if not.
+ */
+bool rxrpc_kernel_get_reply_time(struct socket *sock, struct rxrpc_call *call,
+				 ktime_t *_ts)
+{
+	struct sk_buff *skb;
+	rxrpc_seq_t hard_ack, top, seq;
+	bool success = false;
+
+	mutex_lock(&call->user_mutex);
+
+	if (READ_ONCE(call->state) != RXRPC_CALL_CLIENT_RECV_REPLY)
+		goto out;
+
+	hard_ack = call->rx_hard_ack;
+	if (hard_ack != 0)
+		goto out;
+
+	seq = hard_ack + 1;
+	top = smp_load_acquire(&call->rx_top);
+	if (after(seq, top))
+		goto out;
+
+	skb = call->rxtx_buffer[seq & RXRPC_RXTX_BUFF_MASK];
+	if (!skb)
+		goto out;
+
+	*_ts = skb_get_ktime(skb);
+	success = true;
+
+out:
+	mutex_unlock(&call->user_mutex);
+	return success;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_reply_time);

