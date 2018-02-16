Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031655AbeBPQ0Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:26:16 -0500
Received: from mail02.iobjects.de ([188.40.134.68]:52482 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbeBPQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:26:14 -0500
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
        "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
References: <1697118.nv5eASg0nx@natalenko.name>
 <2189487.nPhU5NAnbi@natalenko.name>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <061740d0-9876-c905-7466-ef225ec3cdc5@applied-asynchrony.com>
Date: Fri, 16 Feb 2018 17:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2189487.nPhU5NAnbi@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/18 16:15, Oleksandr Natalenko wrote:
> Hi, David, Eric, Neal et al.
> 
> On čtvrtek 15. února 2018 21:42:26 CET Oleksandr Natalenko wrote:
>> I've faced an issue with a limited TCP bandwidth between my laptop and a
>> server in my 1 Gbps LAN while using BBR as a congestion control mechanism.
>> To verify my observations, I've set up 2 KVM VMs with the following
>> parameters:
>>
>> 1) Linux v4.15.3
>> 2) virtio NICs
>> 3) 128 MiB of RAM
>> 4) 2 vCPUs
>> 5) tested on both non-PREEMPT/100 Hz and PREEMPT/1000 Hz

These are very odd configurations. :)
Non-preempt/100 might well be too slow, whereas PREEMPT/1000 might simply
have too much overhead.

>> The VMs are interconnected via host bridge (-netdev bridge). I was running
>> iperf3 in the default and reverse mode. Here are the results:
>>
>> 1) BBR on both VMs
>>
>> upload: 3.42 Gbits/sec, cwnd ~ 320 KBytes
>> download: 3.39 Gbits/sec, cwnd ~ 320 KBytes
>>
>> 2) Reno on both VMs
>>
>> upload: 5.50 Gbits/sec, cwnd = 976 KBytes (constant)
>> download: 5.22 Gbits/sec, cwnd = 1.20 MBytes (constant)
>>
>> 3) Reno on client, BBR on server
>>
>> upload: 5.29 Gbits/sec, cwnd = 952 KBytes (constant)
>> download: 3.45 Gbits/sec, cwnd ~ 320 KBytes
>>
>> 4) BBR on client, Reno on server
>>
>> upload: 3.36 Gbits/sec, cwnd ~ 370 KBytes
>> download: 5.21 Gbits/sec, cwnd = 887 KBytes (constant)
>>
>> So, as you may see, when BBR is in use, upload rate is bad and cwnd is low.

BBR in general will run with lower cwnd than e.g. Cubic or others.
That's a feature and necessary for WAN transfers.

>> If using real HW (1 Gbps LAN, laptop and server), BBR limits the throughput
>> to ~100 Mbps (verifiable not only by iperf3, but also by scp while
>> transferring some files between hosts).

Something seems really wrong with your setup. I get completely
expected throughput on wired 1Gb between two hosts:

Connecting to host tux, port 5201
[  5] local 192.168.100.223 port 48718 connected to 192.168.100.222 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   948 Mbits/sec    0    204 KBytes       
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec    0    204 KBytes       
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec    0    204 KBytes       
[...]

Running it locally gives the more or less expected results as well:

Connecting to host ragnarok, port 5201
[  5] local 192.168.100.223 port 54090 connected to 192.168.100.223 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  8.09 GBytes  69.5 Gbits/sec    0    512 KBytes       
[  5]   1.00-2.00   sec  8.14 GBytes  69.9 Gbits/sec    0    512 KBytes       
[  5]   2.00-3.00   sec  8.43 GBytes  72.4 Gbits/sec    0    512 KBytes       
[...]

Both hosts running 4.14.x with bbr and fq_codel (default qdisc everywhere).
In the past I only used BBR briefly for testing since at 1Gb speeds on my
LAN it was actually slightly slower than Cubic (some of those bugs were
recently addressed) and made no difference otherwise, even for uploads -
which are capped by my 50/10 DSL anyway.

Please note that BBR was developed to address the case of WAN transfers
(or more precisely high BDP paths) which often suffer from TCP throughput
collapse due to single packet loss events. While it might "work" in other
scenarios as well, strictly speaking delay-based anything is increasingly
less likely to work when there is no meaningful notion of delay - such
as on a LAN. (yes, this is very simplified..)

The BBR mailing list has several nice reports why the current BBR
implementation (dubbed v1) has a few - sometimes severe - problems.
These are being addressed as we speak.

(let me know if you want some of those tech reports by email. :)

>> Also, I've tried to use YeAH instead of Reno, and it gives me the same
>> results as Reno (IOW, YeAH works fine too).
>>
>> Questions:
>>
>> 1) is this expected?
>> 2) or am I missing some extra BBR tuneable?

No, it should work out of the box.

>> 3) if it is not a regression (I don't have any previous data to compare
>> with), how can I fix this?
>> 4) if it is a bug in BBR, what else should I provide or check for a proper
>> investigation?
> 
> I've played with BBR a little bit more and managed to narrow the issue down to 
> the changes between v4.12 and v4.13. Here are my observations:
> 
> v4.12 + BBR + fq_codel == OK
> v4.12 + BBR + fq       == OK
> v4.13 + BBR + fq_codel == Not OK
> v4.13 + BBR + fq       == OK
> 
> I think this has something to do with an internal TCP implementation for 
> pacing, that was introduced in v4.13 (commit 218af599fa63) specifically to 
> allow using BBR together with non-fq qdiscs. Once BBR relies on fq, the 
> throughput is high and saturates the link, but if another qdisc is in use, for 
> instance, fq_codel, the throughput drops. Just to be sure, I've also tried 
> pfifo_fast instead of fq_codel with the same outcome resulting in the low 
> throughput.

I'm not sure testing the old version without builtin pacing is going to help
matters in finding the actual problem. :)
Several people have reported severe performance regressions with 4.15.x,
maybe that's related. Can you test latest 4.14.x?

Out of curiosity, what is the expected use case for BBR here?

cheers
Holger
