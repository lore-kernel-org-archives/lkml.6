Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031606AbeBPQ0E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:26:04 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33961 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031522AbeBPQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:26:01 -0500
X-Google-Smtp-Source: AH8x226p3V70ekh0dqPVY2XMFlvajNmhp8pXvWCQFxj7nv97LsfQrHLRHvdZ1Doj8rIAiitEjaWscxHYxVnYXekvMq8=
MIME-Version: 1.0
In-Reply-To: <2189487.nPhU5NAnbi@natalenko.name>
References: <1697118.nv5eASg0nx@natalenko.name> <2189487.nPhU5NAnbi@natalenko.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2018 08:25:58 -0800
Message-ID: <CANn89iKqSkh=3D5-arubZkYdVTbb6C=OR5vK0sMDoO6S3A0GeQ@mail.gmail.com>
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GGQ823026491

On Fri, Feb 16, 2018 at 7:15 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
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
>>
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
>> If using real HW (1 Gbps LAN, laptop and server), BBR limits the throughput
>> to ~100 Mbps (verifiable not only by iperf3, but also by scp while
>> transferring some files between hosts).
>>
>> Also, I've tried to use YeAH instead of Reno, and it gives me the same
>> results as Reno (IOW, YeAH works fine too).
>>
>> Questions:
>>
>> 1) is this expected?
>> 2) or am I missing some extra BBR tuneable?
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
>
> Unfortunately, I do not know if this is something expected or should be
> considered as a regression. Thus, asking for an advice.
>
> Ideas?

The way TCP pacing works, it defaults to internal pacing using a hint
stored in the socket.

If you change the qdisc while flow is alive, result could be unexpected.

(TCP socket remembers that one FQ was supposed to handle the pacing)

What results do you have if you use standard pfifo_fast ?

I am asking because TCP pacing relies on High resolution timers, and
that might be weak on your VM.
