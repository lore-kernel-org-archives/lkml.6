Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F645C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A857206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A857206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeHIVOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:14:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeHIVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:14:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w79IkULF2146770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Aug 2018 11:46:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w79IkSeQ2146765;
        Thu, 9 Aug 2018 11:46:28 -0700
Date:   Thu, 9 Aug 2018 11:46:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-a13c600e15de44ccf03df28d3311ef3cb754ed9b@git.kernel.org>
Cc:     dhgutteridge@sympatico.ca, jkosina@suse.cz, luto@kernel.org,
        mingo@kernel.org, will.deacon@arm.com, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org, llong@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        jroedel@suse.de, dave.hansen@intel.com, eduval@amazon.com,
        tglx@linutronix.de, David.Laight@aculab.com,
        torvalds@linux-foundation.org, pavel@ucw.cz,
        boris.ostrovsky@oracle.com, dvlasenk@redhat.com, bp@alien8.de,
        jgross@suse.com, aarcange@redhat.com, brgerst@gmail.com,
        hpa@zytor.com
Reply-To: gregkh@linuxfoundation.org, jpoimboe@redhat.com,
          will.deacon@arm.com, mingo@kernel.org, jkosina@suse.cz,
          luto@kernel.org, dhgutteridge@sympatico.ca,
          dave.hansen@intel.com, jroedel@suse.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, llong@redhat.com, pavel@ucw.cz,
          David.Laight@aculab.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, eduval@amazon.com, hpa@zytor.com,
          aarcange@redhat.com, brgerst@gmail.com, jgross@suse.com,
          bp@alien8.de, dvlasenk@redhat.com, boris.ostrovsky@oracle.com
In-Reply-To: <1533727000-9172-1-git-send-email-joro@8bytes.org>
References: <1533727000-9172-1-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Move user W+X check into pti_finalize()
Git-Commit-ID: a13c600e15de44ccf03df28d3311ef3cb754ed9b
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

Commit-ID:  a13c600e15de44ccf03df28d3311ef3cb754ed9b
Gitweb:     https://git.kernel.org/tip/a13c600e15de44ccf03df28d3311ef3cb754ed9b
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 8 Aug 2018 13:16:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 9 Aug 2018 20:42:07 +0200

x86/mm/pti: Move user W+X check into pti_finalize()

The user page-table gets the updated kernel mappings in pti_finalize(),
which runs after the RO+X permissions got applied to the kernel page-table
in mark_readonly().

But with CONFIG_DEBUG_WX enabled, the user page-table is already checked in
mark_readonly() for insecure mappings.  This causes false-positive
warnings, because the user page-table did not get the updated mappings yet.

Move the W+X check for the user page-table into pti_finalize() after it
updated all required mappings.

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
 arch/x86/mm/dump_pagetables.c  | 3 +--
 arch/x86/mm/pti.c              | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

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
index ccd92c4da57c..b8ab9012ffd6 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -569,7 +569,7 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
 }
 EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 
-static void ptdump_walk_user_pgd_level_checkwx(void)
+void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	pgd_t *pgd = INIT_PGD;
@@ -586,7 +586,6 @@ static void ptdump_walk_user_pgd_level_checkwx(void)
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
