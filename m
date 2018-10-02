Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30233C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79042064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79042064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbeJBUoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:44:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbeJBUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:57 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7AD6C51;
        Tue,  2 Oct 2018 13:30:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Yang <yyd@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 190/228] tcp_bbr: add bbr_check_probe_rtt_done() helper
Date:   Tue,  2 Oct 2018 06:24:47 -0700
Message-Id: <20181002132511.006631062@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Yang <yyd@google.com>

[ Upstream commit fb99886224294b2291d267da41395022fa4200e2 ]

This patch add a helper function bbr_check_probe_rtt_done() to
  1. check the condition to see if bbr should exit probe_rtt mode;
  2. process the logic of exiting probe_rtt mode.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Kevin Yang <yyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -95,11 +95,10 @@ struct bbr {
 	u32     mode:3,		     /* current bbr_mode in state machine */
 		prev_ca_state:3,     /* CA state on previous ACK */
 		packet_conservation:1,  /* use packet conservation? */
-		restore_cwnd:1,	     /* decided to revert cwnd to old value */
 		round_start:1,	     /* start of packet-timed tx->ack round? */
 		idle_restart:1,	     /* restarting after idle? */
 		probe_rtt_round_done:1,  /* a BBR_PROBE_RTT round at 4 pkts? */
-		unused:12,
+		unused:13,
 		lt_is_sampling:1,    /* taking long-term ("LT") samples now? */
 		lt_rtt_cnt:7,	     /* round trips in long-term interval */
 		lt_use_bw:1;	     /* use lt_bw as our bw estimate? */
@@ -392,17 +391,11 @@ static bool bbr_set_cwnd_to_recover_or_r
 		cwnd = tcp_packets_in_flight(tp) + acked;
 	} else if (prev_state >= TCP_CA_Recovery && state < TCP_CA_Recovery) {
 		/* Exiting loss recovery; restore cwnd saved before recovery. */
-		bbr->restore_cwnd = 1;
+		cwnd = max(cwnd, bbr->prior_cwnd);
 		bbr->packet_conservation = 0;
 	}
 	bbr->prev_ca_state = state;
 
-	if (bbr->restore_cwnd) {
-		/* Restore cwnd after exiting loss recovery or PROBE_RTT. */
-		cwnd = max(cwnd, bbr->prior_cwnd);
-		bbr->restore_cwnd = 0;
-	}
-
 	if (bbr->packet_conservation) {
 		*new_cwnd = max(cwnd, tcp_packets_in_flight(tp) + acked);
 		return true;	/* yes, using packet conservation */
@@ -744,6 +737,20 @@ static void bbr_check_drain(struct sock
 		bbr_reset_probe_bw_mode(sk);  /* we estimate queue is drained */
 }
 
+static void bbr_check_probe_rtt_done(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (!(bbr->probe_rtt_done_stamp &&
+	      after(tcp_jiffies32, bbr->probe_rtt_done_stamp)))
+		return;
+
+	bbr->min_rtt_stamp = tcp_jiffies32;  /* wait a while until PROBE_RTT */
+	tp->snd_cwnd = max(tp->snd_cwnd, bbr->prior_cwnd);
+	bbr_reset_mode(sk);
+}
+
 /* The goal of PROBE_RTT mode is to have BBR flows cooperatively and
  * periodically drain the bottleneck queue, to converge to measure the true
  * min_rtt (unloaded propagation delay). This allows the flows to keep queues
@@ -802,12 +809,8 @@ static void bbr_update_min_rtt(struct so
 		} else if (bbr->probe_rtt_done_stamp) {
 			if (bbr->round_start)
 				bbr->probe_rtt_round_done = 1;
-			if (bbr->probe_rtt_round_done &&
-			    after(tcp_jiffies32, bbr->probe_rtt_done_stamp)) {
-				bbr->min_rtt_stamp = tcp_jiffies32;
-				bbr->restore_cwnd = 1;  /* snap to prior_cwnd */
-				bbr_reset_mode(sk);
-			}
+			if (bbr->probe_rtt_round_done)
+				bbr_check_probe_rtt_done(sk);
 		}
 	}
 	/* Restart after idle ends only once we process a new S/ACK for data */
@@ -858,7 +861,6 @@ static void bbr_init(struct sock *sk)
 	bbr->has_seen_rtt = 0;
 	bbr_init_pacing_rate_from_rtt(sk);
 
-	bbr->restore_cwnd = 0;
 	bbr->round_start = 0;
 	bbr->idle_restart = 0;
 	bbr->full_bw_reached = 0;


