Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC51C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B2E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B2E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeLJK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:28:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeLJK2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:28:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6549AE10;
        Mon, 10 Dec 2018 10:28:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA8D51E13F8; Mon, 10 Dec 2018 11:28:46 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:28:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20181210102846.GC29289@quack2.suse.cz>
References: <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208022445.GA7024@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> Another crazy idea, why not treating GUP as another mapping of the page
> and caller of GUP would have to provide either a fake anon_vma struct or
> a fake vma struct (or both for PRIVATE mapping of a file where you can
> have a mix of both private and file page thus only if it is a read only
> GUP) that would get added to the list of existing mapping.
>
> So the flow would be:
>     somefunction_thatuse_gup()
>     {
>         ...
>         GUP(_fast)(vma, ..., fake_anon, fake_vma);
>         ...
>     }
> 
>     GUP(vma, ..., fake_anon, fake_vma)
>     {
>         if (vma->flags == ANON) {
>             // Add the fake anon vma to the anon vma chain as a child
>             // of current vma
>         } else {
>             // Add the fake vma to the mapping tree
>         }
> 
>         // The existing GUP except that now it inc mapcount and not
>         // refcount
>         GUP_old(..., &nanonymous, &nfiles);
> 
>         atomic_add(&fake_anon->refcount, nanonymous);
>         atomic_add(&fake_vma->refcount, nfiles);
> 
>         return nanonymous + nfiles;
>     }

Thanks for your idea! This is actually something like I was suggesting back
at LSF/MM in Deer Valley. There were two downsides to this I remember
people pointing out:

1) This cannot really work with __get_user_pages_fast(). You're not allowed
to get necessary locks to insert new entry into the VMA tree in that
context. So essentially we'd loose get_user_pages_fast() functionality.

2) The overhead e.g. for direct IO may be noticeable. You need to allocate
the fake tracking VMA, get VMA interval tree lock, insert into the tree.
Then on IO completion you need to queue work to unpin the pages again as you
cannot remove the fake VMA directly from interrupt context where the IO is
completed.

You are right that the cost could be amortized if gup() is called for
multiple consecutive pages however for small IOs there's no help...

So this approach doesn't look like a win to me over using counter in struct
page and I'd rather try looking into squeezing HMM public page usage of
struct page so that we can fit that gup counter there as well. I know that
it may be easier said than done...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
