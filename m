Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3521524
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+ksysBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA3521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJKGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:06 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E436D214DA;
        Wed, 10 Oct 2018 23:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213164;
        bh=h6UUXov35x4hMK8+UhZMANrqwBrjnlTpzw7k+RzUgxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+ksysBf+oM8GkH//FKb5lRY59FBoy20j90T1pJ/Hj4LUBqBUfCsQ7z48xUvNMywR
         H0zV42lZWvjWCVpz01fopAwOZzX3v3fesiuajZ7b3XUhQPvqM0TkTNpquj1KnBAyXZ
         IgGDQpEwr7VbL4fMdGnbo8qhK/kjyjBHLeZSVm7E=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 04/30] softirq: Normalize softirq_pending naming scheme
Date:   Thu, 11 Oct 2018 01:11:51 +0200
Message-Id: <1539213137-13953-5-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Use the subsystem as the prefix to name the __softirq_data accessors.
They are going to be extended and want a more greppable and standard
naming sheme.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/s390/include/asm/hardirq.h | 4 ++--
 include/linux/interrupt.h       | 4 ++--
 kernel/softirq.c                | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index e26325f..3103680 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,8 +14,8 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_data)
-#define set_softirq_pending(x) (S390_lowcore.softirq_data = (x))
-#define or_softirq_pending(x)  (S390_lowcore.softirq_data |= (x))
+#define softirq_pending_set(x) (S390_lowcore.softirq_data = (x))
+#define softirq_pending_or(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1de87ec..fc88f0d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -474,8 +474,8 @@ enum
 #endif
 
 #define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
-#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
+#define softirq_pending_set(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define softirq_pending_or(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
 
 #endif /* local_softirq_pending */
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6f58486..c39af4a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -271,7 +271,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	softirq_pending_set(0);
 
 	local_irq_enable();
 
@@ -448,7 +448,7 @@ void raise_softirq(unsigned int nr)
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	trace_softirq_raise(nr);
-	or_softirq_pending(1UL << nr);
+	softirq_pending_or(1UL << nr);
 }
 
 void open_softirq(int nr, void (*action)(struct softirq_action *))
-- 
2.7.4

