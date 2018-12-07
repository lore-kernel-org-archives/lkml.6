Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234620837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2234620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLGTQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:16:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGTQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:16:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C60283154861;
        Fri,  7 Dec 2018 19:16:25 +0000 (UTC)
Received: from redhat.com (ovpn-125-106.rdu2.redhat.com [10.10.125.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D41D6293B;
        Fri,  7 Dec 2018 19:16:23 +0000 (UTC)
Date:   Fri, 7 Dec 2018 14:16:21 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181207191620.GD3293@redhat.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 07 Dec 2018 19:16:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:45:49PM -0800, John Hubbard wrote:
> On 12/4/18 5:57 PM, John Hubbard wrote:
> > On 12/4/18 5:44 PM, Jerome Glisse wrote:
> >> On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
> >>> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
> >>>> On 12/4/18 3:03 PM, Dan Williams wrote:
> >>>>> Except the LRU fields are already in use for ZONE_DEVICE pages... how
> >>>>> does this proposal interact with those?
> >>>>
> >>>> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> >>>> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> >>>> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
> >>>>
> >>>> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
> >>>> LRU field approach is unusable.
> >>>
> >>> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
> >>> damage:
> >>>
> >>> +++ b/include/linux/mm_types.h
> >>> @@ -151,10 +151,12 @@ struct page {
> >>>  #endif
> >>>                 };
> >>>                 struct {        /* ZONE_DEVICE pages */
> >>> +                       unsigned long _zd_pad_2;        /* LRU */
> >>> +                       unsigned long _zd_pad_3;        /* LRU */
> >>> +                       unsigned long _zd_pad_1;        /* uses mapping */
> >>>                         /** @pgmap: Points to the hosting device page map. */
> >>>                         struct dev_pagemap *pgmap;
> >>>                         unsigned long hmm_data;
> >>> -                       unsigned long _zd_pad_1;        /* uses mapping */
> >>>                 };
> >>>  
> >>>                 /** @rcu_head: You can use this to free a page by RCU. */
> >>>
> >>> You don't use page->private or page->index, do you Dan?
> >>
> >> page->private and page->index are use by HMM DEVICE page.
> >>
> > 
> > OK, so for the ZONE_DEVICE + HMM case, that leaves just one field remaining for 
> > dma-pinned information. Which might work. To recap, we need:
> > 
> > -- 1 bit for PageDmaPinned
> > -- 1 bit, if using LRU field(s), for PageDmaPinnedWasLru.
> > -- N bits for a reference count
> > 
> > Those *could* be packed into a single 64-bit field, if really necessary.
> > 
> 
> ...actually, this needs to work on 32-bit systems, as well. And HMM is using a lot.
> However, it is still possible for this to work.
> 
> Matthew, can I have that bit now please? I'm about out of options, and now it will actually
> solve the problem here.
> 
> Given:
> 
> 1) It's cheap to know if a page is ZONE_DEVICE, and ZONE_DEVICE means not on the LRU.
> That, in turn, means only 1 bit instead of 2 bits (in addition to a counter) is required, 
> for that case. 
> 
> 2) There is an independent bit available (according to Matthew). 
> 
> 3) HMM uses 4 of the 5 struct page fields, so only one field is available for a counter 
>    in that case.

To expend on this, HMM private page are use for anonymous page
so the index and mapping fields have the value you expect for
such pages. Down the road i want also to support file backed
page with HMM private (mapping, private, index).

For HMM public both anonymous and file back page are supported
today (HMM public is only useful on platform with something like
OpenCAPI, CCIX or NVlink ... so PowerPC for now).

> 4) get_user_pages() must work on ZONE_DEVICE and HMM pages.

get_user_pages() only need to work with HMM public page not the
private one as we can not allow _anyone_ to pin HMM private page.
So on get_user_pages() on HMM private we get a page fault and
it is migrated back to regular memory.


> 5) For a proper atomic counter for both 32- and 64-bit, we really do need a complete
> unsigned long field.
> 
> So that leads to the following approach:
> 
> -- Use a single unsigned long field for an atomic reference count for the DMA pinned count.
> For normal pages, this will be the *second* field of the LRU (in order to avoid PageTail bit).
> 
> For ZONE_DEVICE pages, we can also line up the fields so that the second LRU field is 
> available and reserved for this DMA pinned count. Basically _zd_pad_1 gets move up and
> optionally renamed:
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 017ab82e36ca..b5dcd9398cae 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -90,8 +90,8 @@ struct page {
>                                  * are in use.
>                                  */
>                                 struct {
> -                                       unsigned long dma_pinned_flags;
> -                                       atomic_t      dma_pinned_count;
> +                                       unsigned long dma_pinned_flags; /* LRU.next */
> +                                       atomic_t      dma_pinned_count; /* LRU.prev */
>                                 };
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> @@ -161,9 +161,9 @@ struct page {
>                 };
>                 struct {        /* ZONE_DEVICE pages */
>                         /** @pgmap: Points to the hosting device page map. */
> -                       struct dev_pagemap *pgmap;
> -                       unsigned long hmm_data;
> -                       unsigned long _zd_pad_1;        /* uses mapping */
> +                       struct dev_pagemap *pgmap;      /* LRU.next */
> +                       unsigned long _zd_pad_1;        /* LRU.prev or dma_pinned_count */
> +                       unsigned long hmm_data;         /* uses mapping */

This breaks HMM today as hmm_data would alias with mapping field.
hmm_data can only be in LRU.prev

Cheers,
Jérôme
