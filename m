Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B85C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198392192C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXMSFPb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfBPPfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:35:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f7oO+Ew2nQzeIjfdjJDynwsK7bQqUf+zmS5boXhVbO8=; b=CXMSFPb5W59BsfDrBr3RELakh
        4RjWh6iQpboQ8WSmKFNyEtXvy3Gw3gSimr28JYj5L3Jg83iX0+mThEW/qF0t9eoy6uZJZ207M9rvu
        6hyEYaC52kTboWcSc+nlDAwtxhbCnhNikJ+k1l5El/A0fw1HD/g2l8kg1wfHh9u0iODsS+mIOgg0Z
        +QioLY4eGh9ju7nLQUPz/XAR2oNgcfgr2fUALXHcpeKt7VZNsbgh+jFxkf5NFlRDQJ796x4HRu3Cy
        fuG05pt6YZ+BAkKPss9mutBgSXJgRI/3h8PPTTEdsrdBjJzcfK6MRDcL2DSq1MivK4Mxe4jwRxEEs
        n8bTWFaDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gv1zj-0001GQ-Ud; Sat, 16 Feb 2019 15:35:12 +0000
Date:   Sat, 16 Feb 2019 07:35:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Subject: Re: find_get_entries_tag regression bisected
Message-ID: <20190216153511.GM12668@bombadil.infradead.org>
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 06:08:15PM -0800, Dan Williams wrote:
> Hi Willy,
> 
> Piotr reports the following crash can be triggered on latest mainline:
> 
>  EXT4-fs (pmem5): recovery complete
>  EXT4-fs (pmem5): mounted filesystem with ordered data mode. Opts: dax
>  ------------[ cut here ]------------
>  kernel BUG at mm/pgtable-generic.c:127!
>  invalid opcode: 0000 [#1] SMP PTI
>  CPU: 28 PID: 1193 Comm: a.out Tainted: G        W  OE     4.19.0-rc5+ #2907
>  [..]
>  RIP: 0010:pmdp_huge_clear_flush+0x1e/0x80
>  [..]
>  Call Trace:
>   dax_writeback_mapping_range+0x473/0x8a0
>   ? print_shortest_lock_dependencies+0x40/0x40
>   ? jbd2_journal_stop+0xef/0x470
>   ? ext4_fill_super+0x3071/0x3110
>   ? __lock_is_held+0x4f/0x90
>   ? __lock_is_held+0x4f/0x90
>   ext4_dax_writepages+0xed/0x2f0
>   do_writepages+0x41/0xe0
>   __filemap_fdatawrite_range+0xbe/0xf0
>   file_write_and_wait_range+0x4c/0xa0
>   ext4_sync_file+0xa6/0x4f0
> 
> I bisected this regression to commit c1901cd33cf4 "page cache: Convert
> find_get_entries_tag to XArray". I suspect another case of pte vs pmd
> confusion.
> 
> Below is the small reproducer from Piotr, it triggers in a qemu
> environment with emulated pmem, but only with ext4 that I can see, but
> I did not dig too deep. Let me know if anything jumps out to you. I'll
> otherwise take a deeper look in the coming days.

I think this is another case of the XArray and radix tree iterators
having different behaviour with multi-slot entries.  The radix tree
iterator would rewind the index to the head index while the XArray
iterator leaves it static.

While the regression was introduced with the change to
find_get_entries_tag(), DAX now uses the xas_for_each_marked() iterator
directly, so changing the behaviour of find_get_entries_tag() would
be pointless.  I think the simplest way to fix this is for DAX to
set the index appropriately.  Maybe something like this?

diff --git a/fs/dax.c b/fs/dax.c
index 6959837cc465..43e3aad31885 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -843,7 +843,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 		struct address_space *mapping, void *entry)
 {
-	unsigned long pfn;
+	unsigned long pfn, index;
 	long ret = 0;
 	size_t size;
 
@@ -894,16 +894,17 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
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
 	size = PAGE_SIZE << dax_entry_order(entry);
+	index = xas->xa_index &~ ((1UL << dax_entry_order(entry)) - 1);
 
-	dax_entry_mkclean(mapping, xas->xa_index, pfn);
+	dax_entry_mkclean(mapping, index, pfn);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), size);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There


Another way to fix this would be to mask the address in dax_entry_mkclean(),
but I think this is cleaner.
