Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvIRQN4uwiejggNFcNDdv87bMP8xaFjEw+dPotaO34knVlERyWdyitNaalEQUnyyANFE0P+
ARC-Seal: i=1; a=rsa-sha256; t=1521463289; cv=none;
        d=google.com; s=arc-20160816;
        b=U1KX8iA0Jl0Gq+MbEp2oq52GcqPmarx0GVSU7Yy9bPOMMgpJxtxSYbuJ2dkwMgGKQK
         9EQwy0Zq0Av0kFbwCyrHeOeSBVUFJWG7aaAdLzGLrvO3YpWE8n9uxXIWFJw6o99oSCcy
         /x0pc1T/gRnxSFBJruMWBgNm+7Eih46IoZYtl6ITRCgXrN2RKIfSEnoxqvtNpptCJsig
         S8pjmVfG9APnbgL7BMI8OO1bHocYY92oMS63ynfPajfRQORHN1b1LWrKifEG5QGzKJ3l
         hVQHq9IzeoQL1FEPvCCgxOQmXzwsKjGSpbSd+FSuO/aIbwZnUkEikSkSCnjaPpJ2FXHQ
         P1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RUyRu+BmX3uuUIhAP/3YMJ5uvgcG7dJi8mXraNrl3kg=;
        b=WPbbv/KHfpZ4LMqBRPG7dMaLz6zUr3oB3gatWUN9SHXt+Obb92bvj+lqMD/u0sdteA
         y6cIctCwN2Ptt6Fpd5GwF5XnSGA13xX3WbAe4o5CxMKuMR+q6P5BOX9SdNWRuFse6CUg
         o4YKOZLW+5Q9AxBVYA2Zx7b67dOajwUcVpfii7kEWUo2Op8fIRLqhgEqbQKjMBc519io
         g1LiOnZsf3u1viS57SqJJ71TP5fIvBeFLNgUMjn4017JWuazTOc7PMrVh7DKYi3vmsvo
         eBLuraWfp6CQJjN6Cr0rxC87GOF3ZMyrJBXl/AgB2djOO00pD/md5qOM+ZnxvIw9BFKH
         L+Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ob0hQ4zd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MrMXWP7R;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ob0hQ4zd;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MrMXWP7R;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C847B60C67
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
Subject: [PATCH v3 2/3] arm64: Implement page table free interfaces
Date: Mon, 19 Mar 2018 18:10:55 +0530
Message-Id: <1521463256-19858-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595369889153070930?=
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
 arch/arm64/mm/mmu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index da98828..c70f139 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/tlbflush.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -975,10 +976,35 @@ int pmd_clear_huge(pmd_t *pmdp)
 
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	pmd = __va(pud_val(*pud));
+	if (pud_val(*pud)) {
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE));
+
+		free_page((unsigned long) pmd);
+		pud_clear(pud);
+		flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+	}
+	return 1;
 }
 
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
-	return pmd_none(*pmd);
+	if (pmd_val(*pmd)) {
+		free_page((unsigned long)__va(pmd_val(*pmd)));
+
+		pmd_clear(pmd);
+		/*
+		 * FIXME: __flush_tlb_pgtable(&init_mm, addr) is
+		 *        ideal candidate here, which exactly
+		 *        flushes intermediate pgtables. But,
+		 *        this is broken (evident from tests).
+		 *        So, use safe TLB op unless that is fixed.
+		 */
+		flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	}
+	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
