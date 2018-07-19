Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84DECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D0A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D0A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeGSB4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:56:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730094AbeGSB4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39B9D87A87;
        Thu, 19 Jul 2018 01:15:34 +0000 (UTC)
Received: from 192-168-1-101.tpgi.com.com (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 678952026D69;
        Thu, 19 Jul 2018 01:15:31 +0000 (UTC)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH V4 net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Thu, 19 Jul 2018 11:14:42 +1000
Message-Id: <20180719011444.4694-2-jmaxwell37@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 01:15:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 01:15:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jmaxwell37@gmail.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit. Part of this series that improves the
socket TCP_USER_TIMEOUT option accuracy. Implement Eric Dumazets idea
to convert icsk->icsk_user_timeout from jiffies to msecs. To eliminate
the msecs_to_jiffies() and jiffies_to_msecs() dance in future.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp.c       | 4 ++--
 net/ipv4/tcp_timer.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e3704a49164b..9d900162f16a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2984,7 +2984,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = msecs_to_jiffies(val);
+			icsk->icsk_user_timeout = val;
 		break;
 
 	case TCP_FASTOPEN:
@@ -3440,7 +3440,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = jiffies_to_msecs(icsk->icsk_user_timeout);
+		val = icsk->icsk_user_timeout;
 		break;
 
 	case TCP_FASTOPEN:
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..fa34984d0b12 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -183,8 +183,9 @@ static bool retransmits_timed_out(struct sock *sk,
 		else
 			timeout = ((2 << linear_backoff_thresh) - 1) * rto_base +
 				(boundary - linear_backoff_thresh) * TCP_RTO_MAX;
+		timeout = jiffies_to_msecs(timeout);
 	}
-	return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= jiffies_to_msecs(timeout);
+	return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= timeout;
 }
 
 /* A write timeout has occurred. Process the after effects. */
@@ -337,8 +338,7 @@ static void tcp_probe_timer(struct sock *sk)
 	if (!start_ts)
 		skb->skb_mstamp = tp->tcp_mstamp;
 	else if (icsk->icsk_user_timeout &&
-		 (s32)(tcp_time_stamp(tp) - start_ts) >
-		 jiffies_to_msecs(icsk->icsk_user_timeout))
+		 (s32)(tcp_time_stamp(tp) - start_ts) > icsk->icsk_user_timeout)
 		goto abort;
 
 	max_probes = sock_net(sk)->ipv4.sysctl_tcp_retries2;
@@ -672,7 +672,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		 * to determine when to timeout instead.
 		 */
 		if ((icsk->icsk_user_timeout != 0 &&
-		    elapsed >= icsk->icsk_user_timeout &&
+		    elapsed >= msecs_to_jiffies(icsk->icsk_user_timeout) &&
 		    icsk->icsk_probes_out > 0) ||
 		    (icsk->icsk_user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
-- 
2.13.6

