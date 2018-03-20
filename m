Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsnHnMueKeEUYHv87gRHCgzSjG0EBPt1Bt2jeE8sdbeMsk0hOCC6bnkPTMTqIdDIN2xg80+
ARC-Seal: i=1; a=rsa-sha256; t=1521546370; cv=none;
        d=google.com; s=arc-20160816;
        b=n+pW8nO/IplTCru4XQFroEtQEc83AIeoiVq5SancAbHRMm+R8gxZRDlXMRnbpuDslr
         /ydFxIe0P/Lp1hpNRg4ZbPsB2KRdxOsFxbbQT3po9np/ihhCF42DHHDYbo+buGhI40yJ
         9X8XotHTaxEpPP5qmXdZn4qTHabgE11mX0gBWo+BsbQt3QeKaQlrp2GoqBPU5oLVHMUF
         uC9v9T8ejOn4Jcblrpru5mbonn6R/Bciafcyyp4RpDMybVyTpCEeH9xEtWhl7rOLNjaN
         ANHZKIeTpgCFpoSoD8OZq83RpQqnVnEyTUh+6W3lT1OcEdpoizN5Vjf14w3unhlYQ+Nj
         CXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=82uqdUv7wwFkMPQOFmfwklyNbtxu81+6YtmkTdCB24w=;
        b=i41OPK+5eNUaPjVZON7y5jwe5dQriKq7VRdHG+4IDgKpbb/wn56yb8HmArgq8RKUIV
         VLCS+2DnwY5Jx8zBDXyOlBQ7yNT1IoumB4UCeaEvlz0lEOJu2ptBKh3wPpQf1uoRtpeH
         ZhB0PXxfPLrR5ISN+X9AaTy9OsArPER/hdGfzRSNKAd3/Ilbs/zO9u1C16qPTKrYPKos
         5NKJYibZeYubgShob+lIB9lJk97uI8QyP+rBJnxE/2a62MwHvwKJIGffAcYr8lh9gwsZ
         w/XDRz4j3RsRHh7YdG/Yo2lck3RR4pH2zrX0wRIKh1NeiBcOuNEyn3OuKGjrV91iWfsI
         Mraw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c8XztDlw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=myGrS5Rf;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c8XztDlw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=myGrS5Rf;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE2BB60F5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com
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
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 2/3] arm64: Implement page table free interfaces
Date: Tue, 20 Mar 2018 17:15:13 +0530
Message-Id: <1521546314-31753-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595457006098694593?=
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
 arch/arm64/mm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index da98828..7be3106 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -973,12 +974,47 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
+static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
+{
+	pmd_t *table;
+
+	if (pmd_val(*pmd)) {
+		table = __va(pmd_val(*pmd));
+		pmd_clear(pmd);
+		/*
+		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
+		 *        ideal candidate here, which exactly
+		 *        flushes intermediate pgtables. But,
+		 *        this is broken (evident from tests).
+		 *        So, use safe TLB op unless that is fixed.
+		 */
+		if (tlb_inv)
+			flush_tlb_kernel_range(addr, addr + PMD_SIZE);
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
