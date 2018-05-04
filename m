Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeEDMiw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:38:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39728 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeEDMdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:33:55 -0400
Message-Id: <7332568467307f9fc79eeef47507909ddc423c4b.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  02/17] powerpc/nohash: remove _PAGE_BUSY
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:33:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_BUSY is always 0, remove it

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 10 +++-------
 arch/powerpc/include/asm/nohash/pte-book3e.h |  5 -----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 4f6f5a27bfb5..c3559d7a94fb 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -186,14 +186,12 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%3		# pte_update\n\
-	andi.	%1,%0,%6\n\
-	bne-	1b \n\
 	andc	%1,%0,%4 \n\
-	or	%1,%1,%7\n\
+	or	%1,%1,%6\n\
 	stdcx.	%1,0,%3 \n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
+	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (set)
 	: "cc" );
 #else
 	unsigned long old = pte_val(*ptep);
@@ -290,13 +288,11 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 
 	__asm__ __volatile__(
 	"1:	ldarx	%0,0,%4\n\
-		andi.	%1,%0,%6\n\
-		bne-	1b \n\
 		or	%0,%3,%0\n\
 		stdcx.	%0,0,%4\n\
 		bne-	1b"
 	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
-	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
+	:"r" (bits), "r" (ptep), "m" (*ptep)
 	:"cc");
 #else
 	unsigned long old = pte_val(*ptep);
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 9ff51b4c0cac..12730b81cd98 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -57,13 +57,8 @@
 #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
 #define _PAGE_PRIVILEGED	(_PAGE_BAP_SR)
 
-#define _PAGE_BUSY	0
-
 #define _PAGE_SPECIAL	_PAGE_SW0
 
-/* Flags to be preserved on PTE modifications */
-#define _PAGE_HPTEFLAGS	_PAGE_BUSY
-
 /* Base page size */
 #ifdef CONFIG_PPC_64K_PAGES
 #define _PAGE_PSIZE	_PAGE_PSIZE_64K
-- 
2.13.3
