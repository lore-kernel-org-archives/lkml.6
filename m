Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF19ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E093B2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VzLrhgqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E093B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGPV3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:29:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeGPV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e8yhZudvEgmFrpG4KtT9RgDHVTSSJK4+29SNmO+tp2s=; b=VzLrhgqKpUNk7D+SP8qNjLlB8
        zGV49llf5Y1rQP9oPjVorwhFeqjSKowCP9gq8n4mwC/EAa26wxtnACWW8Kj8vETNkNQ3G38FZqAVv
        3/xINQWYV/Zm2pkT6SEZrMk5TD4tdvn0j++b7Y5lnAbP4PkEQn0mJN37gewduu/WCQTv4NLDNhpWH
        C8IOZcVsnFu/8TNrbX4teimXRt3xWvnPDT/5YsaD8QVpidXgaW4fX0a8m5jt7HB4GmNm2raE7+v7J
        6ZdqKcKIJjri6qMGMK3kynNTxDcw/QFrff7N1orv+D+2ypzppu7gicqx8CeCNkXq4+aUP9R0tVPaL
        WTR+OfYGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffAbO-0000Ls-T9; Mon, 16 Jul 2018 21:00:14 +0000
Date:   Mon, 16 Jul 2018 14:00:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>,
        vishal.l.verma@intel.com, hch@lst.de, linux-mm@kvack.org,
        jack@suse.cz, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] mm, memremap: Up-level foreach_order_pgoff()
Message-ID: <20180716210014.GA1607@bombadil.infradead.org>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153176044796.12695.10692625606054072713.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153176044796.12695.10692625606054072713.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:00:48AM -0700, Dan Williams wrote:
> The foreach_order_pgoff() helper takes advantage of the ability to
> insert multi-order entries into a radix. It is currently used by
> devm_memremap_pages() to minimize the number of entries in the pgmap
> radix. Instead of dividing a range by a constant power-of-2 sized unit
> and inserting an entry for each unit, it determines the maximum
> power-of-2 sized entry (subject to alignment offset) that can be
> inserted at each iteration.
> 
> Up-level this helper so it can be used for populating other radix
> instances. For example asynchronous-memmap-initialization-thread lookups
> arriving in a follow on change.

Hopefully by the time you're back, I'll have this code replaced with
the XArray.  Here's my proposed API:

	old = xa_store_range(xa, first, last, ptr, GFP_KERNEL);

and then you'd simply use xa_for_each() as an iterator.  You'd do one
iteration for each range in the XArray, not for each entry occupied.
So there's a difference between:

	xa_store(xa, 1, ptr, GFP_KERNEL);
	xa_store(xa, 2, ptr, GFP_KERNEL);
	xa_store(xa, 3, ptr, GFP_KERNEL);

and

	xa_store_range(xa, 1, 3, ptr, GFP_KERNEL);

	index = 0; i = 0;
	xa_for_each(xa, p, index, ULONG_MAX, XA_PRESENT)
		i++;

will return i = 3 for the first case and i = 1 for the second.
