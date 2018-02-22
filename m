Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeBVOiT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:38:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932623AbeBVOiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:38:16 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix send in rxrpc_send_data_packet()
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2018 14:38:14 +0000
Message-ID: <151931029450.9287.5520591027871713676.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the kernel_sendmsg() calls in rxrpc_send_data_packet() need to send
both parts of the iov[] buffer, but one of them does not.  Fix it so that
it does.

Without this, short IPv6 rxrpc DATA packets may be seen that have the rxrpc
header included, but no payload.

Fixes: 5a924b8951f8 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/output.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 42410e910aff..cf73dc006c3b 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -445,7 +445,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 					(char *)&opt, sizeof(opt));
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 1, iov[0].iov_len);
+					     iov, 2, len);
 
 			opt = IPV6_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket,
