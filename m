Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeECM2T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:28:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:28:18 -0400
Date: Thu, 3 May 2018 14:28:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349542.9956.2.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 02:12:22PM +0200, Mike Galbraith wrote:
> [  124.216939] =============================
> [  124.216939] WARNING: suspicious RCU usage
> [  124.216941] 4.17.0.g66d489e-tip-default #82 Tainted: G            E    
> [  124.216941] -----------------------------
> [  124.216943] kernel/sched/core.c:1614 suspicious rcu_dereference_check() usage!
> [  124.216944] 
>                other info that might help us debug this:
> 
> [  124.216945] 
>                RCU used illegally from offline CPU!
>                rcu_scheduler_active = 2, debug_locks = 0
> [  124.216946] 4 locks held by swapper/2/0:
> [  124.216947]  #0: 000000001f9fa447 (stop_cpus_mutex){+.+.}, at: stop_machine_from_inactive_cpu+0x86/0x130
> [  124.216953]  #1: 000000004cb07b3b (&stopper->lock){..-.}, at: cpu_stop_queue_work+0x2d/0x80
> [  124.216958]  #2: 00000000d3a46b90 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0
> [  124.216964]  #3: 00000000f360767b (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x80
> [  124.216969] 
>                stack backtrace:
> [  124.216971] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G            E     4.17.0.g66d489e-tip-default #82
> [  124.216972] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [  124.216973] Call Trace:
> [  124.216977]  dump_stack+0x78/0xb3
> [  124.216979]  ttwu_stat+0x121/0x130
> [  124.216983]  try_to_wake_up+0x2c2/0x5f0
> [  124.216988]  ? cpu_stop_park+0x30/0x30
> [  124.216990]  cpu_stop_queue_work+0x7c/0x80
> [  124.216993]  queue_stop_cpus_work+0x61/0xb0
> [  124.216997]  stop_machine_from_inactive_cpu+0xd3/0x130
> [  124.216999]  ? mtrr_restore+0x80/0x80
> [  124.217005]  mtrr_ap_init+0x62/0x70
> [  124.217008]  identify_secondary_cpu+0x18/0x80
> [  124.217011]  smp_store_cpu_info+0x44/0x50
> [  124.217014]  start_secondary+0x9a/0x1e0
> [  124.217017]  secondary_startup_64+0xa5/0xb0

Hurm.. I don't see how this is 'new'. We moved the wakeup out from under
stopper lock, but that should not affect the RCU state.

The warning is of course valid, stop_machine_from_inactive_cpu()
explicitly run on an 'offline' CPU. The patch didn't change this.
