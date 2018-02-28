Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeB1P7u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932230AbeB1P7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:59:48 -0500
Date: Wed, 28 Feb 2018 16:59:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: kernel test robot <shun.hao@intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [lkp-robot] [printk]  c162d5b433: BUG:KASAN:use-after-scope_in_c
Message-ID: <20180228155941.34z45rjz3bjqde7w@pathway.suse.cz>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian>
 <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-02-28 11:23:34, Petr Mladek wrote:
> On Sat 2018-02-24 13:34:05, kernel test robot wrote:
> > TO: Petr Mladek <pmladek@suse.com>
> > CC: Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt (VMware) <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org, lkp@01.org
> > 
> > 
> > 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: c162d5b4338d72deed61aa65ed0f2f4ba2bbc8ab ("printk: Hide console waiter logic into helpers")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 1G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +--------------------------------+------------+------------+
> > |                                | dbdda842fe | c162d5b433 |
> > +--------------------------------+------------+------------+
> > | boot_successes                 | 0          | 0          |
> > | boot_failures                  | 18         | 16         |
> > | BUG:KASAN:use-after-scope_in_p | 18         |            |
> > | BUG:KASAN:use-after-scope_in_c | 0          | 16         |
> > +--------------------------------+------------+------------+
> > 
> > 
> > 
> > [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
> > [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
> 
> Is there any change to get disassembly of console_unlock() from the
> problematic build?
> 
> I have troubles to reproduce this myself. Also I was not able to find any
> bug just by looking into the code yet. The disassembly might help
> a lot here.
> 
> 
> Interesting symptoms (for myself and other debuggers):
> 
> The lines are duplicated. Therefore it happened when real
> console was registered and before the early console was unregistered.
> See also the full dmesg for these actions. The related printk messages
> are right after the KASAN report.
> 
> I wonder if it is unsafe to pass the console_lock via
> console_trylock_spinnning() from console_unlock() called
> in register_console(). I do not see any problem but I might
> be blind.

The KASAN report is between the following lines in dmesg:

[    0.003333]  Offload RCU callbacks from CPUs: .
[    0.003333] ==================================================================
[    0.003333] ==================================================================
[    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
[    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
[...]
[    0.003333] console [ttyS0] enabled

The first message is printed from rcu_init_nohz().
The last message is printed from register_console().

I would expect that the KASAN message is triggered from the following
code:

	rcu_init_nohz();
	init_timers();
	hrtimers_init();
	softirq_init();
	timekeeping_init();
	time_init();
	sched_clock_postinit();
	printk_safe_init();
	perf_event_init();
	profile_init();
	call_function_init();
	WARN(!irqs_disabled(), "Interrupts were enabled early\n");
	early_boot_irqs_disabled = false;
	local_irq_enable();

	kmem_cache_init_late();

	/*
	 * HACK ALERT! This is early. We're enabling the console before
	 * we've done PCI setups etc, and console_init() must be aware of
	 * this. But we do want output early, in case something goes wrong.
	 */
	console_init();


I am just confused that I do not see any of this function on the
stack. Note that this code is still called in the single CPU mode.

I feel lost a bit.

I am really curious what code is proceed on the line
console_unlock+0x185/0x960.

Best Regards,
Petr
