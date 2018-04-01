Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeDASut (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 14:50:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34749 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeDASur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 14:50:47 -0400
X-Google-Smtp-Source: AIpwx490DYriZ0sdtTxR7MxPnLhEscqnuS0p4u6c1y632besqF7DHrelpIzp9v7Yw3oUhJ8VUt9aow==
Date: Sun, 1 Apr 2018 11:50:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Gary Ceph <agaceph@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: improve ipv4 performances
Message-ID: <20180401115044.17f7ccb4@xeon-e3>
In-Reply-To: <20180401183121.13022-1-agaceph@gmail.com>
References: <20180401183121.13022-1-agaceph@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Apr 2018 20:31:21 +0200
Anton Gary Ceph <agaceph@gmail.com> wrote:

> As the Linux networking stack is growing, more and more protocols are
> added, increasing the complexity of stack itself.
> Modern processors, contrary to common belief, are very bad in branch
> prediction, so it's our task to give hints to the compiler when possible.
> 
> After a few profiling and analysis, turned out that the ethertype field
> of the packets has the following distribution:
> 
>     92.1% ETH_P_IP
>      3.2% ETH_P_ARP
>      2.7% ETH_P_8021Q
>      1.4% ETH_P_PPP_SES
>      0.6% don't know/no opinion
> 
> From a projection on statistics collected by Google about IPv6 adoption[1],
> IPv6 should peak at 25% usage at the beginning of 2030. Hence, we should
> give proper hints to the compiler about the low IPv6 usage.
> 
> Here is an iperf3 run before and after the patch:
> 
> Before:
> [ ID]  Interval           Transfer    Bandwidth       Retr
> [  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec  0       sender
> [  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec          receiver
> 
> After
> [ ID]  Interval           Transfer    Bandwidth       Retr
> [  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec  0       sender
> [  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec          receiver
> 
> [1] https://www.google.com/intl/en/ipv6/statistics.html
> 
> Signed-off-by: Anton Gary Ceph <agaceph@gmail.com>

I am surprised it makes that much of an impact.

It would be easier to manage future bisection if the big patch
was split into several pieces. Bridge,  bonding, netfilter, etc.
There doesn't appear to be any direct cross dependencies.
