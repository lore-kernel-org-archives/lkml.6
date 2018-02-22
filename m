Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeBVIfv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:35:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeBVIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:35:47 -0500
From: John Ogness <john.ogness@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs/dcache: Avoid the try_lock loop in d_delete()
References: <20180216150933.971-1-john.ogness@linutronix.de>
        <20180216150933.971-4-john.ogness@linutronix.de>
        <20180222051857.GL30522@ZenIV.linux.org.uk>
Date: Thu, 22 Feb 2018 09:35:42 +0100
In-Reply-To: <20180222051857.GL30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Thu, 22 Feb 2018 05:18:57 +0000")
Message-ID: <87bmgh4e1t.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-22, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>> @@ -2378,22 +2420,36 @@ void d_delete(struct dentry * dentry)
>>  	/*
>>  	 * Are we the only user?
>>  	 */
>> -again:
>>  	spin_lock(&dentry->d_lock);
>> +again:
>>  	inode = dentry->d_inode;
>>  	isdir = S_ISDIR(inode->i_mode);
>>  	if (dentry->d_lockref.count == 1) {
>> -		if (!spin_trylock(&inode->i_lock)) {
>> -			spin_unlock(&dentry->d_lock);
>> -			cpu_relax();
>> +		/*
>> +		 * Lock the inode. Might drop dentry->d_lock temporarily
>> +		 * which allows inode to change. Start over if that happens.
>> +		 */
>> +		if (!dentry_lock_inode(dentry))
>>  			goto again;
>
> IDGI.  First of all, why do we need to fetch ->d_inode (and calculate
> isdir) before that dentry_lock_inode() of yours? That's at least
> partially understandable in the current version, where we need inode
> in d_delete() scope, but here it looks bloody odd.

I tried to change the function as little as possible. You are right that
it now looks odd. I seem to have missed the forest for the trees.

> And if you move those fetches past the call of dentry_lock_inode(),
> you suddenly get the life much simpler:
>
> 	grab d_lock
> 	if d_count is greater than 1, drop it and bugger off
> 	while !dentry_lock_inode(dentry)
> 		;
> 	fetch inode
> 	recheck d_count, in the unlikely case when it's greater than 1,
> 			drop and bugger off
> 	clear CANT_MOUNT
> 	calculate isdir
> 	unlink_inode
> 	fsnotify shite
>
> I mean, do we really want to keep rechecking d_count on each loop
> iteration?  What does it buy us?  Sure, we want to recheck in the end
> for correctness sake, but...

I have been unable to produce a test case where dentry_lock_inode() can
fail. AFAICT it is not possible from userspace. Perhaps some filesystem
could trigger it. But if it would fail, getting the refcount to increase
in the dropped d_lock window is quite easy to reproduce. And in that
case we wouldn't need to keep trying to aquire the inode lock and could
just drop.
        
> It might make sense to move the loop inside dentry_lock_inode(), IMO.

Agreed. I will change dentry_lock_inode() so that it will only fail if
the refcount changes. If there are inode changes, it will loop
internally. That will change your suggestion to:

 	grab d_lock
 	if d_count is greater than 1
 	 	drop it and bugger off
 	if !dentry_lock_inode(dentry)
	 	drop it and bugger off
 	fetch inode
 	clear CANT_MOUNT
 	calculate isdir
 	unlink_inode
 	fsnotify shite

John Ogness
