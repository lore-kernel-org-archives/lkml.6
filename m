Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeETXHo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:07:44 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:40996 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeETXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:07:43 -0400
X-Google-Smtp-Source: AB8JxZqa+RdkBME2R0Vs2gNa739V1wzVX6m6bkqMRuzk+k1Dc8H9ASYxLa4qZykU+LxMAq9sMCVZkcpSMknFwDXxZY8=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-+jS5BJKHEDp+K4fB41YnY1mR8ksVg98oWPJV=mG01pfg@mail.gmail.com>
References: <20180518080308.GA28587@dragonet.kaist.ac.kr> <CAF=yD-JbiE0W6pv77DUO0pYrJCYfgszm6zwCEfkv8HedvRfujQ@mail.gmail.com>
 <CAF=yD-+jS5BJKHEDp+K4fB41YnY1mR8ksVg98oWPJV=mG01pfg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 20 May 2018 19:07:01 -0400
Message-ID: <CAF=yD-Jv1-KfE32jCrAHL8mPnXHRzU4idV7dQYdGtzUcikrWQA@mail.gmail.com>
Subject: Re: WARNING in __static_key_slow_dec
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> -static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
> +static void sock_disable_timestamp(struct sock *sk, unsigned long flag)
>  {
> -       if (sk->sk_flags & flags) {
> -               sk->sk_flags &= ~flags;
> -               if (sock_needs_netstamp(sk) &&
> -                   !(sk->sk_flags & SK_FLAGS_TIMESTAMP))
> -                       net_disable_timestamp();
> -       }
> +       unsigned long prev;
> +
> +       do {
> +               prev = READ_ONCE(sk->sk_flags);
> +
> +               if (!(prev & flag))
> +                       return;
> +
> +               if (cmpxchg(&sk->sk_flags, prev, prev & ~flag) == prev)
> +                       break;
> +       } while (1);

and this can just use set_mask_bits
