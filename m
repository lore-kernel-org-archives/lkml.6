Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6BDC65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313820881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHgOrFbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8313820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeLCROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeLCROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hfz0kbiqhqUU+fjXjyi4KfSNJKfi4/3dH4BMrL0tMdY=; b=OHgOrFbrq5t4A9A0BjOXG5GQgh
        4Xb/T1RqfTgRbtjRL24pWiF1NgfGStZwKkNonNYPNxZKTt1o4UVuJvqbo9I1FgWTK61tttkyVcNs2
        PeRIVtqIAxGAm8ZVP67ZwriyJE40s0+nxzgRyuQ7G5k2PxTKPwfGPTHYb7mLicvs73BNbkmgeUc3F
        kF3OSlzWbnmcJRIFcJLkbMiwJbes5wVsg1S7UGOxgn32qs3TytkqBZZz2cBrKw5+IQ161g19REQzO
        8Gx0HsD/TRmmWHDFy1wVWE2It+ByggUB+q7+gRxFuNTMapMSxpd7I+WrzyQ1+uZXG37ARaQkKDikH
        APqeiwoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrni-0001H6-02; Mon, 03 Dec 2018 17:14:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 20BD22029F4C5; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.366619025@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 05/10] x86/mm/cpa: Cleanup...
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cpa->vaddr is invariant, this means we can remove all
workarounds that deal with it changing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr-test.c |    7 ++-----
 arch/x86/mm/pageattr.c      |   13 ++++---------
 2 files changed, 6 insertions(+), 14 deletions(-)

--- a/arch/x86/mm/pageattr-test.c
+++ b/arch/x86/mm/pageattr-test.c
@@ -124,7 +124,6 @@ static int pageattr_test(void)
 	unsigned int level;
 	int i, k;
 	int err;
-	unsigned long test_addr;
 
 	if (print)
 		printk(KERN_INFO "CPA self-test:\n");
@@ -181,8 +180,7 @@ static int pageattr_test(void)
 
 		switch (i % 3) {
 		case 0:
-			test_addr = addr[i];
-			err = change_page_attr_set(&test_addr, len[i], PAGE_CPA_TEST, 0);
+			err = change_page_attr_set(&addr[i], len[i], PAGE_CPA_TEST, 0);
 			break;
 
 		case 1:
@@ -226,8 +224,7 @@ static int pageattr_test(void)
 			failed++;
 			continue;
 		}
-		test_addr = addr[i];
-		err = change_page_attr_clear(&test_addr, len[i], PAGE_CPA_TEST, 0);
+		err = change_page_attr_clear(&addr[i], len[i], PAGE_CPA_TEST, 0);
 		if (err < 0) {
 			printk(KERN_ERR "CPA reverting failed: %d\n", err);
 			failed++;
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1908,15 +1908,13 @@ EXPORT_SYMBOL_GPL(set_memory_array_wt);
 int _set_memory_wc(unsigned long addr, int numpages)
 {
 	int ret;
-	unsigned long addr_copy = addr;
 
 	ret = change_page_attr_set(&addr, numpages,
 				   cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
 				   0);
 	if (!ret) {
-		ret = change_page_attr_set_clr(&addr_copy, numpages,
-					       cachemode2pgprot(
-						_PAGE_CACHE_MODE_WC),
+		ret = change_page_attr_set_clr(&addr, numpages,
+					       cachemode2pgprot(_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
 					       0, 0, NULL);
 	}
@@ -2064,7 +2062,6 @@ int set_memory_global(unsigned long addr
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
-	unsigned long start;
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
@@ -2075,8 +2072,6 @@ static int __set_memory_enc_dec(unsigned
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
 
-	start = addr;
-
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
@@ -2091,7 +2086,7 @@ static int __set_memory_enc_dec(unsigned
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush_range(start, numpages, 1);
+	cpa_flush_range(addr, numpages, 1);
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2102,7 +2097,7 @@ static int __set_memory_enc_dec(unsigned
 	 * in case TLB flushing gets optimized in the cpa_flush_range()
 	 * path use the same logic as above.
 	 */
-	cpa_flush_range(start, numpages, 0);
+	cpa_flush_range(addr, numpages, 0);
 
 	return ret;
 }


