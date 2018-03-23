Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCWVk1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeCWVk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:40:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2CF21749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 17:40:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
Message-ID: <20180323174023.60579f45@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
        <20180323172843.763579a9@gandalf.local.home>
        <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 22:33:29 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 23 Mar 2018, Steven Rostedt wrote:
> 
> > On Fri, 23 Mar 2018 22:12:24 +0100 (CET)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > synchronize_rcu() lacks a might_sleep() check which would have caught that
> > > issue way earlier because it would trigger with the minimal debug options
> > > enabled.
> > > 
> > > Add a might_sleep() check to catch such cases.  
> > 
> > I'm not against the patch, but really? I would think that
> > synchronize_rcu() would pretty much always schedule, and scheduling
> > from atomic would have triggered with minimal debug options enabled.  
> 
> Dunno. The reported splat is here:
> 
>        https://pastebin.com/raw/puvh0cXE

[  150.560848] ODEBUG: object is not on stack, but annotated
[  150.566398] ------------[ cut here ]------------
[  150.571133] WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:300 __debug_object_init+0x526/0xc40
[  150.579682] Kernel panic - not syncing: panic_on_warn set ...
[  150.579682] 
[  150.587012] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.9.89-g960923f #61
[  150.593906] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  150.603233]  ffff8801db307a08 ffffffff81d96069 ffffffff83a482c0 ffff8801db307ae0
[  150.611190]  ffffffff83c19700 ffffffff81dfefb6 0000000000000009 ffff8801db307ad0
[  150.619157]  ffffffff8142fbd1 0000000041b58ab3 ffffffff8418bd08 ffffffff8142fa15
[  150.627118] Call Trace:
[  150.629667]  <IRQ> [  150.631700]  [<ffffffff81d96069>] dump_stack+0xc1/0x128
[  150.637051]  [<ffffffff81dfefb6>] ? __debug_object_init+0x526/0xc40
[  150.643431]  [<ffffffff8142fbd1>] panic+0x1bc/0x3a8
[  150.648416]  [<ffffffff8142fa15>] ? percpu_up_read_preempt_enable.constprop.53+0xd7/0xd7
[  150.656611]  [<ffffffff81430835>] ? load_image_and_restore+0xf9/0xf9
[  150.663070]  [<ffffffff81269efd>] ? vprintk_default+0x1d/0x30
[  150.668925]  [<ffffffff81131879>] ? __warn+0x1a9/0x1e0
[  150.674170]  [<ffffffff81dfefb6>] ? __debug_object_init+0x526/0xc40
[  150.680543]  [<ffffffff81131894>] __warn+0x1c4/0x1e0
[  150.685614]  [<ffffffff81131afc>] warn_slowpath_null+0x2c/0x40
[  150.691972]  [<ffffffff81dfefb6>] __debug_object_init+0x526/0xc40
[  150.698174]  [<ffffffff81dfea90>] ? debug_object_fixup+0x30/0x30
[  150.704283]  [<ffffffff81dff709>] debug_object_init_on_stack+0x19/0x20
[  150.710917]  [<ffffffff81287a93>] __wait_rcu_gp+0x93/0x1b0
[  150.716508]  [<ffffffff81290251>] synchronize_rcu.part.65+0x101/0x110
[  150.723054]  [<ffffffff81290150>] ? rcu_pm_notify+0xc0/0xc0
[  150.728735]  [<ffffffff81292bc0>] ? __call_rcu.constprop.72+0x910/0x910
[  150.735459]  [<ffffffff81235221>] ? __lock_is_held+0xa1/0xf0
[  150.741223]  [<ffffffff81290287>] synchronize_rcu+0x27/0x90
[  150.746908]  [<ffffffff83588b35>] __l2tp_session_unhash+0x3d5/0x550

Looks like __l2tp_session_unhash() is the real culprit here.

[  150.753281]  [<ffffffff8358891f>] ? __l2tp_session_unhash+0x1bf/0x550
[  150.759828]  [<ffffffff8114596a>] ? __local_bh_enable_ip+0x6a/0xd0
[  150.766123]  [<ffffffff8358ddb0>] ? l2tp_udp_encap_recv+0xd90/0xd90
[  150.772497]  [<ffffffff83588e97>] l2tp_tunnel_closeall+0x1e7/0x3a0
[  150.778782]  [<ffffffff835897be>] l2tp_tunnel_destruct+0x30e/0x5a0
[  150.785067]  [<ffffffff8358965a>] ? l2tp_tunnel_destruct+0x1aa/0x5a0
[  150.791537]  [<ffffffff835894b0>] ? l2tp_tunnel_del_work+0x460/0x460
[  150.797997]  [<ffffffff82ee8053>] __sk_destruct+0x53/0x570
[  150.803588]  [<ffffffff81293918>] rcu_process_callbacks+0x898/0x1300
[  150.810048]  [<ffffffff812939f7>] ? rcu_process_callbacks+0x977/0x1300
[  150.816684]  [<ffffffff82ee8000>] ? __sk_dst_check+0x240/0x240
[  150.822625]  [<ffffffff838be5d6>] __do_softirq+0x206/0x951
[  150.828223]  [<ffffffff81147315>] irq_exit+0x165/0x190
[  150.833557]  [<ffffffff838bd1eb>] smp_apic_timer_interrupt+0x7b/0xa0
[  150.840018]  [<ffffffff838b9470>] apic_timer_interrupt+0xa0/0xb0
[  150.846132]  <EOI> [  150.848166]  [<ffffffff838b6756>] ? native_safe_halt+0x6/0x10
[  150.854036]  [<ffffffff8123bf2d>] ? trace_hardirqs_on+0xd/0x10
[  150.859973]  [<ffffffff838b5d85>] default_idle+0x55/0x360
[  150.865478]  [<ffffffff8106be0a>] arch_cpu_idle+0xa/0x10

I think you want this instead, as __l2tp_session_unhash is what looks
like might be hiding the call to synchronize_rcu(). It's not called in
all instances, and I don't think your patch would have triggered the
issues before hand. You want this:

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 194a7483bb93..857b494bee29 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1677,6 +1677,8 @@ void __l2tp_session_unhash(struct l2tp_session *session)
 {
 	struct l2tp_tunnel *tunnel = session->tunnel;
 
+	might_sleep();
+
 	/* Remove the session from core hashes */
 	if (tunnel) {
 		/* Remove from the per-tunnel hash */

-- Steve
