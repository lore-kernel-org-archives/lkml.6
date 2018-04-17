Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDQR1r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:27:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45357 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeDQR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:27:45 -0400
X-Google-Smtp-Source: AIpwx4/VVf6M8svaQ8KvVO24JyAlZzI5cleOCg/0mOQsKZGKWuFC3kx6CZv9PUxzmNgl/gxraDAPHQ==
Subject: Re: [PATCH v2 net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
To: Yafang Shao <laoar.shao@gmail.com>, eric.dumazet@gmail.com,
        davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523983016-11005-1-git-send-email-laoar.shao@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <010ea3d3-7925-4718-8aee-c1f6de6cc608@gmail.com>
Date: Tue, 17 Apr 2018 10:27:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523983016-11005-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/17/2018 09:36 AM, Yafang Shao wrote:
> tcp_rcv_space_adjust is called every time data is copied to user space,
> introducing a tcp tracepoint for which could show us when the packet is
> copied to user.
> This could help us figure out whether there's latency in user process.
> 
> When a tcp packet arrives, tcp_rcv_established() will be called and with
> the existed tracepoint tcp_probe we could get the time when this packet
> arrives.
> Then this packet will be copied to user, and tcp_rcv_space_adjust will
> be called and with this new introduced tracepoint we could get the time
> when this packet is copied to user.
> 
>         arrives time : user process time    => latency caused by user
>         tcp_probe      tcp_rcv_space_adjust

Sorry, I could not parse these :/

> 
> Hence in the printk message, sk_cookie is printed as a key to relate
> tcp_rcv_space_adjust with tcp_probe.
> 
> Maybe we could export sockfd in this new tracepoint as well, then we
> could relate this new tracepoint with epoll/read/recv* tracepoints, and
> finally that could show us the whole lifespan of this packet. But we
> could also implement that with pid as these functions are executed in
> process context.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> ---
> v1 -> v2: use sk_cookie as key suggested by Eric.
> ---
>  include/trace/events/tcp.h | 33 +++++++++++++++++++++++++++------
>  net/ipv4/tcp_input.c       |  2 ++
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 3dd6802..814f754 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -10,6 +10,7 @@
>  #include <linux/tracepoint.h>
>  #include <net/ipv6.h>
>  #include <net/tcp.h>
> +#include <linux/sock_diag.h>
>  
>  #define TP_STORE_V4MAPPED(__entry, saddr, daddr)		\
>  	do {							\
> @@ -125,6 +126,7 @@
>  		__array(__u8, daddr, 4)
>  		__array(__u8, saddr_v6, 16)
>  		__array(__u8, daddr_v6, 16)
> +		__field(__u64, sock_cookie)
>  	),
>  
>  	TP_fast_assign(
> @@ -144,12 +146,24 @@
>  
>  		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
>  			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		/*
> +		 * sk_cookie is used to identify a socket, with which we could
> +		 * relate this tracepoint with other tracepoints,
> +		 * i.e. tcp_probe.
> +		 * If we needn't this relation, then sk_cookie is useless;
> +		 * if we need this relation, then tcp_probe is already set,
> +		 * and sk_cookie is already set in tcp_probe, so we could get
> +		 * the value directly.
> +		 */
> +		__entry->sock_cookie = atomic64_read(&sk->sk_cookie);

Please scrap this comment and simply use the real thing.

	_entry->sock_cookie = sock_gen_cookie(sk);

We build generic events.

Being able to filter many TCP events on one socket cookie will be useful

If you worry about sock_gen_cookie(sk) being too expensive, then we can add an inline helper
for the fast path (when sk_cookie has been already set)

>  	),
>  
> -	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
> +	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c sock_cookie=%llu",


iproute2/ss command uses hexadcimal output for socket cookie. Please use %llx for consistency.
