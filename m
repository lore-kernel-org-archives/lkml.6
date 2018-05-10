Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756634AbeEJGP0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:15:26 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37744 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEJGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:15:25 -0400
X-Google-Smtp-Source: AB8JxZq0RvR5LSGvS+Kh2VtElxAgSXSW/wUZDaF/GZXeo4NvkbvqT0uvruB8e+/qN/Ii8mDrZeqdP7iUp1OGkbL2s5I=
MIME-Version: 1.0
In-Reply-To: <eece810c-b3c8-4307-c03a-1cfdaa7109de@gmail.com>
References: <20180510052111.17886-1-jmaxwell37@gmail.com> <eece810c-b3c8-4307-c03a-1cfdaa7109de@gmail.com>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Thu, 10 May 2018 16:14:43 +1000
Message-ID: <CAGHK07CckLqZBKBD-gpu6x1fLDtZ_ea3D+-pQJc-hQUM0DRgJA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Add mark for TIMEWAIT sockets
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 3:45 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/09/2018 10:21 PM, Jon Maxwell wrote:
>
> ...
>
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
>
> I do not believe we could have a non fullsock here ?
>

Okay thanks I'll make these changes to v2.

> A request socket (SYN_RECV state) at this point is not expected.
>
>
> So you can factorize :
>
> if (sk)
>         ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
>                           inet_twsk(sk)->tw_mark : sk->sk_mark;
>
> (same remark for IPv6)
>
>
>> +             ctl_sk->sk_mark = sk->sk_mark;
>> +     ip_send_unicast_reply(ctl_sk,
>>                             skb, &TCP_SKB_CB(skb)->header.h4.opt,
>>                             ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>>                             &arg, arg.iov[0].iov_len);
>
>
