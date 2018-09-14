Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40751FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A792147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A792147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeINSff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:35:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50026 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbeINSfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:35:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0o1v-0006pS-4I; Fri, 14 Sep 2018 15:21:03 +0200
Message-Id: <20180914131302.283495059@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 15:09:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch V2 08/10] x86/mm/cpa: Optimize same protection check
References: <20180914130917.155416208@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Optimize-large-page-preservation-check.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the existing mapping is correct and the new requested page protections
are the same as the existing ones, then further checks can be omitted and the
large page can be preserved. The slow path 4k wise check will not come up with
a different result.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800709
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  538
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               560642
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -836,6 +836,20 @@ static int __should_split_large_page(pte
 	}
 
 	/*
+	 * Optimization: If the requested pgprot is the same as the current
+	 * pgprot, then the large page can be preserved and no updates are
+	 * required independent of alignment and length of the requested
+	 * range. The above already established that the current pgprot is
+	 * correct, which in consequence makes the requested pgprot correct
+	 * as well if it is the same. The static protection scan below will
+	 * not come to a different conclusion.
+	 */
+	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
+		cpa_inc_lp_sameprot(level);
+		return 0;
+	}
+
+	/*
 	 * Make sure that the requested pgprot does not violate the static
 	 * protections. Check the full large page whether one of the pages
 	 * in it results in a different pgprot than the first one of the


