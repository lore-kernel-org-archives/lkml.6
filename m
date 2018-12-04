Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC84C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA60D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA60D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLDVtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:49:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:42572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDVtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:49:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="98065580"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2018 13:49:41 -0800
Subject: [PATCH v3 1/5] generic/pgtable: Make {pmd,
 pud}_same() unconditionally available
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Dec 2018 13:37:06 -0800
Message-ID: <154395942644.32119.10238934183949418128.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154395942121.32119.4039221126859656583.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154395942121.32119.4039221126859656583.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for {pmd,pud}_same() to be used outside of transparent
huge page code paths, make them unconditionally available. This enables
them to be used in the definition of a new family of
set_{pte,pmd,pud,p4d,pgd}_safe() helpers.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/asm-generic/pgtable.h |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 359fb935ded6..eea50ef8b8cd 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -375,7 +375,6 @@ static inline int pte_unused(pte_t pte)
 #endif
 
 #ifndef __HAVE_ARCH_PMD_SAME
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
 	return pmd_val(pmd_a) == pmd_val(pmd_b);
@@ -385,19 +384,6 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 {
 	return pud_val(pud_a) == pud_val(pud_b);
 }
-#else /* CONFIG_TRANSPARENT_HUGEPAGE */
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static inline int pud_same(pud_t pud_a, pud_t pud_b)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE

