Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/yYkmginlixGiz+qtIsIYnWaHtTgeAc9xkpLpY2YKDTveRPMe6p4UnaNlo44dTDKYBynZW
ARC-Seal: i=1; a=rsa-sha256; t=1522234766; cv=none;
        d=google.com; s=arc-20160816;
        b=BrB8PStkbjvLuRkVXaXF9ZZaQ4Vmf0Xa4HnoqfdtZi9keAdegg7VU//uQKAgK++T01
         MYXDTnkhyKzYbcU4PcLn2u6kF5yaDKNFmUrCZ81fb2rlXZZ0SSlJo4YvcvhVQlJX/tLt
         Nyr5V5gZGK76x/6r200od7yQhUjN+XaqGr/N45vR+AnK8FRKfm4R0AbkXxWZW1j3gBOO
         WsZGqP9blILHFuG9pP5C4OnFs0et4dvJ+qyjpKej+YQrUbAsA4YnCVjCfG/osNPSDLRy
         bLLAdDDpoQIz2X9y4h9iuBzG4l1g1ZGHVAUhqj/xoJqA1FkSrC2CsPgU/wNVliTbreIr
         oeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6bXvrwMrY4JUNp6ezaE8Flo4AeexCN8PMelvK4vasmc=;
        b=RILVidcEguy6wW1htSVtk/9Au9c2PsceEwUFhU71+wRxegKnemJMl4I9cxTlAEnxjs
         HVc0Fpw7E7DlJIAUfUXw7GdiGkIzM11kBa5c/R+O1AqoK2b/x9axYef0oh9IZ2nhfc0N
         q7EAaWWwKawdP/D4BoocQOjy9qIGnPT4iG6zia8ZuAzBZoWHwU/FTNyFgiblHTlXrJJq
         5yTleupo8Mm77hj1CwkTRAFB7CBoNr7g9li/+0btiX9OaQvqHlK6rUnGPdJibKmOcof+
         rWSAx6z4vv6jfqMaexVmiLYvUTbEctm0tPionUBqSwqVtkvYf566CTTPHKI/i51zgk85
         IYGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YxUgdFPI;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B1HjLSgH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YxUgdFPI;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=B1HjLSgH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BF1760F6E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	toshi.kani@hpe.com
Cc: arnd@arndb.de,
	ard.biesheuvel@linaro.org,
	marc.zyngier@arm.com,
	james.morse@arm.com,
	kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 1/2] arm64: Implement page table free interfaces
Date: Wed, 28 Mar 2018 16:28:50 +0530
Message-Id: <1522234731-27397-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596178842506096019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement pud_free_pmd_page() and pmd_free_pte_page().

Implementation requires,
 1) Clearing off the current pud/pmd entry
 2) Invalidate TLB which could have previously
    valid but not stale entry
 3) Freeing of the un-used next level page tables

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
>From V5->V6:
 - Removed extra bool parameter 'tlb_inv'
 - Doing pmd/pud TLB invalidation with __flush_tlb_kernel_pgtable()

 arch/arm64/mm/mmu.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index da98828..0f651db 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -973,12 +974,32 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
-	return pud_none(*pud);
+	pmd_t *table;
+
+	if (pmd_present(READ_ONCE(*pmdp))) {
+		table = __va(pmd_val(*pmdp));
+		pmd_clear(pmdp);
+		__flush_tlb_kernel_pgtable(addr);
+		free_page((unsigned long) table);
+	}
+	return 1;
 }
 
-int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	pmd_t *table;
+	int i;
+
+	if (pud_present(READ_ONCE(*pudp))) {
+		table = __va(pud_val(*pudp));
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE));
+
+		pud_clear(pudp);
+		__flush_tlb_kernel_pgtable(addr);
+		free_page((unsigned long) table);
+	}
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
