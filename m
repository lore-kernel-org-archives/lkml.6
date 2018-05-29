Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934688AbeE2Nfl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:35:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43289 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934136AbeE2Nfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:35:32 -0400
X-Google-Smtp-Source: ADUXVKIXmzBAdIAn5dPx73B2XFo2YIMKpZB2nsUOwV+rMyB1wq4e4rXLlx/neUVAZumJPoa5XYQ4PQ==
From: Yafang Shao <laoar.shao@gmail.com>
To: songliubraving@fb.com, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 net-next 2/2] tcp: minor optimization around tcp_hdr() usage in tcp receive path
Date: Tue, 29 May 2018 21:35:15 +0800
Message-Id: <1527600915-10955-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527600915-10955-1-git-send-email-laoar.shao@gmail.com>
References: <1527600915-10955-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional to the commit ea1627c20c34 ("tcp: minor optimizations around tcp_hdr() usage").
At this point, skb->data is same with tcp_hdr() as tcp header has not
been pulled yet.
Remove the third parameter of tcp_rcv_established() and put it into
the function body.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

---
v4: remove the third parameter of tcp_rcv_established()
---
 include/net/tcp.h    | 3 +--
 net/ipv4/tcp_input.c | 4 ++--
 net/ipv4/tcp_ipv4.c  | 2 +-
 net/ipv6/tcp_ipv6.c  | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 952d842..029a51b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -334,8 +334,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg);
 int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
-void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
-			 const struct tcphdr *th);
+void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1191cac..1d70dab 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5390,11 +5390,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
  *	the rest is checked inline. Fast processing is turned on in
  *	tcp_data_queue when everything is OK.
  */
-void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
-			 const struct tcphdr *th)
+void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 {
 	unsigned int len = skb->len;
 	struct tcp_sock *tp = tcp_sk(sk);
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
 
 	/* TCP congestion window tracking */
 	trace_tcp_probe(sk, skb);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index adbdb50..749b0ef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1486,7 +1486,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 				sk->sk_rx_dst = NULL;
 			}
 		}
-		tcp_rcv_established(sk, skb, tcp_hdr(skb));
+		tcp_rcv_established(sk, skb);
 		return 0;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7d47c2b..8764a63 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1322,7 +1322,7 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 		}
 
-		tcp_rcv_established(sk, skb, tcp_hdr(skb));
+		tcp_rcv_established(sk, skb);
 		if (opt_skb)
 			goto ipv6_pktoptions;
 		return 0;
-- 
1.8.3.1
