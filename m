Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeBWEIR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:08:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42786 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBWEIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:08:15 -0500
Date: Fri, 23 Feb 2018 04:08:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in
 shrink_dentry_list()
Message-ID: <20180223040814.GA30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223035814.GZ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:58:14AM +0000, Al Viro wrote:
> On Fri, Feb 23, 2018 at 12:50:25AM +0100, John Ogness wrote:
> 
> > Avoid the trylock loop by using dentry_kill(). When killing dentries
> > from the dispose list, it is very similar to killing a dentry in
> > dput(). The difference is that dput() expects to be the last user of
> > the dentry (refcount=1) and will deref whereas shrink_dentry_list()
> > expects there to be no user (refcount=0). In order to handle both
> > situations with the same code, move the deref code from dentry_kill()
> > into a new wrapper function dentry_put_kill(), which can be used
> > by previous dentry_kill() users. Then shrink_dentry_list() can use
> > the dentry_kill() to cleanup the dispose list.
> > 
> > This also has the benefit that the locking order is now the same.
> > First the inode is locked, then the parent.
> 
> Current code moves the sucker to the end of list in that case; I'm not
> at all sure that what you are doing will improve the situation at all...
> 
> You *still* have a trylock loop there - only it keeps banging at the
> same dentry instead of going through the rest first...

Actually, it's even worse - _here_ you are dealing with something that
really can change inode under you.  This is one and only case where
we are kicking out a zero-refcount dentry without having already held
->i_lock.  At the very least, it's bloody different from regular
dentry_kill().  In this case, dentry itself is protected from freeing
by being on the shrink list - that's what makes __dentry_kill() to
leave the sucker allocated.   We are not holding references, it is
hashed and anybody could come, pick it, d_delete() it, etc.
