Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeC3VOj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeC3VOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:37 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 05/12] rxrpc: Fix resend event time calculation
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:35 +0100
Message-ID: <152244447551.4629.14677984551976863759.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

Commit a158bdd3 ("rxrpc: Fix call timeouts") reworked the time calculation
for the next resend event.  For this calculation, "oldest" will be before
"now", so ktime_sub(oldest, now) will yield a negative value.  When passed
to nsecs_to_jiffies which expects an unsigned value, the end result will be
a very large value, and a resend event scheduled far into the future.  This
could cause calls to stall if some packets were lost.

Fix by ordering the arguments to ktime_sub correctly.

Fixes: a158bdd3247b ("rxrpc: Fix call timeouts")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 3dee89c7a06e..6e0d788b4dc4 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -226,7 +226,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 				       ktime_to_ns(ktime_sub(skb->tstamp, max_age)));
 	}
 
-	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(oldest, now)));
+	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
 	resend_at += jiffies + rxrpc_resend_timeout;
 	WRITE_ONCE(call->resend_at, resend_at);
 
