Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBAVSH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:18:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34698 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeBAVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:17:59 -0500
X-Google-Smtp-Source: AH8x226KZh6CwSnEKZajEtbADz2cd7XFsdcv3hKdKVrxed6NC1Yg2wI8v2NXiUqQUiuElhnbF6Gr7M9iOPAE9/6fLN0=
MIME-Version: 1.0
In-Reply-To: <20180201202158.GA11477@castle.DHCP.thefacebook.com>
References: <20180125001911.15597-1-guro@fb.com> <20180125.120302.1117695034222616751.davem@davemloft.net>
 <20180131215401.GA8956@castle> <20180201.101655.1316424669256047119.davem@davemloft.net>
 <20180201202158.GA11477@castle.DHCP.thefacebook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Feb 2018 13:17:56 -0800
Message-ID: <CANn89iLBOUZNxNqrECvZ7ktX8uu0j3REiZaqTwr=SP-U=vAPpQ@mail.gmail.com>
Subject: Re: [PATCH net] net: memcontrol: charge allocated memory after mem_cgroup_sk_alloc()
To: Roman Gushchin <guro@fb.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 12:22 PM, Roman Gushchin <guro@fb.com> wrote:
> On Thu, Feb 01, 2018 at 10:16:55AM -0500, David Miller wrote:
>> From: Roman Gushchin <guro@fb.com>
>> Date: Wed, 31 Jan 2018 21:54:08 +0000
>>
>> > So I really start thinking that reverting 9f1c2674b328
>> > ("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
>> > and fixing the original issue differently might be easier
>> > and a proper way to go. Does it makes sense?
>>
>> You'll need to work that out with Eric Dumazet who added the
>> change in question which you think we should revert.
>
> Eric,
>
> can you, please, provide some details about the use-after-free problem
> that you've fixed with commit 9f1c2674b328 ("net: memcontrol: defer call
> to mem_cgroup_sk_alloc()" ? Do you know how to reproduce it?
>
> Deferring mem_cgroup_sk_alloc() breaks socket memory accounting
> and makes it much more fragile in general. So, I wonder, if there are
> solutions for the use-after-free problem.
>
> Thank you!
>
> Roman

Unfortunately bug is not public (Google-Bug-Id 67556600 for Googlers
following this thread )

Our kernel has a debug feature on percpu_ref_get_many() which detects
the typical use-after-free problem of
doing atomic_long_add(nr, &ref->count); while ref->count is 0, or
memory already freed.

Bug was serious because css_put() will release the css a second time.

Stack trace looked like :

Oct  8 00:23:14 lphh23 kernel: [27239.568098]  <IRQ>
[<ffffffff909d2fb1>] dump_stack+0x4d/0x6c
Oct  8 00:23:14 lphh23 kernel: [27239.568108]  [<ffffffff906df6e3>] ?
cgroup_get+0x43/0x50
Oct  8 00:23:14 lphh23 kernel: [27239.568114]  [<ffffffff906f2f35>]
warn_slowpath_common+0xac/0xc8
Oct  8 00:23:14 lphh23 kernel: [27239.568117]  [<ffffffff906f2f6b>]
warn_slowpath_null+0x1a/0x1c
Oct  8 00:23:14 lphh23 kernel: [27239.568120]  [<ffffffff906df6e3>]
cgroup_get+0x43/0x50
Oct  8 00:23:14 lphh23 kernel: [27239.568123]  [<ffffffff906e07a4>]
cgroup_sk_alloc+0x64/0x90
Oct  8 00:23:14 lphh23 kernel: [27239.568128]  [<ffffffff90bd6e91>]
sk_clone_lock+0x2d1/0x400
Oct  8 00:23:14 lphh23 kernel: [27239.568134]  [<ffffffff90bf2d56>]
inet_csk_clone_lock+0x16/0x100
Oct  8 00:23:14 lphh23 kernel: [27239.568138]  [<ffffffff90bff163>]
tcp_create_openreq_child+0x23/0x600
Oct  8 00:23:14 lphh23 kernel: [27239.568143]  [<ffffffff90c1ba8a>]
tcp_v6_syn_recv_sock+0x26a/0x8f0
Oct  8 00:23:14 lphh23 kernel: [27239.568146]  [<ffffffff90bffbfe>]
tcp_check_req+0x1ce/0x440
Oct  8 00:23:14 lphh23 kernel: [27239.568152]  [<ffffffff90c6556c>]
tcp_v6_rcv+0x9cc/0x22a0
Oct  8 00:23:14 lphh23 kernel: [27239.568155]  [<ffffffff90c67cc2>] ?
ip6table_mangle_hook+0x42/0x190
Oct  8 00:23:14 lphh23 kernel: [27239.568158]  [<ffffffff90c61e5b>]
ip6_input+0x1ab/0x400
Oct  8 00:23:14 lphh23 kernel: [27239.568162]  [<ffffffff90cd8c0d>] ?
ip6_rcv_finish+0x93/0x93
Oct  8 00:23:14 lphh23 kernel: [27239.568165]  [<ffffffff90c61a2d>]
ipv6_rcv+0x32d/0x5b0
Oct  8 00:23:14 lphh23 kernel: [27239.568167]  [<ffffffff90cd8b7a>] ?
ip6_fragment+0x965/0x965
Oct  8 00:23:14 lphh23 kernel: [27239.568171]  [<ffffffff90c2fd4c>]
process_backlog+0x39c/0xc50
Oct  8 00:23:14 lphh23 kernel: [27239.568177]  [<ffffffff907be695>] ?
ktime_get+0x35/0xa0
Oct  8 00:23:14 lphh23 kernel: [27239.568180]  [<ffffffff907bf681>] ?
clockevents_program_event+0x81/0x1c0
Oct  8 00:23:14 lphh23 kernel: [27239.568183]  [<ffffffff90c2e22e>]
net_rx_action+0x10e/0x360
Oct  8 00:23:14 lphh23 kernel: [27239.568190]  [<ffffffff906064f1>]
__do_softirq+0x151/0x2f5
Oct  8 00:23:14 lphh23 kernel: [27239.568196]  [<ffffffff90d101dc>]
do_softirq_own_stack+0x1c/0x30
Oct  8 00:23:14 lphh23 kernel: [27239.568197]  <EOI>
[<ffffffff9079a12b>] __local_bh_enable_ip+0x6b/0xa0
Oct  8 00:23:14 lphh23 kernel: [27239.568203]  [<ffffffff90c609c6>]
ip6_output+0x326/0x1060
Oct  8 00:23:14 lphh23 kernel: [27239.568206]  [<ffffffff90c67d3d>] ?
ip6table_mangle_hook+0xbd/0x190
Oct  8 00:23:14 lphh23 kernel: [27239.568209]  [<ffffffff90c5f780>] ?
inet6_getname+0x130/0x130
Oct  8 00:23:14 lphh23 kernel: [27239.568212]  [<ffffffff90c606a0>] ?
ip6_finish_output+0xf20/0xf20
Oct  8 00:23:14 lphh23 kernel: [27239.568215]  [<ffffffff90cd77a7>]
ip6_xmit+0x52d/0x5b6
Oct  8 00:23:14 lphh23 kernel: [27239.568217]  [<ffffffff90cd6ffe>] ?
ip6_call_ra_chain+0xc9/0xc9
Oct  8 00:23:14 lphh23 kernel: [27239.568220]  [<ffffffff90c4483d>] ?
tcp_ack+0x60d/0x3290
Oct  8 00:23:14 lphh23 kernel: [27239.568223]  [<ffffffff90c67521>]
inet6_csk_xmit+0x181/0x2b0
Oct  8 00:23:14 lphh23 kernel: [27239.568225]  [<ffffffff90c4bb55>]
tcp_send_ack+0x6f5/0xdf0
Oct  8 00:23:14 lphh23 kernel: [27239.568229]  [<ffffffff90bf8311>]
tcp_rcv_state_process+0x8a1/0x2630
Oct  8 00:23:14 lphh23 kernel: [27239.568231]  [<ffffffff90c1c24b>]
tcp_v6_do_rcv+0x13b/0x340
Oct  8 00:23:14 lphh23 kernel: [27239.568234]  [<ffffffff90c2286c>]
release_sock+0xec/0x180
Oct  8 00:23:14 lphh23 kernel: [27239.568237]  [<ffffffff90c08b6f>]
__inet_stream_connect+0x1ef/0x2f0
Oct  8 00:23:14 lphh23 kernel: [27239.568240]  [<ffffffff906d8710>] ?
__wake_up_locked_key+0x70/0x70
Oct  8 00:23:14 lphh23 kernel: [27239.568243]  [<ffffffff90c08cab>]
inet_stream_connect+0x3b/0x60
Oct  8 00:23:14 lphh23 kernel: [27239.568249]  [<ffffffff90bd5564>]
SYSC_connect+0x84/0xc0
