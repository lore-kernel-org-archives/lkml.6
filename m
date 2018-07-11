Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8ACC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11CF208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11CF208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeGKKWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:22:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeGKKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:22:22 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MRUgC-1fWYKy3g3U-00SjZU; Wed, 11 Jul 2018 12:18:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michael Werner <werner@chelsio.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] [RESEND, net-next, v2] tcp: use monotonic timestamps for PAWS
Date:   Wed, 11 Jul 2018 12:16:12 +0200
Message-Id: <20180711101757.3929777-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:A16E8B5uVLMOrZf8+qwpNqQoV4+Ir3jZrm3SIG0wIJ+o0v/BFQ6
 CeZBo1CPKct6pSMe1CZs7e7euBF2p9UiLNyCa0GVFb1emSLpzuOnvr4zioCYN42IPWxxNik
 NO4y/pCBzw7C7AQUsjTqjExBKEkFKAc5ubj7ogi2dwxPKy6iLoPV7k5xSYyM+MwYPi+s6wy
 3zuX0CAuYYpa9Cc1CBTBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kWUmBiLLR+o=:iohzGX8KeGS/nnmVC0YHHo
 pIQvRBenCPRwu5rU2jPOq2mBDGv6nb1g3lSI2hWSaEYKwSTUTizRpbi/PmrUIJysNR0pEsZtN
 8846aPj7bxOqqkcTFsehjjAbQ+fBJ3+e2er1kfEmpcQNIvfK3HiZPDBVInZvBTe317SBkJW1A
 XWiCxHUT1uq05pndv9WRzhAb01vVgXbBzvvattHltHKfItwz+bSiv4BxjFB6mMiDTFUF6EqWZ
 Fp978nQ5Gj6iHHu6IOdJ0+/61iliqlXgzwhzwOb6MdmwifxISeUQXprAhyk2hEEt3xmf5QXNP
 o9Y31Das3HAG/2zIGg/BtrT0U4qojx2NzvN13guseUMVkV9zejow+54oiKs9Qbo4qUEPRLd/I
 H9NrLeyWflMvXgZxGd55Qoj6oAEna7aahpsMvzkE1xzi9hwPOiFlyUwQwosMW6sYrfAhAS4xz
 AiD2RofKOTSUjTVGB7FrEAQr4GApMi8YlmIPCvXtt+6Snnqc0LLWoTOoaIRtPTI9bNf17q6/0
 cEqGBpJW5aVpvqk7Q79iYKHI9V94GaUFx2jq6cB2/bUwYr2BPizuLVLZyXIIXZhjWqz3Cu51S
 Gdpi3/1BwL5L7naJ0dhJXvr2CYNJJxQD6DgCTtfFdRAH5q0I85x/NOu7piwlCXwJ1fNU8Defq
 bCr8vZ1Wkx+MAzm6PHfTQsj9ZAJlZJKw0UonnbTT5ovH263Qh9pyoAcUj9Z6GbF0UQGc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using get_seconds() for timestamps is deprecated since it can lead
to overflows on 32-bit systems. While the interface generally doesn't
overflow until year 2106, the specific implementation of the TCP PAWS
algorithm breaks in 2038 when the intermediate signed 32-bit timestamps
overflow.

A related problem is that the local timestamps in CLOCK_REALTIME form
lead to unexpected behavior when settimeofday is called to set the system
clock backwards or forwards by more than 24 days.

While the first problem could be solved by using an overflow-safe method
of comparing the timestamps, a nicer solution is to use a monotonic
clocksource with ktime_get_seconds() that simply doesn't overflow (at
least not until 136 years after boot) and that doesn't change during
settimeofday().

To make 32-bit and 64-bit architectures behave the same way here, and
also save a few bytes in the tcp_options_received structure, I'm changing
the type to a 32-bit integer, which is now safe on all architectures.

Finally, the ts_recent_stamp field also (confusingly) gets used to store
a jiffies value in tcp_synq_overflow()/tcp_synq_no_recent_overflow().
This is currently safe, but changing the type to 32-bit requires
some small changes there to keep it working.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use time_before32()/time_after32() everywhere as suggested
    Eric Dumazet in https://lore.kernel.org/lkml/67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com/
