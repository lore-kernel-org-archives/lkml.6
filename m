Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeERSDc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:03:32 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42178 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:03:27 -0400
X-Google-Smtp-Source: AB8JxZrdq8f/dBNHstWKRQFlxJAgW4fm7P/IbJKta16X1A2GUtiSmaMz/QIEbk7KeoB89y9GcbZ2xg==
Date: Fri, 18 May 2018 14:03:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH 00/10] RFC: assorted bcachefs patches
Message-ID: <20180518180324.ymwbajfw5wsfrlth@destiny>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518174536.ai26bg3bhlvzq4pi@destiny>
 <20180518174912.GE31737@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518174912.GE31737@kmo-pixel>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:49:12PM -0400, Kent Overstreet wrote:
> On Fri, May 18, 2018 at 01:45:36PM -0400, Josef Bacik wrote:
> > On Fri, May 18, 2018 at 03:48:58AM -0400, Kent Overstreet wrote:
> > > These are all the remaining patches in my bcachefs tree that touch stuff outside
> > > fs/bcachefs. Not all of them are suitable for inclusion as is, I wanted to get
> > > some discussion first.
> > > 
> > >  * pagecache add lock
> > > 
> > > This is the only one that touches existing code in nontrivial ways.  The problem
> > > it's solving is that there is no existing general mechanism for shooting down
> > > pages in the page and keeping them removed, which is a real problem if you're
> > > doing anything that modifies file data and isn't buffered writes.
> > > 
> > > Historically, the only problematic case has been direct IO, and people have been
> > > willing to say "well, if you mix buffered and direct IO you get what you
> > > deserve", and that's probably not unreasonable. But now we have fallocate insert
> > > range and collapse range, and those are broken in ways I frankly don't want to
> > > think about if they can't ensure consistency with the page cache.
> > > 
> > > Also, the mechanism truncate uses (i_size and sacrificing a goat) has
> > > historically been rather fragile, IMO it might be a good think if we switched it
> > > to a more general rigorous mechanism.
> > > 
> > > I need this solved for bcachefs because without this mechanism, the page cache
> > > inconsistencies lead to various assertions popping (primarily when we didn't
> > > think we need to get a disk reservation going by page cache state, but then do
> > > the actual write and disk space accounting says oops, we did need one). And
> > > having to reason about what can happen without a locking mechanism for this is
> > > not something I care to spend brain cycles on.
> > > 
> > > That said, my patch is kind of ugly, and it requires filesystem changes for
> > > other filesystems to take advantage of it. And unfortunately, since one of the
> > > code paths that needs locking is readahead, I don't see any realistic way of
> > > implementing the locking within just bcachefs code.
> > > 
> > > So I'm hoping someone has an idea for something cleaner (I think I recall
> > > Matthew Wilcox saying he had an idea for how to use xarray to solve this), but
> > > if not I'll polish up my pagecache add lock patch and see what I can do to make
> > > it less ugly, and hopefully other people find it palatable or at least useful.
> > > 
> > >  * lglocks
> > > 
> > > They were removed by Peter Zijlstra when the last in kernel user was removed,
> > > but I've found them useful. His commit message seems to imply he doesn't think
> > > people should be using them, but I'm not sure why. They are a bit niche though,
> > > I can move them to fs/bcachefs if people would prefer. 
> > > 
> > >  * Generic radix trees
> > > 
> > > This is a very simple radix tree implementation that can store types of
> > > arbitrary size, not just pointers/unsigned long. It could probably replace
> > > flex arrays.
> > > 
> > >  * Dynamic fault injection
> > > 
> > 
> > I've not looked at this at all so this may not cover your usecase, but I
> > implemeted a bpf_override_return() to do focused error injection a year ago.  I
> > have this script
> > 
> > https://github.com/josefbacik/debug-scripts/blob/master/inject-error.py
> > 
> > that does it generically, all you have to do is tag the function you want to be
> > error injectable with ALLOW_ERROR_INJECTION() and then you get all these nice
> > things like a debugfs interface to trigger them or use the above script to
> > trigger specific errors and such.  Thanks,
> 
> That sounds pretty cool...
> 
> What about being able to add a random fault injection point in the middle of an
> existing function? Being able to stick race_fault() in random places was a
> pretty big win in terms of getting good code coverage out of realistic tests.

There's nothing stopping us from doing that, it just uses a kprobe to override
the function with our helper, so we could conceivably put it anywhere in the
function.  The reason I limited it to individual functions was because it was
easier than trying to figure out the side-effects of stopping mid-function.  If
I needed to fail mid-function I just added a helper where I needed it and failed
that instead.  I imagine safety is going to be of larger concern if we allow bpf
scripts to randomly return anywhere inside a function, even if the function is
marked as allowing error injection.  Thanks,

Josef
