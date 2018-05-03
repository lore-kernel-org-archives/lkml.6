Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeECMMy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:12:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:12:50 -0400
Message-ID: <1525349542.9956.2.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Date: Thu, 03 May 2018 14:12:22 +0200
In-Reply-To: <20180424133325.GA3179@codeblueprint.co.uk>
References: <20180417142119.GA4511@codeblueprint.co.uk>
         <20180420095005.GH4064@hirez.programming.kicks-ass.net>
         <20180424133325.GA3179@codeblueprint.co.uk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cIqpAzS2YSFCdt0ic9lCT/eorJKOa00niGHKhtTwaUVlt8e165C
 44uf05eLoxLRMZIVqZ9o3CYaY5yBsOWRinlbKkGRYnbw2TByDGk7R63iS5f5QAypAEW4yXt
 k0Sh6CGpK3fO6UdZlmE/WbqupCCPvg55OJ4waEGkYG9jQN8m5qlyktORIm4XsfoPo5p6fzR
 5hzI/cbYdblJykh2TboRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RawK+CGebsc=:G8Bpcm+6O7XltS4C93ljPg
 rSdENGedq2UzI3cxJXlghMxX8tZ/5vgLUroh60fubzIfd30VBHt9NDCGzkGqHGOlPCMjKb+em
 qRzb+i81hBJFuEHGkQStUPY96dApSu6R2rqP5XirR461lHqrMTRFxehQ/C2Eno0wGm1C7Y3Lm
 GCJxbhxfEgKmr5t6Zly2liaGdtdY+oOjVO8oEP4+dQhGSPtGycbWUFmdbl4/Wx7ZlZaWohhkV
 kM0VLKSWtY+dsmyArlardLr2dL5udpRWM7JnJbEKqrcytYq4PJcJW49vAdpNiS4rZyglNp2ij
 t36JKbIO3ELRXpSQ30J1jtrPMWO9ySOI4++7YlZjLPpOzjGLyGQGKaUCgpOxnp84frNN2rRwH
 55he1rcd8/3xofnABON5w5cNMSNNayDPK0WrkgL3ad+G47nCZ2JmxpmYLRHWNC7hceyJ+YhYy
 tRTfRcF9mkgtpDs8JmYEDskshQ48GZC2c2bPCjFL2MDR4TF8Otec10tsrb933fPajzMOLxzpM
 EoZYfcpcrJnch18tEx7IkHKMeI3nCcS9G7ioL3sW1xy7qUZtWnFhD3yPsuSgPLztqk6mVo3rf
 zLwYJzVLykUxZKhLV3IYGyFfA7RQGgZKhPZv9k3WmonrekSiHgcylNSysnlLtsVshAzWnClzT
 GXRa2bwf1SwkLmQ3CvnQPe3j4UjvDzVdnxQOUWHMNk28Zt9zUEVvHQcJ4Rm+8Dh1mVPbs33xy
 EImYi/VRYnvvMtnNdCeBIhJfZNheRLThF8B2ldJaeCdsJ1GDLBMjSHf43YkoTiDNcDxw/08y9
 Oe6kPB7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 14:33 +0100, Matt Fleming wrote:
