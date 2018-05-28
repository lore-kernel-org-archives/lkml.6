Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940261AbeE1Qgj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:36:39 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37333 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeE1Qgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:36:36 -0400
X-Google-Smtp-Source: ADUXVKKQcTMdo46K/py8lUCHJuUmOXfeOTaAiQ8fdwRNOkObG88Dmdjr1rznK/cKf6ewphOeHWgRCcUOuEUSZELQV38=
MIME-Version: 1.0
References: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com> <1527521753-17963-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1527521753-17963-2-git-send-email-laoar.shao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 May 2018 09:36:23 -0700
Message-ID: <CANn89iKU49yBRq4x8xHGXiWZ9h0PNAmyWnMoNDFmSm9oKXsbqw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: laoar.shao@gmail.com
Cc: songliubraving@fb.com, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 8:36 AM Yafang Shao <laoar.shao@gmail.com> wrote:

> This is additional to the commit ea1627c20c34 ("tcp: minor optimizations
around tcp_hdr() usage").
> At this point, skb->data is same with tcp_hdr() as tcp header has not
> been pulled yet.

> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   net/ipv4/tcp_ipv4.c | 2 +-
>   net/ipv6/tcp_ipv6.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index adbdb50..d179386 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1486,7 +1486,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff
*skb)
>                                  sk->sk_rx_dst = NULL;
>                          }
>                  }
> -               tcp_rcv_established(sk, skb, tcp_hdr(skb));
> +               tcp_rcv_established(sk, skb, (const struct tcphdr
*)skb->data);
>                  return 0;
>          }

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 7d47c2b..1c633ff 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1322,7 +1322,7 @@ static int tcp_v6_do_rcv(struct sock *sk, struct
sk_buff *skb)
>                          }
>                  }

> -               tcp_rcv_established(sk, skb, tcp_hdr(skb));
> +               tcp_rcv_established(sk, skb, (const struct tcphdr
*)skb->data);
>                  if (opt_skb)
>                          goto ipv6_pktoptions;
>                  return 0;
> --
> 1.8.3.1


I would rather remove the third parameter of tcp_rcv_established() instead
of duplicating the cast.
