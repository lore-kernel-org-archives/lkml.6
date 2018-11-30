Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A26C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C6720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="py213SAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C6720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeLABPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeLABPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EkOnlpyWymR4eBDz4Zf4LKWAUCpS+ahpknQ+lsJJUwg=; b=py213SACxxv8l3hVYJuwEIT0Bq
        NIhPBhwLKfKqsV2yDvQlwXX95lMXd1CLlOkLJVr7tAE+8eFe/NjsE3wpBf6mSr6Gopl9urkCO3CtA
        Suii9xW6tyMbbQ3NW1JLkeLpNwMqdLRXk7dp6jMTWPs90x9vOy4jVZM8Je+Xo/z4q7/Y5UE9AvDXQ
        nAE5ygZBMHlMSJHx1MfuBjBtoI27ndo0CLEB6Q6LYibKERVUwK7R4l+yMBM2veCpISc3uN9czRW9A
        PSZ2yXccs6vTFuKRSAIOhxjhEpk+bm1JKIGd7UKW6/rZ3p3kTKC13MmKgF+d0UP8HxKcyeWY34e1G
        U+cqXA2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSjQv-0003Dp-2G; Fri, 30 Nov 2018 14:06:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 614CE2029F873; Fri, 30 Nov 2018 15:06:14 +0100 (CET)
Message-Id: <20181130140337.485235040@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 14:44:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86/mm/cpa: Add __cpa_addr() helper
References: <20181130134455.490139778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-cpa-addr.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to compute the virtual address of a cpa_data is duplicated;
introduce a helper before more copies happen.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -228,6 +228,23 @@ static bool __cpa_pfn_in_highmap(unsigne
 
 #endif
 
+static unsigned long __cpa_addr(struct cpa_data *cpa, int idx)
+{
+	if (cpa->flags & CPA_PAGES_ARRAY) {
+		struct page *page = cpa->pages[idx];
+
+		if (unlikely(PageHighMem(page)))
+			return 0;
+
+		return (unsigned long)page_address(page);
+	}
+
+	if (cpa->flags & CPA_ARRAY)
+		return cpa->vaddr[idx];
+
+	return *cpa->vaddr;
+}
+
 /*
  * Flushing functions
  */
@@ -1468,15 +1485,7 @@ static int __change_page_attr(struct cpa
 	unsigned int level;
 	pte_t *kpte, old_pte;
 
-	if (cpa->flags & CPA_PAGES_ARRAY) {
-		struct page *page = cpa->pages[cpa->curpage];
-		if (unlikely(PageHighMem(page)))
-			return 0;
-		address = (unsigned long)page_address(page);
-	} else if (cpa->flags & CPA_ARRAY)
-		address = cpa->vaddr[cpa->curpage];
-	else
-		address = *cpa->vaddr;
+	address = __cpa_addr(cpa, cpa->curpage);
 repeat:
 	kpte = _lookup_address_cpa(cpa, address, &level);
 	if (!kpte)
@@ -1557,16 +1566,7 @@ static int cpa_process_alias(struct cpa_
 	 * No need to redo, when the primary call touched the direct
 	 * mapping already:
 	 */
-	if (cpa->flags & CPA_PAGES_ARRAY) {
-		struct page *page = cpa->pages[cpa->curpage];
-		if (unlikely(PageHighMem(page)))
-			return 0;
-		vaddr = (unsigned long)page_address(page);
-	} else if (cpa->flags & CPA_ARRAY)
-		vaddr = cpa->vaddr[cpa->curpage];
-	else
-		vaddr = *cpa->vaddr;
-
+	vaddr = __cpa_addr(cpa, cpa->curpage);
 	if (!(within(vaddr, PAGE_OFFSET,
 		    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
 