> On Fri, 20 Apr, at 11:50:05AM, Peter Zijlstra wrote:
> > On Tue, Apr 17, 2018 at 03:21:19PM +0100, Matt Fleming wrote:
> > > Hi guys,
> > > 
> > > We've seen a bug in one of our SLE kernels where the cpu stopper
> > > thread ("migration/15") is entering idle balance. This then triggers
> > > active load balance.
> > > 
> > > At the same time, a task on another CPU triggers a page fault and NUMA
> > > balancing kicks in to try and migrate the task closer to the NUMA node
> > > for that page (we're inside stop_two_cpus()). This faulting task is
> > > spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
> > > !VAL)), waiting for "migration/15" to context switch.
> > > 
> > > Unfortunately, because "migration/15" is doing active load balance
> > > it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
> > > which is already held (since it's inside stop_two_cpus()).
> > > 
> > > Deadlock ensues.
> > 
> > 
> > So if I read that right, something like the following happens:
> > 
> > CPU0					CPU1
> > 
> > schedule(.prev=migrate/0)		<fault>
> >   pick_next_task			  ...
> >     idle_balance			    migrate_swap()
> >       active_balance			      stop_two_cpus()
> > 						spin_lock(stopper0->lock)
> > 						spin_lock(stopper1->lock)
> > 						ttwu(migrate/0)
> > 						  smp_cond_load_acquire() -- waits for schedule()
> >         stop_one_cpu(1)
> > 	  spin_lock(stopper1->lock) -- waits for stopper lock
> 
> Yep, that's exactly right.
> 
> > Fix _this_ deadlock by taking out the wakeups from under stopper->lock.
> > I'm not entirely sure there isn't more dragons here, but this particular
> > one seems fixable by doing that.
> > 
> > Is there any way you can reproduce/test this?
> 
> I'm afraid I don't have any way to test this, but I can ask the
> customer that reported it if they can.
> 
> Either way, this fix looks good to me.

Seems there's another problem there with hotplug.  Virgin tip...

[  122.147601] smpboot: CPU 4 is now offline
[  122.189701] smpboot: CPU 5 is now offline
[  122.225612] smpboot: CPU 6 is now offline
[  122.257760] smpboot: CPU 7 is now offline
[  124.172418] smpboot: CPU 2 is now offline
[  124.209121] smpboot: CPU 3 is now offline
[  124.215810] smpboot: Booting Node 0 Processor 2 APIC 0x4

[  124.216939] =============================
[  124.216939] WARNING: suspicious RCU usage
[  124.216941] 4.17.0.g66d489e-tip-default #82 Tainted: G            E    
[  124.216941] -----------------------------
[  124.216943] kernel/sched/core.c:1614 suspicious rcu_dereference_check() usage!
[  124.216944] 
               other info that might help us debug this:

[  124.216945] 
               RCU used illegally from offline CPU!
               rcu_scheduler_active = 2, debug_locks = 0
[  124.216946] 4 locks held by swapper/2/0:
[  124.216947]  #0: 000000001f9fa447 (stop_cpus_mutex){+.+.}, at: stop_machine_from_inactive_cpu+0x86/0x130
[  124.216953]  #1: 000000004cb07b3b (&stopper->lock){..-.}, at: cpu_stop_queue_work+0x2d/0x80
[  124.216958]  #2: 00000000d3a46b90 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0
[  124.216964]  #3: 00000000f360767b (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x80
[  124.216969] 
               stack backtrace:
[  124.216971] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G            E     4.17.0.g66d489e-tip-default #82
[  124.216972] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  124.216973] Call Trace:
[  124.216977]  dump_stack+0x78/0xb3
[  124.216979]  ttwu_stat+0x121/0x130
[  124.216983]  try_to_wake_up+0x2c2/0x5f0
[  124.216988]  ? cpu_stop_park+0x30/0x30
[  124.216990]  cpu_stop_queue_work+0x7c/0x80
[  124.216993]  queue_stop_cpus_work+0x61/0xb0
[  124.216997]  stop_machine_from_inactive_cpu+0xd3/0x130
[  124.216999]  ? mtrr_restore+0x80/0x80
[  124.217005]  mtrr_ap_init+0x62/0x70
[  124.217008]  identify_secondary_cpu+0x18/0x80
[  124.217011]  smp_store_cpu_info+0x44/0x50
[  124.217014]  start_secondary+0x9a/0x1e0
[  124.217017]  secondary_startup_64+0xa5/0xb0

[  124.218433] ======================================================
[  124.218433] WARNING: possible circular locking dependency detected
[  124.218433] 4.17.0.g66d489e-tip-default #82 Tainted: G            E    
[  124.218434] ------------------------------------------------------
[  124.218434] swapper/2/0 is trying to acquire lock:
[  124.218434] 000000006b311cf8 ((console_sem).lock){-...}, at: down_trylock+0xf/0x30

[  124.218436] but task is already holding lock:
[  124.218436] 00000000d3a46b90 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0

[  124.218438] which lock already depends on the new lock.


[  124.218438] the existing dependency chain (in reverse order) is:

