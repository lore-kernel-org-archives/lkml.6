Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx495jdczirxsZ/4y/ZVL6PR/SMWDQbKeOETrApAQYcFvGtRBTnS98ZiIevw3b75NSFbr3o+K
ARC-Seal: i=1; a=rsa-sha256; t=1522742539; cv=none;
        d=google.com; s=arc-20160816;
        b=099sUzWExaOtLIURYW7pYk2MQnwQXaTCxbXQLto4vmofvRfXjG1er7FBcHSUXlnmIw
         tcUABqTEfu9Q8Amh66O0hX11He/oISX2FH7cqTWU3KoLRRuPGRttJLCTQnIzMAG9SDzw
         VhYbkqgXelYSjIm7EpoFpdKA96ZB9EzyB7oe0fq3ABB0wVTPHZBu0ktiSaoP1OoWQLMo
         qktd98a+vf4bSqK4nKEhvDSVDdP5R6svTnkXKgkoH3BuhYexRg5i9+tmHwL19iZmOdH6
         0Oba9utHjp05V1te/OraHeCuJQ6puh2w5t6FJRDOUnGDpyuzZvYOJbf7YNMNmQV0K9nA
         3YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/zJNIcJfeUuQacDi4LQ10egUIeDxiQg7R+ACXjZn1tc=;
        b=VY+vWfEsSRUuqNFUatwVeE8ahkivsVr9lwIx4mVVf4MqnGFhV2KPbmdA4QaF3uC7Lb
         Zfh7YhcW5S0rKvM4IBoBb7J4X5Li12W+FVsMxLrK9jJSLvwSQN6LyCkM/j6pEmZ8W8aG
         4q9FSDSt53jYAGf9sFyHLHwvSRmSPb8Wgzxt3NVF1ECIlXs7hbjAXBGPjrHk4/kRgdB+
         FIHCoiVlcKgDEOVJcCoqocDfsDPfPn5NIs6jjO6tQk1c2PAHz6zdoJMbRWWfiu3tu2cJ
         H37FVOd/nZ9b0GMmRfPQsZdTKWfytFPbXqjZ8D5K8z7HycXEWPA5LgnYkP+zOxXOdKVY
         msEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HDmVRHr2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CQbN9WKH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HDmVRHr2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CQbN9WKH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C677060C5F
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
Subject: [PATCH v8 3/4] arm64: Implement page table free interfaces
Date: Tue,  3 Apr 2018 13:30:45 +0530
Message-Id: <1522742446-5084-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711281107259340?=
X-GMAIL-MSGID: =?utf-8?q?1596711281107259340?=
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
