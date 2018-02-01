Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeBAX1Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:27:25 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41021 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBAX1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:27:17 -0500
X-Google-Smtp-Source: AH8x224o3r1Rftcm0wcN6E9O2/zMYO+ZIhEv/Nu3dGFmdd7JQLCmQNqWC7asqYJ/EZs78S7PZbQTXgBt1ez+hBZurPs=
MIME-Version: 1.0
In-Reply-To: <20180201225542.GA13072@castle>
References: <20180125001911.15597-1-guro@fb.com> <20180125.120302.1117695034222616751.davem@davemloft.net>
 <20180131215401.GA8956@castle> <20180201.101655.1316424669256047119.davem@davemloft.net>
 <20180201202158.GA11477@castle.DHCP.thefacebook.com> <CANn89iLBOUZNxNqrECvZ7ktX8uu0j3REiZaqTwr=SP-U=vAPpQ@mail.gmail.com>
 <20180201225542.GA13072@castle>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Feb 2018 15:27:14 -0800
Message-ID: <CANn89i+mTRsYDikt9VhfbdHo1f5F5tXbZj54679nY_Fy1QS1Vg@mail.gmail.com>
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

Well, this memcg stuff is so confusing.

My recollection is that we had :


https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=d979a39d7242e0601bf9b60e89628fb8ac577179

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=75cb070960ade40fba5de32138390f3c85c90941

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=c0576e3975084d4699b7bfef578613fb8e1144f6

And commit a590b90d472f2c176c140576ee3ab44df7f67839 as well

Honestly bug was closed months ago for us, based on stack traces on the wild.

No C repro or whatever, but reproducing it would be a matter of
having a TCP listener constantly doing a
socket()/setsockopt(REUSEADDR)/bind()/listen()/close() in a loop,
while connections are attempted to the listening port.




On Thu, Feb 1, 2018 at 2:55 PM, Roman Gushchin <guro@fb.com> wrote:
> On Thu, Feb 01, 2018 at 01:17:56PM -0800, Eric Dumazet wrote:
>> On Thu, Feb 1, 2018 at 12:22 PM, Roman Gushchin <guro@fb.com> wrote:
>> > On Thu, Feb 01, 2018 at 10:16:55AM -0500, David Miller wrote:
>> >> From: Roman Gushchin <guro@fb.com>
>> >> Date: Wed, 31 Jan 2018 21:54:08 +0000
>> >>
>> >> > So I really start thinking that reverting 9f1c2674b328
>> >> > ("net: memcontrol: defer call to mem_cgroup_sk_alloc()")
>> >> > and fixing the original issue differently might be easier
>> >> > and a proper way to go. Does it makes sense?
>> >>
>> >> You'll need to work that out with Eric Dumazet who added the
>> >> change in question which you think we should revert.
>> >
>> > Eric,
>> >
>> > can you, please, provide some details about the use-after-free problem
>> > that you've fixed with commit 9f1c2674b328 ("net: memcontrol: defer call
>> > to mem_cgroup_sk_alloc()" ? Do you know how to reproduce it?
>> >
>> > Deferring mem_cgroup_sk_alloc() breaks socket memory accounting
>> > and makes it much more fragile in general. So, I wonder, if there are
>> > solutions for the use-after-free problem.
>> >
>> > Thank you!
>> >
>> > Roman
>>
>> Unfortunately bug is not public (Google-Bug-Id 67556600 for Googlers
>> following this thread )
>>
>> Our kernel has a debug feature on percpu_ref_get_many() which detects
>> the typical use-after-free problem of
>> doing atomic_long_add(nr, &ref->count); while ref->count is 0, or
>> memory already freed.
>>
>> Bug was serious because css_put() will release the css a second time.
>>
>> Stack trace looked like :
>>
>> Oct  8 00:23:14 lphh23 kernel: [27239.568098]  <IRQ>
>> [<ffffffff909d2fb1>] dump_stack+0x4d/0x6c
>> Oct  8 00:23:14 lphh23 kernel: [27239.568108]  [<ffffffff906df6e3>] ?
>> cgroup_get+0x43/0x50
>> Oct  8 00:23:14 lphh23 kernel: [27239.568114]  [<ffffffff906f2f35>]
>> warn_slowpath_common+0xac/0xc8
>> Oct  8 00:23:14 lphh23 kernel: [27239.568117]  [<ffffffff906f2f6b>]
>> warn_slowpath_null+0x1a/0x1c
>> Oct  8 00:23:14 lphh23 kernel: [27239.568120]  [<ffffffff906df6e3>]
>> cgroup_get+0x43/0x50
>> Oct  8 00:23:14 lphh23 kernel: [27239.568123]  [<ffffffff906e07a4>]
>> cgroup_sk_alloc+0x64/0x90
>
> Hm, that looks strange... It's cgroup_sk_alloc(),
> not mem_cgroup_sk_alloc(), which was removed by 9f1c2674b328.
>
> I thought, that it's css_get() in mem_cgroup_sk_alloc(), which
> you removed, but the stacktrace you've posted is different.
>
> void mem_cgroup_sk_alloc(struct sock *sk) {
>         /*
>          * Socket cloning can throw us here with sk_memcg already
>          * filled. It won't however, necessarily happen from
>          * process context. So the test for root memcg given
>          * the current task's memcg won't help us in this case.
>          *
>          * Respecting the original socket's memcg is a better
>          * decision in this case.
>          */
>         if (sk->sk_memcg) {
>                 BUG_ON(mem_cgroup_is_root(sk->sk_memcg));
>>>>             css_get(&sk->sk_memcg->css);
>                 return;
>         }
>
> Is it possible to reproduce the issue on an upstream kernel?
> Any ideas of what can trigger it?
>
> Btw, with the following patch applied (below) and cgroup v2 enabled,
> the issue, which I'm talking about, can be reproduced in seconds after reboot
> by doing almost any network activity. Just sshing to a machine is enough.
> The corresponding warning will be printed to dmesg.
>
> What is a proper way to fix the socket memory accounting in this case,
> what do you think?
>
> Thank you!
>
> Roman
>
> --
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c51c589..55fb890 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -276,6 +276,8 @@ struct mem_cgroup {
>         struct list_head event_list;
>         spinlock_t event_list_lock;
>
> +       atomic_t tcpcnt;
> +
>         struct mem_cgroup_per_node *nodeinfo[0];
>         /* WARNING: nodeinfo must be the last member here */
>  };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 19eea69..c69ff04 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5623,6 +5623,8 @@ static int memory_stat_show(struct seq_file *m, void *v)
>         seq_printf(m, "workingset_nodereclaim %lu\n",
>                    stat[WORKINGSET_NODERECLAIM]);
>
> +       seq_printf(m, "tcpcnt %d\n", atomic_read(&memcg->tcpcnt));
> +
>         return 0;
>  }
>
> @@ -6139,6 +6141,8 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>         gfp_t gfp_mask = GFP_KERNEL;
>
> +       atomic_add(nr_pages, &memcg->tcpcnt);
> +
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>                 struct page_counter *fail;
>
> @@ -6171,6 +6175,11 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
> +       int v = atomic_sub_return(nr_pages, &memcg->tcpcnt);
> +       if (v < 0) {
> +               pr_info("@@@ %p %d \n", memcg, v);
> +       }
> +
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
>                 page_counter_uncharge(&memcg->tcpmem, nr_pages);
>                 return;
