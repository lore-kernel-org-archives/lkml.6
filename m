Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeBWFqa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:46:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44082 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWFq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:46:28 -0500
Date: Fri, 23 Feb 2018 05:46:27 +0000
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
Message-ID: <20180223054626.GB30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-5-john.ogness@linutronix.de>
 <20180223022242.GV30522@ZenIV.linux.org.uk>
 <20180223031214.GW30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223031214.GW30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:12:14AM +0000, Al Viro wrote:

> failed:
> 	spin_unlock(&dentry->d_lock);
> 	spin_lock(&inode->i_lock);
> 	spin_lock(&dentry->d_lock);
> 	parent = lock_parent(dentry);

Hmm...  Negative dentry case obviously is trickier - not to mention oopsen,
it might have become positive under us.  Bugger...  OTOH, it's not much
trickier - with negative dentry we can only fail on trying to lock the
parent, in which case we should just check that it's still negative before
killing it off.  If it has gone positive on us, we'll just unlock the
parent and we are back to the normal "positive dentry, only ->d_lock held"
case.  At most one retry there - once it's positive, it stays positive.
So,

static struct dentry *dentry_kill(struct dentry *dentry)
        __releases(dentry->d_lock)
{
	struct inode *inode = dentry->d_inode;
	struct dentry *parent = NULL;

	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
		goto no_locks;

	if (!IS_ROOT(dentry)) {
		parent = dentry->d_parent;
		if (unlikely(!spin_trylock(&parent->d_lock))) {
			if (inode) {
				spin_unlock(&inode->i_lock);
				goto no_locks;
			}
			goto need_parent;
		}
	}
kill_it:
	__dentry_kill(dentry);
	return parent;

no_locks:	/* positive, only ->d_lock held */
	spin_unlock(&dentry->d_lock);
	spin_lock(&inode->i_lock);
	spin_lock(&dentry->d_lock);
need_parent:
	parent = lock_parent(dentry);
	if (unlikely(dentry->d_lockref.count != 1 || retain_dentry(dentry))) {
		/* we are keeping it, after all */
		if (inode)
			spin_unlock(&inode->i_lock);
		spin_unlock(&dentry->d_lock);
		if (parent)
			spin_unlock(&parent->d_lock);
		return NULL;
	}
	/* it should die */
	if (inode)	/* was positive, ->d_inode unchanged, locks held */
		goto kill_it;
	inode = dentry->d_inode;	// READ_ONCE?
	if (!inode)	/* still negative, locks held */
		goto kill_it;
	/* negative became positive; it can't become negative again */
	if (parent)
		spin_unlock(&parent->d_lock);
	goto no_locks;	/* once */
}
