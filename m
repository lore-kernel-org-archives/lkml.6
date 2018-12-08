Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D78DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED872083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED872083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLHQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLHQd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7619F308421A;
        Sat,  8 Dec 2018 16:33:58 +0000 (UTC)
Received: from redhat.com (ovpn-120-239.rdu2.redhat.com [10.10.120.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C79F95DD63;
        Sat,  8 Dec 2018 16:33:55 +0000 (UTC)
Date:   Sat, 8 Dec 2018 11:33:53 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181208163353.GA2952@redhat.com>
References: <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 08 Dec 2018 16:33:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:16:32PM -0800, Dan Williams wrote:
> On Fri, Dec 7, 2018 at 4:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 12/7/18 11:16 AM, Jerome Glisse wrote:
> > > On Thu, Dec 06, 2018 at 06:45:49PM -0800, John Hubbard wrote:
> [..]
> > I see. OK, HMM has done an efficient job of mopping up unused fields, and now we are
> > completely out of space. At this point, after thinking about it carefully, it seems clear
> > that it's time for a single, new field:
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5ed8f6292a53..1c789e324da8 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -182,6 +182,9 @@ struct page {
> >         /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
> >         atomic_t _refcount;
> >
> > +       /* DMA usage count. See get_user_pages*(), put_user_page*(). */
> > +       atomic_t _dma_pinned_count;
> > +
> >  #ifdef CONFIG_MEMCG
> >         struct mem_cgroup *mem_cgroup;
> >  #endif
> >
> >
> > ...because after all, the reason this is so difficult is that this fix has to work
> > in pretty much every configuration. get_user_pages() use is widespread, it's a very
> > general facility, and...it needs fixing.  And we're out of space.
> 
> HMM seems entirely too greedy in this regard. Especially with zero
> upstream users. When can we start to delete the pieces of HMM that
> have no upstream consumers? I would think that would be 4.21 / 5.0 as
> there needs to be some forcing function. We can always re-add pieces
> of HMM with it's users when / if they arrive.

Patchset to use HMM inside nouveau have already been posted, some
of the bits have already made upstream and more are line up for
next merge window.

Cheers,
Jérôme
