Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D401C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B892080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760173;
	bh=mW0u96xWlHL9Rcf2gtxaR12uo9/pclvDz5N7hTwmbas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UwI+eiTQu5LMZ6JZMYlk8h0mcneGpYu5dGPgi/HgCnxdPPtKpZigRb0wsM//mgqI7
	 jKniN1p1Gd3lia5jmKdYU8BgcVGfS62UWGXez5ggM7y7Wi3jPUJ0zuXMOHXIfyj4G5
	 VqtIduGLPhUHk5MOTn4TBaF5MyWmceCmPkEoyzrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfBUOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfBUOms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC6D2086A;
        Thu, 21 Feb 2019 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760167;
        bh=mW0u96xWlHL9Rcf2gtxaR12uo9/pclvDz5N7hTwmbas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A536i3rE1aOwULs9TX64H3K7vJEqwofTYyIxgTw6cKBs8zsp2xf3U6xujYNHZVgYG
         86r3EU9mzvr3dHBgY//VTXtOiv8B5h4UMSCBc8wLaKRmsR8WYfoxu77Tx2BoUllgvp
         hcn+JcOiwTNJqzipf2/F6jQ7kfYGu8/sEJTCS7mg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 17/32] tcp: clear icsk_backoff in tcp_write_queue_purge()
Date:   Thu, 21 Feb 2019 15:36:05 +0100
Message-Id: <20190221125251.884723766@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 04c03114be82194d4a4858d41dba8e286ad1787c ]

soukjin bae reported a crash in tcp_v4_err() handling
ICMP_DEST_UNREACH after tcp_write_queue_head(sk)
returned a NULL pointer.

Current logic should have prevented this :

  if (seq != tp->snd_una  || !icsk->icsk_retransmits ||
      !icsk->icsk_backoff || fastopen)
      break;

Problem is the write queue might have been purged
and icsk_backoff has not been cleared.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: soukjin bae <soukjin.bae@samsung.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40cbe5609663f..b102973102b9e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2532,6 +2532,7 @@ void tcp_write_queue_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_sk(sk)->packets_out = 0;
+	inet_csk(sk)->icsk_backoff = 0;
 }
 
 int tcp_disconnect(struct sock *sk, int flags)
@@ -2580,7 +2581,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->write_seq += tp->max_window + 2;
 	if (tp->write_seq == 0)
 		tp->write_seq = 1;
-	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
-- 
2.19.1



