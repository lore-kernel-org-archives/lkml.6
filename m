Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsDpJd54O+/yNLRkATVMh/AJCzVE+UZK5Hi7VRz0DSTgcK8NiQmwvXSXICL/LSiaky3W+75
ARC-Seal: i=1; a=rsa-sha256; t=1521546357; cv=none;
        d=google.com; s=arc-20160816;
        b=OnuUtk5jYOa+X2cajlXeeQVwz+k5RoL4hv2yiwEyd8LoDvUfDTNyDsTy/Z/N7d4h03
         o0WXCLnvZ96b1UX0f4HtA1dO8O02hPXp5ycHSRr97U5Crf5hBwYv7cjdWUF/bgkbyHMj
         dbh8rzmclA+sAfvAgX5CK3fNUJGC5Jo2du6NREBhyfPM8RoMJ6dg3/655tqEnXsQ3ATP
         tKai7n2M1J0Bb9JtzY1830GmU9OATF1sliVEmb1kqAm/wfWtwYOLBbNX+MDV8CkkmPE5
         CxTcshE2ghrfzvBSiM464KR5yKfYtMTpzGh0QXUpCayDt6GtKk8rJTb2qv5FeW7V0AQd
         Gt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=r8zMIuQf4y3pz9njVIOi4RpQLZT/v4+tAD29hM0+Yto=;
        b=pvOLDm/igf/4upynOzqdUBxYVTA8QYbCCli6mKUlK9uFjnXP9jC2StNsNyliKV1lx5
         qDzJjoRPito6zFDdgYInH52axygtk3AnOEAJGyVMptsYXbVYrUqDgDrUvg2ftGJ9H/FV
         jqo2xVV7psyi4UQ0PouTXGJbNdJte2HJQxN5IT1fg4M4LC9rTN9Bsw716aghVQx7/XFu
         djkN6U2BLPSMKplF1dlrfzesvDMegFnXLQtEblwexNuArmUSTXqXkmajgFit3hdDpUni
         TYlvZ6vt1eiExozE/C+HxYkgMjn6ZfSgMFS7NfJv4+RYKNPD76GBvD2Di/5gsMp/EUwx
         Easw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nWmriWsv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iRo0wpqH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nWmriWsv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iRo0wpqH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6AF1C610D8
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
Subject: [PATCH v4 1/3] ioremap: Update pgtable free interfaces with addr
Date: Tue, 20 Mar 2018 17:15:12 +0530
Message-Id: <1521546314-31753-2-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
References: <1521546314-31753-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369882117983930?=
X-GMAIL-MSGID: =?utf-8?q?1595456994105577449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch ("mm/vmalloc: Add interfaces to free unmapped
page table") adds following 2 interfaces to free the page
table in case we implement huge mapping.

pud_free_pmd_page() and pmd_free_pte_page()

Some architectures (like arm64) needs to do proper TLB
maintanance after updating pagetable entry even in map.
Why ? Read this,
https://patchwork.kernel.org/patch/10134581/

Pass 'addr' in these interfaces so that proper TLB ops
can be performed.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/mm/mmu.c           | 4 ++--
 arch/x86/mm/pgtable.c         | 6 ++++--
 include/asm-generic/pgtable.h | 8 ++++----
 lib/ioremap.c                 | 4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9..da98828 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -973,12 +973,12 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
 
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 34cda7e..f640ba3 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -706,11 +706,12 @@ int pmd_clear_huge(pmd_t *pmd)
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
+ * @addr: Virtual address associated with pud.
  *
  * Context: The pud range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd;
 	int i;
@@ -733,11 +734,12 @@ int pud_free_pmd_page(pud_t *pud)
 /**
  * pmd_free_pte_page - Clear pmd entry and free pte page.
  * @pmd: Pointer to a PMD.
+ * @addr: Virtual address associated with pmd.
  *
  * Context: The pmd range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index bfbb44a..e6310f4 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -983,8 +983,8 @@ static inline int p4d_clear_huge(p4d_t *p4d)
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-int pud_free_pmd_page(pud_t *pud);
-int pmd_free_pte_page(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud, unsigned long addr);
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1010,11 +1010,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
-static inline int pud_free_pmd_page(pud_t *pud)
+static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
 }
-static inline int pmd_free_pte_page(pmd_t *pmd)
+static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return 0;
 }
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bba..517f585 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -92,7 +92,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd)) {
+		    pmd_free_pte_page(pmd, addr)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -119,7 +119,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud)) {
+		    pud_free_pmd_page(pud, addr)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
