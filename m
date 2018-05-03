Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeECNdL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:33:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:57611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECNdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:33:09 -0400
Message-ID: <1525354359.5576.1.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 15:32:39 +0200
In-Reply-To: <20180503124943.GB12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
         <20180420095005.GH4064@hirez.programming.kicks-ass.net>
         <20180424133325.GA3179@codeblueprint.co.uk>
         <1525349542.9956.2.camel@gmx.de>
         <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
         <1525351221.9956.4.camel@gmx.de>
         <20180503124943.GB12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aK8QKnh4etXQw6uhHvdQaAdp+fRJp9G4+bqYDGxaEp+qAz2Qzjg
 mb16hUlonk4ipJHOJl2c4BfsfIUfUWpHjR03fWAiwvN40nu+/H9Zy5kp8INgTQPEje06JNu
 0jbh1BbiAeiArK4XXMX8FsBm/Zzz3abYW4mWGOrs5BtQECEpxyBMxfzdDvGQzot179VYd8g
 ZzEb+kzpSMIp94QcdOkcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vUOH3PbNqqk=:MbXnfJzpiNK4Brd4Prlmlg
 dX/yZG2k49Fmeou9bOpXleLi66IqA9Pi2hlgQA1k6UJ8FYbadbzcB341c/9tYFSxHUA4mip+p
 4nvQTIp36nZgxrgSuSrY6JelUIDKlkZHc8NLqA1A9rJlO2nXdBwyOvdXUalKeCrVsYaM676n/
 bMCL0o9ts9VHe//UF06TOoBM+PAafOFiLK2Q0Yng7kvv0QT0UMIzwJ/ZficwHc28CESx+ni0n
 Q1a+TbF3xpc2xVwQOaNUjTDWW9y+rf3/b8T9v04UAnu2IHKC19CUlJGoAKobREaLj8Ilyc3wU
 y3TKjU07qyu7oIIhpjIXr3shsokiD6TmuTHSS7qZW1ycU+DBVUOV5Wr4mfNP0xKCbzPoqwaZq
 BN/vXvPWJI8Ci3aGKCceGLr1JcW7QahDS+PBIVwDx+edKJnAP9oOlcS1ftAh9qecGclF2vmAx
 WyhsvFh1EabLFFtGaxmUWt5zn/S79qZZvz2iw+031XXarXI8x9oM5C7ve3kW0ejT1kZHshy/D
 6Fc4PgL5zkb/lAf9E5K7xO4aW3Paj/K2g8hc7L3TrYMmrHOYySrFA2VS/S2CcaGQGmT3Rpjc0
 Op267rmRswv7yK02/V0NcyvcoeNvTvHEFYTOY2wHCmVscS9eGEpMTzV3MeHHkQxa8uFfzo1XO
 EFAjsy0QkMNnPllfqMTFBLlu09+AkxfYW6XIg1Uky7nHjLenU1CEibrQTT8pLnC0q2e6py+Km
 4iKngEKe7vq66DFZEUtw/qubBoKVI74RJoXpXCMgMgYWf2cU0Zdr8oAJpjBs1/yrjn8jL18qQ
 zDQWXN1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 14:49 +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 02:40:21PM +0200, Mike Galbraith wrote:
> > On Thu, 2018-05-03 at 14:28 +0200, Peter Zijlstra wrote:
> > > 
> > > Hurm.. I don't see how this is 'new'. We moved the wakeup out from under
> > > stopper lock, but that should not affect the RCU state.
> > 
> > No, not new, just an additional woes from same spot.
> 
> Ah, ok. Does somsething like this make it go away?

Dang.  With $subject fix applied as well..

[  151.103732] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  151.104908] =============================
[  151.104909] WARNING: suspicious RCU usage
[  151.104910] 4.17.0.g66d489e-tip-default #84 Tainted: G            E    
[  151.104911] -----------------------------
[  151.104912] kernel/sched/core.c:1625 suspicious rcu_dereference_check() usage!
[  151.104913] 
               other info that might help us debug this:

[  151.104914] 
               RCU used illegally from offline CPU!
               rcu_scheduler_active = 2, debug_locks = 0
[  151.104916] 3 locks held by swapper/2/0:
[  151.104916]  #0: 00000000560adb60 (stop_cpus_mutex){+.+.}, at: stop_machine_from_inactive_cpu+0x86/0x140
[  151.104923]  #1: 00000000e4fb0238 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0
[  151.104929]  #2: 000000003341403b (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x80
[  151.104934] 
               stack backtrace:
[  151.104937] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G            E     4.17.0.g66d489e-tip-default #84
[  151.104938] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  151.104938] Call Trace:
[  151.104942]  dump_stack+0x78/0xb3
[  151.104945]  ttwu_stat+0x121/0x130
[  151.104949]  try_to_wake_up+0x2c2/0x5f0
[  151.104953]  ? cpu_stop_park+0x30/0x30
[  151.104956]  wake_up_q+0x4a/0x70
[  151.104959]  cpu_stop_queue_work+0x6b/0xa0
[  151.104963]  queue_stop_cpus_work+0x61/0xb0
[  151.104968]  stop_machine_from_inactive_cpu+0xd8/0x140
[  151.104970]  ? mtrr_restore+0x80/0x80
[  151.104976]  mtrr_ap_init+0x62/0x70
[  151.104979]  identify_secondary_cpu+0x18/0x80
[  151.104982]  smp_store_cpu_info+0x44/0x50
[  151.104985]  start_secondary+0x9a/0x1e0
[  151.104988]  secondary_startup_64+0xa5/0xb0

> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index f89014a2c238..a32518c2ba4a 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -650,8 +650,10 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
>  	/* Schedule work on other CPUs and execute directly for local CPU */
>  	set_state(&msdata, MULTI_STOP_PREPARE);
>  	cpu_stop_init_done(&done, num_active_cpus());
> -	queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop, &msdata,
> -			     &done);
> +
> +	RCU_NONIDLE(queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop,
> +				         &msdata, &done));
> +
>  	ret = multi_cpu_stop(&msdata);
>  
>  	/* Busy wait for completion. */
