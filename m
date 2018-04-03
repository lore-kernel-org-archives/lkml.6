Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDCO2s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:28:48 -0400
Received: from smtp826.redehostenvio.com.br ([187.84.239.40]:47244 "EHLO
        smtp826.redehostenvio.com.br" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751247AbeDCO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:28:47 -0400
Subject: Re: [PATCH] net: improve ipv4 performances
To: Anton Gary Ceph <agaceph@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180401183121.13022-1-agaceph@gmail.com>
From: Douglas Caetano dos Santos <douglascs@taghos.com.br>
Message-ID: <fd3c1749-dedc-10b0-e5a5-f4c88ae434b5@taghos.com.br>
Date: Tue, 3 Apr 2018 11:18:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180401183121.13022-1-agaceph@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [179.219.244.203]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton, everyone,

On 04/01/18 15:31, Anton Gary Ceph wrote:
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

My two cents on the matter:

You should not consider favoring some parts of code in detriment of another just because of one use case. In your patch, you're considering one server that attends for IPv4 and IPv6 connections simultaneously, in a proportion seen on the Internet, but you completely disregard the use cases of servers that could serve, for example, only IPv6. What about those, just let them slow down?

What I think about such hints and optimizations - someone correct me if I'm wrong - is that they should be done not with specific use cases in mind, but according to the code flow in general. For example, it could be a good idea to slow down ARP requests, because there is AFAIK not such a server that attends only ARP (not that I'm advocating for it, just using as an example). But slowing down IPv6, as Eric already said, is utterly non-sense.

Again, "low IPv6 usage" doesn't mean code that is barely touched, with an IPv6-only server being the obvious example.

-- 
Douglas
