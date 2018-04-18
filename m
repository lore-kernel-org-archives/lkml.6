Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeDREmo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:42:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34854 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeDREmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:42:43 -0400
X-Google-Smtp-Source: AIpwx49O5T4Ylxs7NNL+h0yuapVfo+Sxw5R+BTow7XHoZbAH3+gbciyDoJ9DuBtP2LNR3Gga9UY2pTqbbiHVJ2QA5Ug=
MIME-Version: 1.0
In-Reply-To: <20180417234455.q6fgn7oroehmxk6l@ast-mbp>
References: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com>
 <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com> <20180417234455.q6fgn7oroehmxk6l@ast-mbp>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 18 Apr 2018 12:42:02 +0800
Message-ID: <CALOAHbCmC4xjyk8wd9nk6X0CKDp9YWPhGJuNoOAwEV82i4gN-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: introduce a new tracepoint for tcp_rcv_space_adjust
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Song Liu <songliubraving@fb.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 7:44 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Apr 16, 2018 at 08:43:31AM -0700, Eric Dumazet wrote:
>>
>>
>> On 04/16/2018 08:33 AM, Yafang Shao wrote:
>> > tcp_rcv_space_adjust is called every time data is copied to user space,
>> > introducing a tcp tracepoint for which could show us when the packet is
>> > copied to user.
>> > This could help us figure out whether there's latency in user process.
>> >
>> > When a tcp packet arrives, tcp_rcv_established() will be called and with
>> > the existed tracepoint tcp_probe we could get the time when this packet
>> > arrives.
>> > Then this packet will be copied to user, and tcp_rcv_space_adjust will
>> > be called and with this new introduced tracepoint we could get the time
>> > when this packet is copied to user.
>> >
>> >     arrives time : user process time    => latency caused by user
>> >     tcp_probe      tcp_rcv_space_adjust
>> >
>> > Hence in the prink message, sk is printed as a key to connect these two
>> > tracepoints.
>> >
>>
>> socket pointer is not a key.
>>
>> TCP sockets can be reused pretty fast after free.
>>
>> I suggest you go for cookie instead, this is an unique 64bit identifier.
>> ( sock_gen_cookie() for details )
>
> I think would be even better if the stack would do this sock_gen_cookie()
> on its own in some way that user cannnot infere the order.
> In many cases we wanted to use socket cookie, but since it's not inited
> by default it's kinda useless.
> Turning this tracepoint on just to get cookie would be an ugly workaround.
>

Could we init it in sk_alloc() ?
Then in other code paths, for example sock_getsockopt or tracepoints,
we only read the value through a new inline function named
sock_read_cookie().


Thanks
Yafang
