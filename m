Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DEAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8520838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759819;
	bh=/RmsagfOj/kVR+D18RWCHc0Br5Fv9Rn01XH1sm8oumY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GsuyN/5gj+Pa/sRUfUZqGMN3k9L0cSGiTQzsG+JPSWOmWT9cJzHcuJYuvuJYfxpIb
	 8DGMjY12gX7b12obaFCAO3oNWEbBU4rI7bw+BHjJ4jgvI/UHEDfKDgg6Ao/a+zBTNW
	 CVRxQTiKkhT/ZADt2e78zh5sVkdSWu4g7jGuPauo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfBUOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfBUOg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:36:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2DA82086C;
        Thu, 21 Feb 2019 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759816;
        bh=/RmsagfOj/kVR+D18RWCHc0Br5Fv9Rn01XH1sm8oumY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEpXaMvBy8R9b1f+Bcjl33evdwh6gMjhglewhooTtd7ryVuhXMwHiAqRUelaJQ0zl
         ZNI6v+W23fDQESlWhTvSqDArBGnWCEjLz8IBNcTpS2r/ywOEP5UZgkvptoEUkAnLU+
         8DNlxsL7h0gu2GWfUIoMkW6rsIVawE5H7mTVpVUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 03/13] tcp: tcp_v4_err() should be more careful
Date:   Thu, 21 Feb 2019 15:35:34 +0100
Message-Id: <20190221125240.426071647@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -432,14 +432,15 @@ void tcp_v4_err(struct sk_buff *icmp_skb
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


