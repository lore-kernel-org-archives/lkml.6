Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595C420881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595C420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLBXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:23:15 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:58876 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbeLBXXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:23:14 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 03 Dec 2018 09:53:04 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gTb4p-0002pZ-1i; Mon, 03 Dec 2018 10:23:03 +1100
Date:   Mon, 3 Dec 2018 10:23:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181202232302.GT19305@dastard>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201074909.GC213156@sasha-vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 02:49:09AM -0500, Sasha Levin wrote:
> On Sat, Dec 01, 2018 at 08:50:05AM +1100, Dave Chinner wrote:
> >On Fri, Nov 30, 2018 at 05:14:41AM -0500, Sasha Levin wrote:
> >>On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
> >>>On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
> >>>>I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
> >>>>aggregate) to focus on testing the copy_file_range() changes, but
> >>>>Darrick's tests are still ongoing and have passed 40 billion ops in
> >>>>aggregate over the past few days.
> >>>>
> >>>>The reason we are running these so long is that we've seen fsx data
> >>>>corruption failures after 12+ hours of runtime and hundreds of
> >>>>millions of ops. Hence the testing for backported fixes will need to
> >>>>replicate these test runs across multiple configurations for
> >>>>multiple days before we have any confidence that we've actually
> >>>>fixed the data corruptions and not introduced any new ones.
> >>>>
> >>>>If you pull only a small subset of the fixes, the fsx will still
> >>>>fail and we have no real way of actually verifying that there have
> >>>>been no regression introduced by the backport.  IOWs, there's a
> >>>>/massive/ amount of QA needed for ensuring that these backports work
> >>>>correctly.
> >>>>
> >>>>Right now the XFS developers don't have the time or resources
> >>>>available to validate stable backports are correct and regression
> >>>>fre because we are focussed on ensuring the upstream fixes we've
> >>>>already made (and are still writing) are solid and reliable.
> >>>
> >>>Ok, that's fine, so users of XFS should wait until the 4.20 release
> >>>before relying on it?  :)
> >>
> >>It's getting to the point that with the amount of known issues with XFS
> >>on LTS kernels it makes sense to mark it as CONFIG_BROKEN.
> >
> >Really? Where are the bug reports?
> 
> In 'git log'! You report these every time you fix something in upstream
> xfs but don't backport it to stable trees:

That is so wrong on so many levels I don't really know where to
begin. I guess doing a *basic risk analysis* demonstrating that none
of those fixes are backport candidates is a good start:

> $ git log --oneline v4.18-rc1..v4.18 fs/xfs
> d4a34e165557 xfs: properly handle free inodes in extent hint validators

Found by QA with generic/229 on a non-standard config. Not user
reported, unlikely to ever be seen by users.

> 9991274fddb9 xfs: Initialize variables in xfs_alloc_get_rec before using them

Cleaning up coverity reported issues to do with corruption log
messages. No visible symptoms, Not user reported.

> d8cb5e423789 xfs: fix fdblocks accounting w/ RMAPBT per-AG reservation

Minor free space accounting issue, not user reported, doesn't affect
normal operation.

> e53c4b598372 xfs: ensure post-EOF zeroing happens after zeroing part of a file

Found with fsx via generic/127. Not user reported, doesn't affect
userspace operation at all.

> a3a374bf1889 xfs: fix off-by-one error in xfs_rtalloc_query_range

Regression fix for code introduced in 4.18-rc1. Not user reported
because the code has never been released.

> 232d0a24b0fc xfs: fix uninitialized field in rtbitmap fsmap backend

Coverity warning fix, not user reported, not user impact.

> 5bd88d153998 xfs: recheck reflink state after grabbing ILOCK_SHARED for a write

Fixes warning from generic/166, not user reported. Could affect
users mixing direct IO with reflink, but we expect people using
new functionality like reflink to be tracking TOT fairly closely
anyway.

> f62cb48e4319 xfs: don't allow insert-range to shift extents past the maximum offset

Found by QA w/ generic/465. Not user reported, only affects files in
the exabyte range so not a real world problem....

> aafe12cee0b1 xfs: don't trip over negative free space in xfs_reserve_blocks

Found during ENOSPC stress tests that depeleted the reserve pool.
Not user reported, unlikely to ever be hit by users.

> 10ee25268e1f xfs: allow empty transactions while frozen

Removes a spurious warning when running GETFSMAP ioctl on a frozen
filesystem. Not user reported, highly unlikely any user will ever
hit this as nothing but XFs utilities use GETFSMAP at the moment.

