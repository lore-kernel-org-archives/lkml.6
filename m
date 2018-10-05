Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC35C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBDE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBDE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeJEX0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:26:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeJEX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:26:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95GOrO63209018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 09:24:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95GOrkT3209015;
        Fri, 5 Oct 2018 09:24:53 -0700
Date:   Fri, 5 Oct 2018 09:24:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-1be3f247c2882a82279cbcf43717581ea943b692@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        bp@alien8.de, tglx@linutronix.de, dave.hansen@linux.intel.com,
        keescook@chromium.org, jroedel@suse.de, peterz@infradead.org,
        mingo@kernel.org, arnd@arndb.de, toshi.kani@hpe.com, hpa@zytor.com
Reply-To: bp@alien8.de, tglx@linutronix.de, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          luto@kernel.org, toshi.kani@hpe.com, hpa@zytor.com,
          arnd@arndb.de, mingo@kernel.org, jroedel@suse.de,
          peterz@infradead.org, dave.hansen@linux.intel.com,
          keescook@chromium.org
In-Reply-To: <20181005161333.765973-1-arnd@arndb.de>
References: <20181005161333.765973-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
Git-Commit-ID: 1be3f247c2882a82279cbcf43717581ea943b692
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

Commit-ID:  1be3f247c2882a82279cbcf43717581ea943b692
Gitweb:     https://git.kernel.org/tip/1be3f247c2882a82279cbcf43717581ea943b692
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 5 Oct 2018 18:13:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 5 Oct 2018 18:16:55 +0200

x86/mm: Avoid VLA in pgd_alloc()

Turning on -Wvla found a new VLA usage:

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hpe.com>
Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
Fixes: f59dbe9ca670 ("x86/pgtable/pae: Use separate kernel PMDs for user page-table")
Link: http://lkml.kernel.org/r/20181005161333.765973-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
