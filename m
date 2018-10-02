Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032CC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9317A205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9317A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJBS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:59:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbeJBS7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:59:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F34F71682;
        Tue,  2 Oct 2018 05:15:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28E553F5B7;
        Tue,  2 Oct 2018 05:15:53 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
Subject: [PATCH 4/4] arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages
Date:   Tue,  2 Oct 2018 17:45:31 +0530
Message-Id: <1538482531-26883-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let arm64 subscribe to the previously added framework in which architecture
can inform whether a given huge page size is supported for migration. This
just overrides the default function arch_hugetlb_migration_supported() and
enables migration for all possible HugeTLB page sizes on arm64. With this,
HugeTLB migration support on arm64 now covers all possible HugeTLB options.

        CONT PTE    PMD    CONT PMD    PUD
        --------    ---    --------    ---
4K:        64K      2M        32M      1G
16K:        2M     32M         1G
64K:        2M    512M        16G

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/hugetlb.h |  5 +++++
 arch/arm64/mm/hugetlbpage.c      | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index e73f685..656f70e 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -20,6 +20,11 @@
 
 #include <asm/page.h>
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+extern bool arch_hugetlb_migration_supported(struct hstate *h);
+#endif
+
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 4eafd9f..28f4795 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -27,6 +27,26 @@
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	size_t pagesize = huge_page_size(h);
+
+	switch (pagesize) {
+#ifdef CONFIG_ARM64_4K_PAGES
+	case PUD_SIZE:
+#endif
+	case PMD_SIZE:
+	case CONT_PMD_SIZE:
+	case CONT_PTE_SIZE:
+		return true;
+	}
+	pr_warn("%s: unrecognized huge page size 0x%lx\n",
+			__func__, pagesize);
+	return false;
+}
+#endif
+
 int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
-- 
2.7.4

