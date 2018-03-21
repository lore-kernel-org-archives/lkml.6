Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeCUORA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:17:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33302 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeCUOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:16:59 -0400
Message-Id: <7c34db8eca67beefa7ec8243bc07135b4dff4440.1521641523.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc/mm: Add missing tracepoint for tlbie
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Mar 2018 15:16:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
added tracepoints for tlbie calls, but _tlbil_va() was forgotten

Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_decl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 57fbc554c785..107033cc4dcf 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -23,6 +23,7 @@
 #include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_MMU_NOHASH
+#include <asm/trace.h>
 
 /*
  * On 40x and 8xx, we directly inline tlbia and tlbivax
@@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
+	trace_tlbie(0, 0, address, pid, 0, 0, 0);
 }
 #elif defined(CONFIG_PPC_BOOK3E)
 extern void _tlbil_va(unsigned long address, unsigned int pid,
-- 
2.13.3
