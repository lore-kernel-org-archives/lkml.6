Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZq6tlrTroGHtzPGh68JbOj4tY6PwxUTISHqfDqa9MBW8O2ZXY+5jaiN+/CTREs5RPY3lv3p
ARC-Seal: i=1; a=rsa-sha256; t=1525074151; cv=none;
        d=google.com; s=arc-20160816;
        b=hJS929t+9Q/wMHhvtZbO6VZISd3gWvOrRHpZK6qAuVQf/8JZhbvh8M3tGLvyBLO+qn
         Rke5Ir8rm6gjskFURlAhvWVT8ohms+RZ6HRFVHzHixwIT80Ypr3bSf5JJNChpn/255p6
         hP/rZgSNgLgF2semqLUqFZbG81o8IYKhSFkjGvl3mrWPh2KgL3eelngJyanrGamfXD6G
         xZe2BtKPYTVSIbf2x/EN7RXEw/1WeETETBcDZAUeF+hqeNOpnLgCS37XikonIoCBEytb
         cGydkjEJ2Vvoee/1t6W0VeerA5wDDVa/HtnAjGqWEHvJQCnkosEtGY8Aes9/3zgLU93+
         38jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/zJNIcJfeUuQacDi4LQ10egUIeDxiQg7R+ACXjZn1tc=;
        b=dFCUZ2bqZ7EZbFIHQFttugu4BNHNwdfKZVftTZHgg7Lo6M2gmvX/2x804MxqSkKSzp
         yU6Z4vWAxL5dwky64VkR5WxFCThzmAyBEWuI1SAIHqxsK2IhguW5lW6OJGScr3O5cCrD
         PawxyE5Ts2ojzOeSUJT4v20nNwmpeWyyY0XcDFZ39FBT5VqRsMOgcFShVHYkRstG8zp4
         BiLt3GHe4awQMlohSIC9YKllE3IWlUnzRYzMn8ruivHFMarssa9ApGXx4Z/DO/OPlF1P
         ws1eXvPd9X74ViufJYUqxdqn2JgJAZXOihd7ZR8jQwJf6YBhTmN3tuF+TNqCpDpHA4rI
         nFXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kFtTpmva;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=blYnc/ty;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kFtTpmva;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=blYnc/ty;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 771F060FAA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philip Elcan <pelcan@codeaurora.org>,
	James Morse <james.morse@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 3/4] arm64: Implement page table free interfaces
Date: Mon, 30 Apr 2018 13:11:33 +0530
Message-Id: <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599156152916121293?=
X-GMAIL-MSGID: =?utf-8?q?1599156152916121293?=
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
