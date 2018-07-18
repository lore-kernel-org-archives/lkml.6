Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2127ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9822075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DmUcK+RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9822075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbeGRKV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:21:27 -0400
Received: from 8bytes.org ([81.169.241.247]:54024 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbeGRKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C1B91325; Wed, 18 Jul 2018 11:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906880; bh=H6+XRgYKsec5YHvORG8P0AsgnpOKwYcNQ0i+yAmS8p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmUcK+RESwdsJ5tJVU4OT1FBremhqtEbuYdLsOMdPfmHRqOoUG8Mat8n2m/po2KzA
         i7CSJApCa+a9z8n/qTF+rlumAKIL8BAMoEJBfyFqg8EsX5QWhkekrU5K0JS2QnOimQ
         23X+TRKntTJoupsonkGRPKXrGa6PJqikILBQ+iKiJ5lNFKGS9rpWCdC1leybyvYSBJ
         x0dDP4NoF5jR5xEjRfNqNSU8Ky0epMkNqhhLoh9UaqaOD5OqJ3MxJgh8bxD2YmDX8N
         zqx6pqpLq5M2GZBF2DrfApMNKJu8vdn7dop3YioKFVtE1kF1QZOChfeNe1jLNoB885
         IJCnJ98Sy04KA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 15/39] x86/pgtable: Rename pti_set_user_pgd to pti_set_user_pgtbl
Date:   Wed, 18 Jul 2018 11:40:52 +0200
Message-Id: <1531906876-13451-16-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

With the way page-table folding is implemented on 32 bit, we
are not only setting PGDs with this functions, but also PUDs
and even PMDs. Give the function a more generic name to
reflect that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64.h | 12 ++++++------
 arch/x86/mm/pti.c                 |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 3c5385f..9406c4f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -196,21 +196,21 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd);
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
 
 /*
  * Take a PGD location (pgdp) and a pgd value that needs to be set there.
  * Populates the user and returns the resulting PGD that must be set in
  * the kernel copy of the page tables.
  */
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return pgd;
-	return __pti_set_user_pgd(pgdp, pgd);
+	return __pti_set_user_pgtbl(pgdp, pgd);
 }
 #else
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
 }
@@ -226,7 +226,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
-	pgd = pti_set_user_pgd((pgd_t *)p4dp, pgd);
+	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
@@ -237,7 +237,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pti_set_user_pgd(pgdp, pgd);
+	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4d418e7..f512222 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -117,7 +117,7 @@ void __init pti_check_boottime_disable(void)
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
 	 * Changes to the high (kernel) portion of the kernelmode page
-- 
2.7.4

