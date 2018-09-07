Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6920878
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD6920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeIGUY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIGUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIuv-00056Z-5U; Fri, 07 Sep 2018 17:43:29 +0200
Message-Id: <20180907152055.166257785@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 09/10] x86/mm/cpa: Do the range check early
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Do-the-range-check-early.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid excessive 4k wise checks in the common case do a quick check first
whether the requested new page protections conflict with a static
protection area in the large page. If there is no conflict then the
decision whether to preserve or to split the page can be made immediately.

If the requested range covers the full large page, preserve it. Otherwise
split it up. No point in doing a slow crawl in 4k steps.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               560642
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  541
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:                  514
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -850,10 +850,28 @@ static int __should_split_large_page(pte
 	}
 
 	/*
-	 * Make sure that the requested pgprot does not violate the static
-	 * protections. Check the full large page whether one of the pages
-	 * in it results in a different pgprot than the first one of the
-	 * requested range. If yes, then the page needs to be split.
+	 * Optimization: Check whether the requested pgprot is conflicting
+	 * with a static protection requirement in the large page. If not,
+	 * then checking whether the requested range is fully covering the
+	 * large page can be done right here.
+	 */
+	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
+				      CPA_DETECT);
+
+	if (pgprot_val(req_prot) == pgprot_val(new_prot)) {
+		if (address != lpaddr || cpa->numpages != numpages)
+			return 1;
+		goto setlp;
+	}
+
+	/*
+	 * Slow path. The full large page check above established that the
+	 * requested pgprot cannot be applied to the full large page due to
+	 * conflicting requirements of static protection regions. It might
+	 * turn out that the whole requested range is covered by the
+	 * modified protection of the first 4k segment at @address. This
+	 * might result in the ability to preserve the large page
+	 * nevertheless.
 	 */
 	new_prot = static_protections(req_prot, address, pfn, 1, CPA_DETECT);
 	pfn = old_pfn;
@@ -878,6 +896,7 @@ static int __should_split_large_page(pte
 	if (address != lpaddr || cpa->numpages != numpages)
 		return 1;
 
+setlp:
 	/* All checks passed. Update the large page mapping. */
 	new_pte = pfn_pte(old_pfn, new_prot);
 	__set_pmd_pte(kpte, address, new_pte);


