Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeCHKbp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:31:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57093 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754816AbeCHKbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:31:44 -0500
Message-ID: <1520505099.7807.60.camel@suse.de>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
From: Mike Galbraith <mgalbraith@suse.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 08 Mar 2018 11:31:39 +0100
In-Reply-To: <2067762.1uWBf5RSRc@aspire.rjw.lan>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 09:57 +0100, Rafael J. Wysocki wrote:
> Hi All,

Greetings,

> Thanks a lot for the discussion so far!
> 
> Here's a new version of the series addressing some comments from the
> discussion and (most importantly) replacing patches 4 and 5 with another
> (simpler) patch.

Oddity: these patches seemingly manage to cost a bit of power when
lightly loaded.  (but didn't cut cross core nohz cost much.. darn)

i4790 booted nopti nospectre_v2

30 sec tbench
4.16.0.g1b88acc-master (virgin)
Throughput 559.279 MB/sec  1 clients  1 procs  max_latency=0.046 ms
Throughput 997.119 MB/sec  2 clients  2 procs  max_latency=0.246 ms
Throughput 1693.04 MB/sec  4 clients  4 procs  max_latency=4.309 ms
Throughput 3597.2 MB/sec  8 clients  8 procs  max_latency=6.760 ms
Throughput 3474.55 MB/sec  16 clients  16 procs  max_latency=6.743 ms

4.16.0.g1b88acc-master (+v2)
Throughput 588.929 MB/sec  1 clients  1 procs  max_latency=0.291 ms
Throughput 1080.93 MB/sec  2 clients  2 procs  max_latency=0.639 ms
Throughput 1826.3 MB/sec  4 clients  4 procs  max_latency=0.647 ms
Throughput 3561.01 MB/sec  8 clients  8 procs  max_latency=1.279 ms
Throughput 3382.98 MB/sec  16 clients  16 procs  max_latency=4.817 ms

4.16.0.g1b88acc-master (+local nohz mitigation etc for reference [1])
Throughput 722.559 MB/sec  1 clients  1 procs  max_latency=0.087 ms
Throughput 1208.59 MB/sec  2 clients  2 procs  max_latency=0.289 ms
Throughput 2071.94 MB/sec  4 clients  4 procs  max_latency=0.654 ms
Throughput 3784.91 MB/sec  8 clients  8 procs  max_latency=0.974 ms
Throughput 3644.4 MB/sec  16 clients  16 procs  max_latency=5.620 ms

turbostat -q -- firefox /root/tmp/video/BigBuckBunny-DivXPlusHD.mkv & sleep 300;killall firefox

                        PkgWatt
                              1     2     3
4.16.0.g1b88acc-master     6.95  7.03  6.91 (virgin)
4.16.0.g1b88acc-master     7.20  7.25  7.26 (+v2)
4.16.0.g1b88acc-master     6.90  7.06  6.95 (+local)

Why would v2 charge the light firefox load a small but consistent fee?

	-Mike

1. see low end, that's largely due to nohz throttling
