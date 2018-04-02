Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDBEuB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 00:50:01 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36594 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeDBEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 00:50:00 -0400
X-Google-Smtp-Source: AIpwx486SteQcwrEyR9/kaFqX8FMFHx0E2nOZoBZ+9C/1k1jy7HDXf6zVdoEOtvnl+WFzHH92zNXsA==
Subject: Re: [PATCH] net: improve ipv4 performances
To: Anton Gary Ceph <agaceph@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180401183121.13022-1-agaceph@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a18770ce-9c53-5b02-b259-bba149883187@gmail.com>
Date: Sun, 1 Apr 2018 21:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180401183121.13022-1-agaceph@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2018 11:31 AM, Anton Gary Ceph wrote:
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

These iperf3 numbers are simply telling something is wrong in your measures or your hardware.

By the time linux kernels with this patch reach hosts, they will likely use IPv6 anyway.

Please do not tell the compiler that IPv6 should be slowed down in favor of IPv4.

Instead, work on removing IPv4 stack from linux kernel (making it a module)
