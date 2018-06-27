Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A5AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1225394
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E1225394
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeF0JJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:09:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeF0JJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:09:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R99PEi2025936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:09:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R99OCf2025933;
        Wed, 27 Jun 2018 02:09:24 -0700
Date:   Wed, 27 Jun 2018 02:09:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-b8c1e4293a5d1dfd19ab7b0984bfce8191940500@git.kernel.org>
Cc:     peterz@infradead.org, arnd@arndb.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, arnd@arndb.de
In-Reply-To: <20180626100341.49910-1-kirill.shutemov@linux.intel.com>
References: <20180626100341.49910-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Drop unneeded __always_inline for p4d page
 table helpers
Git-Commit-ID: b8c1e4293a5d1dfd19ab7b0984bfce8191940500
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

Commit-ID:  b8c1e4293a5d1dfd19ab7b0984bfce8191940500
Gitweb:     https://git.kernel.org/tip/b8c1e4293a5d1dfd19ab7b0984bfce8191940500
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Tue, 26 Jun 2018 13:03:41 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:55:26 +0200

x86/mm: Drop unneeded __always_inline for p4d page table helpers

This reverts the following commits:

  1ea66554d3b0 ("x86/mm: Mark p4d_offset() __always_inline")
  046c0dbec023 ("x86: Mark native_set_p4d() as __always_inline")

p4d_offset(), native_set_p4d() and native_p4d_clear() were marked
__always_inline in attempt to move __pgtable_l5_enabled into __initdata
section.

It was required as KASAN initialization code is a user of
USE_EARLY_PGTABLE_L5, so all pgtable_l5_enabled() translated to
__pgtable_l5_enabled there. This includes pgtable_l5_enabled() called
from inline p4d helpers.

If compiler would decided to not inline these p4d helpers, but leave
them standalone, we end up with section mismatch.

We don't need __always_inline here anymore. __pgtable_l5_enabled moved
back to be __ro_after_init. See the following commit:

  51be13351517 ("Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"")

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180626100341.49910-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable.h    | 2 +-
 arch/x86/include/asm/pgtable_64.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 99ecde23c3ec..5715647fc4fe 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -898,7 +898,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 #define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
-static __always_inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
 	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 0fdcd21dadbd..3c5385f9a88f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -216,7 +216,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 #endif
 
-static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -230,7 +230,7 @@ static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
-static __always_inline void native_p4d_clear(p4d_t *p4d)
+static inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
 }
