Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C43EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83CC2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEZc6PJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83CC2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJKGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:20 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E000121524;
        Wed, 10 Oct 2018 23:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213179;
        bh=pQ9qeH4qjNbiNVGk4y/TVMXfrhMzGzePHrWSTmP7TYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEZc6PJfqa6kPGXYPqM6JW+YOmj/4oV23efkPGYVNOQYQM9gNzNhfEUXDolMIbgrm
         BvIQoYyyWYwBbfOi8VHlx8YeFweycD4UE6AHP4PJdPcvr+PRMHA62seq4i2vnkqOf5
         OY89uIIIUYddZJdNSQDPaqZCDnCVxPaid07ylv6I=
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
Subject: [RFC PATCH 09/30] x86: Init softirq enabled field
Date:   Thu, 11 Oct 2018 01:11:56 +0200
Message-Id: <1539213137-13953-10-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

All softirqs must be set enabled on boot.

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
 arch/x86/kernel/irq.c       | 5 ++++-
 include/linux/bottom_half.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2e..b859861 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/bottom_half.h>
 
 #include <asm/apic.h>
 #include <asm/io_apic.h>
@@ -22,7 +23,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
 
-DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat) = {
+	.__softirq_data = SOFTIRQ_DATA_INIT,
+};
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 DEFINE_PER_CPU(struct pt_regs *, irq_regs);
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a9571ad..fd75d1a 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -33,6 +33,8 @@ enum
 #define SOFTIRQ_ENABLED_SHIFT 16
 #define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
 
+#define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
+
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
-- 
2.7.4

