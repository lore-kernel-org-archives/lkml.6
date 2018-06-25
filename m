Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06724608
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE06724608
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeFYWfi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:35:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:57474 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754551AbeFYWfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:35:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 15:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,272,1526367600"; 
   d="scan'208";a="49852878"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2018 15:35:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E4A25C5; Tue, 26 Jun 2018 01:35:36 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] x86/mm: Drop unneeded __always_inline for p4d page table helpers
Date:   Tue, 26 Jun 2018 01:35:31 +0300
Message-Id: <20180625223531.73080-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commits 1ea66554d3b09ce09c42e6a871899c84a276bb39 and
046c0dbec0238c25b7526c26c9a9687664229ce2.

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
back to be __ro_after_init. See commit

  51be13351517 ("Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"")

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
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
-- 
2.18.0

