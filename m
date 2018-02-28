Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbeB1XC2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:02:28 -0500
Received: from imap.thunk.org ([74.207.234.97]:39498 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935256AbeB1XC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:02:27 -0500
Date: Wed, 28 Feb 2018 18:02:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] random: Optimize add_interrupt_randomness
Message-ID: <20180228230210.GC3862@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <20180228214328.23108-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228214328.23108-1-andi@firstfloor.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.

					- Ted

On Wed, Feb 28, 2018 at 01:43:28PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> add_interrupt_randomess always wakes up
> code blocking on /dev/random. This wake up is done
> unconditionally. Unfortunately this means all interrupts
> take the wait queue spinlock, which can be rather expensive
> on large systems processing lots of interrupts.
> 
> We saw 1% cpu time spinning on this on a large macro workload
> running on a large system.
> 
> I believe it's a recent regression (?)
> 
> Always check if there is a waiter on the wait queue
> before waking up. This check can be done without
> taking a spinlock.
> 
> 1.06%         10460  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
>          |
>          ---native_queued_spin_lock_slowpath
>             |
>              --0.57%--_raw_spin_lock_irqsave
>                        |
>                         --0.56%--__wake_up_common_lock
>                                   credit_entropy_bits
>                                   add_interrupt_randomness
>                                   handle_irq_event_percpu
>                                   handle_irq_event
>                                   handle_edge_irq
>                                   handle_irq
>                                   do_IRQ
>                                   common_interrupt
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
