Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBWN5d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:57:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBWN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:57:31 -0500
From: John Ogness <john.ogness@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in shrink_dentry_list()
References: <20180222235025.28662-1-john.ogness@linutronix.de>
        <20180222235025.28662-7-john.ogness@linutronix.de>
        <20180223035814.GZ30522@ZenIV.linux.org.uk>
        <20180223040814.GA30522@ZenIV.linux.org.uk>
Date: Fri, 23 Feb 2018 14:57:23 +0100
In-Reply-To: <20180223040814.GA30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 23 Feb 2018 04:08:14 +0000")
Message-ID: <87h8q7erlo.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I am responding to these comments first because they touch on some
fundemental reasons behind the motivation of the patchset.

On 2018-02-23, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>>> Avoid the trylock loop by using dentry_kill(). When killing dentries
>>> from the dispose list, it is very similar to killing a dentry in
>>> dput(). The difference is that dput() expects to be the last user of
>>> the dentry (refcount=1) and will deref whereas shrink_dentry_list()
>>> expects there to be no user (refcount=0). In order to handle both
>>> situations with the same code, move the deref code from dentry_kill()
>>> into a new wrapper function dentry_put_kill(), which can be used
>>> by previous dentry_kill() users. Then shrink_dentry_list() can use
>>> the dentry_kill() to cleanup the dispose list.
>>> 
>>> This also has the benefit that the locking order is now the same.
>>> First the inode is locked, then the parent.
>> 
>> Current code moves the sucker to the end of list in that case; I'm not
>> at all sure that what you are doing will improve the situation at all...
>> 
>> You *still* have a trylock loop there - only it keeps banging at the
>> same dentry instead of going through the rest first...

What I am doing is a loop, but it is not a trylock loop. The trylocks in
the code only exist as likely() optimization. What I am doing is
spinning on each lock I need in the correct locking order until I get
them all. This is quite different than looping until I chance to get the
locks I need by using only trylocks and in the incorrect locking order.

> Actually, it's even worse - _here_ you are dealing with something that
> really can change inode under you.  This is one and only case where we
> are kicking out a zero-refcount dentry without having already held
> ->i_lock.  At the very least, it's bloody different from regular
> dentry_kill().  In this case, dentry itself is protected from freeing
> by being on the shrink list - that's what makes __dentry_kill() to
> leave the sucker allocated.  We are not holding references, it is
> hashed and anybody could come, pick it, d_delete() it, etc.

Yes, and that is why the new dentry_lock_inode() and dentry_kill()
functions react to any changes in refcount and check for inode
changes. Obviously for d_delete() the helper functions are checking way
more than they need to. But if we've missed the trylock optimization
we're already in the unlikely case, so the extra checks _may_ be
acceptable in order to have simplified code. As Linus already pointed
out, the cost of spinning will likely overshadow the cost of a few
compares.

These patches consolidate the 4 trylocking loops into 3 helper
functions: dentry_lock_inode(), dentry_kill(), dentry_put_kill(). And
these helper functions base off one another. Through that consolidation,
all former trylock-loops are now spinning on locks in the correct
locking order. This will directly address the two problems that are
mentioned in the commit messages: PREEMPT_RT sleeping spinlocks with
priorities and current cpu_relax()/cond_resched() efforts to try to
handle bad luck in trylock loops.

Do you recommend I avoid consolidating the 4 trylock loops into the same
set of helper functions and instead handle them all separately (as is
the case in mainline)?

Or maybe the problem is how my patchset is assembling the final
result. If patch 3 and 4 were refined to address your concerns about
them but then by the end of the 6th patch we still end up where we are
now, is that something that is palatable?

IOW, do the patches only need (possibly a lot of) refinement or do you
consider this approach fundamentally flawed?

John Ogness
