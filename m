Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65243C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A1A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A1A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937901AbeFSMwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937848AbeFSMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D5C15BE;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A51C3F5B6;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9B7331AE3632; Tue, 19 Jun 2018 13:53:15 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 2/9] m68k: Don't use asm-generic/bitops/lock.h
Date:   Tue, 19 Jun 2018 13:53:07 +0100
Message-Id: <1529412794-17720-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/bitops/lock.h is shortly going to be built on top of the
atomic_long_* API, which introduces a nasty circular dependency for
m68k where linux/atomic.h pulls in linux/bitops.h via:

	linux/atomic.h
	asm/atomic.h
	linux/irqflags.h
	asm/irqflags.h
	linux/preempt.h
	asm/preempt.h
	asm-generic/preempt.h
	linux/thread_info.h
	asm/thread_info.h
	asm/page.h
	asm-generic/getorder.h
	linux/log2.h
	linux/bitops.h

Since m68k isn't SMP and doesn't support ACQUIRE/RELEASE barriers, we
can just define the lock bitops in terms of the atomic bitops in the
asm/bitops.h header.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m68k/include/asm/bitops.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 93b47b1f6fb4..18193419f97d 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -515,12 +515,16 @@ static inline int __fls(int x)
 
 #endif
 
+/* Simple test-and-set bit locks */
+#define test_and_set_bit_lock	test_and_set_bit
+#define clear_bit_unlock	clear_bit
+#define __clear_bit_unlock	clear_bit_unlock
+
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
-#include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_BITOPS_H */
-- 
2.1.4

