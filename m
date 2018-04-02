Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeDBAvz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 20:51:55 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36310 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeDBAvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 20:51:53 -0400
X-Google-Smtp-Source: AIpwx490YiFm+kycwbtyz9tTiy1anMkQbnWleuKrBTcSDQKHS3H5xChlPu+X1leJCGoQoBHFPVqPKDiNXKwgVqaOvY4=
MIME-Version: 1.0
In-Reply-To: <20180401115044.17f7ccb4@xeon-e3>
References: <20180401183121.13022-1-agaceph@gmail.com> <20180401115044.17f7ccb4@xeon-e3>
From: "Md. Islam" <mislam4@kent.edu>
Date: Sun, 1 Apr 2018 20:51:52 -0400
Message-ID: <CAFgPn1Dk+48J1CDNvzcG6jRx1ccWrecru=QJxvNr1qjoAU4MLg@mail.gmail.com>
Subject: Re: [PATCH] net: improve ipv4 performances
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anton Gary Ceph <agaceph@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'm also seeing good performance improvement after adding
likely() and prefetch().

On Sun, Apr 1, 2018 at 2:50 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Sun,  1 Apr 2018 20:31:21 +0200
> Anton Gary Ceph <agaceph@gmail.com> wrote:
>
>> As the Linux networking stack is growing, more and more protocols are
>> added, increasing the complexity of stack itself.
>> Modern processors, contrary to common belief, are very bad in branch
>> prediction, so it's our task to give hints to the compiler when possible.
>>
>> After a few profiling and analysis, turned out that the ethertype field
>> of the packets has the following distribution:
>>
>>     92.1% ETH_P_IP
>>      3.2% ETH_P_ARP
>>      2.7% ETH_P_8021Q
>>      1.4% ETH_P_PPP_SES
>>      0.6% don't know/no opinion
>>
>> From a projection on statistics collected by Google about IPv6 adoption[1],
>> IPv6 should peak at 25% usage at the beginning of 2030. Hence, we should
>> give proper hints to the compiler about the low IPv6 usage.
>>
>> Here is an iperf3 run before and after the patch:
>>
>> Before:
>> [ ID]  Interval           Transfer    Bandwidth       Retr
>> [  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec  0       sender
>> [  4]  0.00-100.00 sec    100 GBytes  8.60 Gbits/sec          receiver
>>
>> After
>> [ ID]  Interval           Transfer    Bandwidth       Retr
>> [  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec  0       sender
>> [  4]  0.00-100.00 sec    109 GBytes  9.35 Gbits/sec          receiver
>>
>> [1] https://www.google.com/intl/en/ipv6/statistics.html
>>
>> Signed-off-by: Anton Gary Ceph <agaceph@gmail.com>
>
> I am surprised it makes that much of an impact.
>
> It would be easier to manage future bisection if the big patch
> was split into several pieces. Bridge,  bonding, netfilter, etc.
> There doesn't appear to be any direct cross dependencies.
>
>



-- 
Tamim
PhD Candidate,
Kent State University
http://web.cs.kent.edu/~mislam4/
