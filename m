Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC8FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774F42077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774F42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeIGUY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbeIGUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIus-000560-9P; Fri, 07 Sep 2018 17:43:26 +0200
Message-Id: <20180907152054.900227342@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 06/10] x86/mm/cpa: Avoid static protection checks on unmap
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Avoid-static-protection-checks-on-unmap.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the new pgprot has the PRESENT bit cleared, then conflicts vs. RW/NX are
completely irrelevant.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800770
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800709
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -522,6 +522,13 @@ static inline pgprot_t static_protection
 	pgprotval_t forbidden, res;
 	unsigned long end;
 
+	/*
+	 * There is no point in checking RW/NX conflicts when the requested
+	 * mapping is setting the page !PRESENT.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		return prot;
+
 	/* Operate on the virtual address */
 	end = start + npg * PAGE_SIZE - 1;
 


