Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeE3L3J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60919 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752247AbeE3LHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:05 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jan Beulich" <JBeulich@suse.com>, "Juergen Gross" <jgross@suse.com>,
        "Jan Beulich" <jbeulich@suse.com>, "Ingo Molnar" <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Brian Gerst" <brgerst@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Denys Vlasenko" <dvlasenk@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.510978406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 101/153] x86/mm: Fix {pmd,pud}_{set,clear}_flags()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 842cef9113c2120f74f645111ded1e020193d84c upstream.

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
Link: http://lkml.kernel.org/r/5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2:
 - There aren't any pud_{set,clear}_flags() functions
 - There's no p4d level]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -254,14 +254,14 @@ static inline pmd_t pmd_set_flags(pmd_t
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
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -271,6 +271,11 @@ static inline pmdval_t native_pmd_val(pm
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.pgd);
