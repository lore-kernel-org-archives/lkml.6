Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD3AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58541208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58541208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeHYR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 13:29:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:20242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeHYR36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 13:29:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2018 06:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,287,1531810800"; 
   d="scan'208";a="227609615"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2018 06:50:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EE99330105D; Sat, 25 Aug 2018 06:50:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     stable@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Date:   Sat, 25 Aug 2018 06:50:15 -0700
Message-Id: <20180825135015.33547-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Patch for stable only to fix boot resets caused by the L1TF patches.

Stable trees reverted the following patch

Revert "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"

    This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
    commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.

but the L1TF patch backported here

   x86/mm/pat: Make set_memory_np() L1TF safe

    commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream

    set_memory_np() is used to mark kernel mappings not present, but it has
    it's own open coded mechanism which does not have the L1TF protection of
    inverting the address bits.

assumed that cpa->pfn contains a PFN. With the above patch reverted
it does not, which causes the PMD to be set to an incorrect address
shifted by 12 bits, which can cause early boot reset on some
systems, like an Apollo Lake embedded system.

Convert the address to a PFN before passing it to pmd_pfn()

Thanks to Bernhard for bisecting and testing.

Cc: stable@vger.kernel.org # 4.4 and 4.9
Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Tested-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 27610c2d1821..1007fa80f5a6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1006,7 +1006,7 @@ static int populate_pmd(struct cpa_data *cpa,
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
 					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;
-- 
2.17.1

