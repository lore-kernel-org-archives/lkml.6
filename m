Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeERKOA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:14:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36925 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeERKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:13:58 -0400
X-Google-Smtp-Source: AB8JxZp8KJ2mlEoj5pVZ5WMnSpsZlG+NXYfzJPuqfdpVgcgKi3DBZGrlCvsO8d9gv/ZX9oNjlkmwFA==
Date: Fri, 18 May 2018 06:13:53 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 03/10] locking: bring back lglocks
Message-ID: <20180518101353.GA15403@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-7-kent.overstreet@gmail.com>
 <20180518095102.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518095102.GE12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:51:02AM +0200, Peter Zijlstra wrote:
> On Fri, May 18, 2018 at 03:49:04AM -0400, Kent Overstreet wrote:
> > bcachefs makes use of them - also, add a proper lg_lock_init()
> 
> Why?! lglocks are horrid things, we got rid of them for a reason. They
> have terrifying worst case preemption off latencies.

Ah. That was missing from your commit message.

> Why can't you use something like per-cpu rwsems?

Well,

 a) in my use case, lg_global_lock() pretty much isn't used in normal operation,
    it's only called when starting mark and sweep gc (which is not needed
    anymore and disabled by default, it'll eventually get rolled into online
    fsck) and for device resize

 b) I'm using it in conjection with percpu counters, and technically yes I
    certainly _could_ use per-cpu sleepable locks (mutexes would make more sense
    for me than rwsems), there's a bit of a clash there and it's going to be a
    bit ugly and messy and it's more work for me. (this_cpu_ptr() no longer
    makes any sense in that case, so it'd mean auditing and converting all the
    code that touches the relevant data structures).

If you're really that dead set against lglocks I might just come up with a new
lock with similar semantics, that doesn't break this_cpu_ptr() but sleeps if the
global lock is held...
