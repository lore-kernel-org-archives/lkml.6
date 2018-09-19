Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CFE21508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlU+u0B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CFE21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeISOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbeISOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GpRVi227yOJSRjXrDSA4guoX3Jy3ttG6AMJdtQ24lu8=; b=qlU+u0B6vaTUIHXXndaALLhTuK
        CGTCUdogVKPuWANSM8b7OeG5jhO+xzCHIAnV7io46gPPbAgmNjgtPNMjsEJQ1TiBgyvQi2M5eVzav
        qIHrsKf3OeDM/Xn2Efbtxe1/IVT9MdhCD0RgZ3vEep8HISGy/z9/8F14hbecIP4xJkDifMRJi4AHM
        6b6f/03BvtsyVjT0J1yYXAC4w+tV9OEg58NmmTtbG12W4meC8JBvGB5fiMS0VGM5kLZi0MM1FxQ+W
        va0d+vPE+yjsUbTxaLDxBosnzlhiqU3AgkMzF7ef8vVYW2J76RJO6cTpL5jtEmc0p1o8yjYCgvob0
        TDRZ2boA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLR-0000pU-6B; Wed, 19 Sep 2018 09:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A0D41202C1A3F; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085947.882287392@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 2/8] x86/mm/cpa: Move flush_tlb_all()
References: <20180919085016.164552924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an atom errata, where we do a local TLB invalidate right
before we return and then do a global TLB invalidate.

Move the global invalidate up a little bit and avoid the local
invalidate entirely.

This does put the global invalidate under pgd_lock, but that shouldn't
matter.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -996,14 +996,24 @@ __split_large_page(struct cpa_data *cpa,
 	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
 
 	/*
-	 * Intel Atom errata AAH41 workaround.
+	 * Do a global flush tlb after splitting the large page
+	 * and before we do the actual change page attribute in the PTE.
 	 *
-	 * The real fix should be in hw or in a microcode update, but
-	 * we also probabilistically try to reduce the window of having
-	 * a large TLB mixed with 4K TLBs while instruction fetches are
-	 * going on.
+	 * Without this, we violate the TLB application note, that says:
+	 * "The TLBs may contain both ordinary and large-page
+	 *  translations for a 4-KByte range of linear addresses. This
+	 *  may occur if software modifies the paging structures so that
+	 *  the page size used for the address range changes. If the two
+	 *  translations differ with respect to page frame or attributes
+	 *  (e.g., permissions), processor behavior is undefined and may
+	 *  be implementation-specific."
+	 *
+	 * We do this global tlb flush inside the cpa_lock, so that we
+	 * don't allow any other cpu, with stale tlb entries change the
+	 * page attribute in parallel, that also falls into the
+	 * just split large page entry.
 	 */
-	__flush_tlb_all();
+	flush_tlb_all();
 	spin_unlock(&pgd_lock);
 
 	return 0;
@@ -1528,28 +1538,8 @@ static int __change_page_attr(struct cpa
 	 * We have to split the large page:
 	 */
 	err = split_large_page(cpa, kpte, address);
-	if (!err) {
-		/*
-		 * Do a global flush tlb after splitting the large page
-		 * and before we do the actual change page attribute in the PTE.
-		 *
-		 * With out this, we violate the TLB application note, that says
-		 * "The TLBs may contain both ordinary and large-page
-		 *  translations for a 4-KByte range of linear addresses. This
-		 *  may occur if software modifies the paging structures so that
-		 *  the page size used for the address range changes. If the two
-		 *  translations differ with respect to page frame or attributes
-		 *  (e.g., permissions), processor behavior is undefined and may
-		 *  be implementation-specific."
-		 *
-		 * We do this global tlb flush inside the cpa_lock, so that we
-		 * don't allow any other cpu, with stale tlb entries change the
-		 * page attribute in parallel, that also falls into the
-		 * just split large page entry.
-		 */
-		flush_tlb_all();
+	if (!err)
 		goto repeat;
-	}
 
 	return err;
 }


