Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B38BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C33214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tycy9SZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C33214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJKGhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:09 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8FA2150F;
        Wed, 10 Oct 2018 23:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213167;
        bh=FaI9jWQmPY9yPuqX3eTfkx32T3zn9Fp/Ib8swvYa7kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tycy9SZyBoq6r2Q4uD3KRXYaPcu27gbEgHBij3Voq/sNi3negMGJhmi0S7hoxg8oh
         xvXdDrpp7eyExJPYYK+x0rJpUs/naWrFuLcypt81naOtJy/dDqUHoVt42VsWULxHQ0
         8h+jssrre0iZ8jON6jNU3T0h/pkfiGmAqQ2C8M7A=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 05/30] softirq: Convert softirq_pending_set() to softirq_pending_nand()
Date:   Thu, 11 Oct 2018 01:11:52 +0200
Message-Id: <1539213137-13953-6-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vector pending bits will soon need to be opposed to the vector
enabled bits. As such, plain reset of new pending mask is not going to
be needed anymore. Instead we'll need to be able to clear specific bits.
Update the relevant API to allow that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/s390/include/asm/hardirq.h | 2 +-
 include/linux/interrupt.h       | 3 ++-
 kernel/softirq.c                | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 3103680..84ad789 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,7 +14,7 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_data)
-#define softirq_pending_set(x) (S390_lowcore.softirq_data = (x))
+#define softirq_pending_nand(x) (S390_lowcore.softirq_data &= ~(x))
 #define softirq_pending_or(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fc88f0d..a577a54 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -466,6 +466,7 @@ enum
 };
 
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
 
 #ifndef local_softirq_pending
 
@@ -474,7 +475,7 @@ enum
 #endif
 
 #define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define softirq_pending_set(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define softirq_pending_nand(x)	(__this_cpu_and(local_softirq_data_ref, ~(x)))
 #define softirq_pending_or(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
 
 #endif /* local_softirq_pending */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c39af4a..288e007 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -271,7 +271,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	softirq_pending_set(0);
+	softirq_pending_nand(SOFTIRQ_ALL_MASK);
 
 	local_irq_enable();
 
-- 
2.7.4

