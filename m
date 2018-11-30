Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473362082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqRAf+os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473362082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLAHAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:00:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LmMcLXi75RtPt3LEUyEbpMoGB3OpIm4WxXgI8amawoU=; b=DqRAf+osiz1QRNo53KCePCfnK
        +5tKzB7XWe2XjEgFAYT+if3Hc9RflAuAYVqXupeIdkLCsONcg4QOXtcKKe0h36Kn5zkm93ddFTDTi
        RqJmSx6kVQx21N5luwTpS58t7oRNiSb0OtoSu9zUVnYURBozjBzWqsRAzX5Dvn1dj/RhoKsxtu5IP
        1FbOwtGCq8vCt6jdQADAxEQqJvFih4i4/rOF6SmPIjBHPJxST+u5MEM/qykCAehfqAY43mKoQUlzt
        WB5xw6+Zro0RIcwd9yGplgC1hQKyckPkK4Oc2q/1BPOSGZS8HezfqC4HK0SOPwLgscJdFT45JEcku
        GVNhSElyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSont-000536-QP; Fri, 30 Nov 2018 19:50:21 +0000
Date:   Fri, 30 Nov 2018 11:50:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
Message-ID: <20181130195021.GN10377@bombadil.infradead.org>
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org>
 <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
 <20181130162435.GM10377@bombadil.infradead.org>
 <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
 <CAPcyv4gDO7sUJgE5kKe=VC5uUG36QaUrkb6tCrtnaFMkgdSYGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gDO7sUJgE5kKe=VC5uUG36QaUrkb6tCrtnaFMkgdSYGw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:01:07AM -0800, Dan Williams wrote:
> On Fri, Nov 30, 2018 at 8:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 8:24 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 07:54:49AM -0800, Dan Williams wrote:
> > > > Looks good to me, although can we make that cookie an actual type? I
> > > > think it's mostly ok to pass around (void *) for 'entry' inside of
> > > > fs/dax.c, but once an entry leaves that file I'd like it to have an
> > > > explicit type to catch people that might accidentally pass a (struct
> > > > page *) to the unlock routine.
> > >
> > > That's a really good idea.  Something like this?
> > >
> > > typedef struct {
> > >         void *v;
> > > } dax_entry_t;
> >
> > Yes, please.

Oh.  The caller needs to interpret it to see if the entry was successfully
locked, so it needs to be an integer type (or we need a comparison
function ... bleh).

> > > I could see us making good use of that within dax.c.
> 
> I'm now thinking that this is a nice improvement for 4.21. For 4.20-rc
> lets do the localized fix.

I think both patches are equally risky.  I admit this patch crosses a
file boundary, but the other patch changes dax_make_entry() which is
used by several functions which aren't part of this path, whereas this
patch only changes functions used in the path which is known to be buggy.

This patch has the advantage of getting us closer to where we want to be
sooner.


From 1135b8d08f23ab4f5b28261535a817f3de9297c9 Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 30 Nov 2018 11:05:06 -0500
Subject: [PATCH] dax: Change lock/unlock API

Return the unlock cookie from dax_lock_mapping_entry() and
pass it to dax_unlock_mapping_entry().  This fixes a bug where
dax_unlock_mapping_entry() was assuming that the page was PMD-aligned
if the entry was a PMD entry.

Debugged-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 9f32d221301c ("dax: Convert dax_lock_mapping_entry to XArray")
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/dax.c            | 21 ++++++++-------------
 include/linux/dax.h | 15 +++++++++------
 mm/memory-failure.c |  6 ++++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9bcce89ea18e..d2c04e802978 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -351,20 +351,20 @@ static struct page *dax_busy_page(void *entry)
  * @page: The page whose entry we want to lock
  *
  * Context: Process context.
- * Return: %true if the entry was locked or does not need to be locked.
+ * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the
+ * entry could not be locked.
  */
-bool dax_lock_mapping_entry(struct page *page)
+dax_entry_t dax_lock_mapping_entry(struct page *page)
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
+		entry = (void *)~0UL;
 		if (S_ISCHR(mapping->host->i_mode))
 			break;
 
@@ -400,23 +400,18 @@ bool dax_lock_mapping_entry(struct page *page)
 		break;
 	}
 	rcu_read_unlock();
-	return locked;
+	return (dax_entry_t)entry;
 }
 
-void dax_unlock_mapping_entry(struct page *page)
+void dax_unlock_mapping_entry(struct page *page, dax_entry_t entry)
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
+	dax_unlock_entry(&xas, (void *)entry);
 }
 
 /*
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 450b28db9533..f3fcdf3cb86f 100644
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
+dax_entry_t dax_lock_mapping_entry(struct page *page);
+void dax_unlock_mapping_entry(struct page *page, dax_entry_t cookie);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
@@ -122,14 +124,15 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
-static inline bool dax_lock_mapping_entry(struct page *page)
+static inline dax_entry_t dax_lock_mapping_entry(struct page *page)
 {
 	if (IS_DAX(page->mapping->host))
-		return true;
-	return false;
+		return ~0UL;
+	return 0;
 }
 
-static inline void dax_unlock_mapping_entry(struct page *page)
+static inline
+void dax_unlock_mapping_entry(struct page *page, dax_entry_t cookie)
 {
 }
 #endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0cd3de3550f0..688a406f31b3 100644
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
-- 
2.19.1

