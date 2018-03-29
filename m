Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeC2C1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeC2C1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:27:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9345F2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [PATCH 09/10] x86: Switch to generic local_softirq_pending() implementation
Date: Thu, 29 Mar 2018 04:27:04 +0200
Message-Id: <1522290425-22844-10-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522290425-22844-1-git-send-email-frederic@kernel.org>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ad-hoc implementation, the generic code now allows us not to
reinvent the wheel.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/hardirq.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 7c341a7..fd73beb 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -49,14 +49,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 
-#define local_softirq_pending()	this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
-
-#define set_softirq_pending(x)	\
-		this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
-
 extern void ack_bad_irq(unsigned int irq);
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
-- 
2.7.4
