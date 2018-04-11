Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeDKAwO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:52:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46964 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeDKAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:52:12 -0400
X-Google-Smtp-Source: AIpwx48QSwBePXqGnJEOQIm8zEUrsFtL3QKjFjx1zN2961oIw1CV7juFk1AgUi5ZxNZZYANTwIDcKvnP3eAgb/AixRA=
MIME-Version: 1.0
In-Reply-To: <20180410163216.GB3661@localhost.localdomain>
References: <20180406014340.1562-1-march511@gmail.com> <20180408.125114.2111042327285982582.davem@davemloft.net>
 <CAN6D2npQd9AowLCz5CXGNPPib+10nABh1dOvLWV15r1z6FvF8w@mail.gmail.com> <20180410163216.GB3661@localhost.localdomain>
From: Wenhua Shi <march511@gmail.com>
Date: Wed, 11 Apr 2018 02:51:51 +0200
Message-ID: <CAN6D2nrPeWG-LxurpT=u8-kS-2jVQPpWnkth7bxqFn_U=VZJvA@mail.gmail.com>
Subject: Re: [PATCH] make net_gso_ok return false when gso_type is zero(invalid)
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-10 18:32 GMT+02:00 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>:
> On Sun, Apr 08, 2018 at 08:41:21PM +0200, Wenhua Shi wrote:
>> 2018-04-08 18:51 GMT+02:00 David Miller <davem@davemloft.net>:
>> >
>> > From: Wenhua Shi <march511@gmail.com>
>> > Date: Fri,  6 Apr 2018 03:43:39 +0200
>> >
>> > > Signed-off-by: Wenhua Shi <march511@gmail.com>
>> >
>> > This precondition should be made impossible instead of having to do
>> > an extra check everywhere that this helper is invoked, many of which
>> > are in fast paths.
>>
>> I believe the precondition you said is quite true. In my situation, I
>> have to disable GSO for some packet and I notice that it leads to a
>> worse performance (slower than 1Mbps, was almost 800Mbps).
>>
>> Here's the hook I use on debian 9.4, kernel version 4.9:
>
> There is quite a distance between 4.9 and net/net-next. Did you test
> on a more recent kernel too?
>
> Note that TCP stack now works with GSO being always on.
> 0a6b2a1dc2a2 ("tcp: switch to GSO being always on")
>

I've tried testing on the Fedora rawhide channel. The kernel version
is 4.17.0. Detail information is attached.

Without the hook

    [root@fedora-s-1vcpu-1gb-sfo1-01 testing]# iperf -c
myanothernormalmachine -d
    ------------------------------------------------------------
    Server listening on TCP port 5001
    TCP window size: 85.3 KByte (default)
    ------------------------------------------------------------
    ------------------------------------------------------------
    Client connecting to myanothernormalmachine, TCP port 5001
    TCP window size: 85.0 KByte (default)
    ------------------------------------------------------------
    [  3] local 107.170.240.XXX port 44692 connected with
104.131.148.XXX port 5001
    [  5] local 107.170.240.XXX port 5001 connected with
104.131.148.XXX port 53978
    [ ID] Interval       Transfer     Bandwidth
    [  3]  0.0-10.0 sec  1.04 GBytes   892 Mbits/sec
    [  5]  0.0-10.0 sec   757 MBytes   638 Mbits/sec

With the hook

    [root@fedora-s-1vcpu-1gb-sfo1-01 testing]# iperf -c
myanothernormalmachine -d
    ------------------------------------------------------------
    Server listening on TCP port 5001
    TCP window size: 85.3 KByte (default)
    ------------------------------------------------------------
    ------------------------------------------------------------
    Client connecting to myanothernormalmachine, TCP port 5001
    TCP window size: 85.0 KByte (default)
    ------------------------------------------------------------
    [  3] local 107.170.240.XXX port 44694 connected with
104.131.148.XXX port 5001
    [  5] local 107.170.240.XXX port 5001 connected with
104.131.148.XXX port 53980
    [ ID] Interval       Transfer     Bandwidth
    [  5]  0.0-10.0 sec  1.04 GBytes   894 Mbits/sec
    [  3]  0.0-13.5 sec   170 KBytes   103 Kbits/sec

Kernel

    [root@fedora-s-1vcpu-1gb-sfo1-01 testing]# uname -a
    Linux fedora-s-1vcpu-1gb-sfo1-01.localdomain
4.17.0-0.rc0.git5.2.fc29.x86_64 #1 SMP Mon Apr 9 17:16:30 UTC 2018
x86_64 x86_64 x86_64 GNU/Linux

Hook Source Code

    [root@fedora-s-1vcpu-1gb-sfo1-01 testing]# cat testing.c
    #include <linux/kernel.h>
    #include <linux/init.h>
    #include <linux/module.h>
    #include <linux/kernel.h>
    #include <linux/netfilter.h>
    #include <linux/netfilter_ipv4.h>
    #include <linux/netfilter_ipv6.h>
    #include <linux/skbuff.h>
    #include <linux/tcp.h>
    #include <linux/ip.h>

    unsigned int hook_outgoing(
            void * priv,
            struct sk_buff * skb,
            const struct nf_hook_state * state)
    {
            printk(KERN_INFO "Hook working...\n");
            /* for some reason I have to disable GSO */
            skb_gso_reset(skb);

            /* The following won't work any more. */
            // skb->sk->sk_gso_type = ~0;

            return NF_ACCEPT;

    }

    static struct nf_hook_ops hook =
    {
            .hook = hook_outgoing,
            .pf = PF_INET,
            .hooknum = NF_INET_POST_ROUTING,
            .priority = NF_IP_PRI_LAST,
    };

    static int __init init_testing(void)
    {
            nf_register_net_hook(&init_net, &hook);
            return 0;
    }

    static void __exit exit_testing(void)
    {
            nf_unregister_net_hook(&init_net, &hook);
    }

    MODULE_LICENSE("GPL");
    module_init(init_testing);
    module_exit(exit_testing);




It turns out the problem exists and my previous bypassing trick is not
working any more. I'm now testing whether the patch is working for the
latest net-next branch.
