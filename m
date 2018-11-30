Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCDD20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqn+knwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCDD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLAC6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:58:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLAC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MA2s+8gVjStmCtaou91J+A3fkOma7YbmzWeiPVmxV1s=; b=jqn+knwb1lsycPFphNXRhxoMU
        fOKlZ2yaEH5qrg6FMQ8jLw2NX4x/GzmaooHlnrPZ4heiIxlxtkSqHnD1ZY/2ebX0mnh0DZPp81zcP
        TrmitM+hIcnJlk++B++7njnBqeNhJJCsKKX1f8BPrX/rw9dWn5yehdyD339be0T78MasdNL8Y23d2
        Qt7CnN5DljlOd+TB599rqn1TlFnHvYDDW5umHbjynxwwsS8uyPqNyins569PhRKW0MYzFKbNHfuak
        Br0Yu6oraJ5wsWpR5XfnyGb3e+m1qWnxV9FoUfRVgOT6J6wdyIoEgp7eVQ44V26DLKvCE8idIbNp9
        HHjebze2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSl2M-0004ZV-IG; Fri, 30 Nov 2018 15:49:02 +0000
Date:   Fri, 30 Nov 2018 07:49:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
Message-ID: <20181130154902.GL10377@bombadil.infradead.org>
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:13:46PM -0800, Dan Williams wrote:
> Internal to dax_unlock_mapping_entry(), dax_unlock_entry() is used to
> store a replacement entry in the Xarray at the given xas-index with the
> DAX_LOCKED bit clear. When called, dax_unlock_entry() expects the unlocked
> value of the entry relative to the current Xarray state to be specified.
> 
> In most contexts dax_unlock_entry() is operating in the same scope as
> the matched dax_lock_entry(). However, in the dax_unlock_mapping_entry()
> case the implementation needs to recall the original entry. In the case
> where the original entry is a 'pmd' entry it is possible that the pfn
> performed to do the lookup is misaligned to the value retrieved in the
> Xarray.

So far, dax_unlock_mapping_entry only has the one caller.  I'd rather we
returned the 'entry' to the caller, then had them pass it back to the
unlock function.  That matches the flow in the rest of DAX and doesn't
pose an undue burden to the caller.

I plan to reclaim the DAX_LOCK bit (and the DAX_EMPTY bit for that
matter), instead using a special DAX_LOCK value.  DAX is almost free of
assumptions about the other bits in a locked entry, and this will remove
the assuption that there's a PMD bit in the entry.

How does this look?

diff --git a/fs/dax.c b/fs/dax.c
index 9bcce89ea18e..7681429af42f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -351,20 +351,20 @@ static struct page *dax_busy_page(void *entry)
  * @page: The page whose entry we want to lock
  *
  * Context: Process context.
- * Return: %true if the entry was locked or does not need to be locked.
+ * Return: A cookie to pass to dax_unlock_mapping_entry() or %NULL if the
+ * entry could not be locked.
  */
-bool dax_lock_mapping_entry(struct page *page)
+void *dax_lock_mapping_entry(struct page *page)
 {
 	XA_STATE(xas, NULL, 0);
 	void *entry;
-	bool locked;
 
 	/* Ensure page->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
 		struct address_space *mapping = READ_ONCE(page->mapping);
 
-		locked = false;
+		entry = NULL;
 		if (!dax_mapping(mapping))
 			break;
 
@@ -375,7 +375,7 @@ bool dax_lock_mapping_entry(struct page *page)
 		 * otherwise we would not have a valid pfn_to_page()
 		 * translation.
 		 */
-		locked = true;
+		entry = (void *)1;
 		if (S_ISCHR(mapping->host->i_mode))
 			break;
 
@@ -400,22 +400,17 @@ bool dax_lock_mapping_entry(struct page *page)
 		break;
 	}
 	rcu_read_unlock();
-	return locked;
+	return entry;
 }
 
-void dax_unlock_mapping_entry(struct page *page)
+void dax_unlock_mapping_entry(struct page *page, void *entry)
 {
 	struct address_space *mapping = page->mapping;
 	XA_STATE(xas, &mapping->i_pages, page->index);
-	void *entry;
 
 	if (S_ISCHR(mapping->host->i_mode))
 		return;
 
-	rcu_read_lock();
-	entry = xas_load(&xas);
-	rcu_read_unlock();
-	entry = dax_make_entry(page_to_pfn_t(page), dax_is_pmd_entry(entry));
 	dax_unlock_entry(&xas, entry);
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 450b28db9533..bc143c2d6980 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -88,8 +88,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
-bool dax_lock_mapping_entry(struct page *page);
-void dax_unlock_mapping_entry(struct page *page);
+void *dax_lock_mapping_entry(struct page *page);
+void dax_unlock_mapping_entry(struct page *page, void *entry);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
@@ -122,14 +122,14 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
-static inline bool dax_lock_mapping_entry(struct page *page)
+static inline void *dax_lock_mapping_entry(struct page *page)
 {
 	if (IS_DAX(page->mapping->host))
-		return true;
-	return false;
+		return (void *)1;
+	return NULL;
 }
 
-static inline void dax_unlock_mapping_entry(struct page *page)
+static inline void dax_unlock_mapping_entry(struct page *page, void *entry)
 {
 }
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0cd3de3550f0..3abea1e19902 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1161,6 +1161,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	LIST_HEAD(tokill);
 	int rc = -EBUSY;
 	loff_t start;
+	void *cookie;
 
 	/*
 	 * Prevent the inode from being freed while we are interrogating
@@ -1169,7 +1170,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	if (!dax_lock_mapping_entry(page))
+	cookie = dax_lock_mapping_entry(page);
+	if (!cookie)
 		goto out;
 
 	if (hwpoison_filter(page)) {
@@ -1220,7 +1222,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
 unlock:
-	dax_unlock_mapping_entry(page);
+	dax_unlock_mapping_entry(page, cookie);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);

