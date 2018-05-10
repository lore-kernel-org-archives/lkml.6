Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEJWpe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:45:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751338AbeEJWpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/5] rxrpc: Fix error reception on AF_INET6 sockets
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:29 +0100
Message-ID: <152599232943.26376.906355734359474742.stgit@warthog.procyon.org.uk>
In-Reply-To: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
References: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AF_RXRPC tries to turn on IP_RECVERR and IP_MTU_DISCOVER on the UDP socket
it just opened for communications with the outside world, regardless of the
type of socket.  Unfortunately, this doesn't work with an AF_INET6 socket.

Fix this by turning on IPV6_RECVERR and IPV6_MTU_DISCOVER instead if the
socket is of the AF_INET6 family.

Without this, kAFS server and address rotation doesn't work correctly
because the algorithm doesn't detect received network errors.

Fixes: 75b54cb57ca3 ("rxrpc: Add IPv6 support")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/local_object.c |   57 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 8b54e9531d52..b493e6b62740 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -134,22 +134,49 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 		}
 	}
 
-	/* we want to receive ICMP errors */
-	opt = 1;
-	ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
-				(char *) &opt, sizeof(opt));
-	if (ret < 0) {
-		_debug("setsockopt failed");
-		goto error;
-	}
+	switch (local->srx.transport.family) {
+	case AF_INET:
+		/* we want to receive ICMP errors */
+		opt = 1;
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_RECVERR,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
 
-	/* we want to set the don't fragment bit */
-	opt = IP_PMTUDISC_DO;
-	ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
-				(char *) &opt, sizeof(opt));
-	if (ret < 0) {
-		_debug("setsockopt failed");
-		goto error;
+		/* we want to set the don't fragment bit */
+		opt = IP_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IP, IP_MTU_DISCOVER,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+		break;
+
+	case AF_INET6:
+		/* we want to receive ICMP errors */
+		opt = 1;
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_RECVERR,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+
+		/* we want to set the don't fragment bit */
+		opt = IPV6_PMTUDISC_DO;
+		ret = kernel_setsockopt(local->socket, SOL_IPV6, IPV6_MTU_DISCOVER,
+					(char *) &opt, sizeof(opt));
+		if (ret < 0) {
+			_debug("setsockopt failed");
+			goto error;
+		}
+		break;
+
+	default:
+		BUG();
 	}
 
 	/* set the socket up */
