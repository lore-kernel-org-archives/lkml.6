Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeBEOC2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:02:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeBEOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:02:21 -0500
Date: Mon, 5 Feb 2018 15:02:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: efault@gmx.de, linux-kernel@vger.kernel.org,
        alexander.levin@verizon.com, tglx@linutronix.de, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Runqueue spinlock recursion on arm64 v4.15
Message-ID: <20180205140201.GY2269@hirez.programming.kicks-ass.net>
References: <20180202192704.nqwjsthl3agszhzt@lakrids.cambridge.arm.com>
 <20180202195506.GP2269@hirez.programming.kicks-ass.net>
 <20180202220726.23d4ljxxdysafbxd@salmiak>
 <20180205133600.etr32unq6amsa6af@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205133600.etr32unq6amsa6af@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 01:36:00PM +0000, Mark Rutland wrote:
> On Fri, Feb 02, 2018 at 10:07:26PM +0000, Mark Rutland wrote:
> > On Fri, Feb 02, 2018 at 08:55:06PM +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 02, 2018 at 07:27:04PM +0000, Mark Rutland wrote:
> > > > ... in some cases, owner_cpu is -1, so I guess we're racing with an
> > > > unlock. I only ever see this on the runqueue locks in wake up functions.
> > > 
> > > So runqueue locks are special in that the owner changes over a contex
> > > switch, maybe something goes funny there?
> > 
> > Aha! I think that's it!
> > 
> > In finish_lock_switch() we do:
> > 
> > 	smp_store_release(&prev->on_cpu, 0);
> > 	...
> > 	rq->lock.owner = current;
> > 
> > As soon as we update prev->on_cpu, prev can be scheduled on another CPU, and
> > can thus see a stale value for rq->lock.owner (e.g. if it tries to wake up
> > another task on that rq).
> 
> I hacked in a forced vCPU preemption between the two using a sled of WFE
> instructions, and now I can trigger the problem in seconds rather than
> hours.
> 
> With the patch below applied, things seem to fine so far.
> 
> So I'm pretty sure this is it. I'll clean up the patch text and resend
> that in a bit.

Also try and send it against an up-to-date scheduler tree, we just
moved some stuff around just about there.
