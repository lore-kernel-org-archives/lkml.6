Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C905C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05F3214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pohloe9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05F3214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLDKz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeLDKz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954D7214C1;
        Tue,  4 Dec 2018 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920955;
        bh=D5ycQapysjSD+uVurSvuB7ug8+3pzUpP0dguoh/cINo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pohloe9Hh1gp4qoimaZmwbAZdN+6wrnVtwdWuNzaMaMYuLQR88UJY6U9hbaxxMNuQ
         z0q+hQrW4bXXNZUCwfto0CVqeh39rkCfz2OQhSbo8dNE5qW9h9ohJ9jxV/Gpgyd8h6
         LO/bcjYPtbPYAexxrQU12qEciRYTRZEa0k1uIPIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Louis Dupond <jean-louis@dupond.be>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 024/139] tcp: defer SACK compression after DupThresh
Date:   Tue,  4 Dec 2018 11:48:25 +0100
Message-Id: <20181204103650.970700955@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 86de5921a3d5dd246df661e09bdd0a6131b39ae3 ]

Jean-Louis reported a TCP regression and bisected to recent SACK
compression.

After a loss episode (receiver not able to keep up and dropping
packets because its backlog is full), linux TCP stack is sending
a single SACK (DUPACK).

Sender waits a full RTO timer before recovering losses.

While RFC 6675 says in section 5, "Algorithm Details",

   (2) If DupAcks < DupThresh but IsLost (HighACK + 1) returns true --
       indicating at least three segments have arrived above the current
       cumulative acknowledgment point, which is taken to indicate loss
       -- go to step (4).
...
   (4) Invoke fast retransmit and enter loss recovery as follows:

there are old TCP stacks not implementing this strategy, and
still counting the dupacks before starting fast retransmit.

While these stacks probably perform poorly when receivers implement
LRO/GRO, we should be a little more gentle to them.

This patch makes sure we do not enable SACK compression unless
3 dupacks have been sent since last rcv_nxt update.

Ideally we should even rearm the timer to send one or two
more DUPACK if no more packets are coming, but that will
be work aiming for linux-4.21.

Many thanks to Jean-Louis for bisecting the issue, providing
packet captures and testing this patch.

Fixes: 5d9f4262b7ea ("tcp: add SACK compression")
Reported-by: Jean-Louis Dupond <jean-louis@dupond.be>
Tested-by: Jean-Louis Dupond <jean-louis@dupond.be>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/tcp.h   |    1 +
 net/ipv4/tcp_input.c  |   14 ++++++++++++--
 net/ipv4/tcp_output.c |    6 +++---
 net/ipv4/tcp_timer.c  |    2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -196,6 +196,7 @@ struct tcp_sock {
 	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
 	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
+	u32	compressed_ack_rcv_nxt;
 
 	u32	tsoffset;	/* timestamp offset */
 
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4276,7 +4276,7 @@ static void tcp_sack_new_ofo_skb(struct
 	 * If the sack array is full, forget about the last one.
 	 */
 	if (this_sack >= TCP_NUM_SACKS) {
-		if (tp->compressed_ack)
+		if (tp->compressed_ack > TCP_FASTRETRANS_THRESH)
 			tcp_send_ack(sk);
 		this_sack--;
 		tp->rx_opt.num_sacks--;
@@ -5196,7 +5196,17 @@ send_now:
 	if (!tcp_is_sack(tp) ||
 	    tp->compressed_ack >= sock_net(sk)->ipv4.sysctl_tcp_comp_sack_nr)
 		goto send_now;
-	tp->compressed_ack++;
+
+	if (tp->compressed_ack_rcv_nxt != tp->rcv_nxt) {
+		tp->compressed_ack_rcv_nxt = tp->rcv_nxt;
+		if (tp->compressed_ack > TCP_FASTRETRANS_THRESH)
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
+				      tp->compressed_ack - TCP_FASTRETRANS_THRESH);
+		tp->compressed_ack = 0;
+	}
+
+	if (++tp->compressed_ack <= TCP_FASTRETRANS_THRESH)
+		goto send_now;
 
 	if (hrtimer_is_queued(&tp->compressed_ack_timer))
 		return;
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -165,10 +165,10 @@ static inline void tcp_event_ack_sent(st
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (unlikely(tp->compressed_ack)) {
+	if (unlikely(tp->compressed_ack > TCP_FASTRETRANS_THRESH)) {
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
-			      tp->compressed_ack);
-		tp->compressed_ack = 0;
+			      tp->compressed_ack - TCP_FASTRETRANS_THRESH);
+		tp->compressed_ack = TCP_FASTRETRANS_THRESH;
 		if (hrtimer_try_to_cancel(&tp->compressed_ack_timer) == 1)
 			__sock_put(sk);
 	}
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -740,7 +740,7 @@ static enum hrtimer_restart tcp_compress
 
 	bh_lock_sock(sk);
 	if (!sock_owned_by_user(sk)) {
-		if (tp->compressed_ack)
+		if (tp->compressed_ack > TCP_FASTRETRANS_THRESH)
 			tcp_send_ack(sk);
 	} else {
 		if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,


