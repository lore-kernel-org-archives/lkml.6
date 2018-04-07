Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDGMbV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 08:31:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:40100 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeDGMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 08:31:20 -0400
To: peterz@infradead.org, mingo@kernel.org
Cc: akpm@linux-foundation.org, dvyukov@google.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, msb@chromium.org, tglx@linutronix.de,
        vegard.nossum@oracle.com
Subject: Re: [PATCH v2] locking/hung_task: Show all hung tasks before panic
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1522678324-4855-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20180402153530.GN3948@linux.vnet.ibm.com>
        <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
        <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
In-Reply-To: <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
Message-Id: <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sat, 7 Apr 2018 21:31:19 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Can we add lockdep functions which print trace of threads with locks held?

For example,

void debug_show_map_users(struct lockdep_map *map)
{
	struct task_struct *g, *p;
	struct held_lock *hlock;
	int i, depth;

	rcu_read_lock();
	for_each_process_thread(g, p) {
		depth = p->lockdep_depth;
		hlock = p->held_locks;
		for (i = 0; i < depth; i++)
			if (map == hlock[i]->instance) {
				touch_nmi_watchdog();
				touch_all_softlockup_watchdogs();
				sched_show_task(p);
				lockdep_print_held_locks(p);
				break;
			}
	}
	rcu_read_unlock();
}

is for replacing debug_show_all_locks() in oom_reap_task() because
we are interested in only threads holding specific mm->mmap_sem.

For example

void debug_show_relevant_tasks(struct task_struct *origin)
{
	struct task_struct *g, *p;
	struct held_lock *i_hlock, *j_hlock;
	int i, j, i_depth, j_depth;

	rcu_read_lock();
	i_depth = origin->lockdep_depth;
	i_hlock = origin->held_locks;
	for_each_process_thread(g, p) {
		j_depth = p->lockdep_depth;
		j_hlock = p->held_locks;
		for (i = 0; i < i_depth; i++)
			for (j = 0; j < j_depth; j++)
				if (i_hlock[i]->instance == j_hlock[j]->instance)
					goto hit;
		continue;
hit:
		touch_nmi_watchdog();
		touch_all_softlockup_watchdogs();
		sched_show_task(p);
		lockdep_print_held_locks(p);
	}
	rcu_read_unlock();
}

or

void debug_show_all_locked_tasks(void)
{
	struct task_struct *g, *p;

	rcu_read_lock();
	for_each_process_thread(g, p) {
		if (p->lockdep_depth == 0)
			continue;
		touch_nmi_watchdog();
		touch_all_softlockup_watchdogs();
		sched_show_task(p);
		lockdep_print_held_locks(p);
	}
	rcu_read_unlock();
}

are for replacing debug_show_all_locks() in check_hung_task() for cases like
https://syzkaller.appspot.com/bug?id=26aa22915f5e3b7ca2cfca76a939f12c25d624db
because we are interested in only threads holding locks.

SysRq-t is too much but SysRq-w is useless for killable/interruptible threads...
