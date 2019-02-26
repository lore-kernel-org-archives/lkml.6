Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B07C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3075F213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBZHlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBZHlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:41:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03095309D288;
        Tue, 26 Feb 2019 07:41:30 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5D0A5D6AA;
        Tue, 26 Feb 2019 07:41:20 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:41:17 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 23/26] userfaultfd: wp: don't wake up when doing write
 protect
Message-ID: <20190226074117.GL13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-24-peterx@redhat.com>
 <20190225210934.GE10454@rapoport-lnx>
 <20190226062424.GH13653@xz-x1>
 <20190226072933.GF5873@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226072933.GF5873@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Feb 2019 07:41:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:29:33AM +0200, Mike Rapoport wrote:
> On Tue, Feb 26, 2019 at 02:24:52PM +0800, Peter Xu wrote:
> > On Mon, Feb 25, 2019 at 11:09:35PM +0200, Mike Rapoport wrote:
> > > On Tue, Feb 12, 2019 at 10:56:29AM +0800, Peter Xu wrote:
> > > > It does not make sense to try to wake up any waiting thread when we're
> > > > write-protecting a memory region.  Only wake up when resolving a write
> > > > protected page fault.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  fs/userfaultfd.c | 13 ++++++++-----
> > > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 81962d62520c..f1f61a0278c2 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -1771,6 +1771,7 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > > >  	struct uffdio_writeprotect uffdio_wp;
> > > >  	struct uffdio_writeprotect __user *user_uffdio_wp;
> > > >  	struct userfaultfd_wake_range range;
> > > > +	bool mode_wp, mode_dontwake;
> > > > 
> > > >  	if (READ_ONCE(ctx->mmap_changing))
> > > >  		return -EAGAIN;
> > > > @@ -1789,18 +1790,20 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > > >  	if (uffdio_wp.mode & ~(UFFDIO_WRITEPROTECT_MODE_DONTWAKE |
> > > >  			       UFFDIO_WRITEPROTECT_MODE_WP))
> > > >  		return -EINVAL;
> > > > -	if ((uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP) &&
> > > > -	     (uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE))
> > > > +
> > > > +	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
> > > > +	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
> > > > +
> > > > +	if (mode_wp && mode_dontwake)
> > > >  		return -EINVAL;
> > > 
> > > This actually means the opposite of the commit message text ;-)
> > > 
> > > Is any dependency of _WP and _DONTWAKE needed at all?
> > 
> > So this is indeed confusing at least, because both you and Jerome have
> > asked the same question... :)
> > 
> > My understanding is that we don't have any reason to wake up any
> > thread when we are write-protecting a range, in that sense the flag
> > UFFDIO_WRITEPROTECT_MODE_DONTWAKE is already meaningless in the
> > UFFDIO_WRITEPROTECT ioctl context.  So before everything here's how
> > these flags are defined:
> > 
> > struct uffdio_writeprotect {
> > 	struct uffdio_range range;
> > 	/* !WP means undo writeprotect. DONTWAKE is valid only with !WP */
> > #define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
> > #define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
> > 	__u64 mode;
> > };
> > 
> > To make it clear, we simply define it as "DONTWAKE is valid only with
> > !WP".  When with that, "mode_wp && mode_dontwake" is indeed a
> > meaningless flag combination.  Though please note that it does not
> > mean that the operation ("don't wake up the thread") is meaningless -
> > that's what we'll do no matter what when WP==1.  IMHO it's only about
> > the interface not the behavior.
> > 
> > I don't have a good way to make this clearer because firstly we'll
> > need the WP flag to mark whether we're protecting or unprotecting the
> > pages.  Later on, we need DONTWAKE for page fault handling case to
> > mark that we don't want to wake up the waiting thread now.  So both
> > the flags have their reason to stay so far.  Then with all these in
> > mind what I can think of is only to forbid using DONTWAKE in WP case,
> > and that's how above definition comes (I believe, because it was
> > defined that way even before I started to work on it and I think it
> > makes sense).
> 
> There's no argument how DONTWAKE can be used with !WP. The
> userfaultfd_writeprotect() is called in response of the uffd monitor to WP
> page fault, it asks to clear write protection to some range, but it does
> not want to wake the faulting thread yet but rather it will use uffd_wake()
> later.
> 
> Still, I can't grok the usage of DONTWAKE with WP=1. In my understanding,
> in this case userfaultfd_writeprotect() is called unrelated to page faults,
> and the monitored thread runs freely, so why it should be waked at all?

Exactly this is how I understand it.  And that's why I wrote this
patch to remove the extra wakeup() since I think it's unecessary.

> 
> And what happens, if the thread is waiting on a missing page fault and we
> do userfaultfd_writeprotect(WP=1) at the same time?

Then IMHO the userfaultfd_writeprotect() will be a noop simply because
the page is still missing.  Here if with the old code (before this
patch) we'll probably even try to wake up this thread but this thread
should just fault again on the same address due to the fact that the
page is missing.  After this patch the monitored thread should
continue to wait on the missing page.

Thanks,

-- 
Peter Xu
