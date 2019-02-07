Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21225C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF17218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBGC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:27:02 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:5890 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfBGC1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:27:01 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 07 Feb 2019 12:56:58 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1grZOz-0003dZ-OI; Thu, 07 Feb 2019 13:26:57 +1100
Date:   Thu, 7 Feb 2019 13:26:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andre Noll <maan@tuebingen.mpg.de>
Cc:     Nix <nix@esperi.org.uk>, linux-bcache@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: Re: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at
 all?
Message-ID: <20190207022657.GI14116@dastard>
References: <87h8dgefee.fsf@esperi.org.uk>
 <20190206234328.GH14116@dastard>
 <20190207002425.GX24140@tuebingen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207002425.GX24140@tuebingen.mpg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:24:25AM +0100, Andre Noll wrote:
> On Thu, Feb 07, 10:43, Dave Chinner wrote
> > File data readahead: REQ_RAHEAD
> > Metadata readahead: REQ_META | REQ_RAHEAD
> > 
> > drivers/md/bcache/request.c::check_should_bypass():
> > 
> >         /*
> >          * Flag for bypass if the IO is for read-ahead or background,
> >          * unless the read-ahead request is for metadata (eg, for gfs2).
> >          */
> >         if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
> >             !(bio->bi_opf & REQ_PRIO))
> >                 goto skip;
> > 
> > bcache needs fixing - it thinks REQ_PRIO means metadata IO. That's
> > wrong - REQ_META means it's metadata IO, and so this is a bcache
> > bug.
> 
> Do you think 752f66a75abad is bad (ha!) and should be reverted?

Yes, that change is just broken. From include/linux/blk_types.h:

	__REQ_META,             /* metadata io request */
	__REQ_PRIO,             /* boost priority in cfq */


i.e. REQ_META means that it is a metadata request, REQ_PRIO means it
is a "high priority" request. Two completely different things, often
combined, but not interchangeable.

So, yeah, that needs to be reverted if you want bcache to function
properly for metadata caching.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
