Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeERRKX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:10:23 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33947 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:10:19 -0400
X-Google-Smtp-Source: AB8JxZppq56UC/YnRra0bJXX/PMwytmmreIKft0wRTo3QIBdO4JJv+bc+sr8cHVPBFrXjTXCmpai5MVpSqB6+OvR704=
MIME-Version: 1.0
In-Reply-To: <20180518.114433.390752642781753429.davem@davemloft.net>
References: <20180518120826.GA19515@dragonet.kaist.ac.kr> <293d029c-b14c-a625-3703-97a5754e99f1@gmail.com>
 <20180518.114433.390752642781753429.davem@davemloft.net>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 18 May 2018 13:09:37 -0400
Message-ID: <CAF=yD-Kb4ZfJ3sMAnWEOB_s9Y=TTnLbRZxrDPiGZLO=trPjY5Q@mail.gmail.com>
Subject: Re: WARNING in ip_recv_error
To: David Miller <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        DaeLyong Jeong <threeearcat@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:44 AM, David Miller <davem@davemloft.net> wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Fri, 18 May 2018 08:30:43 -0700
>
>> We probably need to revert Willem patch (7ce875e5ecb8562fd44040f69bda96c999e38bbc)
>
> Is it really valid to reach ip_recv_err with an ipv6 socket?

I guess the issue is that setsockopt IPV6_ADDRFORM is not an
atomic operation, so that the socket is neither fully ipv4 nor fully
ipv6 by the time it reaches ip_recv_error.

  sk->sk_socket->ops = &inet_dgram_ops;
  < HERE >
  sk->sk_family = PF_INET;

Even calling inet_recv_error to demux would not necessarily help.

Safest would be to look up by skb->protocol, similar to what
ipv6_recv_error does to handle v4-mapped-v6.

Or to make that function safe with PF_INET and swap the order
of the above two operations.

All sound needlessly complicated for this rare socket option, but
I don't have a better idea yet. Dropping on the floor is not nice,
either.
