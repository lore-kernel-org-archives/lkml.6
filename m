Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBWCIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:08:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41064 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBWCIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:08:18 -0500
Date: Fri, 23 Feb 2018 02:08:16 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] fs/dcache: Avoid the try_lock loop in d_delete()
Message-ID: <20180223020816.GU30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222235025.28662-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:50:22AM +0100, John Ogness wrote:

> The trylock loop can be avoided with functionality similar to
> lock_parent(). The fast path tries the trylock first, which is likely
> to succeed. In the contended case it attempts locking in the correct
> order. This requires to drop dentry->d_lock first, which allows
> another task to free d_inode.

Wait a minute.  _What_ allows another task to free ->d_inode on
a dentry we are holding a reference to?  Any place like that is
a serious bug - after all, what's to prevent the same place
doing that to dentry of an opened file, with obvious ugly
results.

That's the whole reason why d_delete() is *NOT* making dentry
negative when refcount is greater than 1 (i.e. when somebody
else is holding a reference).

Rules for ->d_inode:

* initially NULL.

* only changes under ->d_lock

* __dentry_kill() makes it NULL after dentry has been
	+ marked dead
	+ evicted from all lists except possibly shrink one.
  with ->d_lock held through all of that.  The only thing
  that can be done by anybody else with the ones stuck on
  shrink list is actually freeing them.

  Note that once __dentry_kill() is called, that's it - dentry
  is ours, for all practical purposes.  There'd better be no
  other references to that sucker and we make sure that no new
  ones will arise.

* prior to the call of __dentry_kill() any would-be changer
  of ->d_inode must be holding a reference to dentry.

* changes from non-NULL to NULL are possible only when there's
  nobody else holding references.

Changes from NULL to non-NULL _are_ possible (caller must be
holding a reference, but that's it).  However, feeding a negative
dentry to your dentry_lock_inode() is an instant oops - it won't
live to the point where you would recheck ->d_inode for changes.

So if you see any place where positive could be changed to negative
under us, we do have a problem.  Big one.

Refcount can change once we drop ->d_lock, but it can't get to zero -
our reference is still with us.

Note that ->d_parent *CAN* change, no matter how many references are
held.  That's what rcu games in lock_parent() are about - dentry
can be moved and ex-parent could've been freed if that was the last
reference.