---
 drivers/crypto/chelsio/chtls/chtls_cm.c |  2 +-
 include/linux/tcp.h                     |  4 ++--
 include/net/tcp.h                       | 17 ++++++++++-------
 net/ipv4/tcp_input.c                    |  2 +-
 net/ipv4/tcp_ipv4.c                     |  3 ++-
 net/ipv4/tcp_minisocks.c                |  8 ++++----
 6 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 2bb6f0380758..0997e166ea57 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -1673,7 +1673,7 @@ static void chtls_timewait(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	tp->rcv_nxt++;
-	tp->rx_opt.ts_recent_stamp = get_seconds();
+	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 	tp->srtt_us = 0;
 	tcp_time_wait(sk, TCP_TIME_WAIT, 0);
 }
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3dbea6610304..58a8d7d71354 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -89,7 +89,7 @@ struct tcp_sack_block {
 
 struct tcp_options_received {
 /*	PAWS/RTTM data	*/
-	long	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
+	int	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
 	u32	ts_recent;	/* Time stamp to echo next		*/
 	u32	rcv_tsval;	/* Time stamp value             	*/
 	u32	rcv_tsecr;	/* Time stamp echo reply        	*/
@@ -426,7 +426,7 @@ struct tcp_timewait_sock {
 	/* The time we sent the last out-of-window ACK: */
 	u32			  tw_last_oow_ack_time;
 
-	long			  tw_ts_recent_stamp;
+	int			  tw_ts_recent_stamp;
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
 #endif
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9afce8e674e5..6e53d7db049c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -472,19 +472,20 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
  */
 static inline void tcp_synq_overflow(const struct sock *sk)
 {
-	unsigned long last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
-	unsigned long now = jiffies;
+	unsigned int last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
+	unsigned int now = jiffies;
 
-	if (time_after(now, last_overflow + HZ))
+	if (time_after32(now, last_overflow + HZ))
 		tcp_sk(sk)->rx_opt.ts_recent_stamp = now;
 }
 
 /* syncookies: no recent synqueue overflow on this listening socket? */
 static inline bool tcp_synq_no_recent_overflow(const struct sock *sk)
 {
-	unsigned long last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
+	unsigned int last_overflow = tcp_sk(sk)->rx_opt.ts_recent_stamp;
+	unsigned int now = jiffies;
 
-	return time_after(jiffies, last_overflow + TCP_SYNCOOKIE_VALID);
+	return time_after32(now, last_overflow + TCP_SYNCOOKIE_VALID);
 }
 
 static inline u32 tcp_cookie_time(void)
@@ -1377,7 +1378,8 @@ static inline bool tcp_paws_check(const struct tcp_options_received *rx_opt,
 {
 	if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
 		return true;
-	if (unlikely(get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS))
+	if (unlikely(!time_before32(ktime_get_seconds(),
+				    rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS)))
 		return true;
 	/*
 	 * Some OSes send SYN and SYNACK messages with tsval=0 tsecr=0,
@@ -1407,7 +1409,8 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 	   However, we can relax time bounds for RST segments to MSL.
 	 */
-	if (rst && get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_MSL)
+	if (rst && !time_before32(ktime_get_seconds(),
+				  rx_opt->ts_recent_stamp + TCP_PAWS_MSL))
 		return false;
 	return true;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 814ea43dd12f..d3b6390ecf23 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3462,7 +3462,7 @@ static void tcp_send_challenge_ack(struct sock *sk, const struct sk_buff *skb)
 static void tcp_store_ts_recent(struct tcp_sock *tp)
 {
 	tp->rx_opt.ts_recent = tp->rx_opt.rcv_tsval;
-	tp->rx_opt.ts_recent_stamp = get_seconds();
+	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 }
 
 static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index bea17f1e8302..dc415c66a33a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -155,7 +155,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	   and use initial timestamp retrieved from peer table.
 	 */
 	if (tcptw->tw_ts_recent_stamp &&
-	    (!twp || (reuse && get_seconds() - tcptw->tw_ts_recent_stamp > 1))) {
+	    (!twp || (reuse && time_after32(ktime_get_seconds(),
+					    tcptw->tw_ts_recent_stamp)))) {
 		tp->write_seq = tcptw->tw_snd_nxt + 65535 + 2;
 		if (tp->write_seq == 0)
 			tp->write_seq = 1;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index dac5893a52b4..75ef332a7caf 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -144,7 +144,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		tw->tw_substate	  = TCP_TIME_WAIT;
 		tcptw->tw_rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 		if (tmp_opt.saw_tstamp) {
-			tcptw->tw_ts_recent_stamp = get_seconds();
+			tcptw->tw_ts_recent_stamp = ktime_get_seconds();
 			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;
 		}
 
@@ -189,7 +189,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;
-			tcptw->tw_ts_recent_stamp = get_seconds();
+			tcptw->tw_ts_recent_stamp = ktime_get_seconds();
 		}
 
 		inet_twsk_put(tw);
@@ -537,7 +537,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	if (newtp->rx_opt.tstamp_ok) {
 		newtp->rx_opt.ts_recent = req->ts_recent;
-		newtp->rx_opt.ts_recent_stamp = get_seconds();
+		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
 		newtp->rx_opt.ts_recent_stamp = 0;
@@ -603,7 +603,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			 * it can be estimated (approximately)
 			 * from another data.
 			 */
-			tmp_opt.ts_recent_stamp = get_seconds() - ((TCP_TIMEOUT_INIT/HZ)<<req->num_timeout);
+			tmp_opt.ts_recent_stamp = ktime_get_seconds() - ((TCP_TIMEOUT_INIT/HZ)<<req->num_timeout);
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
-- 
2.9.0

