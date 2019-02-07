Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BFDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAC8217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBGDKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:10:14 -0500
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:26986 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfBGDKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:10:14 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl2.internode.on.net with ESMTP; 07 Feb 2019 13:40:09 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gra4m-0003gs-Nd; Thu, 07 Feb 2019 14:10:08 +1100
Date:   Thu, 7 Feb 2019 14:10:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Coly Li <colyli@suse.de>
Cc:     Andre Noll <maan@tuebingen.mpg.de>, Nix <nix@esperi.org.uk>,
        linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at
 all?
Message-ID: <20190207031008.GJ14116@dastard>
References: <87h8dgefee.fsf@esperi.org.uk>
 <20190206234328.GH14116@dastard>
 <20190207002425.GX24140@tuebingen.mpg.de>
 <20190207022657.GI14116@dastard>
 <438851ef-ef77-b5f2-d46d-05762b6330b2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <438851ef-ef77-b5f2-d46d-05762b6330b2@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:38:58AM +0800, Coly Li wrote:
> On 2019/2/7 10:26 上午, Dave Chinner wrote:
> > On Thu, Feb 07, 2019 at 01:24:25AM +0100, Andre Noll wrote:
> >> On Thu, Feb 07, 10:43, Dave Chinner wrote
> >>> File data readahead: REQ_RAHEAD
> >>> Metadata readahead: REQ_META | REQ_RAHEAD
> >>>
> >>> drivers/md/bcache/request.c::check_should_bypass():
> >>>
> >>>         /*
> >>>          * Flag for bypass if the IO is for read-ahead or background,
> >>>          * unless the read-ahead request is for metadata (eg, for gfs2).
> >>>          */
> >>>         if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
> >>>             !(bio->bi_opf & REQ_PRIO))
> >>>                 goto skip;
> >>>
> >>> bcache needs fixing - it thinks REQ_PRIO means metadata IO. That's
> >>> wrong - REQ_META means it's metadata IO, and so this is a bcache
> >>> bug.
> >>
> >> Do you think 752f66a75abad is bad (ha!) and should be reverted?
> > 
> > Yes, that change is just broken. From include/linux/blk_types.h:
> > 
> > 	__REQ_META,             /* metadata io request */
> > 	__REQ_PRIO,             /* boost priority in cfq */
> > 
> > 
> 
> Hi Dave,
> 
> > i.e. REQ_META means that it is a metadata request, REQ_PRIO means it
> > is a "high priority" request. Two completely different things, often
> > combined, but not interchangeable.
> 
> I found in file system metadata IO, most of time REQ_META and REQ_PRIO
> are tagged together for bio, but XFS seems not use REQ_PRIO.

Yes, that's correct, because we don't specifically prioritise
metadata IO over data IO.

> Is there any basic principle for when should these tags to be used or
> not ?

Yes.

> e.g. If REQ_META is enough for meta data I/O, why REQ_PRIO is used
> too.

REQ_META is used for metadata. REQ_PRIO is used to communicate to
the lower layers that the submitter considers this IO to be more
important that non REQ_PRIO IO and so dispatch should be expedited.

IOWs, if the filesystem considers metadata IO to be more important
that user data IO, then it will use REQ_PRIO | REQ_META rather than
just REQ_META.

Historically speaking, REQ_PRIO was a hack for CFQ to get it to
dispatch journal IO from a different thread without waiting for a
time slice to expire. In the XFs world, we just said "don't use CFQ,
it's fundametnally broken for highly concurrent applications" and
didn't bother trying to hack around the limitations of CFQ.

These days REQ_PRIO is only used by the block layer writeback
throttle, but unlike bcache it considers both REQ_META and REQ_PRIO
to mean the same thing.

REQ_META, OTOH, is used by BFQ and blk-cgroup to detect metadata
IO and don't look at REQ_PRIO at all. So, really, REQ_META is for
metadata, not REQ_PRIO. REQ_PRIO looks like it should just go away.

> And if REQ_PRIO is necessary, why it is not used in fs/xfs/ code ?

It's not necessary, it's just an /optimisation/ that some
filesystems make and some IO schedulers used to pay attention to. It
looks completely redundant now.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
