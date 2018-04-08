Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeDHSlo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 14:41:44 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34553 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeDHSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 14:41:43 -0400
X-Google-Smtp-Source: AIpwx4+fCpjpcaZBjCQvh3OrEuHWwkmeLCnZectfbw7OgQrUPl8ah8hhhNOVmExmlpNcm/U1DVFlfkoAHlTTXjEa2Rs=
MIME-Version: 1.0
In-Reply-To: <20180408.125114.2111042327285982582.davem@davemloft.net>
References: <20180406014340.1562-1-march511@gmail.com> <20180408.125114.2111042327285982582.davem@davemloft.net>
From: Wenhua Shi <march511@gmail.com>
Date: Sun, 8 Apr 2018 20:41:21 +0200
Message-ID: <CAN6D2npQd9AowLCz5CXGNPPib+10nABh1dOvLWV15r1z6FvF8w@mail.gmail.com>
Subject: Re: [PATCH] make net_gso_ok return false when gso_type is zero(invalid)
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-08 18:51 GMT+02:00 David Miller <davem@davemloft.net>:
>
> From: Wenhua Shi <march511@gmail.com>
> Date: Fri,  6 Apr 2018 03:43:39 +0200
>
> > Signed-off-by: Wenhua Shi <march511@gmail.com>
>
> This precondition should be made impossible instead of having to do
> an extra check everywhere that this helper is invoked, many of which
> are in fast paths.

I believe the precondition you said is quite true. In my situation, I
have to disable GSO for some packet and I notice that it leads to a
worse performance (slower than 1Mbps, was almost 800Mbps).

Here's the hook I use on debian 9.4, kernel version 4.9:

    #include <linux/init.h>
    #include <linux/module.h>
    #include <linux/kernel.h>
    #include <linux/netfilter.h>
    #include <linux/netfilter_ipv4.h>
    #include <linux/netfilter_ipv6.h>
    #include <linux/skbuff.h>
    #include <linux/tcp.h>
    #include <linux/ip.h>

    unsigned int hook_outgoing (
        void * priv,
        struct sk_buff * skb,
        const struct nf_hook_state * state)
    {
        /* for some reason I have to disable GSO */
        skb_gso_reset(skb);

        /* After I force sk_can_gso to return false here, the
performance comes back normal. */
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
        nf_register_hook(&hook);
        return 0;
    }

    static void __exit exit_testing(void)
    {
        nf_unregister_hook(&hook);
    }

    module_init(init_testing);
    module_exit(exit_testing);


Here are the performance measurements.
Without the previous hook:

    root@debian-s-1vcpu-1gb-sfo1-01:~/test# iperf -c myanothernormaldebian -d
    ------------------------------------------------------------
    Server listening on TCP port 5001
    TCP window size: 85.3 KByte (default)
    ------------------------------------------------------------
    ------------------------------------------------------------
    Client connecting to myanothernormaldebian, TCP port 5001
    TCP window size:  255 KByte (default)
    ------------------------------------------------------------
    [  3] local 192.241.204.XXX port 60528 connected with
104.131.148.XXX port 5001
    [  5] local 192.241.204.XXX port 5001 connected with
104.131.148.XXX port 58576
    [ ID] Interval       Transfer     Bandwidth
    [  3]  0.0-10.0 sec   922 MBytes   773 Mbits/sec
    [  5]  0.0-10.1 sec  1.00 GBytes   849 Mbits/sec

And with the previous hook:

    root@debian-s-1vcpu-1gb-sfo1-01:~/test# iperf -c myanothernormaldebian -d
    ------------------------------------------------------------
    Server listening on TCP port 5001
    TCP window size: 85.3 KByte (default)
    ------------------------------------------------------------
    ------------------------------------------------------------
    Client connecting to myanothernormaldebian, TCP port 5001
    TCP window size: 85.0 KByte (default)
    ------------------------------------------------------------
    [  3] local 192.241.204.XXX port 60530 connected with
104.131.148.XXX port 5001
    [  5] local 192.241.204.XXX port 5001 connected with
104.131.148.XXX port 58578
    [ ID] Interval       Transfer     Bandwidth
    [  5]  0.0-10.2 sec  1.02 GBytes   864 Mbits/sec
    [  3]  0.0-13.5 sec   170 KBytes   103 Kbits/sec



Or it's just because of that I'm disabling the GSO in a wrong way?
