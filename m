Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeFAEk5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:40:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39178 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeFAEk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:40:56 -0400
X-Google-Smtp-Source: ADUXVKKzfLKlizCwYVubDsNQz+vnFNGhf3tvx7knmUECp8aCJDE3jmXvBFzzl0gU9KM99jrV9TwCNQ==
Date: Fri, 1 Jun 2018 13:40:50 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180601044050.GA5687@jagdpanzerIV>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
 <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/31/18 14:21), Petr Mladek wrote:
> > 
> > Upstream printk has no printing kthread. And we also run
> > printk()->console_unlock() with disabled preemption.
> 
> Yes, the comment was wrong

Yes, that was the only thing I meant.
I really didn't have any time to look at the patch yesterday, just
commented on the most obvious thing.

> but the problem is real.

Yep, could be. But not exactly the way it is described in the commit
messages and the patch does not fully address the problem.

The patch assumes that all those events happen sequentially. While
in reality they can happen in parallel on different CPUs.

Example:

	CPU0					CPU1

	set console verbose

	dump_backtrace()
	{
		// for (;;)  print frames
		printk("%pS\n", frame0);
		printk("%pS\n", frame1);
		printk("%pS\n", frame2);
		printk("%pS\n", frame3);
		...				console_loglevel = CONSOLE_LOGLEVEL_SILENT;
		printk("%pS\n", frame12);
		printk("%pS\n", frame13);
	}

Part of backtrace or the entire backtrace will be missed, because
we read the global console_loglevel. The problem is still there.

> The console handling is asynchronous even without the kthread.
> The current console_lock owner is responsible for handling messages
> also from other CPUs.

A nitpick: that's another thing to improve in the commit message, because
   I don't see that console_silent() race in the upstream kernel. We even
   don't have any users of console_silent() function. The only thing that
   ever sets console_loglevel to CONSOLE_LOGLEVEL_SILENT is
   kernel/debug/kdb/kdb_io.c


Now, there is a bunch of places that manually set console_loglevel.
At a glance, __handle_sysrq() *seems* to be interesting:

---

void __handle_sysrq(int key, bool check_mask)
{
	struct sysrq_key_op *op_p;
	int orig_log_level;
	int i;

	rcu_sysrq_start();
	rcu_read_lock();
	/*
~	 * Raise the apparent loglevel to maximum so that the sysrq header
~	 * is shown to provide the user with positive feedback.  We do not
~	 * simply emit this at KERN_EMERG as that would change message
~	 * routing in the consumers of /proc/kmsg.
~	 */
~	orig_log_level = console_loglevel;
~	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
	pr_info("SysRq : ");

        op_p = __sysrq_get_key_op(key);
        if (op_p) {
		/*
		 * Should we check for enabled operations (/proc/sysrq-trigger
		 * should not) and is the invoked operation enabled?
		 */
		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
			pr_cont("%s\n", op_p->action_msg);
			console_loglevel = orig_log_level;
			op_p->handler(key);
		} else {
			pr_cont("This sysrq operation is disabled.\n");
		}
	} else {
		pr_cont("HELP : ");
		/* Only print the help msg once per handler */
		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
			if (sysrq_key_table[i]) {
				int j;

				for (j = 0; sysrq_key_table[i] !=
						sysrq_key_table[j]; j++)
					;
				if (j != i)
					continue;
				pr_cont("%s ", sysrq_key_table[i]->help_msg);
			}
		}
		pr_cont("\n");
~		console_loglevel = orig_log_level;
	}
	rcu_read_unlock();
	rcu_sysrq_end();
}

---

But only at a glance... In fact, it raises the loglevel to maximum only
to printk() "This sysrq operation is disabled" or "HELP: " and help_msg
messages. The sysrq handler itself is executed under orig_log_level
loglevel. So it doesn't look like we are loosing anything super-critical,
after all.


This case is very interesting:

static void uv_nmi_dump_state(int cpu, struct pt_regs *regs, int master)
{
	if (master) {
		int tcpu;
		int ignored = 0;
		int saved_console_loglevel = console_loglevel;

		pr_alert("UV: tracing %s for %d CPUs from CPU %d\n",
			uv_nmi_action_is("ips") ? "IPs" : "processes",
			atomic_read(&uv_nmi_cpus_in_nmi), cpu);

		console_loglevel = uv_nmi_loglevel;
		atomic_set(&uv_nmi_slave_continue, SLAVE_EXIT);
		for_each_online_cpu(tcpu) {
			if (cpumask_test_cpu(tcpu, uv_nmi_cpu_mask))
				ignored++;
			else if (tcpu == cpu)
				uv_nmi_dump_state_cpu(tcpu, regs);
			else
				uv_nmi_trigger_dump(tcpu);
		}
		if (ignored)
			pr_alert("UV: %d CPUs ignored NMI\n", ignored);

		console_loglevel = saved_console_loglevel;
		pr_alert("UV: process trace complete\n");
	} else {
		while (!atomic_read(&uv_nmi_slave_continue))
			cpu_relax();
		while (this_cpu_read(uv_cpu_nmi.state) != UV_NMI_STATE_DUMP)
			cpu_relax();
		uv_nmi_dump_state_cpu(cpu, regs);
	}
	uv_nmi_sync_exit(master);
}

And it seems to be broken anyway... uv_nmi_dump_state() relies on printk()
to do a direct console_unlock() call from NMI. We don't do it. Apart from
that, printk() is in printk_nmi() context when we call this function, which
sometimes can use printk_deferred() directly [loglevel messages bit will be
useful here], but sometimes it stores the messages in per-CPU buffers and
flushes them to the logbuf later - we don't carry the must-be-printed bit
with every printk_safe/printk_nmi message and as of now there is no way for
to forcibly set it [because it's set automatically in log_store() after
msg->level >= console_loglevel check].

So I'd say that most likely the following scenarios can suffer:

- NMI comes in, sets loglevel to X, printk-s some data, restores the
  loglevel back to Y
- IRQ comes in [like sysrq, etc] comes in and does the same thing
- software exception comes in and does the same thing [e.g. bust_spinlocks()
  at arch/s390/mm/fault.c]

IOW, the following scenario

	CPUA

	something happens
	set console loglevel
	printk			0. writes to the logbuf, e.g. printk_deferred()
				1. writes to the logbuf AND calls console_unlock()
				2. writes to printk_safe per-CPU buffer
				3. writes to printk_nmi per-CPU buffer
	...
	restore loglevel

This is how I see the problem at the moment. May be I'm missing something.

Would be great to see more real cases when it actually hits us and more
analysis, please.

	-ss
