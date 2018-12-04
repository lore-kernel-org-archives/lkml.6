Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073F820850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073F820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeLDVtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:49:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:23927 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDVtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:49:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96132695"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:49:51 -0800
Subject: [PATCH v3 3/5] generic/pgtable: Introduce set_pte_safe()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Dec 2018 13:37:16 -0800
Message-ID: <154395943668.32119.3354342962993305364.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Commit f77084d96355 "x86/mm/pat: Disable preemption around
__flush_tlb_all()" introduced a warning to capture cases
__flush_tlb_all() is called without pre-emption disabled. It triggers a
false positive warning in the memory hotplug path. On investigation it
was found that the __flush_tlb_all() calls are not necessary. However,
they are only "not necessary" in practice provided the ptes are being
initially populated from the !present state. Introduce set_pte_safe() as
a sanity check that the pte is being updated in a way that does not
require a tlb flush.

Forgive the macro, the availability of the various of set_pte() levels
is hit and miss across architectures.

Link: https://lkml.kernel.org/r/279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/asm-generic/pgtable.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index dae7f98babed..a9cac82e9a7a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -400,6 +400,44 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 }
 #endif
 
+/*
+ * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
+ * TLB flush will be required as a result of the "set". For example, use
+ * in scenarios where it is known ahead of time that the routine is
+ * setting non-present entries, or re-setting an existing entry to the
+ * same value. Otherwise, use the typical "set" helpers and flush the
+ * TLB.
+ */
+#define set_pte_safe(ptep, pte) \
+({ \
+	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
+	set_pte(ptep, pte); \
+})
+
+#define set_pmd_safe(pmdp, pmd) \
+({ \
+	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
+	set_pmd(pmdp, pmd); \
+})
+
+#define set_pud_safe(pudp, pud) \
+({ \
+	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
+	set_pud(pudp, pud); \
+})
+
+#define set_p4d_safe(p4dp, p4d) \
+({ \
+	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	set_p4d(p4dp, p4d); \
+})
+
+#define set_pgd_safe(pgdp, pgd) \
+({ \
+	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	set_pgd(pgdp, pgd); \
+})
+
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 /*
  * Some architectures support metadata associated with a page. When a

