Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D675BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6324095
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD6324095
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeGEQ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:26:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55946 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbeGEQZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39m2RCyz9ttwh;
        Thu,  5 Jul 2018 18:25:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3z24RN6QW_5b; Thu,  5 Jul 2018 18:25:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39m1vkBz9ttwg;
        Thu,  5 Jul 2018 18:25:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05CDC8B8CF;
        Thu,  5 Jul 2018 18:25:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tlyJfuMwcIpY; Thu,  5 Jul 2018 18:25:17 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D78378B8BC;
        Thu,  5 Jul 2018 18:25:17 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A9D6A711E2; Thu,  5 Jul 2018 16:25:17 +0000 (UTC)
Message-Id: <d880539cae1cfb4b61cdea5aafc81af9493b194d.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 14/16] powerpc: Split synch.h in two parts
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:25:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move feature-fixups related stuff from synch.h to synch-ftr.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/atomic.h                 |  1 +
 arch/powerpc/include/asm/barrier.h                |  1 +
 arch/powerpc/include/asm/bitops.h                 |  1 +
 arch/powerpc/include/asm/cmpxchg.h                |  1 +
 arch/powerpc/include/asm/spinlock.h               |  1 +
 arch/powerpc/include/asm/{synch.h => synch-ftr.h} | 22 +++--------------
 arch/powerpc/include/asm/synch.h                  | 30 -----------------------
 arch/powerpc/lib/feature-fixups-test.S            |  1 +
 8 files changed, 9 insertions(+), 49 deletions(-)
 copy arch/powerpc/include/asm/{synch.h => synch-ftr.h} (66%)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index cbdb0b7e60a3..49a929ec5435 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,6 +11,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 #include <asm/asm-405.h>
+#include <asm/synch-ftr.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index de1316874e45..d90a1463967b 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -6,6 +6,7 @@
 #define _ASM_POWERPC_BARRIER_H
 
 #include <asm/asm-const.h>
+#include <asm/synch-ftr.h>
 
 /*
  * Memory barrier.
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index ff71566dadee..b8bf2f5b75ce 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -44,6 +44,7 @@
 
 #include <linux/compiler.h>
 #include <asm/asm-compat.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/asm-405.h>
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 27183871eb3b..d94a67a1a574 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -4,6 +4,7 @@
 
 #ifdef __KERNEL__
 #include <linux/compiler.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <linux/bug.h>
 #include <asm/asm-405.h>
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 685c72310f5d..182f950a4c5d 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -24,6 +24,7 @@
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #endif
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-405.h>
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch-ftr.h
similarity index 66%
copy from arch/powerpc/include/asm/synch.h
copy to arch/powerpc/include/asm/synch-ftr.h
index aca70fb43147..f86c536bd351 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch-ftr.h
@@ -1,27 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_SYNCH_H 
-#define _ASM_POWERPC_SYNCH_H 
+#ifndef _ASM_POWERPC_SYNCH_FTR_H
+#define _ASM_POWERPC_SYNCH_FTR_H
 #ifdef __KERNEL__
 
 #include <asm/feature-fixups.h>
 #include <asm/asm-const.h>
 
-#ifndef __ASSEMBLY__
-extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
-extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
-			     void *fixup_end);
-
-static inline void eieio(void)
-{
-	__asm__ __volatile__ ("eieio" : : : "memory");
-}
-
-static inline void isync(void)
-{
-	__asm__ __volatile__ ("isync" : : : "memory");
-}
-#endif /* __ASSEMBLY__ */
-
 #if defined(__powerpc64__)
 #    define LWSYNC	lwsync
 #elif defined(CONFIG_E500)
@@ -50,4 +34,4 @@ static inline void isync(void)
 #endif
 
 #endif /* __KERNEL__ */
-#endif	/* _ASM_POWERPC_SYNCH_H */
+#endif	/* _ASM_POWERPC_SYNCH_FTR_H */
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index aca70fb43147..48b23168ea9e 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -3,9 +3,6 @@
 #define _ASM_POWERPC_SYNCH_H 
 #ifdef __KERNEL__
 
-#include <asm/feature-fixups.h>
-#include <asm/asm-const.h>
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
@@ -22,32 +19,5 @@ static inline void isync(void)
 }
 #endif /* __ASSEMBLY__ */
 
-#if defined(__powerpc64__)
-#    define LWSYNC	lwsync
-#elif defined(CONFIG_E500)
-#    define LWSYNC					\
-	START_LWSYNC_SECTION(96);			\
-	sync;						\
-	MAKE_LWSYNC_SECTION_ENTRY(96, __lwsync_fixup);
-#else
-#    define LWSYNC	sync
-#endif
-
-#ifdef CONFIG_SMP
-#define __PPC_ACQUIRE_BARRIER				\
-	START_LWSYNC_SECTION(97);			\
-	isync;						\
-	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
-#define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
-#define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
-#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(sync) "\n"
-#define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
-#else
-#define PPC_ACQUIRE_BARRIER
-#define PPC_RELEASE_BARRIER
-#define PPC_ATOMIC_ENTRY_BARRIER
-#define PPC_ATOMIC_EXIT_BARRIER
-#endif
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_SYNCH_H */
diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index ee7c5fd5fc64..8c781b2e467b 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -10,6 +10,7 @@
 
 #include <asm/feature-fixups.h>
 #include <asm/ppc_asm.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
 
-- 
2.13.3

