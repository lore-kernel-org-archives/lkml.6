Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CB6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0BA22450
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0BA22450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHJVtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:49:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:49:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7AJG5Mh2562261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Aug 2018 12:16:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7AJG3Fd2562257;
        Fri, 10 Aug 2018 12:16:03 -0700
Date:   Fri, 10 Aug 2018 12:16:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-d878efce73fe86db34ddb2013260adf571a701a7@git.kernel.org>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jroedel@suse.de, peterz@infradead.org,
        pavel@ucw.cz, gregkh@linuxfoundation.org, bp@alien8.de,
        eduval@amazon.com, llong@redhat.com, torvalds@linux-foundation.org,
        dhgutteridge@sympatico.ca, brgerst@gmail.com, hpa@zytor.com,
        tglx@linutronix.de, dvlasenk@redhat.com, jkosina@suse.cz,
        will.deacon@arm.com, luto@kernel.org, jgross@suse.com,
        dave.hansen@intel.com, David.Laight@aculab.com,
        aarcange@redhat.com, boris.ostrovsky@oracle.com
Reply-To: jroedel@suse.de, peterz@infradead.org, pavel@ucw.cz,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          dhgutteridge@sympatico.ca, brgerst@gmail.com, hpa@zytor.com,
          eduval@amazon.com, gregkh@linuxfoundation.org, bp@alien8.de,
          llong@redhat.com, jkosina@suse.cz, will.deacon@arm.com,
          tglx@linutronix.de, dvlasenk@redhat.com, aarcange@redhat.com,
          David.Laight@aculab.com, boris.ostrovsky@oracle.com,
          luto@kernel.org, dave.hansen@intel.com, jgross@suse.com
In-Reply-To: <1533727000-9172-1-git-send-email-joro@8bytes.org>
References: <1533727000-9172-1-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Move user W+X check into pti_finalize()
Git-Commit-ID: d878efce73fe86db34ddb2013260adf571a701a7
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

Commit-ID:  d878efce73fe86db34ddb2013260adf571a701a7
Gitweb:     https://git.kernel.org/tip/d878efce73fe86db34ddb2013260adf571a701a7
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 8 Aug 2018 13:16:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 10 Aug 2018 21:12:45 +0200

x86/mm/pti: Move user W+X check into pti_finalize()

The user page-table gets the updated kernel mappings in pti_finalize(),
which runs after the RO+X permissions got applied to the kernel page-table
in mark_readonly().

But with CONFIG_DEBUG_WX enabled, the user page-table is already checked in
mark_readonly() for insecure mappings.  This causes false-positive
warnings, because the user page-table did not get the updated mappings yet.

Move the W+X check for the user page-table into pti_finalize() after it
updated all required mappings.

[ tglx: Folded !NX supported fix ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1533727000-9172-1-git-send-email-joro@8bytes.org
---
 arch/x86/include/asm/pgtable.h | 7 +++++--
 arch/x86/mm/dump_pagetables.c  | 6 +++---
 arch/x86/mm/pti.c              | 2 ++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39088cb59ab..a1cb3339da8d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -30,11 +30,14 @@ int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
 void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd);
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user);
 void ptdump_walk_pgd_level_checkwx(void);
+void ptdump_walk_user_pgd_level_checkwx(void);
 
 #ifdef CONFIG_DEBUG_WX
-#define debug_checkwx() ptdump_walk_pgd_level_checkwx()
+#define debug_checkwx()		ptdump_walk_pgd_level_checkwx()
+#define debug_checkwx_user()	ptdump_walk_user_pgd_level_checkwx()
 #else
-#define debug_checkwx() do { } while (0)
+#define debug_checkwx()		do { } while (0)
+#define debug_checkwx_user()	do { } while (0)
 #endif
 
 /*
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index ccd92c4da57c..a12afff146d1 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -569,12 +569,13 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
 }
 EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 
-static void ptdump_walk_user_pgd_level_checkwx(void)
+void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	pgd_t *pgd = INIT_PGD;
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!(__supported_pte_mask & _PAGE_NX) ||
+	    !static_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	pr_info("x86/mm: Checking user space page tables\n");
@@ -586,7 +587,6 @@ static void ptdump_walk_user_pgd_level_checkwx(void)
 void ptdump_walk_pgd_level_checkwx(void)
 {
 	ptdump_walk_pgd_level_core(NULL, NULL, true, false);
-	ptdump_walk_user_pgd_level_checkwx();
 }
 
 static int __init pt_dump_init(void)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1dc5c683e7a5..d58b4aba9510 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -646,4 +646,6 @@ void pti_finalize(void)
 	 */
 	pti_clone_entry_text();
 	pti_clone_kernel_text();
+
+	debug_checkwx_user();
 }
