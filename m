Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E82064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E82064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJBS6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:58:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBS6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:58:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA97615B2;
        Tue,  2 Oct 2018 05:15:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C4AD3F5B7;
        Tue,  2 Oct 2018 05:15:45 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
Subject: [PATCH 2/4] mm/hugetlb: Enable arch specific huge page size support for migration
Date:   Tue,  2 Oct 2018 17:45:29 +0530
Message-Id: <1538482531-26883-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures like arm64 have HugeTLB page sizes which are different than
generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
At present these special size HugeTLB pages cannot be identified through
macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.

Enabling migration support for these special HugeTLB page sizes along with
the generic ones (PMD|PUD|PGD) would require identifying all of them on a
given platform. A platform specific hook can precisely enumerate all huge
page sizes supported for migration. Instead of comparing against standard
huge page orders let hugetlb_migration_support() function call a platform
hook arch_hugetlb_migration_support(). Default definition for the platform
hook maintains existing semantics which checks standard huge page order.
But an architecture can choose to override the default and provide support
for a comprehensive set of huge page sizes.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/hugetlb.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9c1b77f..9df1d59 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -479,18 +479,29 @@ static inline pgoff_t basepage_index(struct page *page)
 extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
-static inline bool hugepage_migration_supported(struct hstate *h)
-{
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+#ifndef arch_hugetlb_migration_supported
+static inline bool arch_hugetlb_migration_supported(struct hstate *h)
+{
 	if ((huge_page_shift(h) == PMD_SHIFT) ||
 		(huge_page_shift(h) == PUD_SHIFT) ||
 			(huge_page_shift(h) == PGDIR_SHIFT))
 		return true;
 	else
 		return false;
+}
+#endif
 #else
+static inline bool arch_hugetlb_migration_supported(struct hstate *h)
+{
 	return false;
+}
 #endif
+
+static inline bool hugepage_migration_supported(struct hstate *h)
+{
+	return arch_hugetlb_migration_supported(h);
 }
 
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
-- 
2.7.4

