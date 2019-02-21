Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A55FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760010;
	bh=AX5hcKG1/CSVqzQMa4MqYzUR5XayS+xM6js6jGKwVzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B85E5WY0TBG97bu6jSpOdqQ9h2zJpWhoyqakRHUaWSxHWsHjIUR4hsbdWOMOoAL26
	 j/fvBEkAF45Pa9OlGpNofx1NMM7qmy7JtNsdfYOTo+9BgrmN3aXW275/99yc9GXHYo
	 IuimppJfqdjo559MvLKcTBfcIhK4/VcapCoWyRkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfBUOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfBUOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4E82080D;
        Thu, 21 Feb 2019 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760001;
        bh=AX5hcKG1/CSVqzQMa4MqYzUR5XayS+xM6js6jGKwVzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wjhBwJzmU6HbEu00pfiFCrquFWnRarOP4ue5WX2L9twM82R7dTgKUlxDy208/2Eq
         bzuLqZQuyQaVUHAyg7snSpNgljt/TZfo7ulSYNuVK8qDLFmHShvGBTQ+qIkXd7O0Zu
         fAD/cyyieyk9PecihXv/1f4aZy/2XnMJKNEQRwgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/23] tcp: clear icsk_backoff in tcp_write_queue_purge()
Date:   Thu, 21 Feb 2019 15:36:01 +0100
Message-Id: <20190221125247.723731494@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    1 +
 net/ipv4/tcp.c    |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1622,6 +1622,7 @@ static inline void tcp_write_queue_purge
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_init_send_head(sk);
 	tcp_sk(sk)->packets_out = 0;
+	inet_csk(sk)->icsk_backoff = 0;
 }
 
 static inline struct sk_buff *tcp_write_queue_head(const struct sock *sk)
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2347,7 +2347,6 @@ int tcp_disconnect(struct sock *sk, int
 	tp->write_seq += tp->max_window + 2;
 	if (tp->write_seq == 0)
 		tp->write_seq = 1;
-	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;


