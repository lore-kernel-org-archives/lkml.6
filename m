Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBVFkr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:40:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41008 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBVFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:40:46 -0500
Date: Thu, 22 Feb 2018 05:40:44 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
Message-ID: <20180222054044.GN30522@ZenIV.linux.org.uk>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de>
 <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:03:15AM -0800, Linus Torvalds wrote:
> On Fri, Feb 16, 2018 at 7:09 AM, John Ogness <john.ogness@linutronix.de> wrote:
> > dentry_kill() holds dentry->d_lock and needs to acquire both
> > dentry->d_inode->i_lock and dentry->d_parent->d_lock. This cannot be
> > done with spin_lock() operations because it's the reverse of the
> > regular lock order. To avoid ABBA deadlocks it is done with two
> > trylock loops.
> >
> > Trylock loops are problematic in two scenarios:
> 
> I don't mind this patch series per se (although I would really like Al
> to ack it), but this particular patch I hate.

I'm not happy about the previous patch either.  Why do we need the users
of that thing to deal with retries?  And I'm not even sure we want to
bother with retries on inode change inside dentry_kill() itself - just
unlock, return dentry and let the caller handle that.  Callers *must*
handle "need to drop another one" anyway, so...
