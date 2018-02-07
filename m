Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbeBGQ6H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:58:07 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:39011 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754715AbeBGQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:58:05 -0500
Date: Wed, 7 Feb 2018 17:58:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
Message-ID: <20180207165802.GC25219@hirez.programming.kicks-ass.net>
References: <20180206004903.224390-1-joelaf@google.com>
 <20180207080740.GH2269@hirez.programming.kicks-ass.net>
 <CAJWu+orvHb_-fSgtO0NqCai3PPc7fAe7LqNLVVhYbT+Wi-oATg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+orvHb_-fSgtO0NqCai3PPc7fAe7LqNLVVhYbT+Wi-oATg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 08:09:36AM -0800, Joel Fernandes wrote:
> Hi Peter,
> 
> On Wed, Feb 7, 2018 at 12:07 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:
> >
> >> [ 2115.359650] -(1)[106:kswapd0]=================================
> >> [ 2115.359665] -(1)[106:kswapd0][ INFO: inconsistent lock state ]
> >> [ 2115.359684] -(1)[106:kswapd0]4.9.60+ #2 Tainted: G        W  O
> >> [ 2115.359699] -(1)[106:kswapd0]---------------------------------
> >> [ 2115.359715] -(1)[106:kswapd0]inconsistent {RECLAIM_FS-ON-W} ->
> >> {IN-RECLAIM_FS-W} usage.
> >
> > Please don't wrap log output, this is unreadable :/
> 
> Sorry about that, here's the unwrapped output, I'll fix the commit
> message in next rev: https://pastebin.com/e0BNGkaN

So if you trim that leading garbage: "[ 2115.359650] -(1)[106:kswapd0]"
you instantly have half you screen back.

> > Also, the output is from an ancient kernel and doesn't match the current
> > code.
> 
> Right, however the driver hasn't changed and I don't see immediately
> how lockdep handles this differently upstream, so I thought of fixing
> it upstream.

Well, the annotation got a complete rewrite. Granted, it _should_ be
similar, but the output will be different.


> The bail out happens when GFP_FS is *not* set.

Argh, reading is hard.

> Lockdep reports this issue when GFP_FS is infact set, and we enter
> this path and acquire the lock. So lockdep seems to be doing the right
> thing however by design it is reporting a false-positive.

So I'm not seeing how its a false positive. fs/inode.c sets a different
lock class per filesystem type. So recursing on an i_mutex within a
filesystem does sound dodgy.

> The real issue is that the lock being acquired is of the same lock
> class and a different lock instance is acquired under GFP_FS that
> happens to be of the same class.
> 
> So the issue seems to me to be:
> Process A          kswapd
> ---------          ------
> acquire i_mutex    Enter RECLAIM_FS
> 
> Enter RECLAIM_FS   acquire different i_mutex

That's not a false positive, that's a 2 process way of writing i_mutex
recursion.

What are the rules of acquiring two i_mutexes within a filesystem?

> Neil tried to fix this sometime back:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg623909.html
> but it was kind of NAK'ed.

So that got nacked because Neil tried to fix it in the vfs core. Also
not entirely sure that's the same problem.
