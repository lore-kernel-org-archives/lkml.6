Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELu8iDSwHoFLZR5avdypgzV1//9UvWvywfsEBX4tQlAYsFNzRiPcH6e/PDa5hXbLiI7jW4F4
ARC-Seal: i=1; a=rsa-sha256; t=1521117938; cv=none;
        d=google.com; s=arc-20160816;
        b=uadtpECe+c+2mZ5fDW+Ovz95Quw6TmslATlAve3Fg+21bDtLUsUhNo4WMGQib4cwXT
         RwVr8cz89tnDSXJxE8P6SanpaWAajNZyTBBSWnWFTsAXaBpWo0oPWnDQEVN6umFmp+On
         7D6LoB2eaKhxo6igPS9aAT5OmvEIg7l74iT3fn3Q3d3Glk5/4v8I4iaOFIMPtCqog2m5
         qomZdahxvUiuLJP9qK/WbLHETFCskbxw+CXnHIr7Q9YDXggJdTENVCxKEBbtGgAnKBLE
         jDLeiI1dquD87lM3ugA0gDJaL8PYBgyCUjDg5F4NSBW/hDXsJejON/DKed3CNdBkLA4J
         a6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=fw4doynvttiggochy+4egrEb0l8xGsaCoUlNpNLSyQ0=;
        b=hR2TFpxt9vdOSkynzFmW/SeDSfrJgDkFuoV3lC0DMw/lTv8aukgQboAZ5S8OHCUW3Y
         9oziVTFELPvS81qyKrdlChU84rGttFpuzL+lkQvBzLy0uc3Ep0hb07T7unoWA3q8iJKR
         NLCoaxCmc/pOjWlCwWZ4Z7l5YKsbA6HSSVvpKcNsTMEQaHEg5Lbtech8neu2jJiuOH2Y
         l6JiZX0aIpflcVVkO8cm0Nf1NLUo9T5Kmv3om2fhao5vuHwMABh0GWLA9BA41dzqAXGV
         swJTtQ3AnlYVNn5nj1dl0a92db/MdK+RczCkPBjNzYl1Yic29mhJGqMS6k4s/JGVfPiZ
         ymmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Cq/fzj12;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Veqb1xWO;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Cq/fzj12;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Veqb1xWO;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7B4B600C1
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
Subject: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Date: Thu, 15 Mar 2018 18:15:04 +0530
Message-Id: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595007763353693659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Huge mapping changes PMD/PUD which could have
valid previous entries. This requires proper
TLB maintanance on some architectures, like
ARM64.

Implent BBM (break-before-make) safe TLB
invalidation.

Here, I've used flush_tlb_pgtable() instead
of flush_kernel_range() because invalidating
intermediate page_table entries could have
been optimized for specific arch. That's the
case with ARM64 at least.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 lib/ioremap.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bba..55f8648 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
+#include <asm-generic/tlb.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static int __read_mostly ioremap_p4d_capable;
@@ -80,6 +81,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pmd_t *pmd;
+	pmd_t old_pmd;
 	unsigned long next;
 
 	phys_addr -= addr;
@@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd)) {
-			if (pmd_set_huge(pmd, phys_addr + addr, prot))
+		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
+			old_pmd = *pmd;
+			pmd_clear(pmd);
+			flush_tlb_pgtable(&init_mm, addr);
+			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
+				pmd_free_pte_page(&old_pmd);
 				continue;
+			} else
+				set_pmd(pmd, old_pmd);
 		}
 
 		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
@@ -107,6 +114,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pud_t *pud;
+	pud_t old_pud;
 	unsigned long next;
 
 	phys_addr -= addr;
@@ -118,10 +126,15 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud)) {
-			if (pud_set_huge(pud, phys_addr + addr, prot))
+		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
+			old_pud = *pud;
+			pud_clear(pud);
+			flush_tlb_pgtable(&init_mm, addr);
+			if (pud_set_huge(pud, phys_addr + addr, prot)) {
+				pud_free_pmd_page(&old_pud);
 				continue;
+			} else
+				set_pud(pud, old_pud);
 		}
 
 		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
