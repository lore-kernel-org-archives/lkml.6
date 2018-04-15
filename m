Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDOUlC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 16:41:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52994 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeDOUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 16:41:00 -0400
Date: Sun, 15 Apr 2018 21:40:54 +0100
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
Message-ID: <20180415204054.GA30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com>
 <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
 <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
 <20180414205846.GW30522@ZenIV.linux.org.uk>
 <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
 <20180415005056.GX30522@ZenIV.linux.org.uk>
 <CA+55aFwB0A-F8HW=QZu9O7Mtt4ryB1prB6cwh+6cwHv9b5bLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFwB0A-F8HW=QZu9O7Mtt4ryB1prB6cwh+6cwHv9b5bLNw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 11:34:17AM -0700, Linus Torvalds wrote:

> No, it's obviously not type-safe, but at least it's _legible_, and is
> a pattern, while that "let's randomly just do a cast in the middle of
> the code" is just nasty.

Sure, no problem...  I really wish there was a way to say

void foo(int (*f)(α *), α *data) ∀ α

and have the compiler verify that foo(f, v) is done only
when f(v) is well-typed, but that's C, not Haskell...  The best
approximation is something along the lines of

void __foo(int (*f)(void *), void *data);
#define foo(f, v) (sizeof((f)((v)), 0), __foo((f),(v)))

and that relies upon the identical calling sequence for all pointer
arguments.  AFAIK, it's true for all ABIs we support, but...
Worse, there's no way to get #define in macro expansion, so the
above would be impossible to hide behind anything convenient ;-/

> Side note: I do feel like "d_walk()" should be returning whether it
> terminated early or not. For example, this very same code in the
> caller does
> 
> +               struct dentry *victim = NULL;
> +               d_walk(dentry, &victim, find_submount);
> +               if (!victim) {
> 
> but in many ways it would be more natural to just check the exit condition, and
> 
> +               struct dentry *victim;
> +               if (!d_walk(dentry, &victim, find_submount)) {
> 
> don't you think? Because that matches the actual setting condition in
> the find_submount() callback.
> 
> There are other situations where the same thing is true: that
> path_check_mount() currently has that "info->mounted" flag, but again,
> it could be replaced by just checking what the quit condition was, and
> whether we terminated early or not. Because the two are 100%
> equivalent, and the return value in many ways would be more logical, I
> feel.
> 
> (I'm not sure if we should just return the actual exit condition -
> defaulting to D_WALK_CONTINUE if there was nothing to walk at all - or
> whether we should just return a boolean for "terminated early")
> 
> Hmm?

Not sure...   There are 5 callers:
	* do_one_tree(), d_genocide() - nothing to return
	* path_has_submounts(), d_invalidate() - could use your trick,
but d_invalidate() wants to look at victim if not buggering off, so
that one doesn't win much
	* shrink_dcache_parent() - no way to use that.  Here we normally
run the walk to completion and need to repeat it in all cases of early
termination *and* in some of the ran-to-completion cases.

BTW, the current placement of cond_resched() looks bogus; suppose we
have collected a lot of victims and ran into need_resched().  We leave
d_walk() and call shrink_dentry_list().  At that point there's a lot
of stuff on our shrink list and anybody else running into them will
have to keep scanning.  Giving up the timeslice before we take care
of any of those looks like a bad idea, to put it mildly, and that's
precisely what will happen.

What about doing that in the end of __dentry_kill() instead?  And to
hell with both existing call sites - dput() one (before going to
the parent) is obviously covered by that (dentry_kill() only returns
non-NULL after having called __dentry_kill()) and in shrink_dentry_list()
we'll get to it as soon as we go through all dentries that can be
immediately kicked off the shrink list.  Which, AFAICS, improves the
situation, now that shrink_lock_dentry() contains no trylock loops...

Comments?
