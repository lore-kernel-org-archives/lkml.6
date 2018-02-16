Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161699AbeBPRKU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:10:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161066AbeBPRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:10:19 -0500
Date: Fri, 16 Feb 2018 18:10:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs/dcache: Avoid the try_lock loop in d_delete()
Message-ID: <20180216171013.GI25201@hirez.programming.kicks-ass.net>
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
> +static bool dentry_lock_inode(struct dentry *dentry)
> +{
> +	struct inode *inode = dentry->d_inode;
> +
> +	lockdep_assert_held(&dentry->d_lock);
> +
> +	if (unlikely(!spin_trylock(&inode->i_lock))) {

	if (likely(spin_trylock(&inode->i_lock)))
		return true;

and then unindent by 1 stop the below code:

> +		rcu_read_lock();
> +		spin_unlock(&dentry->d_lock);
> +		spin_lock(&inode->i_lock);
> +		spin_lock(&dentry->d_lock);
> +		rcu_read_unlock();
> +
> +		/*
> +		 * @dentry->d_inode might have changed after dropping
> +		 * @dentry->d_lock. If so, release @inode->i_lock and
> +		 * signal the caller to restart the operation.
> +		 */
> +		if (unlikely(inode != dentry->d_inode)) {
> +			spin_unlock(&inode->i_lock);
> +			return false;
> +		}
> +	}
> +	return true;
> +}
