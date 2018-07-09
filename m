Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC9CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF8920875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF8920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGIQ2O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754459AbeGIQ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:28:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12ECEACA9;
        Mon,  9 Jul 2018 16:28:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32E8F1E0DD5; Mon,  9 Jul 2018 18:27:58 +0200 (CEST)
Date:   Mon, 9 Jul 2018 18:27:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm/fs: put_user_page() proposal
Message-ID: <20180709162758.slewonsgbly4uhhg@quack2.suse.cz>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709080554.21931-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 09-07-18 01:05:52, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> With respect to tracking get_user_pages*() pages with page->dma_pinned*
> fields [1], I spent a few days retrofitting most of the get_user_pages*()
> call sites, by adding calls to a new put_user_page() function, in place
> of put_page(), where appropriate. This will work, but it's a large effort.
> 
> Design note: I didn't see anything that hinted at a way to fix this
> problem, without actually changing all of the get_user_pages*() call sites,
> so I think it's reasonable to start with that.

Agreed.

> Anyway, it's still incomplete, but because this is a large, tree-wide
> change (that will take some time and testing), I'd like to propose a plan,
> before spamming zillions of people with put_user_page() conversion patches.
> So I picked out the first two patches to show where this is going.
> 
> Proposed steps:
> 
> Step 1:
> 
> Start with the patches here, then continue with...dozens more.
> This will eventually convert all of the call sites to use put_user_page().
> This is easy in some places, but complex in others, such as:
> 
>     -- drivers/gpu/drm/amd
>     -- bio
>     -- fuse
>     -- cifs
>     -- anything from:
>            git grep  iov_iter_get_pages | cut -f1 -d ':' | sort | uniq
> 
> The easy ones can be grouped into a single patchset, perhaps, and the
> complex ones probably each need a patchset, in order to get the in-depth
> review they'll need.

Agreed.

> Furthermore, some of these areas I hope to attract some help on, once
> this starts going.
> 
> Step 2:
> 
> In parallel, tidy up the core patchset that was discussed in [1], (version
> 2 has already been reviewed, so I know what to do), and get it perfected
> and reviewed. Don't apply it until step 1 is all done, though.
>
> Step 3:
> 
> Activate refcounting of dma-pinned pages (essentially, patch #5, which is
> [1]), but don't use it yet. Place a few WARN_ON_ONCE calls to start
> mopping up any missed call sites.
> 
> Step 4:
> 
> After some soak time, actually connect it up (patch #6 of [1]) and start
> taking action based on the new page->dma_pinned* fields.
> 
> [1] https://www.spinics.net/lists/linux-mm/msg156409.html
> 
>   or, the same thread on LKML if it's working for you:
> 
>     https://lkml.org/lkml/2018/7/4/368

Yeah, but as Nick pointed out we have some more work to do in step 4 to
avoid deadlocks. Still there's a lot of work to do on which the direction
to progress is clear :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
