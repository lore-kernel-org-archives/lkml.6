Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3859CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39792064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39792064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJOSPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeJOSPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00358313C24D;
        Mon, 15 Oct 2018 10:31:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFB447C594;
        Mon, 15 Oct 2018 10:31:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] rxrpc: Add /proc/net/rxrpc/peers to display peer
 list
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Oct 2018 11:31:03 +0100
Message-ID: <153959946389.27408.16748794272430961849.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Oct 2018 10:31:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/net/rxrpc/peers to display the list of peers currently active.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/ar-internal.h |    1 
 net/rxrpc/net_ns.c      |    3 +
 net/rxrpc/proc.c        |  126 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 8cee7644965c..0a7c49e8e053 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1062,6 +1062,7 @@ void rxrpc_put_peer(struct rxrpc_peer *);
  */
 extern const struct seq_operations rxrpc_call_seq_ops;
 extern const struct seq_operations rxrpc_connection_seq_ops;
+extern const struct seq_operations rxrpc_peer_seq_ops;
 
 /*
  * recvmsg.c
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index 417d80867c4f..fd7eba8467fa 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -102,6 +102,9 @@ static __net_init int rxrpc_init_net(struct net *net)
 	proc_create_net("conns", 0444, rxnet->proc_net,
 			&rxrpc_connection_seq_ops,
 			sizeof(struct seq_net_private));
+	proc_create_net("peers", 0444, rxnet->proc_net,
+			&rxrpc_peer_seq_ops,
+			sizeof(struct seq_net_private));
 	return 0;
 
 err_proc:
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 9805e3b85c36..c7d976859d40 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -212,3 +212,129 @@ const struct seq_operations rxrpc_connection_seq_ops = {
 	.stop   = rxrpc_connection_seq_stop,
 	.show   = rxrpc_connection_seq_show,
 };
+
+/*
+ * generate a list of extant virtual peers in /proc/net/rxrpc/peers
+ */
+static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
+{
+	struct rxrpc_peer *peer;
+	time64_t now;
+	char lbuff[50], rbuff[50];
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(seq,
+			 "Proto Local                                          "
+			 " Remote                                         "
+			 " Use CW  MTU   LastUse          RTT Rc\n"
+			 );
+		return 0;
+	}
+
+	peer = list_entry(v, struct rxrpc_peer, hash_link);
+
+	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
+
+	sprintf(rbuff, "%pISpc", &peer->srx.transport);
+
+	now = ktime_get_seconds();
+	seq_printf(seq,
+		   "UDP   %-47.47s %-47.47s %3u"
+		   " %3u %5u %6llus %12llu %2u\n",
+		   lbuff,
+		   rbuff,
+		   atomic_read(&peer->usage),
+		   peer->cong_cwnd,
+		   peer->mtu,
+		   now - peer->last_tx_at,
+		   peer->rtt,
+		   peer->rtt_cursor);
+
+	return 0;
+}
+
+static void *rxrpc_peer_seq_start(struct seq_file *seq, loff_t *_pos)
+	__acquires(rcu)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+	unsigned int bucket, n;
+	unsigned int shift = 32 - HASH_BITS(rxnet->peer_hash);
+	void *p;
+
+	rcu_read_lock();
+
+	if (*_pos >= UINT_MAX)
+		return NULL;
+
+	n = *_pos & ((1U << shift) - 1);
+	bucket = *_pos >> shift;
+	for (;;) {
+		if (bucket >= HASH_SIZE(rxnet->peer_hash)) {
+			*_pos = UINT_MAX;
+			return NULL;
+		}
+		if (n == 0) {
+			if (bucket == 0)
+				return SEQ_START_TOKEN;
+			*_pos += 1;
+			n++;
+		}
+
+		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], n - 1);
+		if (p)
+			return p;
+		bucket++;
+		n = 1;
+		*_pos = (bucket << shift) | n;
+	}
+}
+
+static void *rxrpc_peer_seq_next(struct seq_file *seq, void *v, loff_t *_pos)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+	unsigned int bucket, n;
+	unsigned int shift = 32 - HASH_BITS(rxnet->peer_hash);
+	void *p;
+
+	if (*_pos >= UINT_MAX)
+		return NULL;
+
+	bucket = *_pos >> shift;
+
+	p = seq_hlist_next_rcu(v, &rxnet->peer_hash[bucket], _pos);
+	if (p)
+		return p;
+
+	for (;;) {
+		bucket++;
+		n = 1;
+		*_pos = (bucket << shift) | n;
+
+		if (bucket >= HASH_SIZE(rxnet->peer_hash)) {
+			*_pos = UINT_MAX;
+			return NULL;
+		}
+		if (n == 0) {
+			*_pos += 1;
+			n++;
+		}
+
+		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], n - 1);
+		if (p)
+			return p;
+	}
+}
+
+static void rxrpc_peer_seq_stop(struct seq_file *seq, void *v)
+	__releases(rcu)
+{
+	rcu_read_unlock();
+}
+
+
+const struct seq_operations rxrpc_peer_seq_ops = {
+	.start  = rxrpc_peer_seq_start,
+	.next   = rxrpc_peer_seq_next,
+	.stop   = rxrpc_peer_seq_stop,
+	.show   = rxrpc_peer_seq_show,
+};

