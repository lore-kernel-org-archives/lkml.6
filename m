Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeDPPnf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:43:35 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42275 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeDPPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:43:34 -0400
X-Google-Smtp-Source: AIpwx4+TLUApjDSkDHptuhhCrK7Y9diAOHx5Eb+FWD86vJD52rPFtogQk+uCK7wdgVnBRJr8S7q85A==
Subject: Re: [PATCH net-next] net: introduce a new tracepoint for
 tcp_rcv_space_adjust
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com>
Date: Mon, 16 Apr 2018 08:43:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2018 08:33 AM, Yafang Shao wrote:
> tcp_rcv_space_adjust is called every time data is copied to user space,
> introducing a tcp tracepoint for which could show us when the packet is
> copied to user.
> This could help us figure out whether there's latency in user process.
> 
> When a tcp packet arrives, tcp_rcv_established() will be called and with
> the existed tracepoint tcp_probe we could get the time when this packet
> arrives.
> Then this packet will be copied to user, and tcp_rcv_space_adjust will
> be called and with this new introduced tracepoint we could get the time
> when this packet is copied to user.
> 
> 	arrives time : user process time    => latency caused by user
> 	tcp_probe      tcp_rcv_space_adjust
> 
> Hence in the prink message, sk is printed as a key to connect these two
> tracepoints.
> 

socket pointer is not a key.

TCP sockets can be reused pretty fast after free.

I suggest you go for cookie instead, this is an unique 64bit identifier.
( sock_gen_cookie() for details )
