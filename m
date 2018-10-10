Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DA42150B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DA42150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJXqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:46:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54812 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJXqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:46:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C08C15B2;
        Wed, 10 Oct 2018 09:23:13 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E11F3F7C3;
        Wed, 10 Oct 2018 09:23:13 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E4FA01AE0964; Wed, 10 Oct 2018 17:23:12 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org,
        sean.j.christopherson@intel.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 2/5] arm64: mmu: Drop pXd_present() checks from pXd_free_pYd_table()
Date:   Wed, 10 Oct 2018 17:23:01 +0100
Message-Id: <1539188584-15819-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539188584-15819-1-git-send-email-will.deacon@arm.com>
References: <1539188584-15819-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code already has a check for pXd_none(), so remove it from the
architecture implementation.

Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8080c9f489c3..0dcb3354d6dd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -985,10 +985,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 
 	pmd = READ_ONCE(*pmdp);
 
-	if (!pmd_present(pmd))
-		return 1;
 	if (!pmd_table(pmd)) {
-		VM_WARN_ON(!pmd_table(pmd));
+		VM_WARN_ON(1);
 		return 1;
 	}
 
@@ -1008,10 +1006,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 
 	pud = READ_ONCE(*pudp);
 
-	if (!pud_present(pud))
-		return 1;
 	if (!pud_table(pud)) {
-		VM_WARN_ON(!pud_table(pud));
+		VM_WARN_ON(1);
 		return 1;
 	}
 
-- 
2.1.4

