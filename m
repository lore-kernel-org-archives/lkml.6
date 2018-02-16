Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965307AbeBPLt5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:49:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:64491 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935341AbeBPLty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:49:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="204800906"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/3] x86/mm: Redefine some of page table helpers as macros
Date: Fri, 16 Feb 2018 14:49:47 +0300
Message-Id: <20180216114948.68868-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216114948.68868-1-kirill.shutemov@linux.intel.com>
References: <20180216114948.68868-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for the next patch, which would change
pgtable_l5_enabled to be cpu_feature_enabled(X86_FEATURE_LA57).

The change makes few helpers in paravirt.h dependent on
cpu_feature_enabled() definition from cpufeature.h.
And cpufeature.h is dependent on paravirt.h.

Let's re-define some of helpers as macros to break this dependency loop.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/paravirt.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 70d3c86927de..6d3b921ae43a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -567,19 +567,22 @@ static inline p4dval_t p4d_val(p4d_t p4d)
 	return PVOP_CALLEE1(p4dval_t, pv_mmu_ops.p4d_val, p4d.p4d);
 }
 
-static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
-		PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, native_pgd_val(pgd));
-	else
-		set_p4d((p4d_t *)(pgdp), (p4d_t) { pgd.pgd });
+	PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, native_pgd_val(pgd));
 }
 
-static inline void pgd_clear(pgd_t *pgdp)
-{
-	if (pgtable_l5_enabled)
-		set_pgd(pgdp, __pgd(0));
-}
+#define set_pgd(pgdp, pgdval) do {					\
+	if (pgtable_l5_enabled)						\
+		__set_pgd(pgdp, pgdval);				\
+	else								\
+		set_p4d((p4d_t *)(pgdp), (p4d_t) { (pgdval).pgd });	\
+} while (0)
+
+#define pgd_clear(pgdp) do {						\
+	if (pgtable_l5_enabled)						\
+		set_pgd(pgdp, __pgd(0));				\
+} while (0)
 
 #endif  /* CONFIG_PGTABLE_LEVELS == 5 */
 
-- 
2.15.1
