Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BADC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeIFKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:15:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:45420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbeIFKPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:15:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D7DBADA9;
        Thu,  6 Sep 2018 05:41:58 +0000 (UTC)
Date:   Thu, 6 Sep 2018 07:41:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
Message-ID: <20180906054157.GI14951@dhcp22.suse.cz>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183345.4416.76515.stgit@localhost.localdomain>
 <20180905062428.GV14951@dhcp22.suse.cz>
 <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 13:18:24, Alexander Duyck wrote:
> On Tue, Sep 4, 2018 at 11:24 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 04-09-18 11:33:45, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > >
> > > It doesn't make much sense to use the atomic SetPageReserved at init time
> > > when we are using memset to clear the memory and manipulating the page
> > > flags via simple "&=" and "|=" operations in __init_single_page.
> > >
> > > This patch adds a non-atomic version __SetPageReserved that can be used
> > > during page init and shows about a 10% improvement in initialization times
> > > on the systems I have available for testing.
> >
> > I agree with Dave about a comment is due. I am also quite surprised that
> > this leads to such a large improvement. Could you be more specific about
> > your test and machines you were testing on?
> 
> So my test case has been just initializing 4 3TB blocks of persistent
> memory with a few trace_printk values added to track total time in
> move_pfn_range_to_zone.
> 
> What I have been seeing is that the time needed for the call drops on
> average from 35-36 seconds down to around 31-32.

This information belongs to the changelog.

> 
> > Other than that the patch makes sense to me.
> >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > With the above addressed, feel free to add
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Thanks!
> 
> As far as adding a comment are we just talking about why it is
> reserved, or do we need a description of the __SetPageReserved versus
> SetPageReserved. For now I was looking at adding a comment like:

the later. The reason why we make it reserved should be quite clear. A
comment wouldn't hurt of course and what you have is a good start. But
it is usually atomic vs. non-atomic SetPage$Foo which needs some
clarification.

> @@ -5517,8 +5517,13 @@ void __meminit memmap_init_zone(unsigned long
> size, int nid, unsigned long zone,
>  not_early:
>                 page = pfn_to_page(pfn);
>                 __init_single_page(page, pfn, zone, nid);
> +
> +               /*
> +                * Mark page reserved as it will need to wait for onlining
> +                * phase for it to be fully associated with a zone.
> +                */
>                 if (context == MEMMAP_HOTPLUG)
> -                       SetPageReserved(page);
> +                       __SetPageReserved(page);
> 
>                 /*
>                  * Mark the block movable so that blocks are reserved for
> 
> Any thoughts on this?
> 
> Thanks.
> 
> - Alex

-- 
Michal Hocko
SUSE Labs
