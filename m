Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032DC2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032DC2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbeIREev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeIREeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64429C49;
        Mon, 17 Sep 2018 23:05:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 106/126] ipv6: frags: rewrite ip6_expire_frag_queue()
Date:   Tue, 18 Sep 2018 00:42:34 +0200
Message-Id: <20180917211710.915884058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Make it similar to IPv4 ip_expire(), and release the lock
before calling icmp functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 05c0b86b9696802fd0ce5676a92a63f1b455bdf3)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -92,7 +92,9 @@ EXPORT_SYMBOL(ip6_frag_init);
 void ip6_expire_frag_queue(struct net *net, struct frag_queue *fq)
 {
 	struct net_device *dev = NULL;
+	struct sk_buff *head;
 
+	rcu_read_lock();
 	spin_lock(&fq->q.lock);
 
 	if (fq->q.flags & INET_FRAG_COMPLETE)
@@ -100,28 +102,34 @@ void ip6_expire_frag_queue(struct net *n
 
 	inet_frag_kill(&fq->q);
 
-	rcu_read_lock();
 	dev = dev_get_by_index_rcu(net, fq->iif);
 	if (!dev)
-		goto out_rcu_unlock;
+		goto out;
 
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
 	/* Don't send error if the first segment did not arrive. */
-	if (!(fq->q.flags & INET_FRAG_FIRST_IN) || !fq->q.fragments)
-		goto out_rcu_unlock;
+	head = fq->q.fragments;
+	if (!(fq->q.flags & INET_FRAG_FIRST_IN) || !head)
+		goto out;
 
 	/* But use as source device on which LAST ARRIVED
 	 * segment was received. And do not use fq->dev
 	 * pointer directly, device might already disappeared.
 	 */
-	fq->q.fragments->dev = dev;
-	icmpv6_send(fq->q.fragments, ICMPV6_TIME_EXCEED, ICMPV6_EXC_FRAGTIME, 0);
-out_rcu_unlock:
-	rcu_read_unlock();
+	head->dev = dev;
+	skb_get(head);
+	spin_unlock(&fq->q.lock);
+
+	icmpv6_send(head, ICMPV6_TIME_EXCEED, ICMPV6_EXC_FRAGTIME, 0);
+	kfree_skb(head);
+	goto out_rcu_unlock;
+
 out:
 	spin_unlock(&fq->q.lock);
+out_rcu_unlock:
+	rcu_read_unlock();
 	inet_frag_put(&fq->q);
 }
 EXPORT_SYMBOL(ip6_expire_frag_queue);


