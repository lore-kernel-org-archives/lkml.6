Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C411C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA9D2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIERH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48990 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbeIERH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4253B81p65z9tvSh;
        Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QiiUtOE2meH6; Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4253B81JJKz9tvSC;
        Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 526BB8B82B;
        Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BmYCsZdBp3ww; Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 251A28B762;
        Wed,  5 Sep 2018 14:37:20 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E7E787159B; Wed,  5 Sep 2018 12:37:19 +0000 (UTC)
Message-Id: <7827f7644d12c321a56c77a5450176447f23c704.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 14/17] powerpc/mm: Allow platforms to redefine some
 helpers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:37:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 40xx defines _PAGE_HWWRITE while others don't.
The 8xx defines _PAGE_RO instead of _PAGE_RW.
The 8xx defines _PAGE_PRIVILEGED instead of _PAGE_USER.
The 8xx defines _PAGE_HUGE and _PAGE_NA while others don't.

Lets those platforms redefine pte_write(), pte_wrprotect() and
pte_mkwrite() and get _PAGE_RO and _PAGE_HWWRITE off the common
helpers.

Lets the 8xx redefine pte_user(), pte_mkprivileged() and pte_mkuser()
and get rid of _PAGE_PRIVILEGED and _PAGE_USER default values.

Lets the 8xx redefine pte_mkhuge() and get rid of
_PAGE_HUGE default value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 16 ++++-----
 arch/powerpc/include/asm/nohash/32/pte-40x.h | 16 +++++++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 51 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  4 ---
 arch/powerpc/include/asm/nohash/pgtable.h    | 24 +++++++++----
 arch/powerpc/include/asm/pte-common.h        | 24 -------------
 6 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 4fab3a7d764b..1577260641c9 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -136,14 +136,12 @@ extern int icache_44x_need_flush;
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~0, 0); } while (0)
 
+#ifndef pte_mkwrite
 static inline pte_t pte_mkwrite(pte_t pte)
 {
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~_PAGE_RO;
-	ptev |= _PAGE_RW;
-	return __pte(ptev);
+	return __pte(pte_val(pte) | _PAGE_RW);
 }
+#endif
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
@@ -155,14 +153,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_ACCESSED);
 }
 
+#ifndef pte_wrprotect
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
-	ptev |= _PAGE_RO;
-	return __pte(ptev);
+	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
+#endif
 
 static inline pte_t pte_mkexec(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 2b48bc289a4d..ab043b3e9b99 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -87,5 +87,21 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 
+#ifndef __ASSEMBLY__
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE));
+}
+
+#define pte_wrprotect pte_wrprotect
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
+}
+
+#define pte_mkclean pte_mkclean
+#endif
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_40x_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index d06fc45bd9ac..b899c3c877ac 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -87,5 +87,56 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_RO)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_RO | _PAGE_EXEC)
 
+#ifndef __ASSEMBLY__
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RO);
+}
+
+#define pte_wrprotect pte_wrprotect
+
+static inline int pte_write(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_RO);
+}
+
+#define pte_write pte_write
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RO);
+}
+
+#define pte_mkwrite pte_mkwrite
+
+static inline bool pte_user(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+}
+
+#define pte_user pte_user
+
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+}
+
+#define pte_mkprivileged pte_mkprivileged
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+}
+
+#define pte_mkuser pte_mkuser
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_HUGE);
+}
+
+#define pte_mkhuge pte_mkhuge
+#endif
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_8xx_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 40162de77c3a..c9e6626093ea 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -90,11 +90,7 @@
  */
 #include <asm/nohash/pte-book3e.h>
 
-#define _PAGE_HWWRITE	0
 #define _PAGE_SAO	0
-#define _PAGE_RO 0
-#define _PAGE_NA 0
-#define _PAGE_HUGE 0
 
 #define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index a40ab294d541..a98768ebc481 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -38,10 +38,12 @@
 #ifndef __ASSEMBLY__
 
 /* Generic accessors to PTE bits */
+#ifndef pte_write
 static inline int pte_write(pte_t pte)
 {
-	return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO;
+	return pte_val(pte) & _PAGE_RW;
 }
+#endif
 static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
@@ -78,10 +80,12 @@ static inline int pte_present(pte_t pte)
  * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
  * _PAGE_USER.  Need to explicitly match _PAGE_BAP_UR bit in that case too.
  */
+#ifndef pte_user
 static inline bool pte_user(pte_t pte)
 {
-	return (pte_val(pte) & (_PAGE_USER | _PAGE_PRIVILEGED)) == _PAGE_USER;
+	return (pte_val(pte) & _PAGE_USER) == _PAGE_USER;
 }
+#endif
 
 /*
  * We only find page table entry in the last level
@@ -121,10 +125,12 @@ static inline pte_t pte_exprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_EXEC);
 }
 
+#ifndef pte_mkclean
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
+	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
 }
+#endif
 
 static inline pte_t pte_mkold(pte_t pte)
 {
@@ -141,20 +147,26 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+#ifndef pte_mkhuge
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_HUGE);
+	return __pte(pte_val(pte));
 }
+#endif
 
+#ifndef pte_mkprivileged
 static inline pte_t pte_mkprivileged(pte_t pte)
 {
-	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+	return __pte(pte_val(pte) & ~_PAGE_USER);
 }
+#endif
 
+#ifndef pte_mkuser
 static inline pte_t pte_mkuser(pte_t pte)
 {
-	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+	return __pte(pte_val(pte) | _PAGE_USER);
 }
+#endif
 
 static inline pte_t pte_mknoncoherent(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 4d594039bca5..1a2102f8b1e7 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -5,36 +5,12 @@
  * Some bits are only used on some cpu families... Make sure that all
  * the undefined gets a sensible default
  */
-#ifndef _PAGE_HWWRITE
-#define _PAGE_HWWRITE	0
-#endif
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
-/* _PAGE_RO and _PAGE_RW shall not be defined at the same time */
-#ifndef _PAGE_RO
-#define _PAGE_RO 0
-#else
-#define _PAGE_RW 0
-#endif
-
-/* At least one of _PAGE_PRIVILEGED or _PAGE_USER must be defined */
-#ifndef _PAGE_PRIVILEGED
-#define _PAGE_PRIVILEGED 0
-#else
-#ifndef _PAGE_USER
-#define _PAGE_USER 0
-#endif
-#endif
-#ifndef _PAGE_NA
-#define _PAGE_NA 0
-#endif
-#ifndef _PAGE_HUGE
-#define _PAGE_HUGE 0
-#endif
 
 /* Location of the PFN in the PTE. Most 32-bit platforms use the same
  * as _PAGE_SHIFT here (ie, naturally aligned).
-- 
2.13.3

