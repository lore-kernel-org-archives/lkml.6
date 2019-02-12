Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44039C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1603E222B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991743;
	bh=KPeq7UuWkE/ne89bctxrqM24b0aF+83U0RKoHRY4wdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AzlBsCQ7BhXxTmKldrEU0bTdhE6u+MBP58g9Wf2TWzHRU21xDntB7w7g0VErUalvJ
	 wWXWnCgkcJB2cIYnob5nzBLqmxCygvLbG3V8pwmibkfbQfQ8q7aWHow3aweL5qZP2V
	 CBNGZZ9/9Llzh0VuxgN+1HOwiRYTCZjO2Dq0AwgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfBLRPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfBLRPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:39 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CF8222AB;
        Tue, 12 Feb 2019 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991738;
        bh=KPeq7UuWkE/ne89bctxrqM24b0aF+83U0RKoHRY4wdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVA8fHYI2pZcpRHVqZ3oylIIYxfHkkQAv7GKPW1DOZV0eRIQIKOJoMB6DqWQhalGI
         jJqS+kWwRQHoVNwrY6BxISGiNyrE0InYxoeQ3xEMz3+e6mv90CcRPYBPwBi40JmTSH
         WqwL3plYl9yPv3O86gX8MEsTKoVDaZXVMtTFE8mI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 21/32] x86: Init softirq enabled field
Date:   Tue, 12 Feb 2019 18:14:12 +0100
Message-Id: <20190212171423.8308-22-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

All softirqs must be set enabled on boot.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/irq.c       | 5 ++++-
 include/linux/bottom_half.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2ea7c2f..b859861733a4 100644
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
index 39aaf9189226..240419382978 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -26,6 +26,8 @@ enum
 #define SOFTIRQ_ENABLED_SHIFT 16
 #define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
 
+#define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
+
 
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.17.1

