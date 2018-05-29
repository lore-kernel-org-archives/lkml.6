Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeE2Oi1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:38:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51750 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934608AbeE2OiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:38:21 -0400
X-Google-Smtp-Source: ADUXVKL3e7iAFUB+XLimK9k6T5Pj1RTGsLnnbLJ9s5bboj3I11k3xr6X3q0d6Gmh6wDOtZDq+ZDebvowxNoCthNYYNA=
MIME-Version: 1.0
In-Reply-To: <b3102638-68a1-c6b7-a359-8658ebf5287a@gmail.com>
References: <1527600915-10955-1-git-send-email-laoar.shao@gmail.com>
 <1527600915-10955-2-git-send-email-laoar.shao@gmail.com> <b3102638-68a1-c6b7-a359-8658ebf5287a@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 22:37:40 +0800
Message-ID: <CALOAHbAywgXie2xZXJGW_vghQ-nGb3ek46FtHs0eeuAmxRB17w@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 9:54 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/29/2018 06:35 AM, Yafang Shao wrote:
>> This is additional to the commit ea1627c20c34 ("tcp: minor optimizations around tcp_hdr() usage").
>> At this point, skb->data is same with tcp_hdr() as tcp header has not
>> been pulled yet.
>> Remove the third parameter of tcp_rcv_established() and put it into
>> the function body.
>>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>
>> ---
>> v4: remove the third parameter of tcp_rcv_established()
>> ---
>>  include/net/tcp.h    | 3 +--
>>  net/ipv4/tcp_input.c | 4 ++--
>>  net/ipv4/tcp_ipv4.c  | 2 +-
>>  net/ipv6/tcp_ipv6.c  | 2 +-
>>  4 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 952d842..029a51b 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -334,8 +334,7 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
>>  void tcp_delack_timer_handler(struct sock *sk);
>>  int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg);
>>  int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>> -void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
>> -                      const struct tcphdr *th);
>> +void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>>  void tcp_rcv_space_adjust(struct sock *sk);
>>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>>  void tcp_twsk_destructor(struct sock *sk);
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 1191cac..1d70dab 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -5390,11 +5390,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>>   *   the rest is checked inline. Fast processing is turned on in
>>   *   tcp_data_queue when everything is OK.
>>   */
>> -void tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
>> -                      const struct tcphdr *th)
>> +void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
>>  {
>>       unsigned int len = skb->len;
>>       struct tcp_sock *tp = tcp_sk(sk);
>> +     const struct tcphdr *th = (const struct tcphdr *)skb->data;
>>
>>
>
> Please reorder list to get a reverse christmas tree.
>

Got it :)

> const struct tcphdr *th = (const struct tcphdr *)skb->data;
> struct tcp_sock *tp = tcp_sk(sk);
> unsigned int len = skb->len;
>
>
