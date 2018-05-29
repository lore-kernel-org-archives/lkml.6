Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeE2AmG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 20:42:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36130 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbeE2AmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 20:42:04 -0400
X-Google-Smtp-Source: AB8JxZrcyLCZpF7t3s/DoWI9ERRn6ES7P0PA6ItNqDwCNdSwCy1dsDmrxcLBePZvZxsILcOAIK8VE+moKR38YRXV3os=
MIME-Version: 1.0
In-Reply-To: <CANn89iKU49yBRq4x8xHGXiWZ9h0PNAmyWnMoNDFmSm9oKXsbqw@mail.gmail.com>
References: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
 <1527521753-17963-2-git-send-email-laoar.shao@gmail.com> <CANn89iKU49yBRq4x8xHGXiWZ9h0PNAmyWnMoNDFmSm9oKXsbqw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 08:41:23 +0800
Message-ID: <CALOAHbAbw6nXggT4ZF-=L_tQqsm-EQ==Qd9aeLys2mwQizFnkw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: Eric Dumazet <edumazet@google.com>
Cc: Song Liu <songliubraving@fb.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:36 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Mon, May 28, 2018 at 8:36 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
>> This is additional to the commit ea1627c20c34 ("tcp: minor optimizations
> around tcp_hdr() usage").
>> At this point, skb->data is same with tcp_hdr() as tcp header has not
>> been pulled yet.
>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>   net/ipv4/tcp_ipv4.c | 2 +-
>>   net/ipv6/tcp_ipv6.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index adbdb50..d179386 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -1486,7 +1486,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff
> *skb)
>>                                  sk->sk_rx_dst = NULL;
>>                          }
>>                  }
>> -               tcp_rcv_established(sk, skb, tcp_hdr(skb));
>> +               tcp_rcv_established(sk, skb, (const struct tcphdr
> *)skb->data);
>>                  return 0;
>>          }
>
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index 7d47c2b..1c633ff 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -1322,7 +1322,7 @@ static int tcp_v6_do_rcv(struct sock *sk, struct
> sk_buff *skb)
>>                          }
>>                  }
>
>> -               tcp_rcv_established(sk, skb, tcp_hdr(skb));
>> +               tcp_rcv_established(sk, skb, (const struct tcphdr
> *)skb->data);
>>                  if (opt_skb)
>>                          goto ipv6_pktoptions;
>>                  return 0;
>> --
>> 1.8.3.1
>
>
> I would rather remove the third parameter of tcp_rcv_established() instead
> of duplicating the cast.

OK.

And what about introducing a new helper tcp_hdr_fast() ?

/* use it when tcp header has not been pulled yet */
static inline struct tcphdr *tcp_hdr_fast(const struct sk_buff *skb)

{

        return (const struct tcphdr *)skb->data;

}


That could help us to use this optimized one instead of the original
one if possilbe.

Thanks
Yafang
