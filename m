Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2EB2080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539883;
	bh=fvebzdf+Je28WQcKrr02Iy1scI+QCZ/VtBQQDGO5VvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OthUzp54o8qfv3lRAI0H29cUfbssYdwyls4mtlxGHxRxAAn9NUVNHLmh2UUaONXLC
	 vp4m6wWgQLFDvL1wizO2CJEOIiQQWuF5gPbTeCH66wclaA0Hrl8hFzxdbURwiIoo7S
	 Gn9TMhlFdiLEAn1YCqXuGBx4S1La2B+dyqE0S/Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfBGLol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfBGLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99DF21917;
        Thu,  7 Feb 2019 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539814;
        bh=fvebzdf+Je28WQcKrr02Iy1scI+QCZ/VtBQQDGO5VvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQOmzLOXlMZKshrpj2r72ft7B8djibK6bzV5pWKlvhoGuSJ8uJghUNWiIxfEWA1op
         jGhq3+vA9oKsdxdwMlKX0imvRyFVUCNcgeRk8FvFx30Z6iadyhsPA1Ce/rirETGMap
         L92ZHhiZfbAXgyDrPKHu9/guTKZdoRGJYd8tSLXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 17/34] ipv6: frags: rewrite ip6_expire_frag_queue()
Date:   Thu,  7 Feb 2019 12:41:59 +0100
Message-Id: <20190207113026.249602528@linuxfoundation.org>
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

commit 05c0b86b9696802fd0ce5676a92a63f1b455bdf3 upstream.

Make it similar to IPv4 ip_expire(), and release the lock
before calling icmp functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
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
 
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
 	IP6_INC_STATS_BH(net, __in6_dev_get(dev), IPSTATS_MIB_REASMTIMEOUT);
 
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


