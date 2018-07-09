Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B393020844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933323AbeGIQiM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:38:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33551 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932770AbeGIQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:38:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fcZAr-0002Re-Dy; Mon, 09 Jul 2018 18:38:05 +0200
Date:   Mon, 9 Jul 2018 18:38:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: cgroup trace events acquire sleeping locks
Message-ID: <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
References: <20180703140750.1dab75ef@tagon>
 <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
 <20180708203600.2edf24e2@tagon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180708203600.2edf24e2@tagon>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clark showed me this:

| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
| in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: systemd
| 5 locks held by systemd/1:
|  #0:  (sb_writers#7){.+.+}, at: [<        (ptrval)>] mnt_want_write+0x1f/0x50
|  #1:  (&type->i_mutex_dir_key#3/1){+.+.}, at: [<        (ptrval)>] do_rmdir+0x14d/0x1f0
|  #2:  (&type->i_mutex_dir_key#5){++++}, at: [<        (ptrval)>] vfs_rmdir+0x50/0x150
|  #3:  (cgroup_mutex){+.+.}, at: [<        (ptrval)>] cgroup_kn_lock_live+0xfb/0x200
|  #4:  (kernfs_rename_lock){+.+.}, at: [<        (ptrval)>] kernfs_path_from_node+0x23/0x50
| Preemption disabled at:
| [<ffffffff8dc994c5>] migrate_enable+0x95/0x340
| CPU: 1 PID: 1 Comm: systemd Not tainted 4.16.18-rt9+ #173
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.1-1 04/01/2014
| Call Trace:
|  dump_stack+0x70/0xa7
|  ___might_sleep+0x159/0x240
|  rt_spin_lock+0x4e/0x60
|  ? kernfs_path_from_node+0x23/0x50
|  kernfs_path_from_node+0x23/0x50
|  trace_event_raw_event_cgroup+0x54/0x110
|  cgroup_rmdir+0xdb/0x1a0
|  kernfs_iop_rmdir+0x53/0x80
|  vfs_rmdir+0x74/0x150
|  do_rmdir+0x191/0x1f0
|  SyS_rmdir+0x11/0x20
|  do_syscall_64+0x73/0x220
|  entry_SYSCALL_64_after_hwframe+0x42/0xb7

which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
trace event invokes cgroup_path() which acquires a spin_lock_t and this
is invoked within a preempt_disable()ed section. 

It says "Preemption disabled at" migrate_enable() but this is not true.
A printk() just before the lock reports preempt_count() of two and
sometimes one. I *think*
- one is from rcu_read_lock_sched_notrace() in __DO_TRACE()
- the second is from preempt_disable_notrace() in ring_buffer_lock_reserve()

I would prefer not to turn kernfs_rename_lock into raw_spin_lock_t. We
had a similar problem with a i915 trace event which eventually vanished
(and before I just disabled it).

So how likely are chances that we can use rcu_read_lock() in __DO_TRACE()?
And how likely are chances that the preempt_disable() in
ring_buffer_lock_reserve() could be avoided while the trace event is
invoked?

I guess nothing of this is easy peasy. Any suggestions?

Sebastian
