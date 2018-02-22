Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeBVFTA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:19:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVFS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:18:59 -0500
Date: Thu, 22 Feb 2018 05:18:57 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs/dcache: Avoid the try_lock loop in d_delete()
Message-ID: <20180222051857.GL30522@ZenIV.linux.org.uk>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216150933.971-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:09:32PM +0100, John Ogness wrote:
> @@ -2378,22 +2420,36 @@ void d_delete(struct dentry * dentry)
>  	/*
>  	 * Are we the only user?
>  	 */
> -again:
>  	spin_lock(&dentry->d_lock);
> +again:
>  	inode = dentry->d_inode;
>  	isdir = S_ISDIR(inode->i_mode);
>  	if (dentry->d_lockref.count == 1) {
> -		if (!spin_trylock(&inode->i_lock)) {
> -			spin_unlock(&dentry->d_lock);
> -			cpu_relax();
> +		/*
> +		 * Lock the inode. Might drop dentry->d_lock temporarily
> +		 * which allows inode to change. Start over if that happens.
> +		 */
> +		if (!dentry_lock_inode(dentry))
>  			goto again;

IDGI.  First of all, why do we need to fetch ->d_inode (and calculate isdir)
before that dentry_lock_inode() of yours?  That's at least partially understandable
in the current version, where we need inode in d_delete() scope, but here it looks
bloody odd.

And if you move those fetches past the call of dentry_lock_inode(), you suddenly
get the life much simpler:

	grab d_lock
	if d_count is greater than 1, drop it and bugger off
	while !dentry_lock_inode(dentry)
		;
	fetch inode
	recheck d_count, in the unlikely case when it's greater than 1,
			drop and bugger off
	clear CANT_MOUNT
	calculate isdir
	unlink_inode
	fsnotify shite

I mean, do we really want to keep rechecking d_count on each loop iteration?
What does it buy us?  Sure, we want to recheck in the end for correctness
sake, but...

It might make sense to move the loop inside dentry_lock_inode(), IMO.
