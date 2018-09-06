Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D472075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOIsaVYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D472075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeIFO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:57:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44995 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIFO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:57:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so4762594plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCOjJCIPjuifYDa+05zHL+WPmPDOj/NAolPV8GEjiP4=;
        b=TOIsaVYJTHzrvs7ufNK+zs1lnHPddRhNS9vMssgDAOZvHX9Qht4OlYinQLaohyH6RD
         mU56zOj/ZYEC1IQIpnrH99T4gFbXZapBet5DD5vY3ZB/YlL1bxwJgJntD6xrBZKp/mdU
         H41EoRJPm1NL3yzWkuyRVW+HXGwVAcOt5eR1/Q6h7uZpmeLQOKl7Nr/JoWQIq8KNZsh8
         b8cCqOLDwPUGep4h2RXQyIfN2DkCIS9TCkT5d2Ok6WRLN6i7kbWqP5LGOaOXw4/Akt59
         Ih6dfjq+OB0kqAWyn8O8InWGb2EkdiWfIJTsea5hyzH10O2AYQYRC155TtRMj4SlLvNp
         RLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sCOjJCIPjuifYDa+05zHL+WPmPDOj/NAolPV8GEjiP4=;
        b=YpIdW4MpvcrJrEC1zwtbo89d8YrNn6EE55IqQYEaXTb6bfofp+OiPviCQ8TiRPOOSv
         pds35F30vb7QrbzO1/KFwSqWh8YCTDhUts8QPW3oeUR0fDK01QRIkJ0GppCZiWxM7cCi
         cJbmw22N4B3rAPLNnzP6A7scGEtvBx/WUKzgO+n2TJBGVZ+sElO9TETqefF9kmWvOgzg
         UdJFKhLYXxmOMY8uWpcTUKXm7iOZ5fk52ApPUMXCRbFqric9oXpDCnq5WaACqrqhBwET
         vECsgSgZXsMpxwZD2WDj1Wy9dTlj6qjKZ882xLq11C+M0gcmSDANYmD5SmYT/GcfbPiy
         q6ag==
X-Gm-Message-State: APzg51CMMY7Xc+y+vKtZBr3yQeh35TZZuwN5anhnZI03JwLBej+qEfX2
        6NJUc1ouGaTasRhZZvjRIkY=
X-Google-Smtp-Source: ANB0Vdac3TqOVzfOTkd+mkLosV6H0nHL5sc7hGEcZLAJ54ZFX4GvaOM8fol92aWpVHkgP9/KImB+fQ==
X-Received: by 2002:a17:902:46a4:: with SMTP id p33-v6mr1947964pld.205.1536229360600;
        Thu, 06 Sep 2018 03:22:40 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7909555pfa.173.2018.09.06.03.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 03:22:39 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        android-treble-mediatek-ext@partner.android.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 3/3] arm: mm: support get_user_pages_fast
Date:   Thu,  6 Sep 2018 19:22:12 +0900
Message-Id: <20180906102212.218294-4-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
In-Reply-To: <20180906102212.218294-1-minchan@kernel.org>
References: <20180906102212.218294-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, there was a report get_user_pages_fast helps app launching
speed due to reducing uninterruptible sleep time because we don't
need to contend for mmap_sem, I believe.

With get_user_pages_fast, that uniterruptible sleep time is reduced
about 5~10% by testing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/mm/Makefile |   6 ++
 arch/arm/mm/gup.c    | 221 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/arm/mm/gup.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699fbfc4..f55f96d56843 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -13,6 +13,12 @@ obj-y				+= nommu.o
 obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o pmsa-v8.o
 endif
 
+ifneq ($(CONFIG_ARM_LPAE),y)
+ifeq ($(CONFIG_ARCH_HAS_PTE_SPECIAL),y)
+obj-$(CONFIG_MMU)		+= gup.o
+endif
+endif
+
 obj-$(CONFIG_ARM_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_ARM_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_MODULES)		+= proc-syms.o
