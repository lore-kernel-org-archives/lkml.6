Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2126C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736B920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2NXm7vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736B920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeJQBQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73062089E;
        Tue, 16 Oct 2018 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710731;
        bh=0MmIzDXzsd4wkMOI7o0UUdqLDy15som9rZ4JZLTK3tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2NXm7vnveMyKHUTJeyljPTit5/Crg+qq95tYBRN2UZEppjpIy9pPgHkV4RE9qrxO
         t7/vLYvQjNHo8lNdJHrbQmlC6ELv0p+b8ByvzYzI6Uznzw95EDzrwgckAcZ7shwGpC
         E9wcSzmEZi6pAnmmlFQ80gZB8nUlF2xLPS6nwMB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 68/71] ip: add helpers to process in-order fragments faster.
Date:   Tue, 16 Oct 2018 19:10:05 +0200
Message-Id: <20181016170542.804830975@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oskolkov <posk@google.com>

This patch introduces several helper functions/macros that will be
used in the follow-up patch. No runtime changes yet.

The new logic (fully implemented in the second patch) is as follows:

* Nodes in the rb-tree will now contain not single fragments, but lists
  of consecutive fragments ("runs").

* At each point in time, the current "active" run at the tail is
  maintained/tracked. Fragments that arrive in-order, adjacent
  to the previous tail fragment, are added to this tail run without
  triggering the re-balancing of the rb-tree.

* If a fragment arrives out of order with the offset _before_ the tail run,
  it is inserted into the rb-tree as a single fragment.

* If a fragment arrives after the current tail fragment (with a gap),
  it starts a new "tail" run, as is inserted into the rb-tree
  at the end as the head of the new run.

skb->cb is used to store additional information
needed here (suggested by Eric Dumazet).

Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 353c9cb360874e737fb000545f783df756c06f9a)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h |    6 +++
 net/ipv4/ip_fragment.c  |   73 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -56,7 +56,9 @@ struct frag_v6_compare_key {
  * @lock: spinlock protecting this frag
  * @refcnt: reference count of the queue
  * @fragments: received fragments head
+ * @rb_fragments: received fragments rb-tree root
  * @fragments_tail: received fragments tail
+ * @last_run_head: the head of the last "run". see ip_fragment.c
  * @stamp: timestamp of the last received fragment
  * @len: total length of the original datagram
  * @meat: length of received fragments so far
@@ -77,6 +79,7 @@ struct inet_frag_queue {
 	struct sk_buff		*fragments;  /* Used in IPv6. */
 	struct rb_root		rb_fragments; /* Used in IPv4. */
 	struct sk_buff		*fragments_tail;
+	struct sk_buff		*last_run_head;
 	ktime_t			stamp;
 	int			len;
 	int			meat;
@@ -112,6 +115,9 @@ void inet_frag_kill(struct inet_frag_que
 void inet_frag_destroy(struct inet_frag_queue *q);
 struct inet_frag_queue *inet_frag_find(struct netns_frags *nf, void *key);
 
+/* Free all skbs in the queue; return the sum of their truesizes. */
+unsigned int inet_frag_rbtree_purge(struct rb_root *root);
+
 static inline void inet_frag_put(struct inet_frag_queue *q)
 {
 	if (atomic_dec_and_test(&q->refcnt))
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -56,6 +56,57 @@
  */
 static const char ip_frag_cache_name[] = "ip4-frags";
 
+/* Use skb->cb to track consecutive/adjacent fragments coming at
+ * the end of the queue. Nodes in the rb-tree queue will
+ * contain "runs" of one or more adjacent fragments.
+ *
+ * Invariants:
+ * - next_frag is NULL at the tail of a "run";
+ * - the head of a "run" has the sum of all fragment lengths in frag_run_len.
+ */
+struct ipfrag_skb_cb {
+	struct inet_skb_parm	h;
+	struct sk_buff		*next_frag;
+	int			frag_run_len;
+};
+
+#define FRAG_CB(skb)		((struct ipfrag_skb_cb *)((skb)->cb))
+
+static void ip4_frag_init_run(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ipfrag_skb_cb) > sizeof(skb->cb));
+
+	FRAG_CB(skb)->next_frag = NULL;
+	FRAG_CB(skb)->frag_run_len = skb->len;
+}
+
+/* Append skb to the last "run". */
+static void ip4_frag_append_to_last_run(struct inet_frag_queue *q,
+					struct sk_buff *skb)
+{
+	RB_CLEAR_NODE(&skb->rbnode);
+	FRAG_CB(skb)->next_frag = NULL;
+
+	FRAG_CB(q->last_run_head)->frag_run_len += skb->len;
+	FRAG_CB(q->fragments_tail)->next_frag = skb;
+	q->fragments_tail = skb;
+}
+
+/* Create a new "run" with the skb. */
+static void ip4_frag_create_run(struct inet_frag_queue *q, struct sk_buff *skb)
+{
+	if (q->last_run_head)
+		rb_link_node(&skb->rbnode, &q->last_run_head->rbnode,
+			     &q->last_run_head->rbnode.rb_right);
+	else
+		rb_link_node(&skb->rbnode, NULL, &q->rb_fragments.rb_node);
+	rb_insert_color(&skb->rbnode, &q->rb_fragments);
+
+	ip4_frag_init_run(skb);
+	q->fragments_tail = skb;
+	q->last_run_head = skb;
+}
+
 /* Describe an entry in the "incomplete datagrams" queue. */
 struct ipq {
 	struct inet_frag_queue q;
@@ -652,6 +703,28 @@ struct sk_buff *ip_check_defrag(struct n
 }
 EXPORT_SYMBOL(ip_check_defrag);
 
+unsigned int inet_frag_rbtree_purge(struct rb_root *root)
+{
+	struct rb_node *p = rb_first(root);
+	unsigned int sum = 0;
+
+	while (p) {
+		struct sk_buff *skb = rb_entry(p, struct sk_buff, rbnode);
+
+		p = rb_next(p);
+		rb_erase(&skb->rbnode, root);
+		while (skb) {
+			struct sk_buff *next = FRAG_CB(skb)->next_frag;
+
+			sum += skb->truesize;
+			kfree_skb(skb);
+			skb = next;
+		}
+	}
+	return sum;
+}
+EXPORT_SYMBOL(inet_frag_rbtree_purge);
+
 #ifdef CONFIG_SYSCTL
 static int dist_min;
 


