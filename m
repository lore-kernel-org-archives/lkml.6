Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWVqV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:46:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeCWVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:46:19 -0400
Date: Fri, 23 Mar 2018 22:46:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>, netdev@vger.kernel.org,
        James Chapman <jchapman@katalix.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
In-Reply-To: <20180323174023.60579f45@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1803232243180.1481@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de> <20180323172843.763579a9@gandalf.local.home> <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de> <20180323174023.60579f45@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Steven Rostedt wrote:
> On Fri, 23 Mar 2018 22:33:29 +0100 (CET)
> [  150.741223]  [<ffffffff81290287>] synchronize_rcu+0x27/0x90
> [  150.746908]  [<ffffffff83588b35>] __l2tp_session_unhash+0x3d5/0x550
> 
> Looks like __l2tp_session_unhash() is the real culprit here.

Yes. I reported that to netdev already.

> [  150.753281]  [<ffffffff8358891f>] ? __l2tp_session_unhash+0x1bf/0x550
> [  150.759828]  [<ffffffff8114596a>] ? __local_bh_enable_ip+0x6a/0xd0
> [  150.766123]  [<ffffffff8358ddb0>] ? l2tp_udp_encap_recv+0xd90/0xd90
> [  150.772497]  [<ffffffff83588e97>] l2tp_tunnel_closeall+0x1e7/0x3a0
> [  150.778782]  [<ffffffff835897be>] l2tp_tunnel_destruct+0x30e/0x5a0
> [  150.785067]  [<ffffffff8358965a>] ? l2tp_tunnel_destruct+0x1aa/0x5a0
> [  150.791537]  [<ffffffff835894b0>] ? l2tp_tunnel_del_work+0x460/0x460
> [  150.797997]  [<ffffffff82ee8053>] __sk_destruct+0x53/0x570
> [  150.803588]  [<ffffffff81293918>] rcu_process_callbacks+0x898/0x1300
> [  150.810048]  [<ffffffff812939f7>] ? rcu_process_callbacks+0x977/0x1300
> [  150.816684]  [<ffffffff82ee8000>] ? __sk_dst_check+0x240/0x240
> [  150.822625]  [<ffffffff838be5d6>] __do_softirq+0x206/0x951
> [  150.828223]  [<ffffffff81147315>] irq_exit+0x165/0x190
> [  150.833557]  [<ffffffff838bd1eb>] smp_apic_timer_interrupt+0x7b/0xa0
> [  150.840018]  [<ffffffff838b9470>] apic_timer_interrupt+0xa0/0xb0
> [  150.846132]  <EOI> [  150.848166]  [<ffffffff838b6756>] ? native_safe_halt+0x6/0x10
> [  150.854036]  [<ffffffff8123bf2d>] ? trace_hardirqs_on+0xd/0x10
> [  150.859973]  [<ffffffff838b5d85>] default_idle+0x55/0x360
> [  150.865478]  [<ffffffff8106be0a>] arch_cpu_idle+0xa/0x10
> 
> I think you want this instead, as __l2tp_session_unhash is what looks
> like might be hiding the call to synchronize_rcu(). It's not called in
> all instances, and I don't think your patch would have triggered the
> issues before hand. You want this:
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 194a7483bb93..857b494bee29 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1677,6 +1677,8 @@ void __l2tp_session_unhash(struct l2tp_session *session)
>  {
>  	struct l2tp_tunnel *tunnel = session->tunnel;
>  
> +	might_sleep();
> +
>  	/* Remove the session from core hashes */
>  	if (tunnel) {
>  		/* Remove from the per-tunnel hash */

That too :)
