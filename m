Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755117AbeEHPf0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:35:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35833 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeEHPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:35:23 -0400
X-Google-Smtp-Source: AB8JxZrq0IEZ86YQK+8YWQq9tCt4yb5pHSiq4iCDpVm3P3SRdaFgTAEtHYjz1/fL2VRDzbah9fxPqNK1c0ZxenWsHXw=
MIME-Version: 1.0
In-Reply-To: <20180507172915.c032cd71c07b1849bf419a5f@arm.com>
References: <20180507172915.c032cd71c07b1849bf419a5f@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 8 May 2018 09:35:21 -0600
Message-ID: <CANLsYkyQLan3XajOz2uuoOF8OQchGfeu2ZkZJ9H1Xm9q==aXTw@mail.gmail.com>
Subject: Re: coresight: documentation: update sysfs section
To: Kim Phillips <kim.phillips@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 May 2018 at 16:29, Kim Phillips <kim.phillips@arm.com> wrote:
> - Align and show updated ls devices output from the TC2, based on
>   current driver
>
> - Provide an example from an ETMv4 based system (Juno)
>
> - Reflect changes to the way the RAM write pointer is accessed since
>   it got changed in commit 7d83d17795ef ("coresight: tmc: adding sysFS
>   management entries").
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  Documentation/trace/coresight.txt | 40 ++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
> index 6f0120c3a4f1..d23d6354b372 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.txt
> @@ -144,10 +144,21 @@ If everything goes well during the registration process the new devices will
>  show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
>
>  root:~# ls /sys/bus/coresight/devices/
> -replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> -20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> +20010000.etb   20040000.funnel 2201d000.ptm  2203d000.etm  replicator
> +20030000.tpiu  2201c000.ptm    2203c000.etm  2203e000.etm
>  root:~#
>
> +and here for a Juno platform:
> +
> +root@juno:~# ls /sys/bus/coresight/devices/
> +20010000.etf    20120000.replicator  22040000.etm     230c0000.funnel
> +20030000.tpiu   20130000.funnel      220c0000.funnel  23140000.etm
> +20040000.funnel  20140000.etf        22140000.etm     23240000.etm
> +20070000.etr    20150000.funnel      23040000.etm     23340000.etm
> +root@juno:~#
> +
> +Note the Juno uses an Embedded Trace Router (ETR) instead of an ETB.

The above is not entirely correct.  On Juno users can select the ETF,
ETR and TPIU as a sink target while on TC2, the ETB and TPIU can be
selected.


> +
>  The functions take a "struct coresight_device", which looks like this:
>
>  struct coresight_desc {
> @@ -193,16 +204,16 @@ the information carried in "THIS_MODULE".
>  How to use the tracer modules
>  -----------------------------
>
> -Before trace collection can start, a coresight sink needs to be identify.
> +Before trace collection can start, a coresight sink needs to be identified.
>  There is no limit on the amount of sinks (nor sources) that can be enabled at
>  any given moment.  As a generic operation, all device pertaining to the sink
>  class will have an "active" entry in sysfs:
>
>  root:/sys/bus/coresight/devices# ls
> -replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
> -20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
> +20010000.etb   20040000.funnel 2201d000.ptm  2203d000.etm  replicator
> +20030000.tpiu  2201c000.ptm    2203c000.etm  2203e000.etm
>  root:/sys/bus/coresight/devices# ls 20010000.etb
> -enable_sink  status  trigger_cntr
> +enable_sink  mgmt  power  subsystem  trigger_cntr  uevent
>  root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
>  root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
>  1
> @@ -216,16 +227,13 @@ trigger a trace capture:
>  root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
>  root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
>  1
> -root:/sys/bus/coresight/devices# cat 20010000.etb/status
> -Depth:          0x2000
> -Status:         0x1
> -RAM read ptr:   0x0
> -RAM wrt ptr:    0x19d3   <----- The write pointer is moving
> -Trigger cnt:    0x0
> -Control:        0x1
> -Flush status:   0x0
> -Flush ctrl:     0x2001
> -root:/sys/bus/coresight/devices#
> +
> +Observe the write pointer moving:
> +
> +root:/sys/bus/coresight/devices# cat 20010000.etb/mgmt/rwp
> +0x1a8
> +root:/sys/bus/coresight/devices# cat 20010000.etb/mgmt/rwp
> +0x19a6
>
>  Trace collection is stopped the same way:
>
> --
> 2.17.0
>
