Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756662AbeEJGYM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:24:12 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:37305 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751313AbeEJGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:24:11 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1345:1437:1534:1543:1711:1730:1747:1777:1792:1801:2393:2559:2562:3138:3139:3140:3141:3142:3354:3865:3867:3868:3871:4321:4384:4605:5007:6261:7903:9592:10004:10848:11026:11473:11658:11914:12043:12294:12438:12555:12895:13141:13230:13868:14181:14394:14721:14915:21080:21433:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: pail00_416a6ce724510
X-Filterd-Recvd-Size: 3888
From: Joe Perches <joe@perches.com>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Li RongQing <lirongqing@baidu.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv4: remove define INET_CSK_DEBUG and unnecessary EXPORT_SYMBOL
Date: Wed,  9 May 2018 23:24:07 -0700
Message-Id: <0424e034b4640359bbe1ae50229b9fbc25b06181.1525932412.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INET_CSK_DEBUG is always set and only is used for 2 pr_debug calls.

EXPORT_SYMBOL(inet_csk_timer_bug_msg) is only used by these 2
pr_debug calls and is also unnecessary as the exported string can
be used directly by these calls.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/net/inet_connection_sock.h | 22 ++++------------------
 net/ipv4/inet_connection_sock.c    |  5 -----
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 2ab6667275df..0a6c9e0f2b5a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -23,8 +23,6 @@
 #include <net/inet_sock.h>
 #include <net/request_sock.h>
 
-#define INET_CSK_DEBUG 1
-
 /* Cancel timers, when they are not required. */
 #undef INET_CSK_CLEAR_TIMERS
 
@@ -196,10 +194,6 @@ static inline void inet_csk_delack_init(struct sock *sk)
 void inet_csk_delete_keepalive_timer(struct sock *sk);
 void inet_csk_reset_keepalive_timer(struct sock *sk, unsigned long timeout);
 
-#ifdef INET_CSK_DEBUG
-extern const char inet_csk_timer_bug_msg[];
-#endif
-
 static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -214,12 +208,9 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 #ifdef INET_CSK_CLEAR_TIMERS
 		sk_stop_timer(sk, &icsk->icsk_delack_timer);
 #endif
+	} else {
+		pr_debug("inet_csk BUG: unknown timer value\n");
 	}
-#ifdef INET_CSK_DEBUG
-	else {
-		pr_debug("%s", inet_csk_timer_bug_msg);
-	}
-#endif
 }
 
 /*
@@ -232,10 +223,8 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (when > max_when) {
-#ifdef INET_CSK_DEBUG
 		pr_debug("reset_xmit_timer: sk=%p %d when=0x%lx, caller=%p\n",
 			 sk, what, when, current_text_addr());
-#endif
 		when = max_when;
 	}
 
@@ -249,12 +238,9 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 		icsk->icsk_ack.pending |= ICSK_ACK_TIMER;
 		icsk->icsk_ack.timeout = jiffies + when;
 		sk_reset_timer(sk, &icsk->icsk_delack_timer, icsk->icsk_ack.timeout);
+	} else {
+		pr_debug("inet_csk BUG: unknown timer value\n");
 	}
-#ifdef INET_CSK_DEBUG
-	else {
-		pr_debug("%s", inet_csk_timer_bug_msg);
-	}
-#endif
 }
 
 static inline unsigned long
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 881ac6d046f2..33a88e045efd 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -27,11 +27,6 @@
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
-#ifdef INET_CSK_DEBUG
-const char inet_csk_timer_bug_msg[] = "inet_csk BUG: unknown timer value\n";
-EXPORT_SYMBOL(inet_csk_timer_bug_msg);
-#endif
-
 #if IS_ENABLED(CONFIG_IPV6)
 /* match_wildcard == true:  IPV6_ADDR_ANY equals to any IPv6 addresses if IPv6
  *                          only, and any IPv4 addresses if not IPv6 only
-- 
2.15.0
