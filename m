Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeERUb3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:31:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46212 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeERUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:31:25 -0400
X-Google-Smtp-Source: AB8JxZp94f9nrAQx3vc/wFPY3g7RWv2v+m9PEDtKoZsloqWO4ZKv/NEHdtmh+CfuFZCMa3r4etmxwuShHQuGmv0/9gE=
MIME-Version: 1.0
In-Reply-To: <20180518080308.GA28587@dragonet.kaist.ac.kr>
References: <20180518080308.GA28587@dragonet.kaist.ac.kr>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 18 May 2018 16:30:44 -0400
Message-ID: <CAF=yD-JbiE0W6pv77DUO0pYrJCYfgszm6zwCEfkv8HedvRfujQ@mail.gmail.com>
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

On Fri, May 18, 2018 at 4:03 AM, DaeRyong Jeong <threeearcat@gmail.com> wrote:
> We report the crash: WARNING in __static_key_slow_dec
>
> This crash has been found in v4.8 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report.
> Even though v4.8 is the relatively old version, we did manual verification
> and we think the bug still exists.
> Our analysis shows that the race occurs when invoking two syscalls
> concurrently, setsockopt() with optname SO_TIMESTAMPING and ioctl() with
> cmd SIOCGSTAMPNS.
>
>
> Diagnosis:
> We think if timestamp was previously enabled with
> SOCK_TIMESTAMPING_RX_SOFTWARE flag, the concurrent execution of
> sock_disable_timestamp() and sock_enable_timestamp() causes the crash.
>
>
> Thread interleaving:
> (Assume sk->flag has the SOCK_TIMESTAMPING_RX_SOFTWARE flag by the
> previous setsockopt() call with SO_TIMESTAMPING)
>
> CPU0 (sock_disable_timestamp())                 CPU1 (sock_enable_timestamp())
> =====                                           =====
> (flag == 1UL << SOCK_TIMESTAMPING_RX_SOFTWARE)  (flag == SOCK_TIMESTAMP)
>
>                                                 if (!sock_flag(sk, flag)) {
>                                                         unsigned long previous_flags = sk->sk_flags;
>
> if (sk->sk_flags & flags) {
>         sk->sk_flags &= ~flags;
>         if (sock_needs_netstamp(sk) &&
>             !(sk->sk_flags & SK_FLAGS_TIMESTAMP))
>                 net_disable_timestamp();
>                                                         sock_set_flag(sk, flag);
>
>                                                         if (sock_needs_netstamp(sk) &&
>                                                             !(previous_flags & SK_FLAGS_TIMESTAMP))
>                                                                 net_enable_timestamp();
>                                                         /* Here, net_enable_timestamp() is not called because
>                                                          * previous_flags has the SOCK_TIMESTAMPING_RX_SOFTWARE
>                                                          * flag
>                                                          */
> /* After the race, sk->sk has the flag SOCK_TIMESTAMP, but
>  * net_enable_timestamp() is not called one more time.
>  * Consequently, when the socket is closed, __sk_destruct()
>  * calls net_disable_timestamp() that leads WARNING.
>  */

Thanks for the detailed analysis.

Indeed the updates to sk->sk_flags and calls to net_(dis|en)able_timestamp
should happen atomically, but this is not the case. The setsockopt
path holds the socket lock, but not all ioctl paths.

Perhaps we can take lock_sock_fast in sock_get_timestamp and
variants.
