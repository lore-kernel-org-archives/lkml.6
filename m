Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvMCYBPDYykRoiYO9gNKrr9NCDx3TV88cVwgcJi0ynFvlfxFbn5VMTq00u/cUGvuurV1f6w
ARC-Seal: i=1; a=rsa-sha256; t=1521117951; cv=none;
        d=google.com; s=arc-20160816;
        b=gOinK0Uxl5fHTUX2xevnecQH6KAGboU2TaV5H1s0+tGwt+BDOpAt8AZhUVMxAlcFH0
         GenINlDhQEI8LmYKZqwb8wNQPlMsWMlvCb/JIDzRNg/ePomVfOrZQ8Ac+GTuS4g5YEG7
         Ttp6fX0NzqrYqUHq5McAB9dDjdsGh7jeNOdNufbsDFEwPb3B37S+7eV5X3pAw8fXo/rJ
         8/i9v0j7C4ua1ai5k/7V8gRHcO8B9jZ82254kggKvLciuG0+zKcWvhQt9W3P+O4KgzmP
         ng+WUAuf1sIDLIUarGt6ix+bk2NtACLidW+6rR0IF93a1SyPw9Tk6sRsCH436j3IQ9hb
         FN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3YwshX0zoWhp0xTSQrkM+fNVERFrg8iHu7XR6W22Zpg=;
        b=z6enFiAhgNK9xzxTh7x9yfkbk4lcLi0X29zIv9eJEkrAkVQLJFhLUnxR+Uv3bfMGGI
         BFD+k1dgBaDp1w4fsScUHv0QC3o3Cg/iwpyp4geVSXIZGzeIcd5f8yAhMRIV+1X7ToGd
         dnpdzA5bqGAjRz6FE1JQmzZOKP9KjK5ttsdC+XzToHiLWa9OWRledAESI3qVMSDI3Jn5
         jBHzEHifNpEMx9BARbyMYkCjbPU9kUhv/fSwscxpGecPPknyilAOruYM/GRK8usRPrum
         9RXienCxm4KY7vy1EIkbByJVPlWlXHGHy56ytzFPHXPO64nIZXTXEmdXkNQpV+yCFwCs
         CviQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oh9Zz6ZB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QsVxzI93;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oh9Zz6ZB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QsVxzI93;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88DFE60F71
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	arnd@arndb.de
Cc: mark.rutland@arm.com,
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
Subject: [PATCH v2 3/4] arm64: Implement page table free interfaces
Date: Thu, 15 Mar 2018 18:15:05 +0530
Message-Id: <1521117906-20107-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595007777008930452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement pud_free_pmd_page() and pmd_free_pte_page().

Make sure, that they are indeed a page table before
taking them to free.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9..6f21a65 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/hugetlb.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -45,6 +46,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/page.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -975,10 +977,24 @@ int pmd_clear_huge(pmd_t *pmdp)
 
 int pud_free_pmd_page(pud_t *pud)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	pmd = __va(pud_val(*pud));
+	if (pud_val(*pud) && !pud_huge(*pud)) {
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			pmd_free_pte_page(&pmd[i]);
+
+		free_page((unsigned long)pmd);
+	}
+
+	return 1;
 }
 
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	return pmd_none(*pmd);
+	if (pmd_val(*pmd) && !pmd_huge(*pmd))
+		free_page((unsigned long)__va(pmd_val(*pmd)));
+
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
