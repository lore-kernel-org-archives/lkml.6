Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7A2C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E39920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rpaUrbJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfAaKJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:09:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:41257 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732130AbfAaKJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:09:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43qwtr43lcz9tyxD;
        Thu, 31 Jan 2019 11:09:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rpaUrbJA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yJjAMWDGxAcp; Thu, 31 Jan 2019 11:09:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtr31Cwz9tyx9;
        Thu, 31 Jan 2019 11:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548929348; bh=XQGEmIenrsIUSLMkN6Eh2UH+4Jq+ReCGjA0jRToV2fM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=rpaUrbJAQX9DIa2ZRbM90VikLDgf03MNAa/GmK0Wtve3e/3pZl9IyhgTC9F/EJN0w
         IJlsEQbRiXNvMjkhtkkbEAzW+3rP3nsM4zue8wb+UY14+lxo3usp4AkAZzb7SwM6re
         301xDFVROLjaB0K87umcR84rss24UzMtq8Tbxceg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BF6C8B814;
        Thu, 31 Jan 2019 11:09:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s4GScOqivpQs; Thu, 31 Jan 2019 11:09:09 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 605198B78D;
        Thu, 31 Jan 2019 11:09:09 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DEDC672E14; Thu, 31 Jan 2019 10:09:08 +0000 (UTC)
Message-Id: <1a102fca8e3853b7f2ef288344399df881eec212.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 13/13] powerpc: clean stack pointers naming
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 31 Jan 2019 10:09:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some stack pointers used to also be thread_info pointers
and were called tp. Now that they are only stack pointers,
rename them sp.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c      | 17 +++++++----------
 arch/powerpc/kernel/setup_64.c | 11 +++--------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 938944c6e2ee..8a936723c791 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -659,21 +659,21 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	void *curtp, *irqtp, *sirqtp;
+	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	curtp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
-	irqtp = hardirq_ctx[raw_smp_processor_id()];
-	sirqtp = softirq_ctx[raw_smp_processor_id()];
+	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	irqsp = hardirq_ctx[raw_smp_processor_id()];
+	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
 	/* Already there ? */
-	if (unlikely(curtp == irqtp || curtp == sirqtp)) {
+	if (unlikely(cursp == irqsp || cursp == sirqsp)) {
 		__do_irq(regs);
 		set_irq_regs(old_regs);
 		return;
 	}
 	/* Switch stack and call */
-	call_do_irq(regs, irqtp);
+	call_do_irq(regs, irqsp);
 
 	set_irq_regs(old_regs);
 }
@@ -695,10 +695,7 @@ void *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void do_softirq_own_stack(void)
 {
-	void *irqtp;
-
-	irqtp = softirq_ctx[smp_processor_id()];
-	call_do_softirq(irqtp);
+	call_do_softirq(softirq_ctx[smp_processor_id()]);
 }
 
 irq_hw_number_t virq_to_hw(unsigned int virq)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2db1c5f7d141..daa361fc6a24 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -716,19 +716,14 @@ void __init emergency_stack_init(void)
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		void *ti;
-
-		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->emergency_sp = ti + THREAD_SIZE;
+		paca_ptrs[i]->emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
-		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->nmi_emergency_sp = ti + THREAD_SIZE;
+		paca_ptrs[i]->nmi_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
-		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->mc_emergency_sp = ti + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 #endif
 	}
 }
-- 
2.13.3

