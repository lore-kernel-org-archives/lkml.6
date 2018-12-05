Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBB42081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U02ON9uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBB42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLEBeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:34:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2THFkAsZkfEIPUI2E/WigtyCc/DcNRVRqfFBrlIBYvw=; b=U02ON9uMc/W+3hqtFdhGY6skr
        70vp1RicSkFSNnkPK9FkO769BUejKbothT0FIJlQCBr6jwn1f6OOE+CYBaqban3ocHFCWoT2Nzvso
        eezc5hYd84+nHIQ9us5yB5opOtk1qOmTamXayUKEt5Kxf/uz3GjN4QhBNrj8RFYDM5Vxvh+kRpSJF
        XUsZrEyL0t4gt0n17dNxdasMy7KhIOdfSQ2get42ILGpRFl9xG5KzCANORj1t7K80jCeq37SNMUiX
        nLyZ9MqKsJZ/6FZfphedo2eiHzh5cKqIAsy2RvS3h6KJrn2G/aBUuANyWYOaY/khcrVU6RlptCSS4
        C/gy/lDMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUM5N-0000yl-4O; Wed, 05 Dec 2018 01:34:45 +0000
Date:   Tue, 4 Dec 2018 17:34:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
Message-ID: <20181205013444.GX10377@bombadil.infradead.org>
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org>
 <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
 <20181130162435.GM10377@bombadil.infradead.org>
 <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
 <CAPcyv4gDO7sUJgE5kKe=VC5uUG36QaUrkb6tCrtnaFMkgdSYGw@mail.gmail.com>
 <20181130195021.GN10377@bombadil.infradead.org>
 <CAPcyv4iqA84WbE8pE=Yi15Q0T8JUXnPZss27HqhQTP08F9sTrQ@mail.gmail.com>
 <CAPcyv4jFwpsiMTwj3tzbQ4NjV_XnO5-2hTqKYOaWtRCGtT=T+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jFwpsiMTwj3tzbQ4NjV_XnO5-2hTqKYOaWtRCGtT=T+g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:33:43PM -0800, Dan Williams wrote:
> On Fri, Nov 30, 2018 at 12:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > -void dax_unlock_mapping_entry(struct page *page)
> > > +void dax_unlock_mapping_entry(struct page *page, dax_entry_t entry)
> >
> > Let's not require the page to be passed back, it can be derived:
> >
> >     page = pfn_to_page(dax_to_pfn((void*) entry));
> >
> > A bit more symmetric that way and canonical with other locking schemes
> > that return a cookie.
> 
> The patch does not apply on top of the pending fixes. could resend on
> top of the current libnvdimm-fixes branch [1]?
> 
> I think because we are changing the calling convention to take return
> a locked dax_entry_t type, I feel like we should go back to the
> originally proposed names of these interfaces. I.e.
> 
>     dax_entry_t dax_lock_page(struct page *page)
> 
>     void dax_unlock_page(dax_entry_t entry)
> 
> Yes, it introduces an entry-to-pfn and pfn-to-page conversion.
> However, If I can't convince you to drop the page argument, lets at
> least do the name change. I.e. offload the responsibility of conveying
> that this is not the traditional page lock to the fact that a
> dax_entry is returned and passed back to the unlock routine.

From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 30 Nov 2018 11:05:06 -0500
Subject: [PATCH] dax: Change lock/unlock API

Return the unlock cookie from dax_lock_page() and pass it to
dax_unlock_page().  This fixes a bug where dax_unlock_page() was
assuming that the page was PMD-aligned if the entry was a PMD entry.

Debugged-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 9f32d221301c ("dax: Convert dax_lock_mapping_entry to XArray")
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
diff --git a/fs/dax.c b/fs/dax.c
index 3f592dc18d67..48132eca3761 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -379,20 +379,20 @@ static struct page *dax_busy_page(void *entry)
  * @page: The page whose entry we want to lock
  *
  * Context: Process context.
- * Return: %true if the entry was locked or does not need to be locked.
+ * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
+ * not be locked.
  */
-bool dax_lock_mapping_entry(struct page *page)
+dax_entry_t dax_lock_page(struct page *page)
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
 		if (!mapping || !dax_mapping(mapping))
 			break;
 
@@ -403,7 +403,7 @@ bool dax_lock_mapping_entry(struct page *page)
 		 * otherwise we would not have a valid pfn_to_page()
 		 * translation.
 		 */
-		locked = true;
+		entry = (void *)~0UL;
 		if (S_ISCHR(mapping->host->i_mode))
 			break;
 
@@ -426,23 +426,18 @@ bool dax_lock_mapping_entry(struct page *page)
 		break;
 	}
 	rcu_read_unlock();
-	return locked;
+	return (dax_entry_t)entry;
 }
 
-void dax_unlock_mapping_entry(struct page *page)
+void dax_unlock_page(struct page *page, dax_entry_t cookie)
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
-	dax_unlock_entry(&xas, entry);
+	dax_unlock_entry(&xas, (void *)cookie);
 }
 
 /*
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 450b28db9533..0dd316a74a29 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -7,6 +7,8 @@
 #include <linux/radix-tree.h>
 #include <asm/pgtable.h>
 
+typedef unsigned long dax_entry_t;
+
 struct iomap_ops;
 struct dax_device;
 struct dax_operations {
@@ -88,8 +90,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
-bool dax_lock_mapping_entry(struct page *page);
-void dax_unlock_mapping_entry(struct page *page);
+dax_entry_t dax_lock_page(struct page *page);
+void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
@@ -122,14 +124,14 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
-static inline bool dax_lock_mapping_entry(struct page *page)
+static inline dax_entry_t dax_lock_page(struct page *page)
 {
 	if (IS_DAX(page->mapping->host))
-		return true;
-	return false;
+		return ~0UL;
+	return 0;
 }
 
-static inline void dax_unlock_mapping_entry(struct page *page)
+static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
 }
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0cd3de3550f0..7c72f2a95785 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1161,6 +1161,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	LIST_HEAD(tokill);
 	int rc = -EBUSY;
 	loff_t start;
+	dax_entry_t cookie;
 
 	/*
 	 * Prevent the inode from being freed while we are interrogating
@@ -1169,7 +1170,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	if (!dax_lock_mapping_entry(page))
+	cookie = dax_lock_page(page);
+	if (!cookie)
 		goto out;
 
 	if (hwpoison_filter(page)) {
@@ -1220,7 +1222,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
 unlock:
-	dax_unlock_mapping_entry(page);
+	dax_unlock_page(page, cookie);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
