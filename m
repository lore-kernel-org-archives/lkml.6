Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbeCSKcl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:32:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13786 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeCSKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:32:40 -0400
Message-Id: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  1/2] powerpc/mm: Add missing tracepoint for tlbie
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Balbir Singh <bsingharora@gmail.com>
Date: Mon, 19 Mar 2018 11:32:38 +0100 (CET)
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
index 57fbc554c785..b9991e0c61a2 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
+#include <asm/trace.h>
 
 #ifdef CONFIG_PPC_MMU_NOHASH
 
@@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
+	trace_tlbie(pid, 0, address, 0, 0, 0, 0);
 }
 #elif defined(CONFIG_PPC_BOOK3E)
 extern void _tlbil_va(unsigned long address, unsigned int pid,
-- 
2.13.3
