Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/Z9qJmBlAspYjY/cAdnvfuClUWp6BdRm5Tan9Q9CZpNfTseLb4hNiT2m3nGF5d19Lr5w2e
ARC-Seal: i=1; a=rsa-sha256; t=1522240324; cv=none;
        d=google.com; s=arc-20160816;
        b=lqqgRzoH0rIIhK02lDbOfdQbOT/eRtLIvyw26sJbat+gou3b2sjCESU6Hi8gpr9h/i
         S9bGfaJKWQnaUA49Y460b2kngXzb083NuY+6XAgCvNzyy44lrW7slfzTvro5wUGonNFA
         1/wUMOAY5ntpoewqd7UMfSDT6QG4czStEoZSGIOGNOpSgJmm2TK3FK9p/2xBZZ2DN9SF
         Lg+TsctAkeztTk+axcQOppZlvnUToyaDrb5rXYiFzCVb6wBxKrmVlrEIP2vQCWRg2Qi9
         PddjVnNS0PM/aiQ7qz42RvuFRoJBNB5f6YYVC3Ako7kOdzWuRv86Rm/Qw1/EPNsoVFHF
         QZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/zJNIcJfeUuQacDi4LQ10egUIeDxiQg7R+ACXjZn1tc=;
        b=OarXEejVKt90NN0IVQFJd+HOYn75K1mAfPVnllKOe4i+/YwaVxLHj+25srfvK1Owu1
         ajHNDnQqx3v5vhHH6AM8uZ4ivOa6AlRIEwlANPdYBvUQfKau39eP/4eZT72SvMVbUGYm
         9ycX+Koa0rn4OOuZKB+6LCRD0zB69gLF6uFGtczi8jWBS6MlSFhsk3R4GBcL+Zhx6qv+
         jJ+NUjVHZl1Gzeg3/56PSRvB8GakJMYgk69utAJwRlVI4qtChGKosmLqRwnbhdUy8NFp
         1GhUQGvDF5MXdHlm/0J52epiBDGj7o7R6OPxY1gvcXxiQYwO7uHxgcttIm/tmH+/YKgM
         B7CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QG8HJhGo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f5S1D9Ok;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QG8HJhGo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f5S1D9Ok;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B1EE60F6B
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
Subject: [PATCH v7 3/4] arm64: Implement page table free interfaces
Date: Wed, 28 Mar 2018 18:01:21 +0530
Message-Id: <1522240282-12104-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
References: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596184670790214391?=
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
