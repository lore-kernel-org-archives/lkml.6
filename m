Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF2C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E061B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E061B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJPUX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:23:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35755 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:23:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42ZF8p0D7tz9ttBk;
        Tue, 16 Oct 2018 14:33:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jS9JomnjwdYd; Tue, 16 Oct 2018 14:33:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42ZF8n6nBTz9ttBd;
        Tue, 16 Oct 2018 14:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B91188B7D0;
        Tue, 16 Oct 2018 14:33:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FXcBBr3Rhg2o; Tue, 16 Oct 2018 14:33:40 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E1588B7CF;
        Tue, 16 Oct 2018 14:33:40 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 306DB6F4CB; Tue, 16 Oct 2018 12:33:40 +0000 (UTC)
Message-Id: <199ae2a28f14f944ee9ae2770a3f1dd030e762bc.1539693039.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/io: remove old GCC version implementation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 16 Oct 2018 12:33:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4.6 is the minimum supported now.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 0a034519957d..3ef40b703c4a 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -111,25 +111,6 @@ extern bool isa_io_special;
 #define IO_SET_SYNC_FLAG()
 #endif
 
-/* gcc 4.0 and older doesn't have 'Z' constraint */
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
-#define DEF_MMIO_IN_X(name, size, insn)				\
-static inline u##size name(const volatile u##size __iomem *addr)	\
-{									\
-	u##size ret;							\
-	__asm__ __volatile__("sync;"#insn" %0,0,%1;twi 0,%0,0;isync"	\
-		: "=r" (ret) : "r" (addr), "m" (*addr) : "memory");	\
-	return ret;							\
-}
-
-#define DEF_MMIO_OUT_X(name, size, insn)				\
-static inline void name(volatile u##size __iomem *addr, u##size val)	\
-{									\
-	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
-		: "=m" (*addr) : "r" (val), "r" (addr) : "memory");	\
-	IO_SET_SYNC_FLAG();						\
-}
-#else /* newer gcc */
 #define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
@@ -146,7 +127,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 		: "=Z" (*addr) : "r" (val) : "memory");			\
 	IO_SET_SYNC_FLAG();						\
 }
-#endif
 
 #define DEF_MMIO_IN_D(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
-- 
2.13.3

