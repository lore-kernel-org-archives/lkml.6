Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEDVSH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:18:07 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:10841 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEDVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:18:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520899200";
   d="scan'208";a="383143664"
From: Chintan Shah <chintsha@cisco.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, jmorris@namei.org,
        yoshfuji@linux-ipv6.org, kaber@trash.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: chintsha@cisco.com, kamensky@cisco.com, takondra@cisco.com,
        xe-linux-external@cisco.com, enkechen@cisco.com
Subject: [PATCH] net: disable UDP punt on sockets in RCV_SHUTDWON
Date: Fri,  4 May 2018 21:08:37 +0000
Message-Id: <1525468117-61242-1-git-send-email-chintsha@cisco.com>
X-Mailer: git-send-email 2.5.0
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: chintsha@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A UDP application which opens multiple sockets with same local
address/port combination (using SO_REUSEPORT/SO_REUSEADDR socket options);
and issues connect to a remote socket (using one of these local socket).
Now if the same socket, which issued connect, issues shutdown (SHUT_RD);
packets would still be queued to this socket (if sent from same remote
client, which the local socket connected to), and not delivered to the
other socket in the normal state.

In UDP socket lookup, socket's state (if it has issued SHUTDOWN on
read or not), is not taken into account. When application calls, SHUTDOWN
(SHUT_RD), UDP socket's state is changed (sk_shutdown is set to
RCV_SHUTDOWN).

UDP socket lookup is performed with help of compute_score
function. The function checks socket's attributes against incoming packets
headers; and based on match/mismatch it returns score. We can check for
the socket's state (sk->sk_shutdown) here, in same compute_score function,
and return values accordingly.

Signed-off-by: Chintan Shah <chintsha@cisco.com>
CC: xe-linux-external@cisco.com
---
 net/ipv4/udp.c | 6 ++++++
 net/ipv6/udp.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0dfcd73..a5fe6d7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -402,6 +402,9 @@ static inline int compute_score(struct sock *sk, struct net *net,
 #endif
 #endif
 
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -1;
+
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
 	    ipv6_only_sock(sk))
@@ -483,6 +486,9 @@ static inline int compute_score2(struct sock *sk, struct net *net,
 #endif
 #endif
 
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -1;
+
 	if (!net_eq(sock_net(sk), net) ||
 	    ipv6_only_sock(sk))
 		return -1;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d956cbb..2254b07 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -170,6 +170,9 @@ static inline int compute_score(struct sock *sk, struct net *net,
 #endif
 #endif
 
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -1;
+
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
 	    sk->sk_family != PF_INET6)
@@ -251,6 +254,9 @@ static inline int compute_score2(struct sock *sk, struct net *net,
 #endif
 #endif
 
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		return -1;
+
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
 	    sk->sk_family != PF_INET6)
-- 
2.5.0
