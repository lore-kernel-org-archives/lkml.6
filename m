Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A30C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6792120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6792120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeILP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:29:55 -0400
Received: from foss.arm.com ([217.140.101.70]:56992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeILP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:29:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111FC1682;
        Wed, 12 Sep 2018 03:26:02 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D766F3F907;
        Wed, 12 Sep 2018 03:26:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A3E011AE33B8; Wed, 12 Sep 2018 11:26:18 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from pXd_free_pYd_table()
Date:   Wed, 12 Sep 2018 11:26:12 +0100
Message-Id: <1536747974-25875-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core code checks this for us, we don't need to do it in the
backend.

Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/mm/pgtable.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ae394552fb94..b4919c44a194 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -796,9 +796,6 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pte_t *pte;
 	int i;
 
-	if (pud_none(*pud))
-		return 1;
-
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
@@ -840,9 +837,6 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
-	if (pmd_none(*pmd))
-		return 1;
-
 	pte = (pte_t *)pmd_page_vaddr(*pmd);
 	pmd_clear(pmd);
 
-- 
2.1.4

