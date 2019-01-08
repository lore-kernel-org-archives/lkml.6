Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C697DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E3E206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAHNnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:43:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57346 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfAHNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:43:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43YtkS5Hdvz9tyN2;
        Tue,  8 Jan 2019 14:43:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jQQeOiQpWgbb; Tue,  8 Jan 2019 14:43:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43YtkS4c6Nz9tyMv;
        Tue,  8 Jan 2019 14:43:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03CF58B833;
        Tue,  8 Jan 2019 14:43:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Qe3X0ee4qBNY; Tue,  8 Jan 2019 14:43:13 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CACF98B7DF;
        Tue,  8 Jan 2019 14:43:13 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A19EC717F2; Tue,  8 Jan 2019 13:43:13 +0000 (UTC)
Message-Id: <12fd0bf34fe8ea00c87c293b0a9f0fd86b30c83c.1546954237.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1546954233.git.christophe.leroy@c-s.fr>
References: <cover.1546954233.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v12 03/10] powerpc: Only use task_struct 'cpu' field on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  8 Jan 2019 13:43:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving to CONFIG_THREAD_INFO_IN_TASK, the thread_info 'cpu' field
gets moved into task_struct and only defined when CONFIG_SMP is set.

This patch ensures that TI_CPU is only used when CONFIG_SMP is set and
that task_struct 'cpu' field is not used directly out of SMP code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 2 ++
 arch/powerpc/kernel/misc_32.S        | 4 ++++
 arch/powerpc/xmon/xmon.c             | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2386ce2a9c6e..2c21e8642a00 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -243,8 +243,10 @@ set_ivor:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+#ifdef CONFIG_SMP
 	CURRENT_THREAD_INFO(r22, r1)
 	stw	r24, TI_CPU(r22)
+#endif
 
 	bl	early_init
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 57d2ffb2d45c..02b8cdd73792 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -183,10 +183,14 @@ _GLOBAL(low_choose_750fx_pll)
 	or	r4,r4,r5
 	mtspr	SPRN_HID1,r4
 
+#ifdef CONFIG_SMP
 	/* Store new HID1 image */
 	CURRENT_THREAD_INFO(r6, r1)
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
+#else
+	li	r6, 0
+#endif
 	addis	r6,r6,nap_save_hid1@ha
 	stw	r4,nap_save_hid1@l(r6)
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 757b8499aba2..a0f44f992360 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2997,7 +2997,7 @@ static void show_task(struct task_struct *tsk)
 	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, rcu_dereference(tsk->parent)->pid,
-		state, task_thread_info(tsk)->cpu,
+		state, task_cpu(tsk),
 		tsk->comm);
 }
 
-- 
2.13.3

