Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93876C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350C214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1350C214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeJEXOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeJEXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:01 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfHxt-1fW6yQ0J1H-00gr4H; Fri, 05 Oct 2018 18:13:37 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfHxt-1fW6yQ0J1H-00gr4H; Fri, 05 Oct 2018 18:13:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: avoid VLA in pgd_alloc()
Date:   Fri,  5 Oct 2018 18:13:16 +0200
Message-Id: <20181005161333.765973-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:8zIErsJuioMiMQ2HAReOpNhMdFUd4Dv+Qsv/DG3fC8VXw2yO8zO
 9qkXpbC5HpA9nrAyAUQrO/sJ9/3P6fXHn+6gL94XfnQ0ITk27OhT3MRYmftZmcZeYeI4+0M
 Iwht1EX0inm/WizYzPgjvCXFIXu/+dQbZyUNH/6Swc+Izcx+LT89F6cTrNSQx8K8ZZGtYZY
 EgmIXGRud/eMIMDHnAxtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GDBiROfLgoo=:yE2smityWbk/lrtX5zEPLx
 X7/oJ7IUW7CFC1ZIenrDtFTRixDVz/wIXmhzu9eXVapfiEswMFPj8eZ2f3DSshBVu05AZW2Hq
 BKru7GE3KvHUEZIkzJSPlNbeFkpyiP1S3WD32xbfsdTqzO9RRNW7jcTZ3dpKziqdr/Ro6525M
 bhCSWJIjzLmcLfEqRrGRLe+R3rekbBHPD7iOB5HBWKCyRNL0NCqtGySu5CVQ1b6MnO7t7ftWS
 ApTBbfHVa3fJJLkcqtEVkYE4LTEOFder84h4xzTnS9x8Ws421+LIxwNDtQGMpkaiP10trecKY
 J+bTLAjdDvpm90xtaMC6BM+PdJW74Svkxod4rItLjyrZqskeUjDlNRzyRVX6NBMEy2B1zIhyF
 quKhVOd6j3dSWyHoHqrS/HEPC2mdheWGrOTSU/GVtV+MU3/nTdqBAf4eh/IfKs38nuSJLIWLd
 w/6Kxq4VtvRO1weKtt5awDVP5Ka4YNPLOMq3naSGAtf39dCB2MwFt+N3Ow9lTtmJMgQ+2OoLt
 lAeLiLpuB+YJLKSr2K6Yjf5cYk8q8sGZDMo7PKrxjow8JEGv9o+PZdiZTbua6mzb/pplVuB78
 IteleXsFyYY1VgfWI/47eBtOg8MIMNZXrKjFxt4CG+0MpDnBntSlTWG0TK3GDWT4p9NvGJoOY
 u+BnLnZzyLC02vbw3/zngYDYqlYIkYgnr8MYmWUBW4FeYCq3Op9SYDNXT3Hhx134D3Lc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turning on -Wvla found a new VLA usage:

In file included from include/linux/kernel.h:15,
                 from include/asm-generic/bug.h:18,
                 from arch/x86/include/asm/bug.h:83,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/mm.h:9,
                 from arch/x86/mm/pgtable.c:2:
arch/x86/mm/pgtable.c: In function 'pgd_alloc':
include/linux/build_bug.h:29:45: error: ISO C90 forbids variable length array 'u_pmds' [-Werror=vla]
arch/x86/mm/pgtable.c:190:34: note: in expansion of macro 'static_cpu_has'
 #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
                                  ^~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:431:16: note: in expansion of macro 'PREALLOCATED_USER_PMDS'
  pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
                ^~~~~~~~~~~~~~~~~~~~~~

Use the actual size of the array that is used for X86_FEATURE_PTI
instead of the variable size.

Fixes: f59dbe9ca670 ("x86/pgtable/pae: Use separate kernel PMDs for user page-table")
Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/mm/pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 089e78c4effd..386b43e3e0ac 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -189,6 +189,7 @@ static void pgd_dtor(pgd_t *pgd)
  */
 #define PREALLOCATED_USER_PMDS	 (static_cpu_has(X86_FEATURE_PTI) ? \
 					KERNEL_PGD_PTRS : 0)
+#define MAX_PREALLOCATED_USER_PMDS KERNEL_PGD_PTRS
 
 void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 {
@@ -211,6 +212,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
 #define PREALLOCATED_USER_PMDS	 0
+#define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
 
 static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
@@ -428,8 +430,8 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
-	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[PREALLOCATED_PMDS];
+	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
+	pmd_t *pmds[MAX_PREALLOCATED_USER_PMDS];
 
 	pgd = _pgd_alloc();
 
-- 
2.18.0

