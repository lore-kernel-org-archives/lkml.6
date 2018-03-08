Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755965AbeCHPbG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:31:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:41176 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754822AbeCHPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:31:05 -0500
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 (RESEND)] lockdep: Fix fs_reclaim warning.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180129135547.GR2269@hirez.programming.kicks-ass.net>
        <201802012036.FEE78102.HOMFFOtJVFOSQL@I-love.SAKURA.ne.jp>
        <201802082043.FFJ39503.SVQFFFOJMHLOtO@I-love.SAKURA.ne.jp>
        <201802280650.FJC73911.FOSOMLJVFFQtHO@I-love.SAKURA.ne.jp>
        <20180307153305.16e5225d8a14d96436235eb1@linux-foundation.org>
In-Reply-To: <20180307153305.16e5225d8a14d96436235eb1@linux-foundation.org>
Message-Id: <201803090030.JGG56208.FMOOFOJFLQVSHt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 9 Mar 2018 00:30:37 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 28 Feb 2018 06:50:02 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
> > 
> > This warning is caused by commit d92a8cfcb37ecd13 ("locking/lockdep: Rework
> > FS_RECLAIM annotation") which replaced lockdep_set_current_reclaim_state()/
> > lockdep_clear_current_reclaim_state() in __perform_reclaim() and
> > lockdep_trace_alloc() in slab_pre_alloc_hook() with fs_reclaim_acquire()/
> > fs_reclaim_release(). Since __kmalloc_reserve() from __alloc_skb() adds
> > __GFP_NOMEMALLOC | __GFP_NOWARN to gfp_mask, and all reclaim path simply
> > propagates __GFP_NOMEMALLOC, fs_reclaim_acquire() in slab_pre_alloc_hook()
> > is trying to grab the 'fake' lock again when __perform_reclaim() already
> > grabbed the 'fake' lock.
> 
> That's quite an audit trail.
> 
> Shouldn't we be doing a cc:stable here?  If so, which patch do we
> identify as being fixed, with "Fixes:"?  d92a8cfcb37ecd13, I assume?

Yes please, if you think this patch qualifies for backport.

The test was outdated since v2.6.31, but only v4.14+ seems to trigger this warning.
Thus, I think it is OK to add:

  Fixes: d92a8cfcb37ecd13 ("locking/lockdep: Rework FS_RECLAIM annotation")
  Cc: <stable@vger.kernel.org> # v4.14+

> 
> I'd never even noticed fs_reclaim_acquire() and friends before.  I do
> wish they had "lockdep" in their names, and a comment to explain what
> they do and why they exist.
