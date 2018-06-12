Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49858C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0114A208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeywvOn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0114A208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbeFLQzy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754402AbeFLQyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33726208B7;
        Tue, 12 Jun 2018 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822474;
        bh=pu1zEXGZANReUsJ5O6SOPg22zr7NQ7XEukWLPlG/lbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeywvOn433cH1jkR5GGlPuU9v8DlfPzZcIIGQFRuyj3tI8VTxgyMIYu6BEgVr3A2t
         tThvQ/SYyBbdhsBSn4N8BItTrcktA8nuvHdvIz96CyEuG52ThXxyJPdKaJU5vx/RJR
         sWdqkDfyuLrdZCMdEJQZIcdtbvv8/KCkCYvSf/c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 04/21] tcp: avoid integer overflows in tcp_rcv_space_adjust()
Date:   Tue, 12 Jun 2018 18:52:01 +0200
Message-Id: <20180612164825.572708025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 607065bad9931e72207b0cac365d7d4abc06bd99 upstream.

When using large tcp_rmem[2] values (I did tests with 500 MB),
I noticed overflows while computing rcvwin.

Lets fix this before the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Wei Wang <weiwan@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Backport: sysctl_tcp_rmem is not Namespace-ify'd in older kernels]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/tcp.h  |    2 +-
 net/ipv4/tcp_input.c |   10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -292,7 +292,7 @@ struct tcp_sock {
 
 /* Receiver queue space */
 	struct {
-		int	space;
+		u32	space;
 		u32	seq;
 		u32	time;
 	} rcvq_space;
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -550,8 +550,8 @@ static inline void tcp_rcv_rtt_measure_t
 void tcp_rcv_space_adjust(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	u32 copied;
 	int time;
-	int copied;
 
 	time = tcp_time_stamp - tp->rcvq_space.time;
 	if (time < (tp->rcv_rtt_est.rtt >> 3) || tp->rcv_rtt_est.rtt == 0)
@@ -573,12 +573,13 @@ void tcp_rcv_space_adjust(struct sock *s
 
 	if (sysctl_tcp_moderate_rcvbuf &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int rcvwin, rcvmem, rcvbuf;
+		int rcvmem, rcvbuf;
+		u64 rcvwin;
 
 		/* minimal window to cope with packet losses, assuming
 		 * steady state. Add some cushion because of small variations.
 		 */
-		rcvwin = (copied << 1) + 16 * tp->advmss;
+		rcvwin = ((u64)copied << 1) + 16 * tp->advmss;
 
 		/* If rate increased by 25%,
 		 *	assume slow start, rcvwin = 3 * copied
@@ -598,7 +599,8 @@ void tcp_rcv_space_adjust(struct sock *s
 		while (tcp_win_from_space(rcvmem) < tp->advmss)
 			rcvmem += 128;
 
-		rcvbuf = min(rcvwin / tp->advmss * rcvmem, sysctl_tcp_rmem[2]);
+		do_div(rcvwin, tp->advmss);
+		rcvbuf = min_t(u64, rcvwin * rcvmem, sysctl_tcp_rmem[2]);
 		if (rcvbuf > sk->sk_rcvbuf) {
 			sk->sk_rcvbuf = rcvbuf;
 


