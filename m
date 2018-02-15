Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165658AbeBORcH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:32:07 -0500
Received: from foss.arm.com ([217.140.101.70]:58402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164882AbeBORcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:32:04 -0500
Date: Thu, 15 Feb 2018 17:31:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>
Subject: Re: v4.16-rc1 misaligned atomics in skb__clone / __napi_alloc_skb
Message-ID: <20180215173157.uj37z76ggionz5g2@lakrids.cambridge.arm.com>
References: <20180215170432.e4wue4osyv3vmdla@lakrids.cambridge.arm.com>
 <CANn89iK-7v=sR3oD3uwkC6qac=GrSDUfMGmvKo=DS6tQ6C1ZJQ@mail.gmail.com>
 <CANn89iLvNjvUsjsqVN=3ZTPQvp6xChqYEu+cUASFXtTSQnA1aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLvNjvUsjsqVN=3ZTPQvp6xChqYEu+cUASFXtTSQnA1aA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 09:24:36AM -0800, Eric Dumazet wrote:
> On Thu, Feb 15, 2018 at 9:20 AM, Eric Dumazet <edumazet@google.com> wrote:
> >
> > Yes, it seems tun.c breaks the assumptions.
> >
> > If it really wants to provide arbitrary fragments and alignments, it
> > should use a separate
> 
> Sorry, I have sent the message to soon.
> 
> tun.c should use a private 'struct page_frag_cache' to deliver
> arbitrary frags/alignments,
> so that syzkaller might catch interesting bugs in the stack.
>
> > Please try :
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 81e6cc951e7fc7c983919365c34842c34bcaedcf..92c6b6d02f7c18b63c42ffe1d9cb7286975e1263
> > 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1500,7 +1500,7 @@ static struct sk_buff
> > *tun_napi_alloc_frags(struct tun_file *tfile,
> >                 }
> >
> >                 local_bh_disable();
> > -               data = napi_alloc_frag(fragsz);
> > +               data = napi_alloc_frag(SKB_DATA_ALIGN(fragsz));
> >                 local_bh_enable();
> >                 if (!data) {
> >                         err = -ENOMEM;
> 
> This patch should solve your immediate problem, but would lower fuzzer
> abilities to find bugs.

So far so good, it seems!

> I will send something more suited to original intent of these commits :
> 
> 90e33d45940793def6f773b2d528e9f3c84ffdc7 tun: enable napi_gro_frags()
> for TUN/TAP driver
> 943170998b200190f99d3fe7e771437e2c51f319 tun: enable NAPI for TUN/TAP driver

Thanks! I'd be more than happy to test any such patches.

As I mentioned, I'm also seeing similar in virtio-net, e.g.

WARNING: CPU: 0 PID: 8 at mm/access_once.c:12 access_once_alignment_check+0x34/0x40 mm/access_once.c:12
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 8 Comm: ksoftirqd/0 Not tainted 4.16.0-rc1-00002-gb03ae7b8b0de #9
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x390 arch/arm64/kernel/time.c:52
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xd0/0x130 lib/dump_stack.c:53
 panic+0x220/0x3fc kernel/panic.c:183
 __warn+0x270/0x2bc kernel/panic.c:547
 report_bug+0x1dc/0x2d0 lib/bug.c:184
 bug_handler+0x7c/0x128 arch/arm64/kernel/traps.c:758
 call_break_hook arch/arm64/kernel/debug-monitors.c:305 [inline]
 brk_handler+0x1a0/0x300 arch/arm64/kernel/debug-monitors.c:320
 do_debug_exception+0x15c/0x408 arch/arm64/mm/fault.c:808
 el1_dbg+0x18/0x78
 access_once_alignment_check+0x34/0x40 mm/access_once.c:12
 __napi_alloc_skb+0x18c/0x2b8 net/core/skbuff.c:482
 napi_alloc_skb include/linux/skbuff.h:2643 [inline]
 page_to_skb.isra.17+0x58/0x610 drivers/net/virtio_net.c:345
 receive_mergeable drivers/net/virtio_net.c:783 [inline]
 receive_buf+0x978/0x2a70 drivers/net/virtio_net.c:888
 virtnet_receive drivers/net/virtio_net.c:1160 [inline]
 virtnet_poll+0x24c/0x850 drivers/net/virtio_net.c:1240
 napi_poll net/core/dev.c:5690 [inline]
 net_rx_action+0x324/0xa50 net/core/dev.c:5756
 __do_softirq+0x318/0x734 kernel/softirq.c:285
 run_ksoftirqd+0x70/0xa8 kernel/softirq.c:666
 smpboot_thread_fn+0x544/0x9d0 kernel/smpboot.c:164
 kthread+0x2f8/0x380 kernel/kthread.c:238
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1158
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x1002082
Memory Limit: none
Rebooting in 86400 seconds..

... does similar apply there?

Thanks,
Mark.
