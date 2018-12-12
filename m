Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3346C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9306E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9306E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbeLLQrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:47:51 -0500
Received: from foss.arm.com ([217.140.101.70]:44454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLQru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:47:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54A2C15AD;
        Wed, 12 Dec 2018 08:47:50 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E538F3F575;
        Wed, 12 Dec 2018 08:47:47 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v7 01/25] arm64: Fix HCR.TGE status for NMI contexts
Date:   Wed, 12 Dec 2018 16:47:01 +0000
Message-Id: <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using VHE, the host needs to clear HCR_EL2.TGE bit in order
to interract with guest TLBs, switching from EL2&0 translation regime
to EL1&0.

However, some non-maskable asynchronous event could happen while TGE is
cleared like SDEI. Because of this address translation operations
relying on EL2&0 translation regime could fail (tlb invalidation,
userspace access, ...).

Fix this by properly setting HCR_EL2.TGE when entering NMI context and
clear it if necessary when returning to the interrupted context.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/hardirq.h | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c          |  3 +++
 include/asm-generic/hardirq.h    |  3 +++
 include/linux/hardirq.h          |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 1473fc2..94b7481 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <asm/irq.h>
+#include <asm/kvm_arm.h>
 
 #define NR_IPI	7
 
@@ -37,6 +38,33 @@
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
+struct nmi_ctx {
+	u64 hcr;
+};
+
+DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
+#define arch_nmi_enter()							\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
+			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
+				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
+				isb();						\
+			}							\
+		}								\
+	} while (0)
+
+#define arch_nmi_exit()								\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			if (!(nmi_ctx->hcr & HCR_TGE))				\
+				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
+		}								\
+	} while (0)
+
 static inline void ack_bad_irq(unsigned int irq)
 {
 	extern unsigned long irq_err_count;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 780a12f..92fa817 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -33,6 +33,9 @@
 
 unsigned long irq_err_count;
 
+/* Only access this in an NMI enter/exit */
+DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
 int arch_show_interrupts(struct seq_file *p, int prec)
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214d..c33b53f20 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -12,6 +12,9 @@
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 #include <linux/irq.h>
 
+#define arch_nmi_enter()	do { } while (0)
+#define arch_nmi_exit()		do { } while (0)
+
 #ifndef ack_bad_irq
 static inline void ack_bad_irq(unsigned int irq)
 {
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 0fbbcdf..776a60f 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -62,6 +62,7 @@ static inline void rcu_nmi_exit(void)
 
 #define nmi_enter()						\
 	do {							\
+		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
@@ -80,6 +81,7 @@ static inline void rcu_nmi_exit(void)
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
+		arch_nmi_exit();				\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */
-- 
1.9.1

