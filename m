Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeBLTHR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:07:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:46823 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbeBLTHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:07:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="17568238"
Subject: Re: [RFC PATCH 00/20] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To: Thomas Gleixner <tglx@linutronix.de>,
        "Hindman, Gavin" <gavin.hindman@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1510568528.git.reinette.chatre@intel.com>
 <alpine.DEB.2.20.1711180133540.2186@nanos>
 <93415e33-6adf-047f-9a46-0862c3cd33b6@intel.com>
 <alpine.DEB.2.20.1801142346200.2371@nanos>
 <D5D6254030DBC644B6EE58B333BFBB1E9D9F2F1C@FMSMSX151.amr.corp.intel.com>
 <alpine.DEB.2.20.1801161227180.1823@nanos>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0a93c952-070f-eb79-74d5-25c1df8a9791@intel.com>
Date: Mon, 12 Feb 2018 11:07:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801161227180.1823@nanos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 1/16/2018 3:38 AM, Thomas Gleixner wrote:
> On Mon, 15 Jan 2018, Hindman, Gavin wrote:
>>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>>> owner@vger.kernel.org] On Behalf Of Thomas Gleixner
>>> On Fri, 17 Nov 2017, Reinette Chatre wrote:

>>>> 2) The most recent kernel supported by PALLOC is v4.4 and also
>>>> mentioned in the above link there is currently no plan to upstream
>>>> this work for a less divergent comparison of PALLOC and the more
>>>> recent RDT/CAT enabling on which Cache Pseudo-Locking is built.
>>>
>>> Well, that's not a really good excuse for not trying. You at Intel should be able
>>> to get to the parameters easy enough :)
>>>
>> We can run the comparison, but I'm not sure that I understand the intent
>> - my understanding of Palloc is that it's intended to allow allocation of
>> memory to specific physical memory banks.  While that might result in
>> reduced cache-misses since processes are more separated, it's not
>> explicitly intended to reduce cache-misses, and Palloc's benefits would
>> only hold as long as you have few enough processes to be able to
>> dedicate/isolate memory accordingly.  Am I misunderstanding the
>> intent/usage of palloc?
> 
> Right. It comes with its own set of restrictions as does the pseudo-locking.

Reporting results of comparison between PALLOC, CAT, and Cache
Pseudo-Locking. CAT is a hardware supported and Linux enabled cache
partitioning mechanism while PALLOC is an out of tree software cache
partitioning mechanism. Neither CAT nor PALLOC protects against eviction
from a cache partition. Cache Pseudo-Locking builds on CAT by adding
protection against eviction from cache.

Latest PALLOC available is a patch against kernel v4.4. PALLOC data was
collected with latest PALLOC v4.4 patch(*) applied against v4.4.113. CAT
and Cache Pseudo-Locking data was collected with a rebase of this patch
series against x86/cache of tip.git (based on v4.15-rc8) when the HEAD was:

commit 31516de306c0c9235156cdc7acb976ea21f1f646
Author: Fenghua Yu <fenghua.yu@intel.com>
Date:   Wed Dec 20 14:57:24 2017 -0800

    x86/intel_rdt: Add command line parameter to control L2_CDP

All tests involve a user space application that allocates (malloc() with
mlockall()) or in the case of Cache Pseudo-Locking maps using mmap()) a
256KB region of memory. The application then randomly accesses this
region, 32 bytes at a time, measuring the latency in cycles of each
access using the rdtsc instruction. Each time a test is run it is
repeated ten times.

As with the previous tests from this thread, testing was done on an
Intel(R) NUC NUC6CAYS (it has an Intel(R) Celeron(R) Processor J3455).
The system has two 1MB L2 cache (1024 sets and 16 ways).

A few extra tests were done with PALLOC to establish a baseline that I
got it working right before comparing it against CAT and Cache
Pseudo-Locking. Each test was run on an idle system as well as a system
where significant interference was introduced on a core sharing the L2 cache
with the core on which the test was running (referred to as "noisy
neighbor").


TEST1) PALLOC: Enable PALLOC but do not do any cache partitioning.

TEST2) PALLOC: Designate four bits to be used for page coloring, thus
creating four bins. Bits were chosen as the only four bits that overlap
between page and cache set addressing. Run application in a cgroup that
has access to one bin with rest of system accessing the three remaining
bins.

TEST3) PALLOC: With the same four bits used for page coloring as in
TEST2. Let application run in cgroup with dedicated access to two bins,
rest of system the remaining two bins.

TEST4) CAT: Same CAT test as in original cover letter where application
runs with dedicated CLOS with CBM of 0xf. Default CLOS CBM changed to
non-overlapping 0xf0.

TEST5) Cache Pseudo-Locking: Application reads from 256KB Cache Pseudo
Locked region.

Data visualizations plot the cumulative (of ten tests) counts of the
number of instances (y axis) a particular number of cycles (x axis) were
measured. Each plot is accompanied by a boxplot used to visualize the
descriptive statistics (whiskers represent 0 to 99th percentile, inter
quartile range q1 to q3 with black rectangle, median is orange line,
green is average).

Visualization
https://github.com/rchatre/data/blob/master/cache_pseudo_locking/palloc/palloc_baseline.png
presents the PALLOC only results for TEST1 through TEST3. The most
prominent improvement when using PALLOC is when the application obtains
dedicated access to two bins (half of the cache, double the size of
memory being accessed) - in this environment its first quartile is
significantly lower than all the other partitionings. The application
thus experiences more instances where memory access latency is low. We
can see though that the average latency experienced by the application
is not affected significantly by this.

Visualization
https://github.com/rchatre/data/blob/master/cache_pseudo_locking/palloc/palloc_cat_pseudo.png
presents the same PALLOC two bins (TEST3) seen in previous visualization
with the CAT and Cache Pseudo-Locking results. The visualization shows
with all descriptive statistics a significant improved latency when
using CAT compared to PALLOC. The additional comparison with Cache
Pseudo-Locking shows the improved average access latency when compared
to both CAT and PALLOC.

In both the PALLOC and CAT tests there was improvement (CAT most
significant) in latency accessing a 256KB memory region but in both
(PALLOC and CAT) 512KB of cache was set aside for application to obtain
these results. Using Cache Pseudo-Locking to access the 256KB memory
region only 256KB of cache was set aside while also reducing the access
latency when compared to both PALLOC and CAT.

I do hope these results establishes the value of Cache Pseudo-Locking to
you. The rebased patch series used in this testing will be sent out
this week.

Regards,

Reinette

(*) A one line change was made as documented in
https://github.com/heechul/palloc/issues/8
