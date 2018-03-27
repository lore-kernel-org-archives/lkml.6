Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvznVAHkcD51ZO+ild514L2/QxEDCIyLV52vMIPXTknMJ4n+c7jRQEZZlRpksFhC8IJTMQR
ARC-Seal: i=1; a=rsa-sha256; t=1522157139; cv=none;
        d=google.com; s=arc-20160816;
        b=iQEa4d3wh7LOqrHniCPpMasEVdJ3apLaILUMSChBPYOaiSYFcwnMIHLclnYpdfvMEo
         AKRajl3sj5y5mPCg1izIBxeEwmNEE0wFc2KgoCqu9nOGRzCMMRqcZ/NQleZafx14pldb
         by8YaT1ebiMc5k/RtZ1fii8qjnHcqj5bq2aaumx+65QBBlDy+eNnHdm+RYo8UMWNo0nX
         0pDKVKKcQ/il/UxyIljaQhq7+GYMkBT/wK04CWOgBNz/qojeny3lw7gzKqo9B5B1kAJF
         h0TU6n6L6J7xPjvgVw4l/aqkTsZ1ylAvYi9rxRcyW/Yd+gWWxKo9SE5DhYjG4YIolCs9
         r6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=yvgadhUzE8DRiB8jLHlNc7eYLhA8HO3byMvDAHg0sdA=;
        b=mWJBM+4MpZ4bL+eWQbyOe6bBk+zz851aPPlZvyr4m2jJWFPgeAn7iv+gkLi7Kt1+83
         diA1Wax4T6JufO+4wKCK2PhWzIe8wiMC+rZWEY8HFQasgTuJ8/rZ0DDsXqz0HdesiRvF
         w/miuRjRJvER4YGAzPru0zg1zfoES4yASa3rwbTGYTCelzdb6+ajqq+6hyJXHRAImoy/
         2kwQF5LfHbfwDrUww/H9K+BbQuhQ1wyZ/Kd8E0FJhTtref4a8nDy7pgwBq+x58t3m2V4
         gClqy1QF30s2qREIiDLM8g7aLcXmMwRQjMA3xYhEKkPdOaaNZOErub20c/jEXyvE4h9V
         4QYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VUADsD56;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DvICk5QG;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VUADsD56;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DvICk5QG;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FA3160FAA
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
Subject: [PATCH v5 3/4] arm64: Implement page table free interfaces
Date: Tue, 27 Mar 2018 18:54:59 +0530
Message-Id: <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596097445014257857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement pud_free_pmd_page() and pmd_free_pte_page().

Implementation requires,
 1) Freeing of the un-used next level page tables
 2) Clearing off the current pud/pmd entry
 3) Invalidate TLB which could have previously
    valid but not stale entry

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
V4->V5:
 - Using __flush_tlb_kernel_pgtable instead of
   flush_tlb_kernel_range


 arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index da98828..3552c7a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -973,12 +974,40 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
+{
+	pmd_t *table;
+
+	if (pmd_val(*pmd)) {
+		table = __va(pmd_val(*pmd));
+		pmd_clear(pmd);
+		if (tlb_inv)
+			__flush_tlb_kernel_pgtable(addr);
+
+		free_page((unsigned long) table);
+	}
+	return 1;
+}
+
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	return pud_none(*pud);
+	pmd_t *table;
+	int i;
+
+	if (pud_val(*pud)) {
+		table = __va(pud_val(*pud));
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			__pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE),
+						false);
+
+		pud_clear(pud);
+		flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+		free_page((unsigned long) table);
+	}
+	return 1;
 }
 
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	return __pmd_free_pte_page(pmd, addr, true);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
