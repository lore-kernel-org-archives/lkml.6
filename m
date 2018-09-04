Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE905C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7469920659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7469920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIEBKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:10:34 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:50294 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeIEBKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:10:34 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 21:10:34 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 5AA831A403A2; Tue,  4 Sep 2018 13:35:34 -0700 (PDT)
Date:   Tue, 4 Sep 2018 13:35:34 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180904203534.yumaest6v5p6izln@shells.gnugeneration.com>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:18:18PM -0400, Jeff Layton wrote:
> On Tue, 2018-09-04 at 14:54 -0400, J. Bruce Fields wrote:
> > On Tue, Sep 04, 2018 at 06:23:48PM +0200, Rogier Wolff wrote:
> > > On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:
> > > > Well, I think the point was that in the above examples you'd prefer that
> > > > the read just fail--no need to keep the data.  A bit marking the file
> > > > (or even the entire filesystem) unreadable would satisfy posix, I guess.
> > > > Whether that's practical, I don't know.
> > > 
> > > When you would do it like that (mark the whole filesystem as "in
> > > error") things go from bad to worse even faster. The Linux kernel 
> > > tries to keep the system up even in the face of errors. 
> > > 
> > > With that suggestion, having one application run into a writeback
> > > error would effectively crash the whole system because the filesystem
> > > may be the root filesystem and stuff like "sshd" that you need to
> > > diagnose the problem needs to be read from the disk.... 
> > 
> > Well, the absolutist position on posix compliance here would be that a
> > crash is still preferable to returning the wrong data.  And for the
> > cases 焦晓冬 gives, that sounds right?  Maybe it's the wrong balance in
> > general, I don't know.  And we do already have filesystems with
> > panic-on-error options, so if they aren't used maybe then maybe users
> > have already voted against that level of strictness.
> > 
> 
> Yeah, idk. The problem here is that this is squarely in the domain of
> implementation defined behavior. I do think that the current "policy"
> (if you call it that) of what to do after a wb error is weird and wrong.
> What we probably ought to do is start considering how we'd like it to
> behave.
> 
> How about something like this?
> 
> Mark the pages as "uncleanable" after a writeback error. We'll satisfy
> reads from the cached data until someone calls fsync, at which point
> we'd return the error and invalidate the uncleanable pages.
> 
> If no one calls fsync and scrapes the error, we'll hold on to it for as
> long as we can (or up to some predefined limit) and then after that
> we'll invalidate the uncleanable pages and start returning errors on
> reads. If someone eventually calls fsync afterward, we can return to
> normal operation.
> 
> As always though...what about mmap? Would we need to SIGBUS at the point
> where we'd start returning errors on read()?
> 
> Would that approximate the current behavior enough and make sense?
> Implementing it all sounds non-trivial though...
> 

Here's a crazy and potentially stupid idea:

Implement a new class of swap space for backing dirty pages which fail
to write back.  Pages in this space survive reboots, essentially backing
the implicit commitment POSIX establishes in the face of asynchronous
writeback errors.  Rather than evicting these pages as clean, they are
swapped out to the persistent swap.

Administrators then decide if they want to throw some cheap storage at
enabling this coverage, or live with the existing risks.

I think it may be an interesting approach, enabling administrators to
repair primary storage while operating in a degraded mode.  Then once
things are corrected, there would be a way to evict pages from
persistent swap for another shot at writeback to primary storage.

Regards,
Vito Caputo
