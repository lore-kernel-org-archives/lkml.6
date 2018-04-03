Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDCSsX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:48:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:25746 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbeDCSsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:48:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="29263004"
Date: Tue, 3 Apr 2018 11:45:22 -0700 (PDT)
From: Shivappa Vikas <vikas.shivappa@intel.com>
X-X-Sender: vikas@vshiva-Udesk
To: Thomas Gleixner <tglx@linutronix.de>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA
 software controller
In-Reply-To: <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.10.1804031118410.27913@vshiva-Udesk>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Apr 2018, Thomas Gleixner wrote:

> On Thu, 29 Mar 2018, Vikas Shivappa wrote:
>> +Memory bandwidth(b/w) in MegaBytes
>> +----------------------------------
>> +
>> +Memory bandwidth is a core specific mechanism which means that when the
>> +Memory b/w percentage is specified in the schemata per package it
>> +actually is applied on a per core basis via IA32_MBA_THRTL_MSR
>> +interface. This may lead to confusion in scenarios below:
>> +
>> +1. User may not see increase in actual b/w when percentage values are
>> +   increased:
>> +
>> +This can occur when aggregate L2 external b/w is more than L3 external
>> +b/w. Consider an SKL SKU with 24 cores on a package and where L2
>> +external b/w is 10GBps (hence aggregate L2 external b/w is 240GBps) and
>> +L3 external b/w is 100GBps. Now a workload with '20 threads, having 50%
>> +b/w, each consuming 5GBps' consumes the max L3 b/w of 100GBps although
>> +the percentage value specified is only 50% << 100%. Hence increasing
>> +the b/w percentage will not yeild any more b/w. This is because
>> +although the L2 external b/w still has capacity, the L3 external b/w
>> +is fully used. Also note that this would be dependent on number of
>> +cores the benchmark is run on.
>> +
>> +2. Same b/w percentage may mean different actual b/w depending on # of
>> +   threads:
>> +
>> +For the same SKU in #1, a 'single thread, with 10% b/w' and '4 thread,
>> +with 10% b/w' can consume upto 10GBps and 40GBps although they have same
>> +percentage b/w of 10%. This is simply because as threads start using
>> +more cores in an rdtgroup, the actual b/w may increase or vary although
>> +user specified b/w percentage is same.
>> +
>> +In order to mitigate this and make the interface more user friendly, we
>> +can let the user specify the max bandwidth per rdtgroup in bytes(or mega
>> +bytes). The kernel underneath would use a software feedback mechanism or
>> +a "Software Controller" which reads the actual b/w using MBM counters
>> +and adjust the memowy bandwidth percentages to ensure the "actual b/w
>> +< user b/w".
>> +
>> +The legacy behaviour is default and user can switch to the "MBA software
>> +controller" mode using a mount option 'mba_MB'.
>
> You said above:
>
>> This may lead to confusion in scenarios below:
>
> Reading the blurb after that creates even more confusion than being
> helpful.
>
> First of all this information should not be under the section 'Memory
> bandwidth in MB/s'.
>
> Also please write bandwidth. The weird acronym b/w (band per width???) is
> really not increasing legibility.

Ok will fix and add a seperate section.

>
> What you really want is a general section about memory bandwidth allocation
> where you explain the technical background in purely technical terms w/o
> fairy tale mode. Technical descriptions have to be factual and not
> 'could/may/would'.
>
> If I decode the above correctly then the current percentage based
> implementation was buggy from the very beginning in several ways.
>
> Now the obvious question which is in no way answered by the cover letter is
> why the current percentage based implementation cannot be fixed and we need
> some feedback driven magic to achieve that. I assume you spent some brain
> cycles on that question, so it would be really helpful if you shared that.
>
> If I understand it correctly then the problem is that the throttling
> mechanism is per core and affects the L2 external bandwidth.
>
>  Is this really per core? What about hyper threads. Both threads have that
>  MSR. How is that working?

It is per core mechanism. On hyperthreads, it just takes the lowest bandwidth 
among the thread siblings. We have the below to explain the same - i can add 
more description if needed

"The bandwidth throttling is a core specific mechanism on some of Intel
SKUs. Using a high bandwidth and a low bandwidth setting on two threads
sharing a core will result in both threads being throttled to use the
low bandwidth."

>
> The L2 external bandwidth is higher than the L3 external bandwidth.
>
>  Is there any information available from CPUID or whatever source which
>  allows us to retrieve the bandwidth ratio or the absolute maximum
>  bandwidth per level?

There is no information in cpuid on the bandwidth available. Also we have seen 
from our experiments that the increase is not perfectly linear (delta bandwidth 
increase from 30% to 40% may not be same as 70% to 80%). So we currently 
dynamically caliberate this delta for the software controller.

>
> What's also missing from your explanation is how that feedback loop behaves
> under different workloads.
>
>  Is this assuming that the involved threads/cpus actually try to utilize
>  the bandwidth completely?

No, the feedback loop only guarentees that the usage will not exceed what the 
user specifies as max bandwidth. If it is using below the max value it does not 
matter how much less it is using.

>
>  What happens if the threads/cpus are only using a small set because they
>  are idle or their computations are mostly cache local and do not need
>  external bandwidth? Looking at the implementation I don't see how that is
>  taken into account.

The feedback only kicks into action if a rdtgroup uses more bandwidth than the 
max specified by the user. I specified that it is always "ensure the "actual b/w
354 < user b/w" " and can add more explanation on these scenarios.

Also note that we are using the MBM counters for this feedback loop. Now that 
the interface is much more useful because we have the same rdtgroup that is 
being monitored and controlled. (vs. if we had the perf mbm the group of threads 
in resctrl mba and in mbm could be different and would be hard to measure what 
the threads/cpus in the resctrl are using). So the resctrl being used for both 
of these is a requirement for this and we always check that.

Thanks,
Vikas

>
> Thanks,
>
> 	tglx
>
>
>
>
>
>
>
