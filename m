Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C087F208EB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiWXSpk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087F208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHDKXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:23:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHDKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AiAFQ6IM1CZIWMQ6ODZhTesmaZXEWKjq9PtsejQ/Zhs=; b=iiWXSpk0NBlW8X2g4tIeSI4g3
        k8mEaCP54vXmx8Tk5ErDEpf5md5ct+afokq6NCdRF5obaSX4x8lzCje/AIob/z5d1oVbtoZIk1mIc
        EhKmoLPjiSZxkGC0xWf57SI557M+SUBzSzjhNS8Zbas/dMoMtDln/PRClTkwb4FCVQ/KaifkLsJzJ
        2RDzwJbXfxaCkBntu3b8GcOVseH/MH7vXpl5JYVTFPeabNQk9W0In/wXrzPlgL+HZQa9auNrxoNv4
        7LZ33X0MyS1NCOPl6hAI7/qUOyYaouUDE37quKOc0KO+oWDk7Iu3HEItQIkbtRVeyr7fic/TIKCNh
        v+5Hcp1Ow==;
Received: from [46.125.249.69] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flrqT-0003e8-87; Sat, 04 Aug 2018 08:23:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 2/8] RISC-V: simplify software interrupt / IPI code
Date:   Sat,  4 Aug 2018 10:23:13 +0200
Message-Id: <20180804082319.5711-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082319.5711-1-hch@lst.de>
References: <20180804082319.5711-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename handle_ipi to riscv_software_interrupt, drop the unused return
value and move the prototype to irq.h together with riscv_timer_interupt.
This allows simplifying the upcoming interrupt handling support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/irq.h | 1 +
 arch/riscv/include/asm/smp.h | 3 ---
 arch/riscv/kernel/smp.c      | 6 ++----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 4dee9d4c13c0..c871661c9df4 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -22,6 +22,7 @@
 #define INTERRUPT_CAUSE_EXTERNAL    9
 
 void riscv_timer_interrupt(void);
+void riscv_software_interrupt(void);
 
 #include <asm-generic/irq.h>
 
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 85e4220839b0..c9395fff246f 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -44,9 +44,6 @@ void arch_send_call_function_single_ipi(int cpu);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
-/* Interprocessor interrupt handler */
-irqreturn_t handle_ipi(void);
-
 #endif /* CONFIG_SMP */
 
 #endif /* _ASM_RISCV_SMP_H */
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

