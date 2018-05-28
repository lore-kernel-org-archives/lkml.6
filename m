Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938393AbeE1L5T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423538AbeE1LIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 094/272] rxrpc: Fix resend event time calculation
Date: Mon, 28 May 2018 12:02:07 +0200
Message-Id: <20180528100249.046668086@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit 59299aa1028fce051adbd25aaff7c387b865cd6d ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/call_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -225,7 +225,7 @@ static void rxrpc_resend(struct rxrpc_ca
 				       ktime_to_ns(ktime_sub(skb->tstamp, max_age)));
 	}
 
-	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(oldest, now)));
+	resend_at = nsecs_to_jiffies(ktime_to_ns(ktime_sub(now, oldest)));
 	resend_at += jiffies + rxrpc_resend_timeout;
 	WRITE_ONCE(call->resend_at, resend_at);
 
