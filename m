Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBTK0W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:26:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBTK0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:26:19 -0500
Date: Tue, 20 Feb 2018 02:25:36 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-842cef9113c2120f74f645111ded1e020193d84c@git.kernel.org>
Cc: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de, jgross@suse.com,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        brgerst@gmail.com, JBeulich@suse.com, dvlasenk@redhat.com,
        jbeulich@suse.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        jbeulich@suse.com, torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dvlasenk@redhat.com, brgerst@gmail.com, JBeulich@suse.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@kernel.org, bp@alien8.de, tglx@linutronix.de
In-Reply-To: <5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com>
References: <5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Fix {pmd,pud}_{set,clear}_flags()
Git-Commit-ID: 842cef9113c2120f74f645111ded1e020193d84c
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

Commit-ID:  842cef9113c2120f74f645111ded1e020193d84c
Gitweb:     https://git.kernel.org/tip/842cef9113c2120f74f645111ded1e020193d84c
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 19 Feb 2018 07:48:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:39 +0100

x86/mm: Fix {pmd,pud}_{set,clear}_flags()

Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
not do any address translation. This was outright wrong under Xen
(causing a dead boot with no useful output on "suitable" systems), and
produced needlessly more complicated code (even if just slightly) when
paravirt was enabled.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable.h       |  8 ++++----
 arch/x86/include/asm/pgtable_types.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 63c2552..b444d83 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -350,14 +350,14 @@ static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t set)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
 
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
@@ -409,14 +409,14 @@ static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v | set);
+	return native_make_pud(v | set);
 }
 
 static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v & ~clear);
+	return native_make_pud(v & ~clear);
 }
 
 static inline pud_t pud_mkold(pud_t pud)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 3696398..246f15b 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -323,6 +323,11 @@ static inline pudval_t native_pud_val(pud_t pud)
 #else
 #include <asm-generic/pgtable-nopud.h>
 
+static inline pud_t native_make_pud(pudval_t val)
+{
+	return (pud_t) { .p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pudval_t native_pud_val(pud_t pud)
 {
 	return native_pgd_val(pud.p4d.pgd);
@@ -344,6 +349,11 @@ static inline pmdval_t native_pmd_val(pmd_t pmd)
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.p4d.pgd);
