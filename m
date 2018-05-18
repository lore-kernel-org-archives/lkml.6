Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeERLcP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:32:15 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42025 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeERLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:32:10 -0400
X-Google-Smtp-Source: AB8JxZq1/FrbWo+aFyc5rc3bsKSXJatOu7BWSsbE9njmCsPM42SbyDX6gg7ywS8QlWkAUb4Uv2CK+w==
Date: Fri, 18 May 2018 07:32:05 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 04/10] locking: export osq_lock()/osq_unlock()
Message-ID: <20180518113205.GA16943@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-9-kent.overstreet@gmail.com>
 <20180518095204.GF12217@hirez.programming.kicks-ass.net>
 <20180518101804.GB15403@kmo-pixel>
 <20180518110808.GH12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518110808.GH12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:08:08PM +0200, Peter Zijlstra wrote:
> On Fri, May 18, 2018 at 06:18:04AM -0400, Kent Overstreet wrote:
> > On Fri, May 18, 2018 at 11:52:04AM +0200, Peter Zijlstra wrote:
> > > On Fri, May 18, 2018 at 03:49:06AM -0400, Kent Overstreet wrote:
> > > 
> > > No.. and most certainly not without a _very_ good reason.
> > 
> > Ok, can I ask why?
> 
> Because it is an internal helper for lock implementations that want to
> do optimistic spinning, it isn't a lock on its own and lacks several
> things you would expect.
> 
> Using it is tricky and I don't trust random module authors to get 1+1
> right, let alone use this thing correctly (no judgement on your code,
> just in general).

Yeah, that's true. I just modelled my usage on the rwsem code.

It does strike me that the whole optimistic spin algorithm
(mutex_optimistic_spin() and rwsem_optimistic_spin()) are ripe for factoring
out. They've been growing more optimizations I see, and the optimizations mostly
aren't specific to either locks.

> > Here's what it's for:
> 
> I'll try and have a look soon :-) But does that really _have_ to live in
> a module?

No, I'd be completely fine with moving six locks out of bcachefs, just don't
know that there'd be any other users. But I suppose we do have other filesystems
that use btrees, and that's what they're for.
