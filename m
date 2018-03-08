Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755831AbeCHLKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:22 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45930 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbeCHLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:16 -0500
X-Google-Smtp-Source: AG47ELv1RXm1IKPFVhe+/GLBWwe/y9xtR6Qh/g6XiyltWf0kWyu+hiF6XrG2uBc+mPoOZ2kt0sKzcQNYPeok/V5tjAk=
MIME-Version: 1.0
In-Reply-To: <1520505099.7807.60.camel@suse.de>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <1520505099.7807.60.camel@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Mar 2018 12:10:15 +0100
X-Google-Sender-Auth: k0--1JqrGSTNdZUmwEXnvonCZbM
Message-ID: <CAJZ5v0gCi7bLL_r45qmoOKwh_dWF_RVs0U5UPe3qY45GbvtK9w@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
To: Mike Galbraith <mgalbraith@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 11:31 AM, Mike Galbraith <mgalbraith@suse.de> wrote:
> On Tue, 2018-03-06 at 09:57 +0100, Rafael J. Wysocki wrote:
>> Hi All,
>
> Greetings,

Hi,

>> Thanks a lot for the discussion so far!
>>
>> Here's a new version of the series addressing some comments from the
>> discussion and (most importantly) replacing patches 4 and 5 with another
>> (simpler) patch.
>
> Oddity: these patches seemingly manage to cost a bit of power when
> lightly loaded.  (but didn't cut cross core nohz cost much.. darn)
>
> i4790 booted nopti nospectre_v2
>
> 30 sec tbench
> 4.16.0.g1b88acc-master (virgin)
> Throughput 559.279 MB/sec  1 clients  1 procs  max_latency=0.046 ms
> Throughput 997.119 MB/sec  2 clients  2 procs  max_latency=0.246 ms
> Throughput 1693.04 MB/sec  4 clients  4 procs  max_latency=4.309 ms
> Throughput 3597.2 MB/sec  8 clients  8 procs  max_latency=6.760 ms
> Throughput 3474.55 MB/sec  16 clients  16 procs  max_latency=6.743 ms
>
> 4.16.0.g1b88acc-master (+v2)
> Throughput 588.929 MB/sec  1 clients  1 procs  max_latency=0.291 ms
> Throughput 1080.93 MB/sec  2 clients  2 procs  max_latency=0.639 ms
> Throughput 1826.3 MB/sec  4 clients  4 procs  max_latency=0.647 ms
> Throughput 3561.01 MB/sec  8 clients  8 procs  max_latency=1.279 ms
> Throughput 3382.98 MB/sec  16 clients  16 procs  max_latency=4.817 ms

max_latency is much lower here for >2 clients/procs, but at the same
time it is much higher for <=2 clients/procs (which then may be
related to the somewhat higher throughput).  Interesting.

> 4.16.0.g1b88acc-master (+local nohz mitigation etc for reference [1])
> Throughput 722.559 MB/sec  1 clients  1 procs  max_latency=0.087 ms
> Throughput 1208.59 MB/sec  2 clients  2 procs  max_latency=0.289 ms
> Throughput 2071.94 MB/sec  4 clients  4 procs  max_latency=0.654 ms
> Throughput 3784.91 MB/sec  8 clients  8 procs  max_latency=0.974 ms
> Throughput 3644.4 MB/sec  16 clients  16 procs  max_latency=5.620 ms
>
> turbostat -q -- firefox /root/tmp/video/BigBuckBunny-DivXPlusHD.mkv & sleep 300;killall firefox
>
>                         PkgWatt
>                               1     2     3
> 4.16.0.g1b88acc-master     6.95  7.03  6.91 (virgin)
> 4.16.0.g1b88acc-master     7.20  7.25  7.26 (+v2)
> 4.16.0.g1b88acc-master     6.90  7.06  6.95 (+local)
>
> Why would v2 charge the light firefox load a small but consistent fee?

Two effects may come into play here I think.

One is that allowing the tick to run biases the menu governor's
predictions towards the lower end, so we may use shallow states more
as a result then (Peter was talking about that).

The second one may be that intermediate states are used quite a bit
"by nature" in this workload (that should be quite straightforward to
verify) and stopping the tick for them saves some energy on idle
entry/exit.

Thanks!
