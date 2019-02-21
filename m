Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F18BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81BB20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760531;
	bh=IAuyMOnB04kpityV8Pa2rhu8E/jbLmw/69rC0V4yzjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KyuI5VGhxxuTsHXNdkb7cNnAp9JCnOs0mso/p6ktfH2lNoWAKTwX0UoFSuEz/EKdH
	 1N2YHK1ynTInEBOL+EOMgs9+bBc3UfIROHxxILFB6ZUzoSjEEj4acMt8x82UuvghUo
	 cqpjzFBp5AKezPXuc+OlXLZ2bhiECKKd9oUROFfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfBUOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbfBUOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ECD2080D;
        Thu, 21 Feb 2019 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759995;
        bh=IAuyMOnB04kpityV8Pa2rhu8E/jbLmw/69rC0V4yzjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+5PPf+lCXl6QKS+TQt4bgt6zB+Vr2WMrUGn1FqXu5aU53JME/G9wTLNbZyKDX+J3
         eqDrEHvI4tQl8Abk6fzgiszhZhwGilc0vH2K4IUt0HzYRbq41IYUtMCib+ZyOxzjft
         jZ4wlyU4RBn5T2tOO7sZNLL777Gl4Hc9bbgaPmAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/23] tcp: tcp_v4_err() should be more careful
Date:   Thu, 21 Feb 2019 15:35:59 +0100
Message-Id: <20190221125247.594253409@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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
@@ -475,14 +475,15 @@ void tcp_v4_err(struct sk_buff *icmp_skb
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
 		tcp_mstamp_refresh(tp);
 		delta_us = (u32)(tp->tcp_mstamp - skb->skb_mstamp);
 		remaining = icsk->icsk_rto -


