Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65F12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65F12147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIQRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:42:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44148 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeIQRmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:42:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DQ6v5xbHz9ttCQ;
        Mon, 17 Sep 2018 14:15:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9NaIs72d97HJ; Mon, 17 Sep 2018 14:15:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DQ6v5V2Fz9ttBj;
        Mon, 17 Sep 2018 14:15:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A34E8B79C;
        Mon, 17 Sep 2018 14:15:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4eejEYax-CZt; Mon, 17 Sep 2018 14:15:08 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 190B48B794;
        Mon, 17 Sep 2018 14:15:08 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 08B8D6FFCE; Mon, 17 Sep 2018 12:15:08 +0000 (UTC)
Message-Id: <7bd67c4ccdd202f2125b7fc0ed0332d0d020690b.1537186089.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
References: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/32: stack protector: change the canary value per
 task
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Sep 2018 12:15:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partially copied from commit df0698be14c66 ("ARM: stack protector:
change the canary value per task")

A new random value for the canary is stored in the task struct whenever
a new task is forked.  This is meant to allow for different canary values
per task.  On powerpc, GCC expects the canary value to be found in a global
variable called __stack_chk_guard.  So this variable has to be updated
with the value stored in the task struct whenever a task switch occurs.

Because the variable GCC expects is global, this cannot work on SMP
unfortunately.  So, on SMP, the same initial canary value is kept
throughout, making this feature a bit less effective although it is still
useful.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 I would have liked to use -mstack-protector-guard=tls -mstack-protector-guard-reg=r2
 -mstack-protector-guard-offset=offsetof(struct task_struct, stack_canary) but I have
 not found how set the value of offsetof(struct task_struct, stack_canary) in Makefile.
 Any idea ?

 arch/powerpc/kernel/asm-offsets.c | 3 +++
 arch/powerpc/kernel/entry_32.S    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..cb02d23764ca 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,9 @@ int main(void)
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
+#ifdef CONFIG_CC_STACKPROTECTOR
+	DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..0cdb4170a21d 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -721,6 +721,11 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
 END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
+#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	lwz	r0, TSK_STACK_CANARY(r2)
+	lis	r4, __stack_chk_guard@ha
+	stw	r0, __stack_chk_guard@l(r4)
+#endif
 
 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
-- 
2.13.3

