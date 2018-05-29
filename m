Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934684AbeE2Nye (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:54:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35997 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934204AbeE2Nya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:54:30 -0400
X-Google-Smtp-Source: AB8JxZrqYJZjwb2hSLPjO3UoFISGeq7fenikWptCK8eEjErMJ0pMoqgqWtUUuJ88UM92axKoZLhjRg==
Subject: Re: [PATCH v4 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: Yafang Shao <laoar.shao@gmail.com>, songliubraving@fb.com,
        edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527600915-10955-1-git-send-email-laoar.shao@gmail.com>
 <1527600915-10955-2-git-send-email-laoar.shao@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b3102638-68a1-c6b7-a359-8658ebf5287a@gmail.com>
Date: Tue, 29 May 2018 06:54:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1527600915-10955-2-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 06:35 AM, Yafang Shao wrote:
> This is additional to the commit ea1627c20c34 ("tcp: minor optimizations around tcp_hdr() usage").
> At this point, skb->data is same with tcp_hdr() as tcp header has not
> been pulled yet.
> Remove the third parameter of tcp_rcv_established() and put it into
> the function body.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> ---
> v4: remove the third parameter of tcp_rcv_established()
> ---
>  include/net/tcp.h    | 3 +--
>  net/ipv4/tcp_input.c | 4 ++--
>  net/ipv4/tcp_ipv4.c  | 2 +-
>  net/ipv6/tcp_ipv6.c  | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 952d842..029a51b 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -334,8 +334,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
>  void tcp_delack_timer_handler(struct sock *sk);
>  int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg);
>  int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
> -void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
> -			 const struct tcphdr *th);
> +void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 1191cac..1d70dab 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5390,11 +5390,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>   *	the rest is checked inline. Fast processing is turned on in
>   *	tcp_data_queue when everything is OK.
>   */
> -void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
> -			 const struct tcphdr *th)
> +void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
>  {
>  	unsigned int len = skb->len;
>  	struct tcp_sock *tp = tcp_sk(sk);
> +	const struct tcphdr *th = (const struct tcphdr *)skb->data;
>  
>

Please reorder list to get a reverse christmas tree.

const struct tcphdr *th = (const struct tcphdr *)skb->data;
struct tcp_sock *tp = tcp_sk(sk);
unsigned int len = skb->len;
