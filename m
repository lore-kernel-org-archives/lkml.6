Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02885C67870
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C776A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJLLay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:30:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJLLax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:30:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE81B15BF;
        Thu, 11 Oct 2018 21:00:29 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 087C03F5B7;
        Thu, 11 Oct 2018 21:00:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, steve.capper@arm.com,
        catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
Date:   Fri, 12 Oct 2018 09:29:55 +0530
Message-Id: <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures like arm64 have PUD level HugeTLB pages for certain configs
(1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
enabled for migration. It can be achieved through checking for PUD_SHIFT
order based HugeTLB pages during migration.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b68e34..9c1b77f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -483,7 +483,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 {
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 	if ((huge_page_shift(h) == PMD_SHIFT) ||
-		(huge_page_shift(h) == PGDIR_SHIFT))
+		(huge_page_shift(h) == PUD_SHIFT) ||
+			(huge_page_shift(h) == PGDIR_SHIFT))
 		return true;
 	else
 		return false;
-- 
2.7.4

