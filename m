Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCE3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2C820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fqdzu34y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfAHU0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:26:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAHU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9qrWwDgvHZseOZtK6QvP+4rrtxKPFe+trAsDEaUCEsg=; b=fqdzu34yoJI8Pg0c86pIh8Rbu
        UrHmAPMUWabCtkhnjxYc6UodlHjnSYxDvKmSyFRYfmsv3SIaKDv7ohSZR8EhTV9OLIKvo7REUiLOp
        vQIziSyixoF60aO6OLVt3i93blMeS14RUO15S+brNnqJwmWNMXg3KN/geekx+HcT2LYJV/BLD5x+k
        tuIozmb+bA3pq/wQNbUtNz6BtNa8OzXTvwkG+Ny63UOJiKnmKF4wIaZJgUwUQMrEGP66elxP5Bt1W
        k44GSDQnjDwFN/PcveXrTOF8suM+WXX8r+xZBo8cOYZQ1jF7Y6BIcawgodiTm0MYrwTx+tT7AMfdJ
        BIjw4aT/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggxxL-0000H9-SJ; Tue, 08 Jan 2019 20:26:35 +0000
Date:   Tue, 8 Jan 2019 12:26:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-ID: <20190108202635.GE6310@bombadil.infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
 <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
 <20190107223935.GC6310@bombadil.infradead.org>
 <20190107150904.09e56f51acaf417ed21f13a3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107150904.09e56f51acaf417ed21f13a3@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:09:04PM -0800, Andrew Morton wrote:
> On Mon, 7 Jan 2019 14:39:35 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Jan 07, 2019 at 02:33:19PM -0800, Andrew Morton wrote:
> > > On Mon,  7 Jan 2019 12:02:24 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > > After we establish a reference on the page, we check the pointer continues
> > > > to be in the correct position in i_pages.  There's no need to check the
> > > > page->mapping or page->index afterwards; if those can change after we've
> > > > got the reference, they can change after we return the page to the caller.
> > > 
> > > But that isn't what the comment says.
> > 
> > Right.  That patch from Nick moved the check from before taking the
> > ref to after taking the ref.  It was racy to have it before.  But it's
> > unnecessary to have it afterwards -- pages can't move once there's a
> > ref on them.  Or if they can move, they can move after the ref is taken.
> 
> So Nick's patch was never necessary?  I wonder what inspired it.

It was necessary to not check before the pin; that was clearly correct.
Checking after the pin, even with the code the way it was in 2006, was
unnecessary.  Look with a bit more context:

-               if (page->mapping == NULL || page->index != index)
-                       break;
-
                if (!page_cache_get_speculative(page))
                        goto repeat;
 
                /* Has the page moved? */
                if (unlikely(page != *((void **)pages[i]))) {
                        page_cache_release(page);
                        goto repeat;
                }
 
+               /*
+                * must check mapping and index after taking the ref.
+                * otherwise we can get both false positives and false
+                * negatives, which is just confusing to the caller.
+                */
+               if (page->mapping == NULL || page->index != index) {
+                       page_cache_release(page);
+                       break;
+               }
+

It's not immediately obvious that those added lines merely re-check the
condition checked by the 'page != *((void **)pages[i])', but if you think
about it, if page->index changes, then page must necessarily move within
the radix tree / xarray.

> Would it be excessively cautious to put a WARN_ON_ONCE() in there for a
> while?

I think it would ... it'd get in the way of a subsequent patch to store
only head pages in the page cache.
