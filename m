Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57A2C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8DC2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788900;
	bh=JrdWMq+DlAgt358f4V+N9SlrMJJKf1gEQpqgDuyfB7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kc8QuKOWcfeYXfSWOifNiHpHUEQbpURFTTtrvpzAEdFuYNtFde2GGhepUq7jHEfUS
	 vrGWTyu1BFYjhHYjqVnXEtIi9TvfTW7W9eJqBAjBbCq6HfuB9YFCPEyO+AZ94ZtNy6
	 tnYHmdep9E6sVOZvIDEtmR7aWGOsOuaJ/i3/WzoY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8DC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeLNMBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeLNMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159DE2133F;
        Fri, 14 Dec 2018 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788896;
        bh=JrdWMq+DlAgt358f4V+N9SlrMJJKf1gEQpqgDuyfB7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucAjiJxHG/9FVNkBuyWjqrm68hqTuLzVChPUfy4OjUnBBUwDG2JU/w7OlqVl70xAF
         QdRmfr1G3YjIrkUIl5w9sKO7ojrFxlUhPE/lTCQFCYmVofiSix6z+LbDJgZ32sYDaq
         Qwq3DKjcGTYYYkTsPaFW8MJPvSQgC3DL18/57ut0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rafael Tinoco <rafael.tinoco@linaro.org>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 015/142] tcp: fix NULL ref in tail loss probe
Date:   Fri, 14 Dec 2018 12:58:20 +0100
Message-Id: <20181214115747.658743162@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit b2b7af861122a0c0f6260155c29a1b2e594cd5b5 ]

TCP loss probe timer may fire when the retranmission queue is empty but
has a non-zero tp->packets_out counter. tcp_send_loss_probe will call
tcp_rearm_rto which triggers NULL pointer reference by fetching the
retranmission queue head in its sub-routines.

Add a more detailed warning to help catch the root cause of the inflight
accounting inconsistency.

Reported-by: Rafael Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2479,15 +2479,18 @@ void tcp_send_loss_probe(struct sock *sk
 		goto rearm_timer;
 	}
 	skb = skb_rb_last(&sk->tcp_rtx_queue);
+	if (unlikely(!skb)) {
+		WARN_ONCE(tp->packets_out,
+			  "invalid inflight: %u state %u cwnd %u mss %d\n",
+			  tp->packets_out, sk->sk_state, tp->snd_cwnd, mss);
+		inet_csk(sk)->icsk_pending = 0;
+		return;
+	}
 
 	/* At most one outstanding TLP retransmission. */
 	if (tp->tlp_high_seq)
 		goto rearm_timer;
 
-	/* Retransmit last segment. */
-	if (WARN_ON(!skb))
-		goto rearm_timer;
-
 	if (skb_still_in_host_queue(sk, skb))
 		goto rearm_timer;
 


