Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758740AbeBPQ5f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:57:35 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41255 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758690AbeBPQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:56:58 -0500
X-Google-Smtp-Source: AH8x2261n8cUOIaUMyLE8QhgGu54GpEHcnjGsyqFMG5U61zkn6bLyla+za+FVnUjTgkyDFbiOf7Zr9f/V8xBhksj37M=
MIME-Version: 1.0
In-Reply-To: <061740d0-9876-c905-7466-ef225ec3cdc5@applied-asynchrony.com>
References: <1697118.nv5eASg0nx@natalenko.name> <2189487.nPhU5NAnbi@natalenko.name>
 <061740d0-9876-c905-7466-ef225ec3cdc5@applied-asynchrony.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 Feb 2018 11:56:35 -0500
Message-ID: <CADVnQy=9veR6ee7Hn2dp7g7-0Tmw_7Cggpyh=krOiNizdjEr8w@mail.gmail.com>
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GGvdXB010272

On Fri, Feb 16, 2018 at 11:26 AM, Holger Hoffstätte
<holger@applied-asynchrony.com> wrote:
>
> BBR in general will run with lower cwnd than e.g. Cubic or others.
> That's a feature and necessary for WAN transfers.

Please note that there's no general rule about whether BBR will run
with a lower or higher cwnd than CUBIC, Reno, or other loss-based
congestion control algorithms. Whether BBR's cwnd will be lower or
higher depends on the BDP of the path, the amount of buffering in the
bottleneck, and the number of flows. BBR tries to match the amount of
in-flight data to the BDP based on the available bandwidth and the
two-way propagation delay. This will usually produce an amount of data
in flight that is smaller than CUBIC/Reno (yielding lower latency) if
the path has deep buffers (bufferbloat), but can be larger than
CUBIC/Reno (yielding higher throughput) if the buffers are shallow and
the traffic is suffering burst losses.

>
>>> If using real HW (1 Gbps LAN, laptop and server), BBR limits the throughput
>>> to ~100 Mbps (verifiable not only by iperf3, but also by scp while
>>> transferring some files between hosts).
>
> Something seems really wrong with your setup. I get completely
> expected throughput on wired 1Gb between two hosts:
>
> Connecting to host tux, port 5201
> [  5] local 192.168.100.223 port 48718 connected to 192.168.100.222 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   113 MBytes   948 Mbits/sec    0    204 KBytes
> [  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec    0    204 KBytes
> [  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec    0    204 KBytes
> [...]
>
> Running it locally gives the more or less expected results as well:
>
> Connecting to host ragnarok, port 5201
> [  5] local 192.168.100.223 port 54090 connected to 192.168.100.223 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  8.09 GBytes  69.5 Gbits/sec    0    512 KBytes
> [  5]   1.00-2.00   sec  8.14 GBytes  69.9 Gbits/sec    0    512 KBytes
> [  5]   2.00-3.00   sec  8.43 GBytes  72.4 Gbits/sec    0    512 KBytes
> [...]
>
> Both hosts running 4.14.x with bbr and fq_codel (default qdisc everywhere).

Can you please clarify if this is over bare metal or between VM
guests? It sounds like Oleksandr's initial report was between KVM VMs,
so the virtualization may be an ingredient here.

thanks,
neal
