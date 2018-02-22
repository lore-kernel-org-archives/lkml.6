Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeBVF3J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:29:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40824 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:29:08 -0500
Date: Thu, 22 Feb 2018 05:29:06 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
Message-ID: <20180222052906.GM30522@ZenIV.linux.org.uk>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de>
 <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de>
 <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
 <87r2pk358g.fsf@linutronix.de>
 <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
 <87lgfs3374.fsf@linutronix.de>
 <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
 <878tbov9i6.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tbov9i6.fsf@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 12:34:57AM +0100, John Ogness wrote:


> Implementation 3: The same as implementation 2 but using if's to
> support branch prediction. This approach is probably the most
> complicated to understand but will be the fastest.
> 
>  		/*
>  		 * Lock the inode. Might drop dentry->d_lock temporarily
>  		 * which allows inode to change. Start over if that happens.
>  		 */
>                 int ret = dentry_lock_inode(dentry);
>                 if (unlikely(ret != LOCK_FAST)) {
>                         if (ret == LOCK_FAILED)
>                                 goto again;
>                         /*
>                          * Recheck refcount as it might have been
>                          * incremented while d_lock was dropped.
>                          */
>                         if (dentry->d_lockref.count != 1)
>                                 goto drop_ref;
>                 }

Implementation 4: screw the tristate, move the loop inside dentry_lock_inode().

> If lock_parent() returns a non-NULL, it is returning
> dentry->d_parent. So the return value is really just a boolean and the
> locked parent is the parent of the dentry. The function is a little bit
> tricky because it could return NULL (lock failed) even if the dentry has
> a non-NULL d_parent. So any caller using a tristate return variation of
> lock_parent() must rely on the return value instead of a non-NULL
> dentry->d_parent.

dentry always has non-NULL ->d_parent; it might point to dentry itself, but
it's never NULL.

>  		if (!dentry->d_lockref.count) {
> -			struct dentry *parent = lock_parent(dentry);
> +			int ret = lock_parent(dentry);
> +			parent = dentry->d_parent;
>  			if (likely(!dentry->d_lockref.count)) {
>  				__dentry_kill(dentry);
>  				dput(parent);

Broken.  In IS_ROOT case you'll hit an extra dput() on dentry itself.
dput(NULL) is no-op; this, OTOH, isn't.
