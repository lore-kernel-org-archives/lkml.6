Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E0DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQs7KFU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE3E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeK3Tah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3Tah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:30:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000E420868;
        Fri, 30 Nov 2018 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543566125;
        bh=stc1e6HDFNgtp9updESIBa/TXsI5lXm87Nje7gxxAU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQs7KFU5l9VEsP3tl8/papLDdKMY7BFunqHUUXDbaFFKrxvmk5pKpzcLKQ/LBsowI
         B2u4qcijtczY7lo0Em/3ewwJFLd9TMW1DhkP30QdRAuwlPKFm0xenE4BdZdQ6HH2aP
         zAl0mcIwiswbdWHf1AP/ji8IxHxccx3dbg0RRPLQ=
Date:   Fri, 30 Nov 2018 09:22:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181130082203.GA26830@kroah.com>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129224019.GM19305@dastard>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
> On Thu, Nov 29, 2018 at 01:47:56PM +0100, Greg KH wrote:
> > On Thu, Nov 29, 2018 at 11:14:59PM +1100, Dave Chinner wrote:
> > > 
> > > Cherry picking only one of the 50-odd patches we've committed into
> > > late 4.19 and 4.20 kernels to fix the problems we've found really
> > > seems like asking for trouble. If you're going to back port random
> > > data corruption fixes, then you need to spend a *lot* of time
> > > validating that it doesn't make things worse than they already
> > > are...
> > 
> > Any reason why we can't take the 50-odd patches in their entirety?  It
> > sounds like 4.19 isn't fully fixed, but 4.20-rc1 is?  If so, what do you
> > recommend we do to make 4.19 working properly?
> 
> You coul dpull all the fixes, but then you have a QA problem.
> Basically, we have multiple badly broken syscalls (FICLONERANGE,
> FIDEDUPERANGE and copy_file_range), and even 4.20-rc4 isn't fully
> fixed.
> 
> There were ~5 critical dedupe/clone data corruption fixes for XFS
> went into 4.19-rc8.

Have any of those been tagged for stable?

> There were ~30 patches that went into 4.20-rc1 that fixed the
> FICLONERANGE/FIDEDUPERANGE ioctls. That completely reworks the
> entire VFS infrastructure for those calls, and touches several
> filesystems as well. It fixes problems with setuid files, swap
> files, modifying immutable files, failure to enforce rlimit and
> max file size constraints, behaviour that didn't match man page
> descriptions, etc.
> 
> There were another ~10 patches that went into 4.20-rc4 that fixed
> yet more data corruption and API problems that we found when we
> enhanced fsx to use the above syscalls.
> 
> And I have another ~10 patches that I'm working on right now to fix
> the copy_file_range() implementation - it has all the same problems
> I listed above for FICLONERANGE/FIDEDUPERANGE and some other unique
> ones. I'm currently writing error condition tests for fstests so
> that we at least have some coverage of the conditions
> copy_file_range() is supposed to catch and fail. This might all make
> a late 4.20-rcX, but it's looking more like 4.21 at this point.
> 
> As to testing this stuff, I've spend several weeks now on this and
> so has Darrick. Between us we've done a huge amount of QA needed to
> verify that the problems are fixed and it is still ongoing. From
> #xfs a couple of days ago:
> 
> [28/11/18 16:59] * djwong hits 6 billion fsxops...
> [28/11/18 17:07] <dchinner_> djwong: I've got about 3.75 billion ops running on a machine here....
> [28/11/18 17:20] <djwong> note that's 1 billion fsxops x 6 machines
> [28/11/18 17:21] <djwong> [xfsv4, xfsv5, xfsv5 w/ 1k blocks] * [directio fsx, buffered fsx]
> [28/11/18 17:21] <dchinner_> Oh, I've got 3.75B x 4 instances on one filesystem :P
> [28/11/18 17:22] <dchinner_> [direct io, buffered] x [small op lengths, large op lengths]
> 
> And this morning:
> 
> [30/11/18 08:53] <djwong> 7 billion fsxops...
> 
> I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
> aggregate) to focus on testing the copy_file_range() changes, but
> Darrick's tests are still ongoing and have passed 40 billion ops in
> aggregate over the past few days.
> 
> The reason we are running these so long is that we've seen fsx data
> corruption failures after 12+ hours of runtime and hundreds of
> millions of ops. Hence the testing for backported fixes will need to
> replicate these test runs across multiple configurations for
> multiple days before we have any confidence that we've actually
> fixed the data corruptions and not introduced any new ones.
> 
> If you pull only a small subset of the fixes, the fsx will still
> fail and we have no real way of actually verifying that there have
> been no regression introduced by the backport.  IOWs, there's a
> /massive/ amount of QA needed for ensuring that these backports work
> correctly.
> 
> Right now the XFS developers don't have the time or resources
> available to validate stable backports are correct and regression
> fre because we are focussed on ensuring the upstream fixes we've
> already made (and are still writing) are solid and reliable.

Ok, that's fine, so users of XFS should wait until the 4.20 release
before relying on it?  :)

I understand your reluctance to want to backport anything, but it really
feels like you are not even allowing for fixes that are "obviously
right" to be backported either, even after they pass testing.  Which
isn't ok for your users.

thanks,

greg k-h
