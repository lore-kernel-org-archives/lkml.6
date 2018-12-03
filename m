Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F40C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C98520881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwayiJqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C98520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeLCROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36684 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLCROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7iTU7PtDadNsIfoA4Rc1bHJ+ShsMc+3dWuH41UuEPq4=; b=dwayiJqsUO5fi3+nanAZBfUKIp
        IqPPqLWllTySj4QFZt0y1qgG/ZXo8+zgDnzzo8SwugfHCBugp2tyZ7uQqM9Ytw/fvLwr7QNPPufb4
        omPoR5Rf6D19HwYCxM79uArFHRQjwnHcJk4/y2s/jSKnWSYj7xh1MmfTUOk7CbYS2Qa+dYKkT2gm1
        Q2KE+xo9UUUcrtGRsJhMTXCteAs6MZgXZjr14HOl3ILKXgSB9G5B8eCihNvFtXVxoH09rgpr37aub
        uI/sMXMSp+hW5DYdrXVQCvviaqs7zzskKTYyDGlxenH6vB8qXPoosK6yfBNJVtcweOAU9bXTsqDDW
        SHRw03ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrng-0001H5-Ub; Mon, 03 Dec 2018 17:14:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1BD7F2029FD78; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.295174892@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 04/10] x86/mm/cpa: Make cpa_data::vaddr invariant
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __change_page_attr_set_clr() will modify cpa->vaddr when
!(CPA_ARRAY | CPA_PAGES_ARRAY), whereas in the array cases it will
increment cpa->curpage.

Change __cpa_addr() such that its @idx argument also works in the
!array case and use cpa->curpage increments for all cases.

NOTE: since cpa_data::numpages is 'unsigned long' so should cpa_data::curpage be.
NOTE: after this only cpa->numpages is still modified.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -35,11 +35,11 @@ struct cpa_data {
 	pgprot_t	mask_set;
 	pgprot_t	mask_clr;
 	unsigned long	numpages;
-	int		flags;
+	unsigned long	curpage;
 	unsigned long	pfn;
-	unsigned	force_split		: 1,
+	unsigned int	flags;
+	unsigned int	force_split		: 1,
 			force_static_prot	: 1;
-	int		curpage;
 	struct page	**pages;
 };
 
@@ -228,7 +228,7 @@ static bool __cpa_pfn_in_highmap(unsigne
 
 #endif
 
-static unsigned long __cpa_addr(struct cpa_data *cpa, int idx)
+static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
 	if (cpa->flags & CPA_PAGES_ARRAY) {
 		struct page *page = cpa->pages[idx];
@@ -242,7 +242,7 @@ static unsigned long __cpa_addr(struct c
 	if (cpa->flags & CPA_ARRAY)
 		return cpa->vaddr[idx];
 
-	return *cpa->vaddr;
+	return *cpa->vaddr + idx * PAGE_SIZE;
 }
 
 /*
@@ -1581,6 +1581,7 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa = *cpa;
 		alias_cpa.vaddr = &laddr;
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
 
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
 		if (ret)
@@ -1600,6 +1601,7 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa = *cpa;
 		alias_cpa.vaddr = &temp_cpa_vaddr;
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
+		alias_cpa.curpage = 0;
 
 		/*
 		 * The high mapping range is imprecise, so ignore the
@@ -1648,11 +1650,7 @@ static int __change_page_attr_set_clr(st
 		 */
 		BUG_ON(cpa->numpages > numpages || !cpa->numpages);
 		numpages -= cpa->numpages;
-		if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY))
-			cpa->curpage++;
-		else
-			*cpa->vaddr += cpa->numpages * PAGE_SIZE;
-
+		cpa->curpage += cpa->numpages;
 	}
 	return 0;
 }


