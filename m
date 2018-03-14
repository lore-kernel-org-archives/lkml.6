Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvPAQfwLTQs7TeyuIzDq4Njam0EKvebw3OtyDY4IicSjngINtwKuNaXzxlzARxt/yGw8LNy
ARC-Seal: i=1; a=rsa-sha256; t=1521017340; cv=none;
        d=google.com; s=arc-20160816;
        b=JsDPZRMsvU6HoR5zcpGzu+j9ndQ4qHlhtke+ILmF3W5X4pp1giNoWAvyIA6XiU27f7
         0/ulcNySZfjqZ/xv1ipONE2pfM+98kOoRV2KMz9DDNYB3LaypqD6GQv91pMNS1ToDw5i
         jt/ifLoIFKamlJwkk/SpUVyzj0ySFUmsmgJ/l3zVG0kzI93nZ6op+JsUj0aPTuF0szHB
         ssINWSiopF12dZR/EGk1tpyb5Fi7sdoRBoNKrHlQo2Mfs7FUBBMflh5b6vWh62Pwd+Ds
         +eB3PVMYoKsHWPrjOkYThdUb/vjINakQa8pye0wWopoXvv1tcVk+ids0nx2qEgXCgt6C
         33NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kCn93DkU5GpFy857IVyk2awTuNJhcmWJ1MtjYBOXoIc=;
        b=eSH27QdApTBDCb4EJ2KVnO5/94x8oI8Xw2/dkmHvT/90bwY91HJnXaz2GCiL7R2zZK
         F47wYX5isB+8bJE3CoHIA2LWluMBcq7DwvybR7Mq6r7O+B6oR23wZ1aFvNnZXtPHsv+l
         6VR2GoKRCqs77Hl53S8te6JJ/gh1nJp+PcwYhy3ygx6Aj5vGpGtTT/MjJHI4Z80c22GN
         m1fJTKnEgj49Yh8hqIKUD2AYZ7FxRauQsjxDVDR1rF22UZAXQrqEiVMcA4oajIbJnrbi
         HZsgFpy9+t6j7ROSTk9Qg3Eyef7IY4Tos28I0uEAz/SwdbD6F1SRNe80tRWUnUZpwwTB
         01VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GrkOOgRa;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TeJpI14P;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GrkOOgRa;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TeJpI14P;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E059A609F3
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
Subject: [PATCH v1 3/4] arm64: Fix the page leak in pud/pmd_set_huge
Date: Wed, 14 Mar 2018 14:18:24 +0530
Message-Id: <1521017305-28518-4-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902279347636561?=
X-GMAIL-MSGID: =?utf-8?q?1594902279347636561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While setting huge page, we need to take care of
previously existing next level mapping. Since,
we are going to overrite previous mapping, the
only reference to next level page table will get
lost and the next level page table will be zombie,
occupying space forever. So, free it before
overriding.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8c704f1..c0df264 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,7 +32,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-
+#include <linux/hugetlb.h>
 #include <asm/barrier.h>
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
@@ -45,6 +45,7 @@
 #include <asm/memblock.h>
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
+#include <asm/page.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
@@ -939,6 +940,9 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 		return 0;
 
 	BUG_ON(phys & ~PUD_MASK);
+	if (pud_val(*pud) && !pud_huge(*pud))
+		free_page((unsigned long)__va(pud_val(*pud)));
+
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
@@ -953,6 +957,9 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 		return 0;
 
 	BUG_ON(phys & ~PMD_MASK);
+	if (pmd_val(*pmd) && !pmd_huge(*pmd))
+		free_page((unsigned long)__va(pmd_val(*pmd)));
+
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
