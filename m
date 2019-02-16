Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D3C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD37A21B26
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="raZxWxbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfBPR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:29:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfBPR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZkqWT7moI9M+sjW3dBMSP9prhew8vS5t7Hl7+NLuMoY=; b=raZxWxbHo7wx1AjI1EvrOQcxF
        BcGzdGXtT6Vi6/mrTUYlgBoO1jbqgLLUF3S5kC4vozJY0VMmpUWR409+g75yw4zsCGdIba6IkPmGY
        VSQ+jDXCZnhJbrLCuVWVb7GtIqMkuaf4asI/1+Zq4JZEVDy1m4Nyz4U1drc5EXigh+hTarlEIqZFj
        t/NpADyx89Wv3Hb/d5qVb977/y3a6UXInpsji/C33I1Yiv0WE5mRDjB9N3+dSmbhetsgeOz9ujde8
        ZcFItCbixXxGAn9bBPumIYxz8023ssLl6UtJpZAd4DHVDdMUyvwBX/7msoBWA+OOxl6JmAF24HUY3
        JJk3+b/UQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gv3me-0008AC-SN; Sat, 16 Feb 2019 17:29:48 +0000
Date:   Sat, 16 Feb 2019 09:29:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Subject: Re: find_get_entries_tag regression bisected
Message-ID: <20190216172948.GN12668@bombadil.infradead.org>
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
 <20190216153511.GM12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216153511.GM12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 07:35:11AM -0800, Matthew Wilcox wrote:
> Another way to fix this would be to mask the address in dax_entry_mkclean(),
> but I think this is cleaner.

That's clearly rubbish, dax_entry_mkclean() can't possibly mask the
address.  It might be mis-aligned in another process.  But ... if it's
misaligned in another process, dax_entry_mkclean() will only clean the first
PTE associated with the PMD; it won't clean the whole thing.  I think we need
something like this:

(I'll have to split it apart to give us something to backport)

diff --git a/fs/dax.c b/fs/dax.c
index 6959837cc465..09680aa0481f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -768,7 +768,7 @@ unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
 
 /* Walk all mappings of a given index of a file and writeprotect them */
 static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
-		unsigned long pfn)
+		pgoff_t end, unsigned long pfn)
 {
 	struct vm_area_struct *vma;
 	pte_t pte, *ptep = NULL;
@@ -776,7 +776,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 	spinlock_t *ptl;
 
 	i_mmap_lock_read(mapping);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
 		struct mmu_notifier_range range;
 		unsigned long address;
 
@@ -843,9 +843,9 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 		struct address_space *mapping, void *entry)
 {
-	unsigned long pfn;
+	unsigned long pfn, index;
 	long ret = 0;
-	size_t size;
+	unsigned long count;
 
 	/*
 	 * A page got tagged dirty in DAX mapping? Something is seriously
@@ -894,17 +894,18 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	xas_unlock_irq(xas);
 
 	/*
-	 * Even if dax_writeback_mapping_range() was given a wbc->range_start
-	 * in the middle of a PMD, the 'index' we are given will be aligned to
-	 * the start index of the PMD, as will the pfn we pull from 'entry'.
+	 * If dax_writeback_mapping_range() was given a wbc->range_start
+	 * in the middle of a PMD, the 'index' we are given needs to be
+	 * aligned to the start index of the PMD.
 	 * This allows us to flush for PMD_SIZE and not have to worry about
 	 * partial PMD writebacks.
 	 */
 	pfn = dax_to_pfn(entry);
-	size = PAGE_SIZE << dax_entry_order(entry);
+	count = 1UL << dax_entry_order(entry);
+	index = xas->xa_index &~ (count - 1);
 
-	dax_entry_mkclean(mapping, xas->xa_index, pfn);
-	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), size);
+	dax_entry_mkclean(mapping, index, index + count - 1, pfn);
+	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
 	 * cannot be new dirty data in the pfn after the flush has completed as
@@ -917,8 +918,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
 	dax_wake_entry(xas, entry, false);
 
-	trace_dax_writeback_one(mapping->host, xas->xa_index,
-			size >> PAGE_SHIFT);
+	trace_dax_writeback_one(mapping->host, xas->xa_index, count);
 	return ret;
 
  put_unlocked:

