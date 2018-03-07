Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754946AbeCGXdH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:33:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbeCGXdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:33:06 -0500
Date: Wed, 7 Mar 2018 15:33:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 (RESEND)] lockdep: Fix fs_reclaim warning.
Message-Id: <20180307153305.16e5225d8a14d96436235eb1@linux-foundation.org>
In-Reply-To: <201802280650.FJC73911.FOSOMLJVFFQtHO@I-love.SAKURA.ne.jp>
References: <20180129102746.GQ2269@hirez.programming.kicks-ass.net>
        <201801292047.EHC05241.OHSQOJOVtFMFLF@I-love.SAKURA.ne.jp>
        <20180129135547.GR2269@hirez.programming.kicks-ass.net>
        <201802012036.FEE78102.HOMFFOtJVFOSQL@I-love.SAKURA.ne.jp>
        <201802082043.FFJ39503.SVQFFFOJMHLOtO@I-love.SAKURA.ne.jp>
        <201802280650.FJC73911.FOSOMLJVFFQtHO@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 06:50:02 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> 
> This warning is caused by commit d92a8cfcb37ecd13 ("locking/lockdep: Rework
> FS_RECLAIM annotation") which replaced lockdep_set_current_reclaim_state()/
> lockdep_clear_current_reclaim_state() in __perform_reclaim() and
> lockdep_trace_alloc() in slab_pre_alloc_hook() with fs_reclaim_acquire()/
> fs_reclaim_release(). Since __kmalloc_reserve() from __alloc_skb() adds
> __GFP_NOMEMALLOC | __GFP_NOWARN to gfp_mask, and all reclaim path simply
> propagates __GFP_NOMEMALLOC, fs_reclaim_acquire() in slab_pre_alloc_hook()
> is trying to grab the 'fake' lock again when __perform_reclaim() already
> grabbed the 'fake' lock.

That's quite an audit trail.

Shouldn't we be doing a cc:stable here?  If so, which patch do we
identify as being fixed, with "Fixes:"?  d92a8cfcb37ecd13, I assume?

I'd never even noticed fs_reclaim_acquire() and friends before.  I do
wish they had "lockdep" in their names, and a comment to explain what
they do and why they exist.
