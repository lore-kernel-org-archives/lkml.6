Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034631AbeE1PhC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:37:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35914 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968825AbeE1PgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:36:20 -0400
X-Google-Smtp-Source: AB8JxZrWwhATwQct+t2cdadFyfYGYkJACxpX8pf3mxLC3MozD77AHob7QTMTHzxY18sGeGabwkO4vw==
From: Yafang Shao <laoar.shao@gmail.com>
To: songliubraving@fb.com, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 net-next 2/2] tcp: minor optimization around tcp_hdr() usage in tcp receive path
Date: Mon, 28 May 2018 23:35:53 +0800
Message-Id: <1527521753-17963-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
References: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional to the commit ea1627c20c34 ("tcp: minor optimizations around tcp_hdr() usage").
At this point, skb->data is same with tcp_hdr() as tcp header has not
been pulled yet.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index adbdb50..d179386 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1486,7 +1486,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 				sk->sk_rx_dst = NULL;
 			}
 		}
-		tcp_rcv_established(sk, skb, tcp_hdr(skb));
+		tcp_rcv_established(sk, skb, (const struct tcphdr *)skb->data);
 		return 0;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7d47c2b..1c633ff 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1322,7 +1322,7 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 		}
 
-		tcp_rcv_established(sk, skb, tcp_hdr(skb));
+		tcp_rcv_established(sk, skb, (const struct tcphdr *)skb->data);
 		if (opt_skb)
 			goto ipv6_pktoptions;
 		return 0;
-- 
1.8.3.1
