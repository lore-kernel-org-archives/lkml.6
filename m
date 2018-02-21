Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeBULDB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:03:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeBULDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:03:00 -0500
Date: Wed, 21 Feb 2018 02:51:21 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-92e1c5b3f7bf5407cfdbf13613e7101831216dc5@git.kernel.org>
Cc: tglx@linutronix.de, luto@amacapital.net, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, arjan@linux.intel.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, bp@alien8.de,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        bp@suse.de, jpoimboe@redhat.com, luto@kernel.org
Reply-To: hpa@zytor.com, jpoimboe@redhat.com, luto@kernel.org, bp@suse.de,
        dan.j.williams@intel.com, arjan@linux.intel.com, tglx@linutronix.de,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, bp@alien8.de,
        kirill.shutemov@linux.intel.com, torvalds@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org
In-Reply-To: <20180216114948.68868-3-kirill.shutemov@linux.intel.com>
References: <20180216114948.68868-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Redefine some of page table helpers as macros
Git-Commit-ID: 92e1c5b3f7bf5407cfdbf13613e7101831216dc5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92e1c5b3f7bf5407cfdbf13613e7101831216dc5
Gitweb:     https://git.kernel.org/tip/92e1c5b3f7bf5407cfdbf13613e7101831216dc5
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 16 Feb 2018 14:49:47 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:19:18 +0100

x86/mm: Redefine some of page table helpers as macros

This is preparation for the next patch, which would change
pgtable_l5_enabled to be cpu_feature_enabled(X86_FEATURE_LA57).

The change makes few helpers in paravirt.h dependent on
cpu_feature_enabled() definition from cpufeature.h.
And cpufeature.h is dependent on paravirt.h.

Let's re-define some of helpers as macros to break this dependency loop.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180216114948.68868-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/paravirt.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 3fbaad2..2c0c8c9 100644
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
 
