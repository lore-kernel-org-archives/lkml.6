Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeBWCWp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:22:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41282 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBWCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:22:44 -0500
Date: Fri, 23 Feb 2018 02:22:43 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs/dcache: Avoid the try_lock loops in
 dentry_kill()
Message-ID: <20180223022242.GV30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222235025.28662-5-john.ogness@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:50:23AM +0100, John Ogness wrote:
>  static struct dentry *dentry_kill(struct dentry *dentry)
>  	__releases(dentry->d_lock)
>  {
> -	struct inode *inode = dentry->d_inode;
> -	struct dentry *parent = NULL;
> +	int saved_count = dentry->d_lockref.count;

	Umm...  How can that be not 1?  After all, fast_dput() should
never return false without ->d_lock being held *and* ->d_count being
equal to 1.

> +	/*
> +	 * d_inode might have changed if d_lock was temporarily
> +	 * dropped. If it changed it is necessary to start over
> +	 * because a wrong inode (or no inode) lock is held.
> +	 */

If it might have changed, we are fucked.

> +out_ref_changed:
> +	/*
> +	 * The refcount was incremented while dentry->d_lock was dropped.
> +	 * Just decrement the refcount, unlock, and tell the caller to
> +	 * stop the directory walk.
> +	 */
> +	if (!WARN_ON(dentry->d_lockref.count < 1))
> +		dentry->d_lockref.count--;
> +
>  	spin_unlock(&dentry->d_lock);
> -	return dentry; /* try again with same dentry */
> +
> +	return NULL;

No.  This is completely wrong.  If somebody else has found the sucker
while we dropped the lock and even got around to playing with refcount,
they might have done more than that.

In particular, they might have *dropped* their reference, after e.g.
picking it as our inode's alias and rehashed the fucker.  Making
our decision not to retain it no longer valid.  And your code will
not notice that.
