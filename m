Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8936C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1420660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeK1U2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:28:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28993 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbeK1U2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:28:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 434b0D27Gpz9vBKF;
        Wed, 28 Nov 2018 10:27:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s6XbJ59pVyIs; Wed, 28 Nov 2018 10:27:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 434b0D1Strz9vBK9;
        Wed, 28 Nov 2018 10:27:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C5108B85D;
        Wed, 28 Nov 2018 10:27:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9DCV_XcLaLrE; Wed, 28 Nov 2018 10:27:25 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB9228B853;
        Wed, 28 Nov 2018 10:27:24 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C663069AFA; Wed, 28 Nov 2018 09:27:24 +0000 (UTC)
Message-Id: <98e37def51328f58d8c2ceb60edd4b3da7b6f2ef.1543356926.git.christophe.leroy@c-s.fr>
In-Reply-To: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 11/11] powerpc/book3s32: Implement Kernel Userspace
 Access Protection
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Nov 2018 09:27:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements Kernel Userspace Access Protection for
book3s/32.

Due to limitations of the processor page protection capabilities,
the protection is only against writing. read protection cannot be
achieved using page protection.

In order to provide the protection, Ku and Ks keys are modified in
Userspace Segment registers, and different PP bits are used to:

PP01 provides RW for Key 0 and RO for Key 1
PP10 provides RW for all
PP11 provides RO for all

Today PP10 is used for RW pages and PP11 for RO pages. This patch
modifies page protection to PP01 for RW pages.

Then segment registers are set to Ku 0 and Ks 1. When kernel needs
to write to RW pages, the associated segment register is changed to
Ks 0 in order to allow write access to the kernel.

In order to avoid having the read all segment registers when
locking/unlocking the access, some data is kept in the thread_struct
and saved on stack on exceptions. The field identifies both the
first unlocked segment and the first segment following the last
unlocked one. When no segment is unlocked, it contains value 0.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 98 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kup.h           |  3 +
 arch/powerpc/kernel/head_32.S            |  2 +-
 arch/powerpc/mm/ppc_mmu_32.c             | 10 ++++
 arch/powerpc/platforms/Kconfig.cputype   |  1 +
 5 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/kup.h

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
new file mode 100644
index 000000000000..7455ecaab3f9
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_32_KUP_H
+#define _ASM_POWERPC_BOOK3S_32_KUP_H
+
+#ifdef CONFIG_PPC_KUAP
+#define LOCK_USER_ACCESS(val, sp, sr, srmax, thread)			\
+	lwz	sr, KUAP(thread);					\
+	stw	sr, _KUAP(sp);						\
+	cmpli	cr7, sr, 0;						\
+	beq+	cr7, 102f;						\
+	li	val, 0;							\
+	stw	val, KUAP(thread);					\
+	rlwinm	srmax, sr, 28, 0xf0000000;				\
+	mfsrin	val, sr;						\
+	oris	val, val ,0x4000;	/* Set Ks */			\
+101:									\
+	mtsrin	val, sr;						\
+	addi	val, val, 0x111;	/* next VSID */			\
+	rlwinm	val, val, 0, 8, 3;	/* clear VSID overflow */	\
+	addis	sr, sr, 0x1000;		/* address of next segment */	\
+	cmpl	cr7, sr, srmax;						\
+	blt-	cr7, 101b;						\
+102:
+
+#define REST_USER_ACCESS(val, sp, sr, srmax, curr)			\
+	lwz	sr, _KUAP(sp);						\
+	stw	sr, THREAD+KUAP(curr);					\
+	cmpli	cr7, sr, 0;						\
+	beq+	cr7, 102f;						\
+	rlwinm	srmax, sr, 28, 0xf0000000;				\
+	mfsrin	val, sr;						\
+	rlwinm	val, val ,0, ~0x40000000;	/* Clear Ks */		\
+101:									\
+	mtsrin	val, sr;						\
+	addi	val, val, 0x111;	/* next VSID */			\
+	rlwinm	val, val, 0, 8, 3;	/* clear VSID overflow */	\
+	addis	sr, sr, 0x1000;		/* address of next segment */	\
+	cmpl	cr7, sr, srmax;						\
+	blt-	cr7, 101b;						\
+102:
+
+#define KUAP_START			0
+#endif
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_PPC_KUAP
+
+#include <linux/sched.h>
+
+static inline void lock_user_access(void __user *to, const void __user *from,
+				    unsigned long size)
+{
+	unsigned long addr = (unsigned long)to;
+	unsigned long end = addr + size;
+	unsigned long sr;
+
+	if (!to)
+		return;
+
+	current->thread.kuap = 0;
+	sr = mfsrin(addr);
+	sr |= 0x40000000;		/* set Ks */
+	mb();	/* make sure all writes are done before SR are updated */
+	while (addr < end) {
+		mtsrin(sr, addr);
+		sr += 0x111;		/* next VSID */
+		sr &= 0xf0ffffff;	/* clear VSID overflow */
+		addr += 0x10000000;	/* address of next segment */
+	}
+}
+
+static inline void unlock_user_access(void __user *to, const void __user *from,
+				      unsigned long size)
+{
+	unsigned long addr = (unsigned long)to;
+	unsigned long end = addr + size;
+	unsigned long kuap = addr & 0xf0000000;
+	unsigned long sr;
+
+	if (!to)
+		return;
+
+	sr = mfsrin(addr);
+	sr &= ~0x40000000;		/* clear Ks */
+	while (addr < end) {
+		mtsrin(sr, addr);
+		sr += 0x111;		/* next VSID */
+		sr &= 0xf0ffffff;	/* clear VSID overflow */
+		addr += 0x10000000;	/* address of next segment */
+	}
+	kuap |= (addr >> 28) & 0xf;
+	current->thread.kuap = kuap;
+	mb();	/* make sure SRs are updated before writing */
+}
+#endif
+#endif
+
+#endif /* _ASM_POWERPC_BOOK3S_32_KUP_H */
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index d4dd242251bd..7813e2bcfb7c 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,6 +5,9 @@
 #ifdef CONFIG_PPC_8xx
 #include <asm/nohash/32/kup-8xx.h>
 #endif
+#ifdef CONFIG_PPC_BOOK3S_32
+#include <asm/book3s/32/kup.h>
+#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/kup-radix.h>
 #endif
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 1aca0dba0ec1..f73db6891901 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1015,7 +1015,7 @@ _ENTRY(switch_mmu_context)
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
 #ifdef CONFIG_PPC_KUAP
-	addis	r3,r3,0x4000	/* Set Ks, clear Ku bits */
+	addis	r3, r3, 0x4000	/* Set Ks, clear Ku bits */
 #endif
 	li	r0,NUM_USER_SEGMENTS
 	mtctr	r0
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f6f575bae3bc..5dfebed93ab6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -287,3 +287,13 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	else /* Anything else has 256M mapped */
 		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
 }
+
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
+{
+	pr_info("Activating Kernel Userspace Access Protection\n");
+
+	if (disabled)
+		pr_warn("KUAP cannot be disabled yet on 6xx when compiled in\n");
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5fbfa041194d..0b9a8eda413a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -24,6 +24,7 @@ choice
 config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
+	select PPC_HAVE_KUAP
 
 config PPC_85xx
 	bool "Freescale 85xx"
-- 
2.13.3

