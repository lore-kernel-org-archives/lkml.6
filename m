Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeC0Wo2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:44:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752484AbeC0WoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:44:24 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/6] rxrpc: Fix a bit of time confusion
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 23:44:23 +0100
Message-ID: <152219066297.24098.8955419771155600248.stgit@warthog.procyon.org.uk>
In-Reply-To: <152219064515.24098.9428175357244257284.stgit@warthog.procyon.org.uk>
References: <152219064515.24098.9428175357244257284.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rxrpc_reduce_call_timer() function should be passed the 'current time'
in jiffies, not the current ktime time.  It's confusing in rxrpc_resend
because that has to deal with both.  Pass the correct current time in.

Note that this only affects the trace produced and not the functioning of
the code.

Fixes: a158bdd3247b ("rxrpc: Fix call timeouts")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index ad2ab1103189..27f77b7d0ead 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -237,7 +237,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 	 * retransmitting data.
 	 */
 	if (!retrans) {
-		rxrpc_reduce_call_timer(call, resend_at, now,
+		rxrpc_reduce_call_timer(call, resend_at, now_j,
 					rxrpc_timer_set_for_resend);
 		spin_unlock_bh(&call->lock);
 		ack_ts = ktime_sub(now, call->acks_latest_ts);
