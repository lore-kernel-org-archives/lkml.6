Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF18220892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790923;
	bh=D7kF05SA+l2ORZBKjOnwTttg+4FvkNqDRfz7unZxIuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7mFNS7TKFB8u/2x2JjSDVMhUeWQMmNotNIRgwFpqB21AH6ROx2860EyzKmbSQ3eD
	 g1YYhKXFFI6P1NiY+yWZ9TYLunfhRp6xPFWayFgXUZeEuDBoNLnHfGTwCnUdOJUdcO
	 dly8G/gDfbjA2Bv6t1UIzcQpKKMukYuLStOyasOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF18220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeLNMfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbeLNMH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4883321479;
        Fri, 14 Dec 2018 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789247;
        bh=D7kF05SA+l2ORZBKjOnwTttg+4FvkNqDRfz7unZxIuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghXWzIeeRp9OjO+6K+HyvYIBEX/2e+/AvhaNiA5gytiLT9Z2+uMuyr7ljOFveNvNL
         VeBDRqZXBtozSDc6S4+v2Eie5VBKg13JnZFibo+bwzsAp7bVvWa98lJVDGHs2rIjVz
         ALxqDHJB7cI18kylN6xyF6aVL4367FRDfw6ct5EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Wiesner <jwiesner@suse.com>,
        Per Sundstrom <per.sundstrom@redqube.se>,
        Peter Oskolkov <posk@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 01/89] ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes
Date:   Fri, 14 Dec 2018 12:59:14 +0100
Message-Id: <20181214115729.731269763@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

From: Jiri Wiesner <jwiesner@suse.com>

[ Upstream commit ebaf39e6032faf77218220707fc3fa22487784e0 ]

The *_frag_reasm() functions are susceptible to miscalculating the byte
count of packet fragments in case the truesize of a head buffer changes.
The truesize member may be changed by the call to skb_unclone(), leaving
the fragment memory limit counter unbalanced even if all fragments are
processed. This miscalculation goes unnoticed as long as the network
namespace which holds the counter is not destroyed.

Should an attempt be made to destroy a network namespace that holds an
unbalanced fragment memory limit counter the cleanup of the namespace
never finishes. The thread handling the cleanup gets stuck in
inet_frags_exit_net() waiting for the percpu counter to reach zero. The
thread is usually in running state with a stacktrace similar to:

 PID: 1073   TASK: ffff880626711440  CPU: 1   COMMAND: "kworker/u48:4"
  #5 [ffff880621563d48] _raw_spin_lock at ffffffff815f5480
  #6 [ffff880621563d48] inet_evict_bucket at ffffffff8158020b
  #7 [ffff880621563d80] inet_frags_exit_net at ffffffff8158051c
  #8 [ffff880621563db0] ops_exit_list at ffffffff814f5856
  #9 [ffff880621563dd8] cleanup_net at ffffffff814f67c0
 #10 [ffff880621563e38] process_one_work at ffffffff81096f14

It is not possible to create new network namespaces, and processes
that call unshare() end up being stuck in uninterruptible sleep state
waiting to acquire the net_mutex.

The bug was observed in the IPv6 netfilter code by Per Sundstrom.
I thank him for his analysis of the problem. The parts of this patch
that apply to IPv4 and IPv6 fragment reassembly are preemptive measures.

Signed-off-by: Jiri Wiesner <jwiesner@suse.com>
Reported-by: Per Sundstrom <per.sundstrom@redqube.se>
Acked-by: Peter Oskolkov <posk@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c                  |    7 +++++++
 net/ipv6/netfilter/nf_conntrack_reasm.c |    8 +++++++-
 net/ipv6/reassembly.c                   |    8 +++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -513,6 +513,7 @@ static int ip_frag_reasm(struct ipq *qp,
 	struct rb_node *rbn;
 	int len;
 	int ihlen;
+	int delta;
 	int err;
 	u8 ecn;
 
@@ -554,10 +555,16 @@ static int ip_frag_reasm(struct ipq *qp,
 	if (len > 65535)
 		goto out_oversize;
 
+	delta = - head->truesize;
+
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
 		goto out_nomem;
 
+	delta += head->truesize;
+	if (delta)
+		add_frag_mem_limit(qp->q.net, delta);
+
 	/* If the first fragment is fragmented itself, we split
 	 * it to two chunks: the first with data and paged part
 	 * and the second, holding only fragments. */
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -349,7 +349,7 @@ static bool
 nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *prev,  struct net_device *dev)
 {
 	struct sk_buff *fp, *head = fq->q.fragments;
-	int    payload_len;
+	int    payload_len, delta;
 	u8 ecn;
 
 	inet_frag_kill(&fq->q);
@@ -371,10 +371,16 @@ nf_ct_frag6_reasm(struct frag_queue *fq,
 		return false;
 	}
 
+	delta = - head->truesize;
+
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
 		return false;
 
+	delta += head->truesize;
+	if (delta)
+		add_frag_mem_limit(fq->q.net, delta);
+
 	/* If the first fragment is fragmented itself, we split
 	 * it to two chunks: the first with data and paged part
 	 * and the second, holding only fragments. */
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -348,7 +348,7 @@ static int ip6_frag_reasm(struct frag_qu
 {
 	struct net *net = container_of(fq->q.net, struct net, ipv6.frags);
 	struct sk_buff *fp, *head = fq->q.fragments;
-	int    payload_len;
+	int    payload_len, delta;
 	unsigned int nhoff;
 	int sum_truesize;
 	u8 ecn;
@@ -389,10 +389,16 @@ static int ip6_frag_reasm(struct frag_qu
 	if (payload_len > IPV6_MAXPLEN)
 		goto out_oversize;
 
+	delta = - head->truesize;
+
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
 		goto out_oom;
 
+	delta += head->truesize;
+	if (delta)
+		add_frag_mem_limit(fq->q.net, delta);
+
 	/* If the first fragment is fragmented itself, we split
 	 * it to two chunks: the first with data and paged part
 	 * and the second, holding only fragments. */