> e53946dbd31a xfs: xfs_iflush_abort() can be called twice on cluster writeback failure

Bug in corrupted filesystem handling, been there for ~15 years IIRC.
Not user reported - found by one of our shutdown stress tests
on a debug kernel (generic/388, IIRC). Highly unlikely to show up in
the real world given how long the bug has been there.

> 23fcb3340d03 xfs: More robust inode extent count validation

Found by filesystem image fuzzing (i.e. intentional filesystem
corruption). Not user reported, and the filesystem corruption that
triggered this problem is so artificial there is really no chance of
it ever occurring in the real world.

> e2ac836307e3 xfs: simplify xfs_bmap_punch_delalloc_range

Cleanup and simplification. Not a bug fix, not user reported, not a
backport candidate.

IOWs, there isn't a single commit in this list that is user
reported, nor anything that I'd consider a stable kernel backport
candidate because none of them affect normal user workloads. i.e.
they've all be found by tools designed to break filesystems and
exercise rarely travelled error paths.

> Since I'm assuming that at least some of them are based on actual issues
> users hit, and some of those apply to stable kernels, why would users
> want to use an XFS version which is knowingly buggy?

Your assumption is not only incorrect, it is fundamentally flawed.
A list of commits containing bug fixes is not a list of bug reports
from users.

IOWs, backporting them only increases the risk of regressions for
users, it doesn't reduce the risk of users hitting problems or fix
any problems that users are at risk of actually hitting. IOWs, all
of these changes fall on the wrong side of the risk-benefit analysis
equation.

Risk/benefit analysis is fundamental to software engineering
processes.  Running "git log" is not a risk analysis - it's just
provides a list of things that you need to perform an analysis on.
Risk analsysis takes time and effort, and to imply that it is not
necessary and we should just backport everything makes the incorrect
assumption that backporting carries no risk at all.

It seems to me that the stable kernel process measures itself on how
many commits an dhow fast they are backported from mainline kernels,
and the entire focus of improvement is on backporting /more/ commits
/faster/. i.e.  it's all about the speed and quantity of code being
moved back to the "stable" kernels. What it should be doing is
identifying and addressing bugs or flaws that put users are risk or
that users are reporting.

Further, the speed at which backports occur (i.e. within a day or 3
of upstream commit) means that the code being backported hasn't had
time to reach a wide testing audience and have regressions shaken
out of it. The whole purpose of having progressively stricter -rcX
upstream kernel releases is to allow the new code to stabilise and
shake out unforseen regressions before it gets to users. The stable
process is actually releasing upstream code to users before they can
even get it in a released upstream kernel (i.e. a .0 kernel, not a
-rcX).

IOWs, pulling code back to stable kernels before it's had a chance
to stabilise and be more widely tested in the upstream kernel is
entirely the wrong thing to be doing. Speed here does not improve
stability, it just increases the risk of regressions and unforseen
bugs being introduced into the stable tree. And that's made worse by
the fact that the -rcX process and widespread upstream testing that
goes along with it* to catch those bugs and regressions. And that's
made even worse by the fact that subsystems don't have control over
what is backported anymore, so they may not even be aware that a fix
for a fix needs to be sent back to stable kernels.

This is the issue here - the "stable kernel" criteria is not about
stability - it's being optimised to shovel as much change as
possible with /as little effort as possible/ back into older code
bases. That's not a recipe for stability, especially considering the
relative lack of QA the stable kernels get.

IMO, the whole set of linux kernel processes are being optimised
around the wrong metrics - we count new features, the number of
commits per release and the quantity of code that gets changed. We
then optimise our processes to increase these metrics. IOWs, we're
optimising for speed and rapid change, not quality, reliability and
stability.

We are not measuring code quality improvements, how effective our
code review is, we do not do post-mortem analysis of major failures
and we most certainly don't change processes to avoid those problems
in future, etc. And worst of all is that people who want better
processes to improve code quality, testing, etc get shouted at
because it may slow down the rate at which we change code. i.e. only
"speed and quantity" seems to matter to the core upstream kernel
developement community.

As Darrick said, what we are seeing here is a result of "[...] the
kernel community's systemic inability to QA new fs features
properly." I'm taking that one step further - what we are seeing
here is the kernel community's systemic inability to address
fundamental engineering process deficiencies because "speed and
quantity" are considered more important than the quality of the
product being produced.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
