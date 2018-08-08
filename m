Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA51C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94979216E5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="q5BHcFZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94979216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:41:07 -0400
Received: from 8bytes.org ([81.169.241.247]:35768 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeHHNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:41:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D1E642EA; Wed,  8 Aug 2018 13:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533727310; bh=5bv0qSO6zUgvBLoIEiLfGAXfUu5gCSUL3booLj+Fs20=;
        h=From:To:Cc:Subject:Date:From;
        b=q5BHcFZGK/IQ5TP31Sl8jWfWuH1q8tutPt+RA5JVQIyviJfq6+JEIDlADJvyzovvd
         jbJRtPcGcVjyed7t3qFq1QXVedRsTXF9w05zRQ4IIbUtNpPskiBQad1JzAd8EYKNId
         wAXTib2kYvHx+VhrVIOnh3U52BfOCS1KWMz464hdPpkVJvgoytJN2hVc+RgmRQZTAo
         bMzyE6FhNOajXiGxe+NpWTVdTl9leY1ZTvb2ZIL93z360j4n/uoGdS+QgeqYhipTkr
         BidwSo6yPZdkbuqBgSi/LFZy8O3wLYUws1/9p2L/j3smvBJtvsJ2eMnua3vlCvrxWB
         CgB90afcGlc9A==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH] x86/mm/pti: Move user W+X check into pti_finalize()
Date:   Wed,  8 Aug 2018 13:16:40 +0200
Message-Id: <1533727000-9172-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The user page-table gets the updated kernel mappings in
pti_finalize(), which runs after the RO+X permissions got
applied to the kernel page-table in mark_readonly().

But with CONFIG_DEBUG_WX enabled, the user page-table is
already checked in mark_readonly() for insecure mappings.
This causes false-positive warnings, because the user
page-table did not get the updated mappings yet.

Move the W+X check for the user page-table into
pti_finalize() after it updated all required mappings.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable.h | 7 +++++--
 arch/x86/mm/dump_pagetables.c  | 3 +--
 arch/x86/mm/pti.c              | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39088cb..a1cb333 100644
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
index ccd92c4..b8ab901 100644
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
index 69a9d60..026a89a 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -628,4 +628,6 @@ void pti_finalize(void)
 	 */
 	pti_clone_entry_text();
 	pti_clone_kernel_text();
+
+	debug_checkwx_user();
 }
-- 
2.7.4

