Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32833C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BAD2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759897;
	bh=82SAn6VBjC8wyR9JZFYWZj8T5FJGWys/l3TaH3bYBqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVKPpCXyhM1PuWBwiuNy8p48uLvVH/d7K5MZP+PrApjwvB6WtJBBhnVOD8kWUBsFZ
	 0MMz4U9WBK/ChL5xC2ERYyofI28zXcep9p0+Z/3M0WoMAdFO0DUgBI9P09ZkjaV1QA
	 5czaKw1i7eujyYZ/vIJ/jO9tFEPxulRKkrEZ+3+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfBUOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfBUOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE4020838;
        Thu, 21 Feb 2019 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759891;
        bh=82SAn6VBjC8wyR9JZFYWZj8T5FJGWys/l3TaH3bYBqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpjIPFx5QLPPYKIVSLeUo6P8JjLl+l7vDpTSmIGbB7NuBEmuLgwaDYRuqIUdBf/qX
         UPkqsDjR4WYmvR+XhljDXdNDBvVBXudwm8h5MY9MPO6s537223K0NJZQCs2sBQiHRL
         /Oh8nZQxpnHIftRja7qnBzdNTA5asNBAR/zCZnQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 07/20] tcp: tcp_v4_err() should be more careful
Date:   Thu, 21 Feb 2019 15:35:37 +0100
Message-Id: <20190221141946.984750657@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

[ Upstream commit 2c4cc9712364c051b1de2d175d5fbea6be948ebf ]

ICMP handlers are not very often stressed, we should
make them more resilient to bugs that might surface in
the future.

If there is no packet in retransmit queue, we should
avoid a NULL deref.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: soukjin bae <soukjin.bae@samsung.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -466,14 +466,15 @@ void tcp_v4_err(struct sk_buff *icmp_skb
 		if (sock_owned_by_user(sk))
 			break;
 
+		skb = tcp_write_queue_head(sk);
+		if (WARN_ON_ONCE(!skb))
+			break;
+
 		icsk->icsk_backoff--;
 		icsk->icsk_rto = tp->srtt_us ? __tcp_set_rto(tp) :
 					       TCP_TIMEOUT_INIT;
 		icsk->icsk_rto = inet_csk_rto_backoff(icsk, TCP_RTO_MAX);
 
-		skb = tcp_write_queue_head(sk);
-		BUG_ON(!skb);
-
 		remaining = icsk->icsk_rto -
 			    min(icsk->icsk_rto,
 				tcp_time_stamp - tcp_skb_timestamp(skb));


