Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90CFECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF322087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF322087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeIYNzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:55:31 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:53458 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbeIYNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:55:31 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 25 Sep 2018 17:19:12 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g4i5m-0005Tv-91; Tue, 25 Sep 2018 17:49:10 +1000
Date:   Tue, 25 Sep 2018 17:49:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christopher Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180925074910.GB31060@dastard>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de>
 <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180921130504.GA22551@lst.de>
 <010001660c54fb65-b9d3a770-6678-40d0-8088-4db20af32280-000000@email.amazonses.com>
 <1f88f59a-2cac-e899-4c2e-402e919b1034@kernel.dk>
 <010001660cbd51ea-56e96208-564d-4f5d-a5fb-119a938762a9-000000@email.amazonses.com>
 <1a5b255f-682e-783a-7f99-9d02e39c4af2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5b255f-682e-783a-7f99-9d02e39c4af2@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:09:37PM -0600, Jens Axboe wrote:
> On 9/24/18 12:00 PM, Christopher Lameter wrote:
> > On Mon, 24 Sep 2018, Jens Axboe wrote:
> > 
> >> The situation is making me a little uncomfortable, though. If we export
> >> such a setting, we really should be honoring it...

That's what I said up front, but you replied to this with:

| I think this is all crazy talk. We've never done this, [...]

Now I'm not sure what you are saying we should do....

> > Various subsystems create custom slab arrays with their particular
> > alignment requirement for these allocations.
> 
> Oh yeah, I think the solution is basic enough for XFS, for instance.
> They just have to error on the side of being cautious, by going full
> sector alignment for memory...

How does the filesystem find out about hardware alignment
requirements? Isn't probing through the block device to find out
about the request queue configurations considered a layering
violation?

What if sector alignment is not sufficient?  And how would this work
if we start supporting sector sizes larger than page size? (which the
XFS buffer cache supports just fine, even if nothing else in
Linux does).

But even ignoring sector size > page size, implementing this
requires a bunch of new slab caches, especially for 64k page
machines because XFS supports sector sizes up to 32k.  And every
other filesystem that uses sector sized buffers (e.g. HFS) would
have to do the same thing. Seems somewhat wasteful to require
everyone to implement their own aligned sector slab cache...

Perhaps we should take the filesystem out of this completely - maybe
the block layer could provide a generic "sector heap" and have all
filesystems that use sector sized buffers allocate from it. e.g.
something like

	mem = bdev_alloc_sector_buffer(bdev, sector_size)

That way we don't have to rely on filesystems knowing anything about
the alignment limitations of the devices or assumptions about DMA
to work correctly...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
