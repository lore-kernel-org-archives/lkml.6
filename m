Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD6C65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1122054F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1122054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeJEO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:29:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5669 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJEO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:29:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42RM005G8Bz9ttFb;
        Fri,  5 Oct 2018 09:32:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hgX4YWxEaR-g; Fri,  5 Oct 2018 09:32:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42RM004nZ2z9ttFV;
        Fri,  5 Oct 2018 09:32:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F6238BB74;
        Fri,  5 Oct 2018 09:32:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hHB9W_PTV8sY; Fri,  5 Oct 2018 09:32:04 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6ECE18BB6E;
        Fri,  5 Oct 2018 09:32:04 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 646E66F198; Fri,  5 Oct 2018 07:32:04 +0000 (UTC)
Message-Id: <2f0aa84e4b82f61181bcb533d69a2c5ddc6f9fcb.1538687075.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1538687073.git.christophe.leroy@c-s.fr>
References: <cover.1538687073.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 2/9] powerpc: Only use task_struct 'cpu' field on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  5 Oct 2018 07:32:04 +0000 (UTC)
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
index e2750b856c8f..05b574f416b3 100644
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
index 695b24a2d954..2f0fe8bfc078 100644
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
index c70d17c9a6ba..1731793e1277 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2986,7 +2986,7 @@ static void show_task(struct task_struct *tsk)
 	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, tsk->parent->pid,
-		state, task_thread_info(tsk)->cpu,
+		state, task_cpu(tsk),
 		tsk->comm);
 }
 
-- 
2.13.3

