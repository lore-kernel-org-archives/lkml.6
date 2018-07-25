Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADC820893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVsjdAC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADC820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeGYKrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:47:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeGYKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kyUCWKy8PIc0CzhOk3Xl+OXhFGSudP08A9BZQC+3IXs=; b=WVsjdAC+Xg33Nox4Lx7k78BnC
        bEEzjLv7QM1Q70VC5vkvYzUC/n5z/wepaRfRdnOp/k+ajOGHFG9q48DYY76QxbfU3oTWVUVgP+Ph8
        GC0mNgc8BbLiE6q1CWDFTFBEH9R3AI3ctxmcAeH4XTgoMlQYDFJY6Xk1bvVM34ER9anYX5R+Dwsky
        hdcZjNJaYfN+B5SdM3tbQZLUBikrvWxqHSjfCvp6XIJnmf8PUMxoQRntwM0zVideZSdArvYgyCYTj
        wxZHCi1Sng8dxONjl4d6DNoC9raRYdt3OsD113Cv4aayvh29qf88FoAnzzd9z9uqHu5BKoC1T3wT7
        TSoK6rS9Q==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGE4-0005EL-Ht; Wed, 25 Jul 2018 09:36:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 1/6] RISC-V: simplify software interrupt / IPI code
Date:   Wed, 25 Jul 2018 11:36:44 +0200
Message-Id: <20180725093649.32332-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename handle_ipi to riscv_software_interrupt, drop the unused return
value and provide a stub for the !SMP build.  This allows simplifying
the upcoming interrupt controller driver by not providing a wrapper
for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/smp.h | 13 +++++++++++--
 arch/riscv/kernel/smp.c      |  6 ++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 85e4220839b0..80ecb957fe9f 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -44,8 +44,17 @@ void arch_send_call_function_single_ipi(int cpu);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
-/* Interprocessor interrupt handler */
-irqreturn_t handle_ipi(void);
+/* Software interrupt handler */
+void riscv_software_interrupt(void);
+
+#else /* CONFIG_SMP */
+
+/*
+ * We currently only use software interrupts to pass inter-processor
+ * interrupts, so if a non-SMP system gets a software interrupt then we
+ * don't know what to do.
+ */
+#define riscv_software_interrupt()	WARN_ON()
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 6d3962435720..906fe21ea21b 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -45,7 +45,7 @@ int setup_profiling_timer(unsigned int multiplier)
 	return -EINVAL;
 }
 
-irqreturn_t handle_ipi(void)
+void riscv_software_interrupt(void)
 {
 	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
 
@@ -60,7 +60,7 @@ irqreturn_t handle_ipi(void)
 
 		ops = xchg(pending_ipis, 0);
 		if (ops == 0)
-			return IRQ_HANDLED;
+			return;
 
 		if (ops & (1 << IPI_RESCHEDULE))
 			scheduler_ipi();
@@ -73,8 +73,6 @@ irqreturn_t handle_ipi(void)
 		/* Order data access and bit testing. */
 		mb();
 	}
-
-	return IRQ_HANDLED;
 }
 
 static void
-- 
2.18.0

