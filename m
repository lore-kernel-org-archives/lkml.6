Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B186C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0722D24B36
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="N/oKc46u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0722D24B36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeGCLwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:52:34 -0400
Received: from 8bytes.org ([81.169.241.247]:45346 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752381AbeGCLwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:52:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8D3311EE; Tue,  3 Jul 2018 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530618750; bh=aL4QCYLZka/EEWIKVhKnynNvDJG3s8xofpThig3Hjj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/oKc46uYTybv28T5H+Dk8GXNYCfXvJ9iN8dkKgozFkG2JXPuCEhsvkUMFtU4ZeSI
         tCD4zsItObmcnjIrmUavH2ceY4Qx2nA3WPmYVxtKyP2nStUJcXwpWgIniuc+CUUpnH
         EpO/oXNcU+JnBHkfAvPbeTrYboafMLfZWjKcJy7UlgjTbkNyIClRwL0+d9Yf3Xwcw6
         42a8ZeJXhZ7pHr7ZHq3fsn875VrZMeQuF1Oh576xiac+/3hUOi6Op3PA9BFJsAUYsU
         8NCrujrrtwUj5pc8ErxB4emPA+ZFKjeclK9aYalm5jYi3gNnEgpkwH9qI1gAgze2NZ
         04ZKJtidweDhw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/3] x86/pti: Move pti_init() code out of __init
Date:   Tue,  3 Jul 2018 13:52:24 +0200
Message-Id: <1530618746-23116-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530618746-23116-1-git-send-email-joro@8bytes.org>
References: <1530618746-23116-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This removes the __init annotations from pti_init() and everything it
calls on x86. The pti_init() function sets up the kernel-mappings
visible in the user-space page-table when PTI is enabled, which only
makes sense after the relevant kernel mappings have been finished.

The kernel mappings are finished when the appropriate read-only and
no-execute protections are established for the kernel text, rodata and
data sections, which happens after the init-code/data has been freed by
the kernel.

So to call pti_init() at the right place it can't be __init anymore.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/mm/pti.c                     | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 82ed001..6cd5cbf 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -340,7 +340,7 @@ int in_gate_area_no_mm(unsigned long addr)
  * vsyscalls but leave the page not present.  If so, we skip calling
  * this.
  */
-void __init set_vsyscall_pgtable_user_bits(pgd_t *root)
+void set_vsyscall_pgtable_user_bits(pgd_t *root)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4d418e7..8a80522 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -234,7 +234,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
@@ -262,7 +262,7 @@ static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 	return pte;
 }
 
-static void __init pti_setup_vsyscall(void)
+static void pti_setup_vsyscall(void)
 {
 	pte_t *pte, *target_pte;
 	unsigned int level;
@@ -279,7 +279,7 @@ static void __init pti_setup_vsyscall(void)
 	set_vsyscall_pgtable_user_bits(kernel_to_user_pgdp(swapper_pg_dir));
 }
 #else
-static void __init pti_setup_vsyscall(void) { }
+static void pti_setup_vsyscall(void) { }
 #endif
 
 static void
@@ -348,7 +348,7 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
  * Clone a single p4d (i.e. a top-level entry on 4-level systems and a
  * next-level entry on 5-level systems.
  */
-static void __init pti_clone_p4d(unsigned long addr)
+static void pti_clone_p4d(unsigned long addr)
 {
 	p4d_t *kernel_p4d, *user_p4d;
 	pgd_t *kernel_pgd;
@@ -362,7 +362,7 @@ static void __init pti_clone_p4d(unsigned long addr)
 /*
  * Clone the CPU_ENTRY_AREA into the user space visible page table.
  */
-static void __init pti_clone_user_shared(void)
+static void pti_clone_user_shared(void)
 {
 	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
 }
@@ -370,7 +370,7 @@ static void __init pti_clone_user_shared(void)
 /*
  * Clone the ESPFIX P4D into the user space visible page table
  */
-static void __init pti_setup_espfix64(void)
+static void pti_setup_espfix64(void)
 {
 #ifdef CONFIG_X86_ESPFIX64
 	pti_clone_p4d(ESPFIX_BASE_ADDR);
@@ -380,7 +380,7 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry and irqentry text and force it RO.
  */
-static void __init pti_clone_entry_text(void)
+static void pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
@@ -486,7 +486,7 @@ void pti_set_kernel_image_nonglobal(void)
 /*
  * Initialize kernel page table isolation
  */
-void __init pti_init(void)
+void pti_init(void)
 {
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4

