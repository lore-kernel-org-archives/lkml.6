Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756235AbeEJEYZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:24:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36009 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeEJEYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:24:24 -0400
X-Google-Smtp-Source: AB8JxZpIApoVv2cwAxQv1HqjK4djOUU0uUnzDxiIKShATWMnQnGmH4Hllsc4imCB73n3+QyyMFM1q96bec2/Pjkx15g=
MIME-Version: 1.0
In-Reply-To: <e408e7b1-cb92-fb98-d9ec-256ba18d6ca7@gmail.com>
References: <20180510020739.8599-1-jmaxwell37@gmail.com> <e408e7b1-cb92-fb98-d9ec-256ba18d6ca7@gmail.com>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Thu, 10 May 2018 14:23:42 +1000
Message-ID: <CAGHK07DGn50gO9GmZo3BqMg8K8iEawERx2J1RFs1E_CRiMw3fQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Add mark for TIMEWAIT sockets
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 1:32 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/09/2018 07:07 PM, Jon Maxwell wrote:
>> Aidan McGurn from Openwave Mobility systems reported the following bug:
>>
>> "Marked routing is broken on customer deployment. Its effects are large
>> increase in Uplink retransmissions caused by the client never receiving
>> the final ACK to their FINACK - this ACK misses the mark and routes out
>> of the incorrect route."
>>
>> Currently marks are added to sk_buffs for replies when the "fwmark_reflect"
>> sysctl is enabled. But not for TIME_WAIT sockets where the original socket had
>> sk->sk_mark set via setsockopt(SO_MARK..).
>>
>> Fix this in IPv4/v6 by adding tw->tw_mark for TIME_WAIT sockets. Copy the the
>> original sk->sk_mark in __inet_twsk_hashdance() to the new tw->tw_mark location.
>> Then copy this into ctl_sk->sk_mark so that the skb gets sent with the correct
>> mark. Do the same for resets. Give the "fwmark_reflect" sysctl precedence over
>> sk->sk_mark so that netfilter rules are still honored.
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> ---
>>  include/net/inet_timewait_sock.h |  1 +
>>  net/ipv4/ip_output.c             |  3 ++-
>>  net/ipv4/tcp_ipv4.c              | 18 ++++++++++++++++--
>>  net/ipv4/tcp_minisocks.c         |  1 +
>>  net/ipv6/tcp_ipv6.c              |  8 +++++++-
>>  5 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
>> index c7be1ca8e562..659d8ed5a3bc 100644
>> --- a/include/net/inet_timewait_sock.h
>> +++ b/include/net/inet_timewait_sock.h
>> @@ -62,6 +62,7 @@ struct inet_timewait_sock {
>>  #define tw_dr                        __tw_common.skc_tw_dr
>>
>>       int                     tw_timeout;
>> +     __u32                   tw_mark;
>>       volatile unsigned char  tw_substate;
>>       unsigned char           tw_rcv_wscale;
>>
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 95adb171f852..cca4412dc4cb 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -1539,6 +1539,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
>>       struct sk_buff *nskb;
>>       int err;
>>       int oif;
>> +     __u32 mark = IP4_REPLY_MARK(net, skb->mark);
>>
>>       if (__ip_options_echo(net, &replyopts.opt.opt, skb, sopt))
>>               return;
>> @@ -1561,7 +1562,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
>>               oif = skb->skb_iif;
>>
>>       flowi4_init_output(&fl4, oif,
>> -                        IP4_REPLY_MARK(net, skb->mark),
>> +                        mark ? (mark) : sk->sk_mark,
>
> You can avoid the declaration of mark variable and simply use here :
>
>                         IP4_REPLY_MARK(net, skb->mark) ?: sk->sk_mark,
>

Thanks for the advice and suggestions Eric. That is more elegant. Will do in v1.

>>                          RT_TOS(arg->tos),
>>                          RT_SCOPE_UNIVERSE, ip_hdr(skb)->protocol,
>>                          ip_reply_arg_flowi_flags(arg),
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index f70586b50838..fbee36579c83 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -621,6 +621,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
>>       struct sock *sk1 = NULL;
>>  #endif
>>       struct net *net;
>> +     struct sock *ctl_sk;
>>
>>       /* Never send a reset in response to a reset. */
>>       if (th->rst)
>> @@ -723,11 +724,17 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
>>       arg.tos = ip_hdr(skb)->tos;
>>       arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
>>       local_bh_disable();
>> -     ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
>> +     ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
>> +     if (sk && sk->sk_state == TCP_TIME_WAIT)
>> +             ctl_sk->sk_mark = inet_twsk(sk)->tw_mark;
>> +     else if (sk && sk_fullsock(sk))
>> +             ctl_sk->sk_mark = sk->sk_mark;
>> +     ip_send_unicast_reply(ctl_sk,
>>                             skb, &TCP_SKB_CB(skb)->header.h4.opt,
>>                             ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>>                             &arg, arg.iov[0].iov_len);
>>
>> +     ctl_sk->sk_mark = 0;
>>       __TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
>>       __TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
>>       local_bh_enable();
>> @@ -759,6 +766,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
>>       } rep;
>>       struct net *net = sock_net(sk);
>>       struct ip_reply_arg arg;
>> +     struct sock *ctl_sk;
>>
>>       memset(&rep.th, 0, sizeof(struct tcphdr));
>>       memset(&arg, 0, sizeof(arg));
>> @@ -809,11 +817,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
>>       arg.tos = tos;
>>       arg.uid = sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
>>       local_bh_disable();
>> -     ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
>> +     ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
>> +     if (sk && sk->sk_state == TCP_TIME_WAIT)
>> +             ctl_sk->sk_mark = inet_twsk(sk)->tw_mark;
>> +     else if (sk && sk_fullsock(sk))
>> +             ctl_sk->sk_mark = sk->sk_mark;
>> +     ip_send_unicast_reply(ctl_sk,
>>                             skb, &TCP_SKB_CB(skb)->header.h4.opt,
>>                             ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>>                             &arg, arg.iov[0].iov_len);
>>
>> +     ctl_sk->sk_mark = 0;
>>       __TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
>>       local_bh_enable();
>>  }
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index 57b5468b5139..f867658b4b30 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -263,6 +263,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
>>               struct inet_sock *inet = inet_sk(sk);
>>
>>               tw->tw_transparent      = inet->transparent;
>> +             tw->tw_mark             = sk->sk_mark;
>>               tw->tw_rcv_wscale       = tp->rx_opt.rcv_wscale;
>>               tcptw->tw_rcv_nxt       = tp->rcv_nxt;
>>               tcptw->tw_snd_nxt       = tp->snd_nxt;
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 6d664d83cd16..a6f876125091 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -803,6 +803,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
>>       unsigned int tot_len = sizeof(struct tcphdr);
>>       struct dst_entry *dst;
>>       __be32 *topt;
>> +     __u32 mark = IP6_REPLY_MARK(net, skb->mark);
>>
>>       if (tsecr)
>>               tot_len += TCPOLEN_TSTAMP_ALIGNED;
>> @@ -871,11 +872,16 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
>>               fl6.flowi6_oif = oif;
>>       }
>>
>> -     fl6.flowi6_mark = IP6_REPLY_MARK(net, skb->mark);
>> +     if (sk && sk->sk_state == TCP_TIME_WAIT)
>> +             ctl_sk->sk_mark = inet_twsk(sk)->tw_mark;
>> +     else if (sk && sk_fullsock(sk))
>> +             ctl_sk->sk_mark = sk->sk_mark;
>
> Unfortunately IPv6 has a single net->ipv6.tcp_sk, shared by all cpus.
>
> So writing ctl_sk->sk_mark is racy on SMP hosts.
>
> I would suggest using a local variable, and not touch ctl_sk->sk_mark
>

Sure I'll use a local variable for that in IPv6 instead and post in v1 as well.

> For consistency, you could do the same for IPv4, even if IPv4 currently uses per-cpu sockets
>

If it's okay I'll stick to ctl_sk->sk_mark for IPv4 as its pulled out
of the ctl_sk again in
ip_send_unicast_reply() and that will avoid having to add another argument.

Regards

Jon

>
>> +     fl6.flowi6_mark = mark ? (mark) : ctl_sk->sk_mark;
>>       fl6.fl6_dport = t1->dest;
>>       fl6.fl6_sport = t1->source;
>>       fl6.flowi6_uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
>>       security_skb_classify_flow(skb, flowi6_to_flowi(&fl6));
>> +     ctl_sk->sk_mark = 0;
>>
>>       /* Pass a socket to ip6_dst_lookup either it is for RST
>>        * Underlying function will use this to retrieve the network
>>