diff --git a/arch/arm/mm/gup.c b/arch/arm/mm/gup.c
new file mode 100644
index 000000000000..44e12fb7430e
--- /dev/null
+++ b/arch/arm/mm/gup.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/pagemap.h>
+#include <asm/pgtable.h>
+
+static inline pte_t gup_get_pte(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
+static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
+			int write, struct page **pages, int *nr)
+{
+	int ret = 0;
+	pte_t *ptep, *ptem;
+
+	ptem = ptep = pte_offset_map(&pmd, addr);
+	do {
+		pte_t pte = gup_get_pte(ptep);
+		struct page *page;
+
+		if (!pte_access_permitted(pte, write))
+			goto pte_unmap;
+
+		if (pte_special(pte))
+			goto pte_unmap;
+
+		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+		page = pte_page(pte);
+
+		if (!page_cache_get_speculative(page))
+			goto pte_unmap;
+
+		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+			put_page(page);
+			goto pte_unmap;
+		}
+
+		SetPageReferenced(page);
+		pages[*nr] = page;
+		(*nr)++;
+
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+
+	ret = 1;
+
+pte_unmap:
+	pte_unmap(ptem);
+	return ret;
+}
+
+static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pmd_t *pmdp;
+
+	pmdp = pmd_offset(&pud, addr);
+	do {
+		pmd_t pmd = READ_ONCE(*pmdp);
+
+		next = pmd_addr_end(addr, end);
+		if (!pmd_present(pmd))
+			return 0;
+		else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
+			return 0;
+	} while (pmdp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_pud_range(p4d_t *p4dp, unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pud_t *pudp;
+
+	pudp = pud_offset(p4dp, addr);
+	do {
+		pud_t pud = READ_ONCE(*pudp);
+
+		next = pud_addr_end(addr, end);
+		if (pud_none(pud))
+			return 0;
+		else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+			return 0;
+	} while (pudp++, addr = next, addr != end);
+
+	return 1;
+}
+
+static int gup_p4d_range(pgd_t *pgdp, unsigned long addr, unsigned long end,
+			 int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	p4d_t *p4dp;
+
+	p4dp = p4d_offset(pgdp, addr);
+	do {
+		next = p4d_addr_end(addr, end);
+		if (p4d_none(*p4dp)) {
+			return 0;
+		} else if (!gup_pud_range(p4dp, addr, next, write, pages, nr))
+			return 0;
+	} while (p4dp++, addr = next, addr != end);
+
+	return 1;
+}
+
+
+static void gup_pgd_range(unsigned long addr, unsigned long end,
+		int write, struct page **pages, int *nr)
+{
+	unsigned long next;
+	pgd_t *pgdp;
+
+	pgdp = pgd_offset(current->mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgdp))
+			return;
+		else if (!gup_p4d_range(pgdp, addr, next, write, pages, nr))
+			break;
+	} while (pgdp++, addr = next, addr != end);
+}
+
+bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+{
+	unsigned long len, end;
+
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+	return end >= start;
+}
+
+/*
+ * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
+ * back to the regular GUP.
+ */
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
+{
+	unsigned long addr, len, end;
+	unsigned long flags;
+	int nr = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return 0;
+
+	/*
+	 * Disable interrupts.  We use the nested form as we can already have
+	 * interrupts disabled by get_futex_key.
+	 *
+	 * With interrupts disabled, we block page table pages from being
+	 * freed from under us. See mmu_gather_tlb in asm-generic/tlb.h
+	 * for more details.
+	 *
+	 * We do not adopt an rcu_read_lock(.) here as we also want to
+	 * block IPIs that come from THPs splitting.
+	 */
+
+	if (gup_fast_permitted(start, nr_pages, write)) {
+		local_irq_save(flags);
+		gup_pgd_range(addr, end, write, pages, &nr);
+		local_irq_restore(flags);
+	}
+
+	return nr;
+}
+
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			struct page **pages)
+{
+	unsigned long addr, len, end;
+	int nr = 0, ret = 0;
+
+	start &= PAGE_MASK;
+	addr = start;
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+
+	if (nr_pages <= 0)
+		return 0;
+
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return -EFAULT;
+
+	if (gup_fast_permitted(start, nr_pages, write)) {
+		local_irq_disable();
+		gup_pgd_range(addr, end, write, pages, &nr);
+		local_irq_enable();
+		ret = nr;
+	}
+
+	if (nr < nr_pages) {
+		/* Try to get the remaining pages with get_user_pages */
+		start += nr << PAGE_SHIFT;
+		pages += nr;
+
+		ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
+				write ? FOLL_WRITE : 0);
+
+		/* Have to be a bit careful with return values */
+		if (nr > 0) {
+			if (ret < 0)
+				ret = nr;
+			else
+				ret += nr;
+		}
+	}
+
+	return ret;
+}
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

