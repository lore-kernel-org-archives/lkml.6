Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDOWeq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 18:34:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54422 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 18:34:44 -0400
Date: Sun, 15 Apr 2018 23:34:39 +0100
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
Message-ID: <20180415223439.GC30522@ZenIV.linux.org.uk>
References: <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
 <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
 <20180414205846.GW30522@ZenIV.linux.org.uk>
 <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
 <20180415005056.GX30522@ZenIV.linux.org.uk>
 <CA+55aFwB0A-F8HW=QZu9O7Mtt4ryB1prB6cwh+6cwHv9b5bLNw@mail.gmail.com>
 <20180415204054.GA30522@ZenIV.linux.org.uk>
 <20180415215455.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415215455.GB30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 10:54:55PM +0100, Al Viro wrote:
> On Sun, Apr 15, 2018 at 09:40:54PM +0100, Al Viro wrote:
> 
> > BTW, the current placement of cond_resched() looks bogus; suppose we
> > have collected a lot of victims and ran into need_resched().  We leave
> > d_walk() and call shrink_dentry_list().  At that point there's a lot
> > of stuff on our shrink list and anybody else running into them will
> > have to keep scanning.  Giving up the timeslice before we take care
> > of any of those looks like a bad idea, to put it mildly, and that's
> > precisely what will happen.
> > 
> > What about doing that in the end of __dentry_kill() instead?  And to
> > hell with both existing call sites - dput() one (before going to
> > the parent) is obviously covered by that (dentry_kill() only returns
> > non-NULL after having called __dentry_kill()) and in shrink_dentry_list()
> > we'll get to it as soon as we go through all dentries that can be
> > immediately kicked off the shrink list.  Which, AFAICS, improves the
> > situation, now that shrink_lock_dentry() contains no trylock loops...
> > 
> > Comments?
> 
> What I mean is something like this (cumulative diff, it'll obviously need
> to be carved up into 3--4 commits):

... and carved-up version is in vfs.git#work.dcache.  Could syzbot folks
hit it with their reproducers?
