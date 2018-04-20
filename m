Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeDTISB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:18:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeDTIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:17:58 -0400
Date: Fri, 20 Apr 2018 10:17:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@fb.com
Subject: Re: [PATCH] lockdep: fix fs_reclaim annotation
Message-ID: <20180420081742.GC4064@hirez.programming.kicks-ass.net>
References: <9f8aa70652a98e98d7c4de0fc96a4addcee13efe.1523778026.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8aa70652a98e98d7c4de0fc96a4addcee13efe.1523778026.git.osandov@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 12:42:25AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> While revisiting my Btrfs swapfile series [1], I introduced a situation
> in which reclaim would lock i_rwsem, and even though the swapon() path
> clearly made GFP_KERNEL allocations while holding i_rwsem, I got no
> complaints from lockdep. It turns out that the rework of the fs_reclaim
> annotation was broken: if the current task has PF_MEMALLOC set, we don't
> acquire the dummy fs_reclaim lock, but when reclaiming we always check
> this _after_ we've just set the PF_MEMALLOC flag. In most cases, we can
> fix this by moving the fs_reclaim_{acquire,release}() outside of the
> memalloc_noreclaim_{save,restore}(), althought kswapd is slightly
> different. After applying this, I got the expected lockdep splats.
> 
> 1: https://lwn.net/Articles/625412/
> Fixes: d92a8cfcb37e ("locking/lockdep: Rework FS_RECLAIM annotation")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Urgh, thanks for fixing that!
