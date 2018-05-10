Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756593AbeEJFpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 01:45:21 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36845 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753696AbeEJFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 01:45:19 -0400
X-Google-Smtp-Source: AB8JxZqxNMcqleMOKzzBqdtXYKY6/Sb5O5VOBZHOnqoZ+L9Md8l4kK8kyurTZZ6yWeNTWC2MzXJVaQ==
Subject: Re: [PATCH net-next v1] tcp: Add mark for TIMEWAIT sockets
To: Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
References: <20180510052111.17886-1-jmaxwell37@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <eece810c-b3c8-4307-c03a-1cfdaa7109de@gmail.com>
Date: Wed, 9 May 2018 22:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180510052111.17886-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 10:21 PM, Jon Maxwell wrote:

...

>  	if (th->rst)
> @@ -723,11 +724,17 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
>  	arg.tos = ip_hdr(skb)->tos;
>  	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
>  	local_bh_disable();
> -	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
> +	ctl_sk = *this_cpu_ptr(net->ipv4.tcp_sk);
> +	if (sk && sk->sk_state == TCP_TIME_WAIT)
> +		ctl_sk->sk_mark = inet_twsk(sk)->tw_mark;
> +	else if (sk && sk_fullsock(sk))

I do not believe we could have a non fullsock here ?

A request socket (SYN_RECV state) at this point is not expected. 


So you can factorize :

if (sk)
        ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
			  inet_twsk(sk)->tw_mark : sk->sk_mark;

(same remark for IPv6)


> +		ctl_sk->sk_mark = sk->sk_mark;
> +	ip_send_unicast_reply(ctl_sk,
>  			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
>  			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
>  			      &arg, arg.iov[0].iov_len);
