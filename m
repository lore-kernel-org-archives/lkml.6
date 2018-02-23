Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBWDsa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:48:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42502 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWDs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:48:29 -0500
Date: Fri, 23 Feb 2018 03:48:27 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] fs/dcache: Avoid a try_lock loop in
 shrink_dentry_list()
Message-ID: <20180223034827.GY30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222235025.28662-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:50:24AM +0100, John Ogness wrote:
> -		while (dentry && !lockref_put_or_lock(&dentry->d_lockref)) {
> -			parent = lock_parent(dentry);
> -			if (dentry->d_lockref.count != 1) {
> -				dentry->d_lockref.count--;
> -				spin_unlock(&dentry->d_lock);
> -				if (parent)
> -					spin_unlock(&parent->d_lock);
> -				break;
> -			}
> -			inode = dentry->d_inode;	/* can't be NULL */
> -			if (unlikely(!spin_trylock(&inode->i_lock))) {
> -				spin_unlock(&dentry->d_lock);
> -				if (parent)
> -					spin_unlock(&parent->d_lock);
> -				cpu_relax();
> -				continue;
> -			}
> -			__dentry_kill(dentry);
> -			dentry = parent;
> -		}
> +		while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
> +			dentry = dentry_kill(dentry);

Hmm...  OK, that's interesting.  I agree that it looks similar to dentry_kill()
loop, with one exception - here we are aggressively pruning the branch.  None
of the "do we want to retain that sucker" stuff here.  It doesn't matter for
most of the callers, with one exception: prune_dcache_sb().  OTOH, there it
just might be the right thing to do anyway - after all, it matters only if
somebody has grabbed and dropped the sucker while we'd been trying to do
lock_parent().  Had we lost the race with their dput(), we would've left
the damn thing alone, and we are called from a memory shrinker, so we'll get
called again if needed.
