Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEBWpg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:45:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58918 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeEBWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:45:35 -0400
Date: Wed, 2 May 2018 23:45:33 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu
Subject: Re: [PATCH] dcache: fix quadratic behavior with parallel shrinkers
Message-ID: <20180502224533.GW30522@ZenIV.linux.org.uk>
References: <20180502222635.1862-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502222635.1862-1-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 12:26:35AM +0200, Miklos Szeredi wrote:
> When multiple shrinkers are operating on a directory containing many
> dentries, it takes much longer than if only one shrinker is operating on
> the directory.
> 
> Call the shrinker instances A and B, which shrink DIR containing NUM
> dentries.
> 
> Assume A wins the race for locking DIR's d_lock, then it goes onto moving
> all unlinked dentries to its dispose list.  When it's done, then B will
> scan the directory once again, but will find that all dentries are already
> being shrunk, so it will have an empty dispose list.  Both A and B will
> have found NUM dentries (data.found == NUM).
> 
> Now comes the interesting part: A will proceed to shrink the dispose list
> by killing individual dentries and decrementing the refcount of the parent
> (which is DIR).  NB: decrementing DIR's refcount will block if DIR's d_lock
> is held.  B will shrink a zero size list and then immediately restart
> scanning the directory, where it will lock DIR's d_lock, scan the remaining
> dentries and find no dentry to dispose.
> 
> So that results in B doing the directory scan over and over again, holding
> d_lock of DIR, while A is waiting for a chance to decrement refcount of DIR
> and making very slow progress because of this.  B is wasting time and
> holding up progress of A at the same time.
> 
> Proposed fix is to check this situation in B (found some dentries, but
> all are being shrunk already) and just sleep for some time, before retrying
> the scan.  The sleep is proportional to the number of found dentries.

The thing is, the majority of massive shrink_dcache_parent() can be killed.
Let's do that first and see if anything else is really needed.

As it is, rmdir() and rename() are ridiculously bad - they should only call
shrink_dcache_parent() after successful ->rmdir() or ->rename().  Sure,
there are other places where we do large shrink_dcache_parent() runs,
but those won't trigger in parallel on the same tree.

IOW, let's wait adding complexity until we fix the sources of those calls.
