Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED289C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC81120875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC81120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJEMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:42:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55375 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbeJEMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:42:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439617|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.CzctUJq_1538718302;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzctUJq_1538718302)
          by smtp.aliyun-inc.com(10.147.41.231);
          Fri, 05 Oct 2018 13:45:02 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     green.hu@gmail.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 10/20] csky: IRQ handling
Date:   Fri,  5 Oct 2018 13:41:52 +0800
Message-Id: <b092fb59fe7e767fcff00d04ef9ef025139de782.1538715563.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IRQ handling files.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/irqflags.h | 49 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/irq.c           | 22 ++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/csky/include/asm/irqflags.h
 create mode 100644 arch/csky/kernel/irq.c

diff --git a/arch/csky/include/asm/irqflags.h b/arch/csky/include/asm/irqflags.h
new file mode 100644
index 0000000..9e3a569
--- /dev/null
+++ b/arch/csky/include/asm/irqflags.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_IRQFLAGS_H
+#define __ASM_CSKY_IRQFLAGS_H
+#include <abi/reg_ops.h>
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = mfcr("psr");
+	asm volatile("psrclr ie\n":::"memory");
+	return flags;
+}
+#define arch_local_irq_save arch_local_irq_save
+
+static inline void arch_local_irq_enable(void)
+{
+	asm volatile("psrset ee, ie\n":::"memory");
+}
+#define arch_local_irq_enable arch_local_irq_enable
+
+static inline void arch_local_irq_disable(void)
+{
+	asm volatile("psrclr ie\n":::"memory");
+}
+#define arch_local_irq_disable arch_local_irq_disable
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return mfcr("psr");
+}
+#define arch_local_save_flags arch_local_save_flags
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	mtcr("psr", flags);
+}
+#define arch_local_irq_restore arch_local_irq_restore
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1<<6));
+}
+#define arch_irqs_disabled_flags arch_irqs_disabled_flags
+
+#include <asm-generic/irqflags.h>
+
+#endif /* __ASM_CSKY_IRQFLAGS_H */
diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
new file mode 100644
index 0000000..03a1930
--- /dev/null
+++ b/arch/csky/kernel/irq.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <asm/traps.h>
+#include <asm/smp.h>
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+#ifdef CONFIG_SMP
+	setup_smp_ipi();
+#endif
+}
+
+asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
-- 
2.7.4

