Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeBTNCJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:02:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeBTNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:05 -0500
Date: Tue, 20 Feb 2018 09:43:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hjl.tools@gmail.com
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
Message-ID: <20180220084354.GO25235@hirez.programming.kicks-ass.net>
References: <20180216150933.971-5-john.ogness@linutronix.de>
 <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de>
 <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
 <87r2pk358g.fsf@linutronix.de>
 <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
 <87lgfs3374.fsf@linutronix.de>
 <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
 <878tbov9i6.fsf@linutronix.de>
 <20180220083937.GX25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220083937.GX25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 09:39:37AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 20, 2018 at 12:34:57AM +0100, John Ogness wrote:
> > Implementation 2: Using switch on a dentry_lock_inode() that returns a
> > tristate value. Does not support branch prediction. This approach is
> > probably easiest to understand.
> > 
> >  		/*
> >  		 * Lock the inode. Might drop dentry->d_lock temporarily
> >  		 * which allows inode to change. Start over if that happens.
> >  		 */
> >                 switch (dentry_lock_inode(dentry)) {
> >                 case LOCK_FAST:
> 
> Bah, I just checked, you cannot use GCC label attributes on statements
> :/ Otherwise you could've done:
> 
> 		case LOCK_FAST: __attribute__((hot));

Oooh shiny, you can actually write:

		switch(__builtin_expect(dentry_lock_inode(dentry), LOCK_FAST)) {

and have that work, see:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59521

> >                         break;
> >                 case LOCK_SLOW:
> >                         /*
> >                          * Recheck refcount as it might have been
> >                          * incremented while d_lock was dropped.
> >                          */
> >                         if (unlikely(dentry->d_lockref.count != 1))
> >                                 goto drop_ref;
> >                         break;
> >                 case LOCK_FAILED:
> >                         goto again;
> >                 }
> > 
