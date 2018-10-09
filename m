Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DDC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856032075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856032075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIOTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:19:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeJIOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:19:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9973dHL935844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 00:03:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9973dW5935841;
        Tue, 9 Oct 2018 00:03:39 -0700
Date:   Tue, 9 Oct 2018 00:03:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-184d47f0fd365108bd06ab26cdb3450b716269fd@git.kernel.org>
Cc:     peterz@infradead.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, arnd@arndb.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, toshi.kani@hpe.com,
        torvalds@linux-foundation.org, bp@alien8.de, jroedel@suse.de,
        keescook@chromium.org, hpa@zytor.com, dave.hansen@linux.intel.com
Reply-To: jroedel@suse.de, bp@alien8.de, torvalds@linux-foundation.org,
          toshi.kani@hpe.com, dave.hansen@linux.intel.com, hpa@zytor.com,
          keescook@chromium.org, mingo@kernel.org, luto@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          akpm@linux-foundation.org, tglx@linutronix.de, arnd@arndb.de
In-Reply-To: <20181008235434.GA35035@beast>
References: <20181008235434.GA35035@beast>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
Git-Commit-ID: 184d47f0fd365108bd06ab26cdb3450b716269fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  184d47f0fd365108bd06ab26cdb3450b716269fd
Gitweb:     https://git.kernel.org/tip/184d47f0fd365108bd06ab26cdb3450b716269fd
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 8 Oct 2018 16:54:34 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Oct 2018 08:55:07 +0200

x86/mm: Avoid VLA in pgd_alloc()

Arnd Bergmann reported that turning on -Wvla found a new (unintended) VLA usage:

  arch/x86/mm/pgtable.c: In function 'pgd_alloc':
  include/linux/build_bug.h:29:45: error: ISO C90 forbids variable length array 'u_pmds' [-Werror=vla]
  arch/x86/mm/pgtable.c:190:34: note: in expansion of macro 'static_cpu_has'
   #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
                                    ^~~~~~~~~~~~~~
  arch/x86/mm/pgtable.c:431:16: note: in expansion of macro 'PREALLOCATED_USER_PMDS'
    pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
                ^~~~~~~~~~~~~~~~~~~~~~

Use the actual size of the array that is used for X86_FEATURE_PTI,
which is known at build time, instead of the variable size.

[ mingo: Squashed original fix with followup fix to avoid bisection breakage, wrote new changelog. ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Original-written-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hpe.com>
Fixes: 1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")
Link: http://lkml.kernel.org/r/20181008235434.GA35035@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pgtable.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 089e78c4effd..59274e2c1ac4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -115,6 +115,8 @@ static inline void pgd_list_del(pgd_t *pgd)
 
 #define UNSHARED_PTRS_PER_PGD				\
 	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
+#define MAX_UNSHARED_PTRS_PER_PGD			\
+	max_t(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
 
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
@@ -181,6 +183,7 @@ static void pgd_dtor(pgd_t *pgd)
  * and initialize the kernel pmds here.
  */
 #define PREALLOCATED_PMDS	UNSHARED_PTRS_PER_PGD
+#define MAX_PREALLOCATED_PMDS	MAX_UNSHARED_PTRS_PER_PGD
 
 /*
  * We allocate separate PMDs for the kernel part of the user page-table
@@ -189,6 +192,7 @@ static void pgd_dtor(pgd_t *pgd)
  */
 #define PREALLOCATED_USER_PMDS	 (static_cpu_has(X86_FEATURE_PTI) ? \
 					KERNEL_PGD_PTRS : 0)
+#define MAX_PREALLOCATED_USER_PMDS KERNEL_PGD_PTRS
 
 void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 {
@@ -210,7 +214,9 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
+#define MAX_PREALLOCATED_PMDS	0
 #define PREALLOCATED_USER_PMDS	 0
+#define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
 
 static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
@@ -428,8 +434,8 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
-	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[PREALLOCATED_PMDS];
+	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
+	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
 
