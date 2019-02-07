Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A47C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DC82190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539816;
	bh=SkoBuGxzXOo+XiTqE7OBF+mUE4OmG305FdFr7+VFD50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Djns+bHmHVX85bo/O7xVK1PjlNEHEPhilklmgXgaFUle01NOUh3yT8YDF9xfVr9Rf
	 C91z6qZYe2De16tq3svdbBU/OSYT9YPtciMMlvQWPEkEVcI2RmmI3+VzGIAKpmQ6OI
	 Ek0zhAiztJ7t9XjhhOoYaBqOy+8u6imawrJS+mQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfBGLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfBGLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B103521908;
        Thu,  7 Feb 2019 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539811;
        bh=SkoBuGxzXOo+XiTqE7OBF+mUE4OmG305FdFr7+VFD50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6LyEOspeEV0wiyZaRm6O2HbMU2SL/h7jkNLtWBuw7+qVE9ZIcu6B8bYnRt1zFUzw
         5iCtnUFXH1FIZkMF/fnT2ScKwELC9sWLSbYxnjMSQqlBm7DoClaoZkq92MS5nL75CH
         X2eJPdmLpGM2RclnZduAiIfpEzIjb/bv0YDU23Is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 16/34] inet: frags: do not clone skb in ip_expire()
Date:   Thu,  7 Feb 2019 12:41:58 +0100
Message-Id: <20190207113026.216027585@linuxfoundation.org>
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

commit 1eec5d5670084ee644597bd26c25e22c69b9f748 upstream.

An skb_clone() was added in commit ec4fbd64751d ("inet: frag: release
spinlock before calling icmp_send()")

While fixing the bug at that time, it also added a very high cost
for DDOS frags, as the ICMP rate limit is applied after this
expensive operation (skb_clone() + consume_skb(), implying memory
allocations, copy, and freeing)

We can use skb_get(head) here, all we want is to make sure skb wont
be freed by another cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -143,8 +143,8 @@ static bool frag_expire_skip_icmp(u32 us
  */
 static void ip_expire(unsigned long arg)
 {
-	struct sk_buff *clone, *head;
 	const struct iphdr *iph;
+	struct sk_buff *head;
 	struct net *net;
 	struct ipq *qp;
 	int err;
@@ -187,16 +187,12 @@ static void ip_expire(unsigned long arg)
 	    (skb_rtable(head)->rt_type != RTN_LOCAL))
 		goto out;
 
-	clone = skb_clone(head, GFP_ATOMIC);
+	skb_get(head);
+	spin_unlock(&qp->q.lock);
+	icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
+	kfree_skb(head);
+	goto out_rcu_unlock;
 
-	/* Send an ICMP "Fragment Reassembly Timeout" message. */
-	if (clone) {
-		spin_unlock(&qp->q.lock);
-		icmp_send(clone, ICMP_TIME_EXCEEDED,
-			  ICMP_EXC_FRAGTIME, 0);
-		consume_skb(clone);
-		goto out_rcu_unlock;
-	}
 out:
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:


