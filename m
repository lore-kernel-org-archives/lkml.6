Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1081C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBEF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHduc+Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBEF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeJQBQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D88B2089E;
        Tue, 16 Oct 2018 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710705;
        bh=g7gZwwW8KAjZsv5BoIyMrYX9SZFv1ihsWdXhTeOyLbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHduc+Wb5m6P7sE8CQBFLvUn8MiG2p3cTduLNQMeTOiIOSVJS5u4FW9/TRO3zsgOA
         X5nTu13ED+O8SEKNhpjs2tKGlDOSo+pl09UBGA8PhzIewXh5sxbx/HY9kZJh8KXp5v
         dMU1IQ2CJuvIYa8uY3O1jp/XqLSPLk8zDjZu1CA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 60/71] inet: frags: fix ip6frag_low_thresh boundary
Date:   Tue, 16 Oct 2018 19:09:57 +0200
Message-Id: <20181016170542.375068858@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

Giving an integer to proc_doulongvec_minmax() is dangerous on 64bit arches,
since linker might place next to it a non zero value preventing a change
to ip6frag_low_thresh.

ip6frag_low_thresh is not used anymore in the kernel, but we do not
want to prematuraly break user scripts wanting to change it.

Since specifying a minimal value of 0 for proc_doulongvec_minmax()
is moot, let's remove these zero values in all defrag units.

Fixes: 6e00f7dd5e4e ("ipv6: frags: fix /proc/sys/net/ipv6/ip6frag_low_thresh")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 3d23401283e80ceb03f765842787e0e79ff598b7)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/reassembly.c     |    2 -
 net/ipv4/ip_fragment.c                  |   40 ++++++++++++--------------------
 net/ipv6/netfilter/nf_conntrack_reasm.c |    2 -
 net/ipv6/reassembly.c                   |    4 ---
 4 files changed, 17 insertions(+), 31 deletions(-)

--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -410,7 +410,6 @@ err:
 }
 
 #ifdef CONFIG_SYSCTL
-static long zero;
 
 static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 	{
@@ -427,7 +426,6 @@ static struct ctl_table lowpan_frags_ns_
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
 	},
 	{
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -56,14 +56,6 @@
  */
 static const char ip_frag_cache_name[] = "ip4-frags";
 
-struct ipfrag_skb_cb
-{
-	struct inet_skb_parm	h;
-	int			offset;
-};
-
-#define FRAG_CB(skb)	((struct ipfrag_skb_cb *)((skb)->cb))
-
 /* Describe an entry in the "incomplete datagrams" queue. */
 struct ipq {
 	struct inet_frag_queue q;
@@ -351,13 +343,13 @@ static int ip_frag_queue(struct ipq *qp,
 	 * this fragment, right?
 	 */
 	prev = qp->q.fragments_tail;
-	if (!prev || FRAG_CB(prev)->offset < offset) {
+	if (!prev || prev->ip_defrag_offset < offset) {
 		next = NULL;
 		goto found;
 	}
 	prev = NULL;
 	for (next = qp->q.fragments; next != NULL; next = next->next) {
-		if (FRAG_CB(next)->offset >= offset)
+		if (next->ip_defrag_offset >= offset)
 			break;	/* bingo! */
 		prev = next;
 	}
@@ -368,7 +360,7 @@ found:
 	 * any overlaps are eliminated.
 	 */
 	if (prev) {
-		int i = (FRAG_CB(prev)->offset + prev->len) - offset;
+		int i = (prev->ip_defrag_offset + prev->len) - offset;
 
 		if (i > 0) {
 			offset += i;
@@ -385,8 +377,8 @@ found:
 
 	err = -ENOMEM;
 
-	while (next && FRAG_CB(next)->offset < end) {
-		int i = end - FRAG_CB(next)->offset; /* overlap is 'i' bytes */
+	while (next && next->ip_defrag_offset < end) {
+		int i = end - next->ip_defrag_offset; /* overlap is 'i' bytes */
 
 		if (i < next->len) {
 			int delta = -next->truesize;
@@ -399,7 +391,7 @@ found:
 			delta += next->truesize;
 			if (delta)
 				add_frag_mem_limit(qp->q.net, delta);
-			FRAG_CB(next)->offset += i;
+			next->ip_defrag_offset += i;
 			qp->q.meat -= i;
 			if (next->ip_summed != CHECKSUM_UNNECESSARY)
 				next->ip_summed = CHECKSUM_NONE;
@@ -423,7 +415,13 @@ found:
 		}
 	}
 
-	FRAG_CB(skb)->offset = offset;
+	/* Note : skb->ip_defrag_offset and skb->dev share the same location */
+	dev = skb->dev;
+	if (dev)
+		qp->iif = dev->ifindex;
+	/* Makes sure compiler wont do silly aliasing games */
+	barrier();
+	skb->ip_defrag_offset = offset;
 
 	/* Insert this fragment in the chain of fragments. */
 	skb->next = next;
@@ -434,11 +432,6 @@ found:
 	else
 		qp->q.fragments = skb;
 
-	dev = skb->dev;
-	if (dev) {
-		qp->iif = dev->ifindex;
-		skb->dev = NULL;
-	}
 	qp->q.stamp = skb->tstamp;
 	qp->q.meat += skb->len;
 	qp->ecn |= ecn;
@@ -514,7 +507,7 @@ static int ip_frag_reasm(struct ipq *qp,
 	}
 
 	WARN_ON(!head);
-	WARN_ON(FRAG_CB(head)->offset != 0);
+	WARN_ON(head->ip_defrag_offset != 0);
 
 	/* Allocate a new buffer for the datagram. */
 	ihlen = ip_hdrlen(head);
@@ -677,7 +670,7 @@ struct sk_buff *ip_check_defrag(struct n
 EXPORT_SYMBOL(ip_check_defrag);
 
 #ifdef CONFIG_SYSCTL
-static long zero;
+static int dist_min;
 
 static struct ctl_table ip4_frags_ns_ctl_table[] = {
 	{
@@ -694,7 +687,6 @@ static struct ctl_table ip4_frags_ns_ctl
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.ipv4.frags.high_thresh
 	},
 	{
@@ -710,7 +702,7 @@ static struct ctl_table ip4_frags_ns_ctl
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero
+		.extra1		= &dist_min,
 	},
 	{ }
 };
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -63,7 +63,6 @@ struct nf_ct_frag6_skb_cb
 static struct inet_frags nf_frags;
 
 #ifdef CONFIG_SYSCTL
-static long zero;
 
 static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 	{
@@ -79,7 +78,6 @@ static struct ctl_table nf_ct_frag6_sysc
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.nf_frag.frags.high_thresh
 	},
 	{
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -548,7 +548,6 @@ static const struct inet6_protocol frag_
 };
 
 #ifdef CONFIG_SYSCTL
-static int zero;
 
 static struct ctl_table ip6_frags_ns_ctl_table[] = {
 	{
@@ -564,8 +563,7 @@ static struct ctl_table ip6_frags_ns_ctl
 		.data		= &init_net.ipv6.frags.low_thresh,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &init_net.ipv6.frags.high_thresh
 	},
 	{


