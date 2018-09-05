Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27FF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27FF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeIEFTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:19:22 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:55472 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbeIEFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:19:22 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 05 Sep 2018 10:21:44 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fxM2o-0002y1-1s; Wed, 05 Sep 2018 10:51:42 +1000
Date:   Wed, 5 Sep 2018 10:51:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905005141.GD27618@dastard>
References: <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
 <20180904203534.yumaest6v5p6izln@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904203534.yumaest6v5p6izln@shells.gnugeneration.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:35:34PM -0700, Vito Caputo wrote:
> On Tue, Sep 04, 2018 at 04:18:18PM -0400, Jeff Layton wrote:
> > On Tue, 2018-09-04 at 14:54 -0400, J. Bruce Fields wrote:
> > > On Tue, Sep 04, 2018 at 06:23:48PM +0200, Rogier Wolff wrote:
> > > > On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:
> > > > > Well, I think the point was that in the above examples you'd prefer that
> > > > > the read just fail--no need to keep the data.  A bit marking the file
> > > > > (or even the entire filesystem) unreadable would satisfy posix, I guess.
> > > > > Whether that's practical, I don't know.
> > > > 
> > > > When you would do it like that (mark the whole filesystem as "in
> > > > error") things go from bad to worse even faster. The Linux kernel 
> > > > tries to keep the system up even in the face of errors. 
> > > > 
> > > > With that suggestion, having one application run into a writeback
> > > > error would effectively crash the whole system because the filesystem
> > > > may be the root filesystem and stuff like "sshd" that you need to
> > > > diagnose the problem needs to be read from the disk.... 
> > > 
> > > Well, the absolutist position on posix compliance here would be that a
> > > crash is still preferable to returning the wrong data.  And for the
> > > cases 焦晓冬 gives, that sounds right?  Maybe it's the wrong balance in
> > > general, I don't know.  And we do already have filesystems with
> > > panic-on-error options, so if they aren't used maybe then maybe users
> > > have already voted against that level of strictness.
> > > 
> > 
> > Yeah, idk. The problem here is that this is squarely in the domain of
> > implementation defined behavior. I do think that the current "policy"
> > (if you call it that) of what to do after a wb error is weird and wrong.
> > What we probably ought to do is start considering how we'd like it to
> > behave.
> > 
> > How about something like this?
> > 
> > Mark the pages as "uncleanable" after a writeback error. We'll satisfy
> > reads from the cached data until someone calls fsync, at which point
> > we'd return the error and invalidate the uncleanable pages.
> > 
> > If no one calls fsync and scrapes the error, we'll hold on to it for as
> > long as we can (or up to some predefined limit) and then after that
> > we'll invalidate the uncleanable pages and start returning errors on
> > reads. If someone eventually calls fsync afterward, we can return to
> > normal operation.
> > 
> > As always though...what about mmap? Would we need to SIGBUS at the point
> > where we'd start returning errors on read()?
> > 
> > Would that approximate the current behavior enough and make sense?
> > Implementing it all sounds non-trivial though...
> > 
> 
> Here's a crazy and potentially stupid idea:
> 
> Implement a new class of swap space for backing dirty pages which fail
> to write back.  Pages in this space survive reboots, essentially backing
> the implicit commitment POSIX establishes in the face of asynchronous
> writeback errors.  Rather than evicting these pages as clean, they are
> swapped out to the persistent swap.

And when that "swap" area gets write errors, too? What then? We're
straight back to the same "what the hell do we do with the error"
problem.

Adding more turtles doesn't help solve this issue.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
