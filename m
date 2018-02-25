Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBYHkl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 02:40:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43912 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBYHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 02:40:38 -0500
Date: Sun, 25 Feb 2018 07:40:05 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [BUG] lock_parent() breakage when used from shrink_dentry_list()
 (was Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in
 shrink_dentry_list())
Message-ID: <20180225073950.GI30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224002248.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 12:22:48AM +0000, Al Viro wrote:
> On Fri, Feb 23, 2018 at 01:35:52PM -0800, Linus Torvalds wrote:
> 
> > This is too subtle, and your fix to check d_lockref.count < 0 sounds
> > wrong to me. If it's really gone, maybe it has been reused and the
> > refcount is positive again, but it's something else than a dentry
> > entirely?
> > 
> > Hmm.
> > 
> > No, you extended the rcu read section, so I guess your patch is fine.
> > And lock_parent already has that pattern, soiit's not new.
> > 
> > Ok, I agree, looks like lock_parent should just re-check that thing
> > that it already checked earler, but that now might be true again
> > because of we dropped d_lock.
> 
> IMO that's the right thing for backports; whether we keep it after
> the getting rid of trylock loops is a different question.  Note that
> the only case where we do not have __dentry_kill() prevention
> guaranteed by the caller (either by holding a reference, or by
> holding onto ->i_lock all along) is in shrink_dentry_list().
> And there we have more than enough of other subtle crap.
> 
> Moreover, there we have a good reason to treat "it had been moved"
> as "kick it off the shrink list and free if it's already dead",
> which might simplify the things.  Below is a stab at that:

FWIW, a variant of that series is in #work.dcache; it's
almost certainly not the final (I want to clean the things up
and probably reorder them as well) and it needs one hell of
profiling and review.  It seems to work, and I don't see any
obvious performance regressions (everything seems to be within
normal noise), but I'd like it beaten up a lot more.

Parts are from John's series, parts are rewritten as discussed
upthread.  As the result, trylock loops are gone and no new
retry loops had been added in their place - lock_parent() still
has one, but that's it.

I'll play with cleaning up and reordering tomorrow after I get
some sleep.  In the meanwhile, the current state of that set is at
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache
