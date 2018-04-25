Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDYHJe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:09:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDYHJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:09:30 -0400
Date: Wed, 25 Apr 2018 09:09:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@fb.com
Subject: Re: [PATCH] lockdep: fix fs_reclaim annotation
Message-ID: <20180425070912.GZ4043@hirez.programming.kicks-ass.net>
References: <9f8aa70652a98e98d7c4de0fc96a4addcee13efe.1523778026.git.osandov@fb.com>
 <20180420081742.GC4064@hirez.programming.kicks-ass.net>
 <20180424225834.GB28295@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424225834.GB28295@vader>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:58:34PM -0700, Omar Sandoval wrote:
> On Fri, Apr 20, 2018 at 10:17:42AM +0200, Peter Zijlstra wrote:
> > On Sun, Apr 15, 2018 at 12:42:25AM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > While revisiting my Btrfs swapfile series [1], I introduced a situation
> > > in which reclaim would lock i_rwsem, and even though the swapon() path
> > > clearly made GFP_KERNEL allocations while holding i_rwsem, I got no
> > > complaints from lockdep. It turns out that the rework of the fs_reclaim
> > > annotation was broken: if the current task has PF_MEMALLOC set, we don't
> > > acquire the dummy fs_reclaim lock, but when reclaiming we always check
> > > this _after_ we've just set the PF_MEMALLOC flag. In most cases, we can
> > > fix this by moving the fs_reclaim_{acquire,release}() outside of the
> > > memalloc_noreclaim_{save,restore}(), althought kswapd is slightly
> > > different. After applying this, I got the expected lockdep splats.
> > > 
> > > 1: https://lwn.net/Articles/625412/
> > > Fixes: d92a8cfcb37e ("locking/lockdep: Rework FS_RECLAIM annotation")
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > Urgh, thanks for fixing that!
> 
> Is this going to go through the tip tree? Should Andrew take it?

It's all mm/ code now... so I guess Andrew would be the one routing it.
