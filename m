Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EDEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C082147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDWGyj8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C082147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIQGMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:12:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42770 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeIQGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:12:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so6707096pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lu2PgCEukDUKcyyH9ZHIymp8UVajcy/xPZG0wdOBiO0=;
        b=jDWGyj8iNCXcMMiGKO0YjmpYOb0S6vZ9a+d5bODR1dgX0fqFtKGFPttyhLZ4d0/Qaz
         W7OP/PMp06x6Mn1BrtdRYTFeOc6S+GzN6/f3SQ7BtI8O2+Yv2HkPS4uNrGVm5SO23DTU
         E/UwAKrITBz2ZoIOn+79L7KaK6weC/x0SQQzaxdJpoWeHxIEFrL3OqDyf2bzb89VhBbP
         0jaaB9yLnaZy/Fz5bc37kPhvh5fnH5Q3gdxsPRQqvbNb9cOQU4szYbmGhUi7wuo0mZVy
         ONCqOCty7FAltv3nAILdNzEjMCTGDp2RkK/HCjDk4CC0Yqv/M/uNQZcmaekjvt8z1vJ2
         +A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Lu2PgCEukDUKcyyH9ZHIymp8UVajcy/xPZG0wdOBiO0=;
        b=LNm5ZiSbAtUBSq4haOSDO1uKVpDSPiDfXCP7QOG1vvET+VPfajPVM/k5pi6U9Ei5so
         ecCOQyB0gerc/ePRxIUwOeLQ0xUCUcXj4skoJSyTpEvo6VxkmnGuJRM/X5MoneqbBzy5
         xznTinNxzYVBEgIAYZjT7OEJh+GtpyOCgdJ2oLBINpabMj2Yu8EVOY4jGyu8KtxrHOXH
         mUkicvFV0Il/4sbAxySqbeWJqcwfUBtfv+kk787Qyz6SDJAQdXwKes4tmoNc5Q/eFU5O
         D/NY5OSgn3GS77CXRV/pGoCt3K+0+LcAm5aCT7A89DTNnw7DoeHid7yxL8A+eQHtVeHG
         c/nQ==
X-Gm-Message-State: APzg51C2ULp9fXz4oMcdG2aQJhirGgei92ZA1rdBKei0Jxv/+xuYTCgp
        t93DfJ1wFrEKmZhLQRdIExs=
X-Google-Smtp-Source: ANB0Vdags2QI3tv3e6B0jaIhFkz73xyaB8eZ9Fbn71wlQyhz/f6G9ZYsmdMBbCiTOY3a/RhOM3O2Bg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr21620384pgd.326.1537145238476;
        Sun, 16 Sep 2018 17:47:18 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29311503pfi.101.2018.09.16.17.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:47:16 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        miles.chen@mediatek.com, jian-min.lui@mediatek.com,
        juju.sung@mediatek.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 3/3] arm: mm: support get_user_pages_fast
Date:   Mon, 17 Sep 2018 09:44:51 +0900
Message-Id: <20180917004451.174527-4-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
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
index 000000000000..4b9ce1f2d998
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
+		if (p4d_none(*p4dp))
+			return 0;
+		else if (!gup_pud_range(p4dp, addr, next, write, pages, nr))
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
2.19.0.397.gdd90340f6a-goog

