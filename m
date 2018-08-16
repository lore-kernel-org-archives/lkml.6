Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF63C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60102145D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60102145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeHPUVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:21:30 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.104]:18261 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728312AbeHPUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:21:30 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 1FB16163940
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:21:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id qLxef1g4dPvAdqLxof1OnW; Thu, 16 Aug 2018 12:21:43 -0500
X-Authority-Reason: nr=8
Received: from [189.250.72.226] (port=51192 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fqLxd-002l7H-JT; Thu, 16 Aug 2018 12:21:25 -0500
Date:   Thu, 16 Aug 2018 12:21:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] futex: Mark expected switch fall-throughs
Message-ID: <20180816172124.GA2407@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.72.226
X-Source-L: No
X-Exim-ID: 1fqLxd-002l7H-JT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.72.226]:51192
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/futex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1f450e0..11fc3bb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3523,10 +3523,12 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
+		/* fall through */
 	case FUTEX_WAIT_BITSET:
 		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
+		/* fall through */
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
-- 
2.7.4

