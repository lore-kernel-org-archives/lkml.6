Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1221872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfALJzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:55:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49283 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfALJzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:55:37 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43cFTw357Jz9vCJB;
        Sat, 12 Jan 2019 10:55:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OPNE7Dhp5IMS; Sat, 12 Jan 2019 10:55:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43cFTw2S20z9vCJ7;
        Sat, 12 Jan 2019 10:55:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32F8D8B77F;
        Sat, 12 Jan 2019 10:55:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wfn5u8tTjGtv; Sat, 12 Jan 2019 10:55:35 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF4558B74C;
        Sat, 12 Jan 2019 10:55:34 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C23C97183D; Sat, 12 Jan 2019 09:55:34 +0000 (UTC)
Message-Id: <6681b212d49622ae71344a0d320f5c546f49d049.1547195976.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547195976.git.christophe.leroy@c-s.fr>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v13 01/10] powerpc/irq: use memblock functions returning
 virtual address
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 12 Jan 2019 09:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only the virtual address of allocated blocks is used,
lets use functions returning directly virtual address.

Those functions have the advantage of also zeroing the block.

Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c      |  5 -----
 arch/powerpc/kernel/setup_32.c | 25 +++++++++++++++----------
 arch/powerpc/kernel/setup_64.c | 19 +++++++------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 916ddc4aac44..4a44bc395fbc 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -725,18 +725,15 @@ void exc_lvl_ctx_init(void)
 #endif
 #endif
 
-		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = critirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
 #ifdef CONFIG_BOOKE
-		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = dbgirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
-		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
 		tp = mcheckirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = HARDIRQ_OFFSET;
@@ -754,12 +751,10 @@ void irq_ctx_init(void)
 	int i;
 
 	for_each_possible_cpu(i) {
-		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
 		klp_init_thread_info(tp);
 
-		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
 		tp = hardirq_ctx[i];
 		tp->cpu = i;
 		klp_init_thread_info(tp);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..f0e25d845f8c 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -196,6 +196,16 @@ static int __init ppc_init(void)
 }
 arch_initcall(ppc_init);
 
+static void *__init alloc_stack(void)
+{
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+
+	if (!ptr)
+		panic("cannot allocate stacks");
+
+	return ptr;
+}
+
 void __init irqstack_early_init(void)
 {
 	unsigned int i;
@@ -203,10 +213,8 @@ void __init irqstack_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		softirq_ctx[i] = alloc_stack();
+		hardirq_ctx[i] = alloc_stack();
 	}
 }
 
@@ -224,13 +232,10 @@ void __init exc_lvl_early_init(void)
 		hw_cpu = 0;
 #endif
 
-		critirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		critirq_ctx[hw_cpu] = alloc_stack();
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[hw_cpu] = alloc_stack();
+		mcheckirq_ctx[hw_cpu] = alloc_stack();
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..080dd515d587 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
 
 static void *__init alloc_stack(unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		if (!pa)
-			panic("cannot allocate stacks");
-	}
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+				     MEMBLOCK_LOW_LIMIT, limit,
+				     early_cpu_to_node(cpu));
+	if (!ptr)
+		panic("cannot allocate stacks");
 
-	return __va(pa);
+	return ptr;
 }
 
 void __init irqstack_early_init(void)
@@ -739,20 +737,17 @@ void __init emergency_stack_init(void)
 		struct thread_info *ti;
 
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
-- 
2.13.3

