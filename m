Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2737AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078721904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539787;
	bh=u8mL5WUVhUj9XIFzSZ1agifuyEmoUhH9EhDmdCliGMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRNIchnuXoP4WnWQzquXOTaQhIbECvNdszXAYhkYMi58u+sRmEOJlCJGZ8HURw/D4
	 1xAWIAT8wfJ8tMseV89i+9GEV3gBXv77BPisCMqTFdBPEOZyBnF8R3ngViXMRboaXv
	 WbETUWXFFjl8SXYyUbKwvT8e/XbsbYJFYntLAMg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfBGLnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfBGLnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31BC218FE;
        Thu,  7 Feb 2019 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539781;
        bh=u8mL5WUVhUj9XIFzSZ1agifuyEmoUhH9EhDmdCliGMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVBpQJbKJGnd6O9L2AnY0FxxDD9Rl8//11QemwtoJV4yyoAS4KXIVc3EX9j3gxwZj
         xsXBfNE/4yDn8raE6ZY/9hzvcLW9j12tzgubb6uFmj3S8xVE/0LmE4GDr5PSzzWog2
         fd4Bb8wsnU9QCnyxJ8wvuKuC20JWWejumGCp9n28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 21/34] inet: frags: fix ip6frag_low_thresh boundary
Date:   Thu,  7 Feb 2019 12:42:03 +0100
Message-Id: <20190207113026.394109647@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 3d23401283e80ceb03f765842787e0e79ff598b7 upstream.

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
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
@@ -58,14 +58,6 @@
 static int sysctl_ipfrag_max_dist __read_mostly = 64;
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
@@ -353,13 +345,13 @@ static int ip_frag_queue(struct ipq *qp,
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
@@ -370,7 +362,7 @@ found:
 	 * any overlaps are eliminated.
 	 */
 	if (prev) {
-		int i = (FRAG_CB(prev)->offset + prev->len) - offset;
+		int i = (prev->ip_defrag_offset + prev->len) - offset;
 
 		if (i > 0) {
 			offset += i;
@@ -387,8 +379,8 @@ found:
 
 	err = -ENOMEM;
 
-	while (next && FRAG_CB(next)->offset < end) {
-		int i = end - FRAG_CB(next)->offset; /* overlap is 'i' bytes */
+	while (next && next->ip_defrag_offset < end) {
+		int i = end - next->ip_defrag_offset; /* overlap is 'i' bytes */
 
 		if (i < next->len) {
 			/* Eat head of the next overlapped fragment
@@ -396,7 +388,7 @@ found:
 			 */
 			if (!pskb_pull(next, i))
 				goto err;
-			FRAG_CB(next)->offset += i;
+			next->ip_defrag_offset += i;
 			qp->q.meat -= i;
 			if (next->ip_summed != CHECKSUM_UNNECESSARY)
 				next->ip_summed = CHECKSUM_NONE;
@@ -420,7 +412,13 @@ found:
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
@@ -431,11 +429,6 @@ found:
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
@@ -511,7 +504,7 @@ static int ip_frag_reasm(struct ipq *qp,
 	}
 
 	WARN_ON(!head);
-	WARN_ON(FRAG_CB(head)->offset != 0);
+	WARN_ON(head->ip_defrag_offset != 0);
 
 	/* Allocate a new buffer for the datagram. */
 	ihlen = ip_hdrlen(head);
@@ -678,7 +671,7 @@ struct sk_buff *ip_check_defrag(struct n
 EXPORT_SYMBOL(ip_check_defrag);
 
 #ifdef CONFIG_SYSCTL
-static long zero;
+static int dist_min;
 
 static struct ctl_table ip4_frags_ns_ctl_table[] = {
 	{
@@ -695,7 +688,6 @@ static struct ctl_table ip4_frags_ns_ctl
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.ipv4.frags.high_thresh
 	},
 	{
@@ -724,7 +716,7 @@ static struct ctl_table ip4_frags_ctl_ta
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
@@ -64,7 +64,6 @@ struct nf_ct_frag6_skb_cb
 static struct inet_frags nf_frags;
 
 #ifdef CONFIG_SYSCTL
-static long zero;
 
 static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 	{
@@ -80,7 +79,6 @@ static struct ctl_table nf_ct_frag6_sysc
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
 		.extra2		= &init_net.nf_frag.frags.high_thresh
 	},
 	{
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -547,7 +547,6 @@ static const struct inet6_protocol frag_
 };
 
 #ifdef CONFIG_SYSCTL
-static int zero;
 
 static struct ctl_table ip6_frags_ns_ctl_table[] = {
 	{
@@ -563,8 +562,7 @@ static struct ctl_table ip6_frags_ns_ctl
 		.data		= &init_net.ipv6.frags.low_thresh,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &init_net.ipv6.frags.high_thresh
 	},
 	{


