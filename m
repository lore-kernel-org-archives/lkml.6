Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59222075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759822;
	bh=hd2lSV/Lb2BOVyodMarextK4mj86DMntOLRSnYvLBqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcuxabgo8zgjHA1gh+3PZ2gIiXNzheHoVfLmsn7OJbfK2uCMuihswICQQ4glj7msk
	 ow/rDe/St7MQlPCpav19XioRpBL6B7z1K/3xBwR+pIz405zurQsJm2ldtS9jHlbItI
	 PdwGl5MqqSU6lexjla6Edxh1bc1DnwEgBAKib0SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBUOhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbfBUOhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552A12075C;
        Thu, 21 Feb 2019 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759819;
        bh=hd2lSV/Lb2BOVyodMarextK4mj86DMntOLRSnYvLBqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUH6Y7CLkAFviDJJWUr5s4xD5MZ+IbsbUMGX4jPZ7LAooCdW2/xZK39srtWF8maOT
         89tUhduFMI6qvEYYRoe5K/u7T0sHkUuT520HHn4XLruCkRfJJKrg2N5PFCdsUL1vqe
         fdco6+mPoaHep1de3plOCorgj/9fK7Hh06YzDBk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 04/13] tcp: clear icsk_backoff in tcp_write_queue_purge()
Date:   Thu, 21 Feb 2019 15:35:35 +0100
Message-Id: <20190221125240.484240814@linuxfoundation.org>
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
@@ -1379,6 +1379,7 @@ static inline void tcp_write_queue_purge
 		sk_wmem_free_skb(sk, skb);
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
+	inet_csk(sk)->icsk_backoff = 0;
 }
 
 static inline struct sk_buff *tcp_write_queue_head(const struct sock *sk)
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2258,7 +2258,6 @@ int tcp_disconnect(struct sock *sk, int
 	tp->srtt_us = 0;
 	if ((tp->write_seq += tp->max_window + 2) == 0)
 		tp->write_seq = 1;
-	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
 	tp->packets_out = 0;


