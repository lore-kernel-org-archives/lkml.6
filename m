Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784E320827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546964832;
	bh=mJaGqnVmEL5wVShngGxdmwG0XGFvmfuZp6oazpHo0ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0v7OjwenvLvgWYnL3uK4gHLBNI/SIOP+GlRibNtmUCnCgC0cGHMC7HVfbotvfNk5Y
	 Yo3/T4GtUfU7s35qmtI90jyxEORSXRIS5KES5poLx30Z3nTYK+uYi+RNvEll4jliT4
	 7tyq7FGy96dIQi9DHyzfW4EfgweDZKLSfcQKRjb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfAHQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfAHQ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:27:10 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EC12173C;
        Tue,  8 Jan 2019 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546964829;
        bh=mJaGqnVmEL5wVShngGxdmwG0XGFvmfuZp6oazpHo0ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0/xniZvEXq1YipaTVLzq3a0QvU/Qt8SrmCJJ0Kp19L7i9xvDPmDkczl/cvgj0b+y
         8Q7udtMgwRoX7C+Ghr00zwKUyqNMcGJ8uYam7I5FLJYVWMiTk0IAiWkSQ+sD0QJ5Yd
         0WuFuaeyJvyaUorhjBTG/rRGQQ3ZGWf8UPMxVNTo=
From:   guoren@kernel.org
To:     tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mhocko@kernel.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Guo Ren <ren_guo@c-sky.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/5] csky: fixup compile error with pte_alloc
Date:   Wed,  9 Jan 2019 00:26:37 +0800
Message-Id: <1546964798-30067-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Commit: 4cf58924951e remove the address argument of pte_alloc without
modify csky related code. linux-5.0-rc1 compile failed with csky.

Remove the unnecessary address testing in pte_alloc().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/csky/include/asm/pgalloc.h | 43 +++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf4f4a0..d213bb4 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -24,41 +24,34 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern void pgd_init(unsigned long *p);
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *pte;
-	unsigned long *kaddr, i;
+	unsigned long i;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL,
-					 PTE_ORDER);
-	kaddr = (unsigned long *)pte;
-	if (address & 0x80000000)
-		for (i = 0; i < (PAGE_SIZE/4); i++)
-			*(kaddr + i) = 0x1;
-	else
-		clear_page(kaddr);
+	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	if (!pte)
+		return NULL;
+
+	for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
+		(pte + i)->pte_low = _PAGE_GLOBAL;
 
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-						unsigned long address)
+static inline struct page *pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
-	unsigned long *kaddr, i;
-
-	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL, PTE_ORDER);
-	if (pte) {
-		kaddr = kmap_atomic(pte);
-		if (address & 0x80000000) {
-			for (i = 0; i < (PAGE_SIZE/4); i++)
-				*(kaddr + i) = 0x1;
-		} else
-			clear_page(kaddr);
-		kunmap_atomic(kaddr);
-		pgtable_page_ctor(pte);
+
+	pte = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!pte)
+		return NULL;
+
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
 	}
+
 	return pte;
 }
 
-- 
2.7.4

