Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB988C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836D721536
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836D721536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHZKZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:25:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHZKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:25:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73BEA949;
        Sun, 26 Aug 2018 06:44:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, Andi Kleen" <ak@linux.intel.com>,
        Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4.4 1/5] x86/mm/pat: Fix L1TF stable backport for CPA
Date:   Sun, 26 Aug 2018 08:42:53 +0200
Message-Id: <20180826064103.168679506@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064102.584749876@linuxfoundation.org>
References: <20180826064102.584749876@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pageattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1006,7 +1006,7 @@ static int populate_pmd(struct cpa_data
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
 					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;


