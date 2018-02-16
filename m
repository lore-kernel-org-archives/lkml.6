Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755745AbeBPRao (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:30:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeBPRan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:30:43 -0500
Date: Fri, 16 Feb 2018 18:30:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] fs/dcache: Avoid the try_lock loop in d_delete()
Message-ID: <20180216173033.GJ25201@hirez.programming.kicks-ass.net>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216150933.971-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:09:32PM +0100, John Ogness wrote:
> 
>    inode = dentry->d_inode;
>    rcu_read_lock();         <- Protects d_inode from being freed,
>                                i.e. dentry->d_inode is a valid pointer
>                                even after dentry->d_lock is dropped
>    unlock(dentry->d_lock);
>    lock(inode->i_lock);
>    lock(dentry->d_lock);
>    rcu_read_unlock();

So that is entirely tricky, typically we have to have a lookup _after_
rcu_read_lock().

Here, we rely on not being able to call dentry_free() while we hold
d_lock, which ensure dentry must be valid in the freshly started
rcu-section.

And I suppose that same ensures dentry->d_ionde stays alive. But this
needs a comment at least.
