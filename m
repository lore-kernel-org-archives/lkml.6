Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C37C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8034120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDQA3WAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8034120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLCROh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeLCROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QWHfmE55FeADc9tJIqrEmwx8F0xqdqz5MH0vzHyrRjM=; b=SDQA3WAjPlLmkK+M0H+AGaFsed
        JYeZkyICF2w57TlSKThdU3l6o2z6DBQiHwL90/ar7sFAswtr0bvhIuxW81KFb1uRDn/DoOH+2vUTy
        GBwMqYPw1RyYQHAkrKqB1HYBU8G2TVNzEIU/FEncZqxlivM34MLE4zU1FUZnMI9yuVRaDNtHiUcf1
        JwOlnYvXQ76xLKWlwrzNLzqFAI5fkWTgYjVMErMczxE5PzLI98QeFv4XRikkSaW20ujpS2vhF9/x4
        F0flU2Zx8t2ZXV77elONqw9jNsQ7d0hy6yU6rYYkj4mw2Pn/aIxoqKgyKWCUkA+qaBelBkmB9NsZb
        VpnWY5EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrni-00022Y-7L; Mon, 03 Dec 2018 17:14:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 386DA2029F4CF; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203171043.695039210@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 10/10] x86/mm/cpa: Rename @addrinarray
References: <20181203170343.054618965@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPA_ARRAY interface works in single pages, and everything, except
in these 'few' locations is this variable called 'numpages'. Remove
this abberation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pageattr.c |   52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1805,14 +1805,14 @@ int set_memory_uc(unsigned long addr, in
 }
 EXPORT_SYMBOL(set_memory_uc);
 
-static int _set_memory_array(unsigned long *addr, int addrinarray,
+static int _set_memory_array(unsigned long *addr, int numpages,
 		enum page_cache_mode new_type)
 {
 	enum page_cache_mode set_type;
 	int i, j;
 	int ret;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		ret = reserve_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE,
 					new_type, NULL);
 		if (ret)
@@ -1823,11 +1823,11 @@ static int _set_memory_array(unsigned lo
 	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
 				_PAGE_CACHE_MODE_UC_MINUS : new_type;
 
-	ret = change_page_attr_set(addr, addrinarray,
+	ret = change_page_attr_set(addr, numpages,
 				   cachemode2pgprot(set_type), 1);
 
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(addr, addrinarray,
+		ret = change_page_attr_set_clr(addr, numpages,
 					       cachemode2pgprot(
 						_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
@@ -1844,21 +1844,21 @@ static int _set_memory_array(unsigned lo
 	return ret;
 }
 
-int set_memory_array_uc(unsigned long *addr, int addrinarray)
+int set_memory_array_uc(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_UC_MINUS);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_UC_MINUS);
 }
 EXPORT_SYMBOL(set_memory_array_uc);
 
-int set_memory_array_wc(unsigned long *addr, int addrinarray)
+int set_memory_array_wc(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_WC);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WC);
 }
 EXPORT_SYMBOL(set_memory_array_wc);
 
-int set_memory_array_wt(unsigned long *addr, int addrinarray)
+int set_memory_array_wt(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_WT);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WT);
 }
 EXPORT_SYMBOL_GPL(set_memory_array_wt);
 
@@ -1940,18 +1940,18 @@ int set_memory_wb(unsigned long addr, in
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-int set_memory_array_wb(unsigned long *addr, int addrinarray)
+int set_memory_array_wb(unsigned long *addr, int numpages)
 {
 	int i;
 	int ret;
 
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	ret = change_page_attr_clear(addr, addrinarray,
+	ret = change_page_attr_clear(addr, numpages,
 				      __pgprot(_PAGE_CACHE_MASK), 1);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < addrinarray; i++)
+	for (i = 0; i < numpages; i++)
 		free_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE);
 
 	return 0;
@@ -2081,7 +2081,7 @@ int set_pages_uc(struct page *page, int
 }
 EXPORT_SYMBOL(set_pages_uc);
 
-static int _set_pages_array(struct page **pages, int addrinarray,
+static int _set_pages_array(struct page **pages, int numpages,
 		enum page_cache_mode new_type)
 {
 	unsigned long start;
@@ -2091,7 +2091,7 @@ static int _set_pages_array(struct page
 	int free_idx;
 	int ret;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		if (PageHighMem(pages[i]))
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
@@ -2104,10 +2104,10 @@ static int _set_pages_array(struct page
 	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
 				_PAGE_CACHE_MODE_UC_MINUS : new_type;
 
-	ret = cpa_set_pages_array(pages, addrinarray,
+	ret = cpa_set_pages_array(pages, numpages,
 				  cachemode2pgprot(set_type));
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(NULL, addrinarray,
+		ret = change_page_attr_set_clr(NULL, numpages,
 					       cachemode2pgprot(
 						_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
@@ -2127,21 +2127,21 @@ static int _set_pages_array(struct page
 	return -EINVAL;
 }
 
-int set_pages_array_uc(struct page **pages, int addrinarray)
+int set_pages_array_uc(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_UC_MINUS);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_UC_MINUS);
 }
 EXPORT_SYMBOL(set_pages_array_uc);
 
-int set_pages_array_wc(struct page **pages, int addrinarray)
+int set_pages_array_wc(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_WC);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WC);
 }
 EXPORT_SYMBOL(set_pages_array_wc);
 
-int set_pages_array_wt(struct page **pages, int addrinarray)
+int set_pages_array_wt(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_WT);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
 }
 EXPORT_SYMBOL_GPL(set_pages_array_wt);
 
@@ -2153,7 +2153,7 @@ int set_pages_wb(struct page *page, int
 }
 EXPORT_SYMBOL(set_pages_wb);
 
-int set_pages_array_wb(struct page **pages, int addrinarray)
+int set_pages_array_wb(struct page **pages, int numpages)
 {
 	int retval;
 	unsigned long start;
@@ -2161,12 +2161,12 @@ int set_pages_array_wb(struct page **pag
 	int i;
 
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	retval = cpa_clear_pages_array(pages, addrinarray,
+	retval = cpa_clear_pages_array(pages, numpages,
 			__pgprot(_PAGE_CACHE_MASK));
 	if (retval)
 		return retval;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		if (PageHighMem(pages[i]))
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;


