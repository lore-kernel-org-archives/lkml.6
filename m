Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ADAECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FA3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FA3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeGSJ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeGSJ1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9042AADD7;
        Thu, 19 Jul 2018 08:45:39 +0000 (UTC)
Date:   Thu, 19 Jul 2018 10:45:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180719084538.GP7193@dhcp22.suse.cz>
References: <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard>
 <20180716090901.GG17280@dhcp22.suse.cz>
 <20180716124115.GA7072@bombadil.infradead.org>
 <20180716164032.94e13f765c5f33c6022eca38@linux-foundation.org>
 <20180717083326.GD16803@dhcp22.suse.cz>
 <20180719003329.GD19934@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719003329.GD19934@dastard>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 10:33:29, Dave Chinner wrote:
> On Tue, Jul 17, 2018 at 10:33:26AM +0200, Michal Hocko wrote:
> > On Mon 16-07-18 16:40:32, Andrew Morton wrote:
> > > On Mon, 16 Jul 2018 05:41:15 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > > It's quite a small code change and would provide a mechanism for
> > > implementing the hammer-cache-until-youve-freed-enough design above.
> > > 
> > > 
> > > 
> > > Aside 2: if we *do* do something like the above __d_alloc() pseudo code
> > > then perhaps it could be cast in terms of pages, not dentries.  ie,
> > > 
> > > __d_alloc()
> > > {
> > > 	...
> > > 	while (too many pages in dentry_cache)
> > > 		call the dcache shrinker
> > > 	...
> > > }
> 
> Direct reclaim will result in all the people who care about long
> tail latencies and/or highly concurent workloads starting to hate
> you.  Direct reclaim already hammers superblock shrinkers with
> excessive concurrency, this would only make it worse.

I can only confirm that! We have something similar in our SLES kernel.
We have page cache soft limit implemented for many years and it is
basically similar thing to above. We just shrink the page cache when we
have too much of it. It turned out to be a complete PITA on large
machines when hundreds of CPUs are fighting for locks. We have tried to
address that but it is a complete whack a mole.

More important lesson from this is that the original motivation for this
functionality was to not allow too much page cache which would push a
useful DB data out to swap. And as it turned out MM internals have
changed a lot since the introduction and we do not really swap out in
presence of the page cache anymore. Moreover we have a much more
effective reclaim protection thanks to memcg low limit reclaim etc.
While that is all good and nice there are still people tunning the
pagecache limit based on some really old admin guides and the feature
makes more harm than good and we see bug reports that system gets
stalled...

I really do not see why limiting (negative) dentries should be any
different.

> IOWs, anything like this needs to co-ordinate with other reclaim
> operations in progress and, most likely, be done via background
> reclaim processing rather than blocking new allocations
> indefinitely. background processing can be done in bulk and as
> efficiently as possible - concurrent direct reclaim in tiny batches
> will just hammer dcache locks and destroy performance when there is
> memory pressure.

Absolutely agreed!

> How many times do we have to learn this lesson the hard way?
> 
> > > and, apart from the external name thing (grr), that should address
> > > these fragmentation issues, no?  I assume it's easy to ask slab how
> > > many pages are presently in use for a particular cache.
> > 
> > I remember Dave Chinner had an idea how to age dcache pages to push
> > dentries with similar live time to the same page. Not sure what happened
> > to that.
> 
> Same thing that happened to all the "select the dentries on this
> page for reclaim". i.e. it's referenced dentries that we can't
> reclaim or move that are the issue, not the reclaimable dentries on
> the page.
> 
> Bsaically, without a hint at allocation time as to the expected life
> time of the dentry, we can't be smart about how we select partial
> pages to allocate from. And because we don't know at allocation time
> if the dentry is going to remain a negative dentry or not, we can't
> provide a hint about expected lifetime of teh object being
> allocated.

Can we allocate a new dentry at the time when we know the life time or
the dentry pointer is so spread by that time that we cannot?
-- 
Michal Hocko
SUSE Labs
