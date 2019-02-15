Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29E2222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfBORDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:03:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbfBORDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:03:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C4B1682;
        Fri, 15 Feb 2019 09:03:41 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 521F63F557;
        Fri, 15 Feb 2019 09:03:38 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] x86/mm: Convert ptdump_walk_pgd_level_debugfs() to take an mm_struct
Date:   Fri, 15 Feb 2019 17:02:32 +0000
Message-Id: <20190215170235.23360-12-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215170235.23360-1-steven.price@arm.com>
References: <20190215170235.23360-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable x86 to use the generic walk_page_range() function, the
callers of ptdump_walk_pgd_level_debugfs() need to pass in the mm_struct.

This means that ptdump_walk_pgd_level_core() is now always passed a
valid pgd, so drop the support for pgd==NULL.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/include/asm/pgtable.h |  3 ++-
 arch/x86/mm/debug_pagetables.c |  8 ++++----
 arch/x86/mm/dump_pagetables.c  | 14 ++++++--------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 371901283d5f..ab2aa3eb05e9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -28,7 +28,8 @@ extern pgd_t early_top_pgt[PTRS_PER_PGD];
 int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
 
 void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm);
-void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user);
+void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
+				   bool user);
 void ptdump_walk_pgd_level_checkwx(void);
 void ptdump_walk_user_pgd_level_checkwx(void);
 
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index cd84f067e41d..824131052574 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -6,7 +6,7 @@
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
-	ptdump_walk_pgd_level_debugfs(m, NULL, false);
+	ptdump_walk_pgd_level_debugfs(m, &init_mm, false);
 	return 0;
 }
 
@@ -16,7 +16,7 @@ static int ptdump_curknl_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
-		ptdump_walk_pgd_level_debugfs(m, current->mm->pgd, false);
+		ptdump_walk_pgd_level_debugfs(m, current->mm, false);
 		up_read(&current->mm->mmap_sem);
 	}
 	return 0;
@@ -31,7 +31,7 @@ static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd) {
 		down_read(&current->mm->mmap_sem);
-		ptdump_walk_pgd_level_debugfs(m, current->mm->pgd, true);
+		ptdump_walk_pgd_level_debugfs(m, current->mm, true);
 		up_read(&current->mm->mmap_sem);
 	}
 	return 0;
@@ -46,7 +46,7 @@ static struct dentry *pe_efi;
 static int ptdump_efi_show(struct seq_file *m, void *v)
 {
 	if (efi_mm.pgd)
-		ptdump_walk_pgd_level_debugfs(m, efi_mm.pgd, false);
+		ptdump_walk_pgd_level_debugfs(m, &efi_mm, false);
 	return 0;
 }
 
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 1a4a03e3a6bd..18fb6193311f 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -525,16 +525,12 @@ static inline bool is_hypervisor_range(int idx)
 static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 				       bool checkwx, bool dmesg)
 {
-	pgd_t *start = INIT_PGD;
+	pgd_t *start = pgd;
 	pgprotval_t prot, eff;
 	int i;
 	struct pg_state st = {};
 
-	if (pgd) {
-		start = pgd;
-		st.to_dmesg = dmesg;
-	}
-
+	st.to_dmesg = dmesg;
 	st.check_wx = checkwx;
 	st.seq = m;
 	if (checkwx)
@@ -579,8 +575,10 @@ void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm)
 	ptdump_walk_pgd_level_core(m, mm->pgd, false, true);
 }
 
-void ptdump_walk_pgd_level_debugfs(struct seq_file *m, pgd_t *pgd, bool user)
+void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
+				   bool user)
 {
+	pgd_t *pgd = mm->pgd;
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	if (user && static_cpu_has(X86_FEATURE_PTI))
 		pgd = kernel_to_user_pgdp(pgd);
@@ -606,7 +604,7 @@ void ptdump_walk_user_pgd_level_checkwx(void)
 
 void ptdump_walk_pgd_level_checkwx(void)
 {
-	ptdump_walk_pgd_level_core(NULL, NULL, true, false);
+	ptdump_walk_pgd_level_core(NULL, INIT_PGD, true, false);
 }
 
 static int __init pt_dump_init(void)
-- 
2.20.1