[  124.218439] -> #1 (&p->pi_lock){-.-.}:
[  124.218440]        lock_acquire+0xbd/0x200
[  124.218440]        _raw_spin_lock_irqsave+0x4c/0x60
[  124.218441]        try_to_wake_up+0x2d/0x5f0
[  124.218441]        up+0x40/0x50
[  124.218441]        __up_console_sem+0x41/0x80
[  124.218441]        console_unlock+0x398/0x6b0
[  124.218442]        do_con_write.part.20+0x71b/0x9d0
[  124.218442]        con_write+0x55/0x60
[  124.218442]        do_output_char+0x181/0x200
[  124.218442]        n_tty_write+0x20a/0x460
[  124.218443]        tty_write+0x14a/0x2b0
[  124.218443]        do_iter_write+0x144/0x180
[  124.218443]        vfs_writev+0x71/0xd0
[  124.218444]        do_writev+0x51/0xd0
[  124.218444]        do_syscall_64+0x60/0x210
[  124.218444]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  124.218445] -> #0 ((console_sem).lock){-...}:
[  124.218446]        __lock_acquire+0x436/0x770
[  124.218446]        lock_acquire+0xbd/0x200
[  124.218446]        _raw_spin_lock_irqsave+0x4c/0x60
[  124.218447]        down_trylock+0xf/0x30
[  124.218447]        __down_trylock_console_sem+0x37/0xa0
[  124.218447]        console_trylock+0x13/0x60
[  124.218447]        vprintk_emit+0x237/0x460
[  124.218448]        printk+0x48/0x4a
[  124.218448]        lockdep_rcu_suspicious+0x26/0x100
[  124.218448]        ttwu_stat+0x121/0x130
[  124.218449]        try_to_wake_up+0x2c2/0x5f0
[  124.218449]        cpu_stop_queue_work+0x7c/0x80
[  124.218449]        queue_stop_cpus_work+0x61/0xb0
[  124.218450]        stop_machine_from_inactive_cpu+0xd3/0x130
[  124.218450]        mtrr_ap_init+0x62/0x70
[  124.218450]        identify_secondary_cpu+0x18/0x80
[  124.218450]        smp_store_cpu_info+0x44/0x50
[  124.218451]        start_secondary+0x9a/0x1e0
[  124.218451]        secondary_startup_64+0xa5/0xb0

[  124.218451] other info that might help us debug this:

[  124.218452]  Possible unsafe locking scenario:

[  124.218452]        CPU0                    CPU1
[  124.218453]        ----                    ----
[  124.218453]   lock(&p->pi_lock);
[  124.218454]                                lock((console_sem).lock);
[  124.218454]                                lock(&p->pi_lock);
[  124.218455]   lock((console_sem).lock);

[  124.218456]  *** DEADLOCK ***

[  124.218456] 4 locks held by swapper/2/0:
[  124.218456]  #0: 000000001f9fa447 (stop_cpus_mutex){+.+.}, at: stop_machine_from_inactive_cpu+0x86/0x130
[  124.218458]  #1: 000000004cb07b3b (&stopper->lock){..-.}, at: cpu_stop_queue_work+0x2d/0x80
[  124.218459]  #2: 00000000d3a46b90 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0
[  124.218460]  #3: 00000000f360767b (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x80

[  124.218462] stack backtrace:
[  124.218462] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G            E     4.17.0.g66d489e-tip-default #82
[  124.218462] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  124.218463] Call Trace:
[  124.218463]  dump_stack+0x78/0xb3
[  124.218463]  print_circular_bug.isra.38+0x1f3/0x200
[  124.218463]  check_prev_add.constprop.46+0x717/0x730
[  124.218464]  validate_chain.isra.42+0x652/0x980
[  124.218464]  __lock_acquire+0x436/0x770
[  124.218464]  lock_acquire+0xbd/0x200
[  124.218464]  ? down_trylock+0xf/0x30
[  124.218465]  ? vprintk_emit+0x237/0x460
[  124.218465]  _raw_spin_lock_irqsave+0x4c/0x60
[  124.218465]  ? down_trylock+0xf/0x30
[  124.218466]  down_trylock+0xf/0x30
[  124.218466]  __down_trylock_console_sem+0x37/0xa0
[  124.218466]  console_trylock+0x13/0x60
[  124.218466]  vprintk_emit+0x237/0x460
[  124.218467]  printk+0x48/0x4a
[  124.218467]  lockdep_rcu_suspicious+0x26/0x100
[  124.218467]  ttwu_stat+0x121/0x130
[  124.218467]  try_to_wake_up+0x2c2/0x5f0
[  124.218468]  ? cpu_stop_park+0x30/0x30
[  124.218468]  cpu_stop_queue_work+0x7c/0x80
[  124.218468]  queue_stop_cpus_work+0x61/0xb0
[  124.218468]  stop_machine_from_inactive_cpu+0xd3/0x130
[  124.218469]  ? mtrr_restore+0x80/0x80
[  124.218469]  mtrr_ap_init+0x62/0x70
[  124.218469]  identify_secondary_cpu+0x18/0x80
[  124.218469]  smp_store_cpu_info+0x44/0x50
[  124.218470]  start_secondary+0x9a/0x1e0
[  124.218470]  secondary_startup_64+0xa5/0xb0
[  124.478753] smpboot: Booting Node 0 Processor 3 APIC 0x6
