Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeFERPw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753399AbeFERFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>, Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 18/61] tcp: avoid integer overflows in tcp_rcv_space_adjust()
Date: Tue,  5 Jun 2018 19:01:39 +0200
Message-Id: <20180605170118.783762261@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -337,7 +337,7 @@ struct tcp_sock {
 
 /* Receiver queue space */
 	struct {
-		int	space;
+		u32	space;
 		u32	seq;
 		u32	time;
 	} rcvq_space;
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -581,8 +581,8 @@ static inline void tcp_rcv_rtt_measure_t
 void tcp_rcv_space_adjust(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	u32 copied;
 	int time;
-	int copied;
 
 	time = tcp_time_stamp - tp->rcvq_space.time;
 	if (time < (tp->rcv_rtt_est.rtt >> 3) || tp->rcv_rtt_est.rtt == 0)
@@ -604,12 +604,13 @@ void tcp_rcv_space_adjust(struct sock *s
 
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
@@ -629,7 +630,8 @@ void tcp_rcv_space_adjust(struct sock *s
 		while (tcp_win_from_space(rcvmem) < tp->advmss)
 			rcvmem += 128;
 
-		rcvbuf = min(rcvwin / tp->advmss * rcvmem, sysctl_tcp_rmem[2]);
+		do_div(rcvwin, tp->advmss);
+		rcvbuf = min_t(u64, rcvwin * rcvmem, sysctl_tcp_rmem[2]);
 		if (rcvbuf > sk->sk_rcvbuf) {
 			sk->sk_rcvbuf = rcvbuf;
 
