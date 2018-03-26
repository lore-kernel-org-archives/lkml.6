Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeCZRjB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:39:01 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:54183 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeCZRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:38:59 -0400
Date: Mon, 26 Mar 2018 19:38:55 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: Joel Fernandes <joelaf@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>,
        "open list:BPF (Safe dynamic programs and tools)"
        <netdev@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: syzbot rcu/debugobjects warning
Message-ID: <20180326173855.GP1351@alphalink.fr>
References: <CAJWu+oo1mnS=2v_SbnDCDih6AyystU2aXVCUEa5k0W0q0Ovk6w@mail.gmail.com>
 <alpine.DEB.2.21.1803231004130.4625@nanos.tec.linutronix.de>
 <CAJWu+ooHzLpJZxsFq7hifmaEh7fOdYsExKz6pGLgSPQUxAB4Nw@mail.gmail.com>
 <alpine.DEB.2.21.1803232133450.1481@nanos.tec.linutronix.de>
 <CAJWu+or1YJEZX8R1fwJrb=cUc05_uzwZHJhD5-SMEycUO7W1mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+or1YJEZX8R1fwJrb=cUc05_uzwZHJhD5-SMEycUO7W1mQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 11:29:42PM -0700, Joel Fernandes wrote:
> On Fri, Mar 23, 2018 at 1:41 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 23 Mar 2018, Joel Fernandes wrote:
> >> On Fri, Mar 23, 2018 at 2:11 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > On Thu, 22 Mar 2018, Joel Fernandes wrote:
> >> Sorry. Here is the raw crash log: https://pastebin.com/raw/puvh0cXE
> >> (The kernel logs are toward the end with the above).
> >
> > And that is interesting:
> >
> > [  150.629667]  <IRQ> [  150.631700]  [<ffffffff81d96069>] dump_stack+0xc1/0x128
> > [  150.637051]  [<ffffffff81dfefb6>] ? __debug_object_init+0x526/0xc40
> > [  150.643431]  [<ffffffff8142fbd1>] panic+0x1bc/0x3a8
> > [  150.648416]  [<ffffffff8142fa15>] ? percpu_up_read_preempt_enable.constprop.53+0xd7/0xd7
> > [  150.656611]  [<ffffffff81430835>] ? load_image_and_restore+0xf9/0xf9
> > [  150.663070]  [<ffffffff81269efd>] ? vprintk_default+0x1d/0x30
> > [  150.668925]  [<ffffffff81131879>] ? __warn+0x1a9/0x1e0
> > [  150.674170]  [<ffffffff81dfefb6>] ? __debug_object_init+0x526/0xc40
> > [  150.680543]  [<ffffffff81131894>] __warn+0x1c4/0x1e0
> > [  150.685614]  [<ffffffff81131afc>] warn_slowpath_null+0x2c/0x40
> > [  150.691972]  [<ffffffff81dfefb6>] __debug_object_init+0x526/0xc40
> > [  150.698174]  [<ffffffff81dfea90>] ? debug_object_fixup+0x30/0x30
> > [  150.704283]  [<ffffffff81dff709>] debug_object_init_on_stack+0x19/0x20
> > [  150.710917]  [<ffffffff81287a93>] __wait_rcu_gp+0x93/0x1b0
> > [  150.716508]  [<ffffffff81290251>] synchronize_rcu.part.65+0x101/0x110
> > [  150.723054]  [<ffffffff81290150>] ? rcu_pm_notify+0xc0/0xc0
> > [  150.728735]  [<ffffffff81292bc0>] ? __call_rcu.constprop.72+0x910/0x910
> > [  150.735459]  [<ffffffff81235221>] ? __lock_is_held+0xa1/0xf0
> > [  150.741223]  [<ffffffff81290287>] synchronize_rcu+0x27/0x90
> >
> > So this calls synchronize_rcu from a rcu callback. That's a nono. This is
> > on the back of an interrupt in softirq context and __wait_rcu_gp() can
> > sleep, which is obviously a bad idea in softirq context....
> >
> > Cc'ed netdev ....
> >
> > And that also explains the debug object splat because this is not running
> > on the task stack. It's running on the softirq stack ....
> >
> > [  150.746908]  [<ffffffff83588b35>] __l2tp_session_unhash+0x3d5/0x550
> > [  150.753281]  [<ffffffff8358891f>] ? __l2tp_session_unhash+0x1bf/0x550
> > [  150.759828]  [<ffffffff8114596a>] ? __local_bh_enable_ip+0x6a/0xd0
> > [  150.766123]  [<ffffffff8358ddb0>] ? l2tp_udp_encap_recv+0xd90/0xd90
> > [  150.772497]  [<ffffffff83588e97>] l2tp_tunnel_closeall+0x1e7/0x3a0
> > [  150.778782]  [<ffffffff835897be>] l2tp_tunnel_destruct+0x30e/0x5a0
> > [  150.785067]  [<ffffffff8358965a>] ? l2tp_tunnel_destruct+0x1aa/0x5a0
> > [  150.791537]  [<ffffffff835894b0>] ? l2tp_tunnel_del_work+0x460/0x460
> > [  150.797997]  [<ffffffff82ee8053>] __sk_destruct+0x53/0x570
> > [  150.803588]  [<ffffffff81293918>] rcu_process_callbacks+0x898/0x1300
> > [  150.810048]  [<ffffffff812939f7>] ? rcu_process_callbacks+0x977/0x1300
> > [  150.816684]  [<ffffffff82ee8000>] ? __sk_dst_check+0x240/0x240
> > [  150.822625]  [<ffffffff838be5d6>] __do_softirq+0x206/0x951
> > [  150.828223]  [<ffffffff81147315>] irq_exit+0x165/0x190
> > [  150.833557]  [<ffffffff838bd1eb>] smp_apic_timer_interrupt+0x7b/0xa0
> > [  150.840018]  [<ffffffff838b9470>] apic_timer_interrupt+0xa0/0xb0
> > [  150.846132]  <EOI> [  150.848166]  [<ffffffff838b6756>] ? native_safe_halt+0x6/0x10
> > [  150.854036]  [<ffffffff8123bf2d>] ? trace_hardirqs_on+0xd/0x10
> > [  150.859973]  [<ffffffff838b5d85>] default_idle+0x55/0x360
> > [  150.865478]  [<ffffffff8106be0a>] arch_cpu_idle+0xa/0x10
> > [  150.870896]  [<ffffffff838b6b96>] default_idle_call+0x36/0x60
> > [  150.876751]  [<ffffffff81226cb0>] cpu_startup_entry+0x2b0/0x380
> > [  150.882787]  [<ffffffff81226a00>] ? cpu_in_idle+0x20/0x20
> > [  150.888291]  [<ffffffff812d2343>] ? clockevents_register_device+0x123/0x200
> > [  150.895358]  [<ffffffff810b0693>] start_secondary+0x303/0x3e0
> > [  150.901209]  [<ffffffff810b0390>] ? set_cpu_sibling_map+0x11f0/0x11f0
> 
> Thomas, thanks a lot. It appears this issue will not happen on
> mainline since from commit  765924e362d1  (subject "l2tp: don't close
> sessions in l2tp_tunnel_destruct()"), l2tp_tunnel_closeall is no
> longer called from l2tp_tunnel_destruct. From that commit message it
> seems one of the motivations is to solve scheduling from atomic issue.
> 
I agree that this patch should fix the above splat.

> However for this change to be applied to android-4.9 and/or 4.9
> stable, it depends on several other l2p patches and they aren't
> straight forward cherry-picks from mainline (and I don't have much
> background with this driver).
> 
> v3.16.56 stable seems to be further along with l2tp than v4.9.89, in
> that it atleast has more of the upstream patches adapted for it, that
> the above patch depends on. Since this also related to stable, I am
> CC'ing Greg kh and Ben.
> 
I generally review l2tp patches proposed for -stable trees (although
not in time). If a patch has been ported to 3.16.y and is missing in
another tree, then it should be safe to port it there too.

> Here are some of the commits in 3.16 stable that I couldn't find
> applied to v4.9 stable. The above fix quotes the below patches as
> dependencies so they would need to be stable backported. Also CC'ing
> Guillaume since he authored the above mentioned fix.
> 
> 0c15ddabbcf l2tp: don't register sessions in l2tp_session_create()
> a3c5d5b70f4e l2tp: fix race condition in l2tp_tunnel_delete
> 5b216e8dcda2 l2tp: prevent creation of sessions on terminated tunnels
> 76ff5e22f1e0 l2tp: hold tunnel while looking up sessions in l2tp_netlink
> ceb8f6b23a38 l2tp: define parameters of l2tp_session_get*() as "const"
> 0295d020b63f l2tp: initialise session's refcount before making it reachable
> 29a77518927e l2tp: take reference on sessions being dumped
> b301c9b7782f l2tp: take a reference on sessions used in genetlink handlers
> 
Yes, I think it'd make sense to port these patches.
