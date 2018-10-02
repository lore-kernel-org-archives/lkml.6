Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825B1C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F452064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F452064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJBS6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:58:48 -0400
Received: from foss.arm.com ([217.140.101.70]:35932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBS6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:58:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944D51596;
        Tue,  2 Oct 2018 05:15:45 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 022B53F5B7;
        Tue,  2 Oct 2018 05:15:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
Date:   Tue,  2 Oct 2018 17:45:28 +0530
Message-Id: <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
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

