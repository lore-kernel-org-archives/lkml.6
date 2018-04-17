Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDQXpC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:45:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41987 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeDQXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:45:00 -0400
X-Google-Smtp-Source: AIpwx49yYc7It3HSea/JYGSEJMn1VnxayYk5vJATdoiuLxmn+Ir93U5n1hm/uXVSlJHLxNxiyY9fKQ==
Date: Tue, 17 Apr 2018 16:44:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
Message-ID: <20180417234455.q6fgn7oroehmxk6l@ast-mbp>
References: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com>
 <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 08:43:31AM -0700, Eric Dumazet wrote:
> 
> 
> On 04/16/2018 08:33 AM, Yafang Shao wrote:
> > tcp_rcv_space_adjust is called every time data is copied to user space,
> > introducing a tcp tracepoint for which could show us when the packet is
> > copied to user.
> > This could help us figure out whether there's latency in user process.
> > 
> > When a tcp packet arrives, tcp_rcv_established() will be called and with
> > the existed tracepoint tcp_probe we could get the time when this packet
> > arrives.
> > Then this packet will be copied to user, and tcp_rcv_space_adjust will
> > be called and with this new introduced tracepoint we could get the time
> > when this packet is copied to user.
> > 
> > 	arrives time : user process time    => latency caused by user
> > 	tcp_probe      tcp_rcv_space_adjust
> > 
> > Hence in the prink message, sk is printed as a key to connect these two
> > tracepoints.
> > 
> 
> socket pointer is not a key.
> 
> TCP sockets can be reused pretty fast after free.
> 
> I suggest you go for cookie instead, this is an unique 64bit identifier.
> ( sock_gen_cookie() for details )

I think would be even better if the stack would do this sock_gen_cookie()
on its own in some way that user cannnot infere the order.
In many cases we wanted to use socket cookie, but since it's not inited
by default it's kinda useless.
Turning this tracepoint on just to get cookie would be an ugly workaround.
