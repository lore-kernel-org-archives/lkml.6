Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id I4XCEGZCGVulfAAAmS7hNA
	; Thu, 07 Jun 2018 14:36:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 83C2E607DC; Thu,  7 Jun 2018 14:36:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E008601D2;
	Thu,  7 Jun 2018 14:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E008601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeFGOgM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:36:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40402 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933394AbeFGOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005dI-Af; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003GO-9i; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Randy E. Witt" <randy.e.witt@intel.com>,
        "Vinicius Costa Gomes" <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.412936680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 368/410] skbuff: Fix not waking applications when
 errors are enqueued
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

commit 6e5d58fdc9bedd0255a8781b258f10bbdc63e975 upstream.

When errors are enqueued to the error queue via sock_queue_err_skb()
function, it is possible that the waiting application is not notified.

Calling 'sk->sk_data_ready()' would not notify applications that
selected only POLLERR events in poll() (for example).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Randy E. Witt <randy.e.witt@intel.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3512,7 +3512,7 @@ int sock_queue_err_skb(struct sock *sk,
 
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
