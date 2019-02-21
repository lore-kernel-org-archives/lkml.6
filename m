Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD79EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A84A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760077;
	bh=rFI+SS6WbvzYHjAZnPB+IkAQDuw7RkAAxCOCevyUci4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJFfXvhv/MaeyQDSwpufT5D0w0iNyg2gWzRFoJGY+Cr6z6OVJwewM58YYSL6YfSN6
	 jI3Z0EODH/5AE0prnbb0uYg6bmLVasp3wHb4edCaOqzci7ZwE+7fqcPv1qGfl+pk7/
	 /PztAo+FvtTu5HbSWZ4vOb7NxKBdc89WfI9GLrX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfBUOlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfBUOlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485752080D;
        Thu, 21 Feb 2019 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760072;
        bh=rFI+SS6WbvzYHjAZnPB+IkAQDuw7RkAAxCOCevyUci4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W29HDknijze0o/8fWSYPR0CVSdtFdmibciDNcivQJuSvH+3FZ3IENia/X0tpC6CKr
         to9VfsQkfwwQJVY0DWnXp/mjni1xPs/QNaoM9HzzskEZiTCJICJ6ARqQON3nkltB9t
         3P98BtgaYOJMdN2QMfsl8YtrOfCMGGpBhw9FYqo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        soukjin bae <soukjin.bae@samsung.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/30] tcp: clear icsk_backoff in tcp_write_queue_purge()
Date:   Thu, 21 Feb 2019 15:36:00 +0100
Message-Id: <20190221125251.549370209@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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
index 87fe44197aa1f..432dc9af11720 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2519,6 +2519,7 @@ void tcp_write_queue_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_sk(sk)->packets_out = 0;
+	inet_csk(sk)->icsk_backoff = 0;
 }
 
 int tcp_disconnect(struct sock *sk, int flags)
@@ -2567,7 +2568,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->write_seq += tp->max_window + 2;
 	if (tp->write_seq == 0)
 		tp->write_seq = 1;
-	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
-- 
2.19.1



