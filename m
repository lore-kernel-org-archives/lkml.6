Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBBFECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CF3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CF3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGSB4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:56:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbeGSB4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:56:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29C2FCE1C2;
        Thu, 19 Jul 2018 01:15:44 +0000 (UTC)
Received: from 192-168-1-101.tpgi.com.com (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5192026D69;
        Thu, 19 Jul 2018 01:15:41 +0000 (UTC)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH V4 net-next 3/3] tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy
Date:   Thu, 19 Jul 2018 11:14:44 +1000
Message-Id: <20180719011444.4694-4-jmaxwell37@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 01:15:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 01:15:44 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmaxwell37@gmail.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the tcp_clamp_rto_to_user_timeout() helper routine. To calculate
the correct rto, so that the TCP_USER_TIMEOUT socket option is more
accurate. Taking suggestions and feedback into account from
Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we
can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d212f183dd2d..a242f8874629 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -36,6 +36,21 @@ u32 tcp_retransmit_stamp(const struct sock *sk)
 	return start_ts;
 }
 
+static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 elapsed, start_ts;
+
+	start_ts = tcp_retransmit_stamp(sk);
+	if (!icsk->icsk_user_timeout || !start_ts)
+		return icsk->icsk_rto;
+	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
+	if (elapsed >= icsk->icsk_user_timeout)
+		return 1; /* user timeout has passed; fire ASAP */
+	else
+		return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout - elapsed));
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -544,7 +559,8 @@ void tcp_retransmit_timer(struct sock *sk)
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
+	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+				  tcp_clamp_rto_to_user_timeout(sk), TCP_RTO_MAX);
 	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
 		__sk_dst_reset(sk);
 
-- 
2.13.6

