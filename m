Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52CCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3109F2145B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3109F2145B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeGFJph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:45:37 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63986 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753575AbeGFJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:45:36 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from haswell.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 12270065-1500050 
        for multiple; Fri, 06 Jul 2018 10:44:56 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] bitops: Introduce BITS_PER_TYPE
Date:   Fri,  6 Jul 2018 10:44:58 +0100
Message-Id: <20180706094458.14116-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the
macro to bitops.h, alongside BITS_PER_BYTE, for wider usage.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andy Gospodarek <gospo@broadcom.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/bitops.h  | 3 ++-
 include/linux/net_dim.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..091cb17d1a9b 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -11,7 +11,8 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #endif
 
 /*
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index 29ed8fd6379a..14f1734e740a 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -326,7 +326,6 @@ static inline void net_dim_sample(u16 event_ctr,
 }
 
 #define NET_DIM_NEVENTS 64
-#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
 
 static inline void net_dim_calc_stats(struct net_dim_sample *start,
-- 
2.18.0

