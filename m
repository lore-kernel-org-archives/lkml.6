Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeEWSoU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:44:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44434 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934109AbeEWSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:44:02 -0400
X-Google-Smtp-Source: AB8JxZpZ+qZrx7wkiMHWabDXp3CPD/qv8u+rzTWKsJOey5rIP0dQr21DMi0A0FefV8i+pGhj5++hcA==
From: Laura Abbott <labbott@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCHv2] arm64: Make sure permission updates happen for pmd/pud
Date: Wed, 23 May 2018 11:43:46 -0700
Message-Id: <20180523184346.487-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
disallowed block mappings for ioremap since that code does not honor
break-before-make. The same APIs are also used for permission updating
though and the extra checks prevent the permission updates from happening,
even though this should be permitted. This results in read-only permissions
not being fully applied. Visibly, this can occasionaly be seen as a failure
on the built in rodata test when the test data ends up in a section or
as an odd RW gap on the page table dump. Fix this by using
pgattr_change_is_safe instead of p*d_present for determining if the
change is permitted.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to using pgattr_change_is_safe per suggestion of Will
---
 arch/arm64/mm/mmu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..493ff75670ff 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -933,13 +933,15 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pud_present(READ_ONCE(*pudp)))
+	/* Only allow permission changes for now */
+	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
+				   pud_val(new_pud)))
 		return 0;
 
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
+	set_pud(pudp, new_pud);
 	return 1;
 }
 
@@ -947,13 +949,15 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), sect_prot);
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pmd_present(READ_ONCE(*pmdp)))
+	/* Only allow permission changes for now */
+	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
+				   pmd_val(new_pmd)))
 		return 0;
 
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+	set_pmd(pmdp, new_pmd);
 	return 1;
 }
 
-- 
2.17.0
