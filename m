Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeDOCkZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 22:40:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40590 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeDOCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 22:40:23 -0400
Date: Sun, 15 Apr 2018 03:39:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
Message-ID: <20180415023939.GY30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com>
 <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
 <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
 <20180414205846.GW30522@ZenIV.linux.org.uk>
 <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
 <20180415005056.GX30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415005056.GX30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 01:51:07AM +0100, Al Viro wrote:
> On Sat, Apr 14, 2018 at 02:47:21PM -0700, Linus Torvalds wrote:
> > On Sat, Apr 14, 2018 at 1:58 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > That breaks d_invalidate(), unfortunately.  Look at the termination
> > > conditions in the loop there...
> > 
> > Ugh. I was going to say "but that doesn't even use select_collect()",
> > but yeah, detach_and_collect() calls it.
> > 
> > It would be easy enough to just change the
> > 
> >                 if (!list_empty(&data.select.dispose))
> > 
> > there to
> > 
> >                 if (!list_empty(&data.select.found))
> > 
> > too.
> 
> You would have to do the same in check_and_drop() as well,
> and that brings back d_invalidate()/d_invalidate() livelock
> we used to have.  See 81be24d263db...
> 
> I'm trying to put something together, but the damn thing is
> full of potential livelocks, unfortunately ;-/  Will send
> a followup once I have something resembling a sane solution...

I really wonder if we should just do the following in
d_invalidate():
	* grab ->d_lock on victim, check if it's unhashed,
unlock and bugger off if it is.  Otherwise, unhash and unlock.
>From that point on any d_set_mounted() in the subtree will
fail.
	* shrink_dcache_parent() to reduce the subtree size.
	* go through the (hopefully shrunk) subtree, picking
mountpoints.  detach_mounts() for each of them.
	* shrink_dcache_parent() if any points had been
encountered, to kick the now-unpinned stuff.

As a side benefit, we could probably be gentler on rename_lock
in d_set_mounted() after that change...
