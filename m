Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A35713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A720881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342A720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeG3MkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:40:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:35319 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeG3MkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:40:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 04:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="77146422"
Received: from speedy.fi.intel.com (HELO [10.237.72.71]) ([10.237.72.71])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2018 04:05:43 -0700
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
To:     Mel Gorman <mgorman@techsingularity.net>,
        Francisco Jerez <currojerez@riseup.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        ggherdovich@suse.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
 <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
 <87bmarhqk4.fsf@riseup.net>
 <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
From:   Eero Tamminen <eero.t.tamminen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <e7388bf4-deb1-34b6-97d7-89ced8e78ef1@intel.com>
Date:   Mon, 30 Jul 2018 14:16:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 28.07.2018 15:36, Mel Gorman wrote:
> On Fri, Jul 27, 2018 at 10:34:03PM -0700, Francisco Jerez wrote:
>> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>
>>> Enable HWP boost on Skylake server and workstations.
>>>
>>
>> Please revert this series, it led to significant energy usage and
>> graphics performance regressions [1].  The reasons are roughly the ones
>> we discussed by e-mail off-list last April: This causes the intel_pstate
>> driver to decrease the EPP to zero when the workload blocks on IO
>> frequently enough, which for the regressing benchmarks detailed in [1]
>> is a symptom of the workload being heavily IO-bound, which means they
>> won't benefit at all from the EPP boost since they aren't significantly
>> CPU-bound, and they will suffer a decrease in parallelism due to the
>> active CPU core using a larger fraction of the TDP in order to achieve
>> the same work, causing the GPU to have a lower power budget available,
>> leading to a decrease in system performance.
 >
> It slices both ways. With the series, there are large boosts to
> performance on other workloads where a slight increase in power usage is
> acceptable in exchange for performance. For example,
> 
> Single socket skylake running sqlite
[...]
> That's over doubling the transactions per second for that workload.
> 
> Two-socket skylake running dbench4
[...]> This is reporting the average latency of operations running 
dbench. The
> series over halves the latencies. There are many examples of basic
> workloads that benefit heavily from the series and while I accept it may
> not be universal, such as the case where the graphics card needs the power
> and not the CPU, a straight revert is not the answer. Without the series,
> HWP cripplies the CPU.

I assume SQLite IO-bottleneck is for the disk.  Disk doesn't share
the TDP limit with the CPU, like IGP does.

Constraints / performance considerations for TDP sharing IO-loads
differ from ones that don't share TDP with CPU cores.


Workloads that can be "IO-bound" and which can be on the same chip
with CPU i.e. share TDP with it are:
- 3D rendering
- Camera / video processing
- Compute

Intel, AMD and ARM manufacturers all have (non-server) chips where these
IP blocks are on the same die as CPU cores.  If CPU part redundantly
doubles its power consumption, it's directly eating TDP budget away from
these devices.

For workloads where IO bottleneck doesn't share TDP budget with CPU,
like (sqlite) databases, you don't lose performance by running CPU
constantly at full tilt, you only use more power [1].

Questions:

* Does currently kernel CPU freq management have any idea which IO
   devices share TDP with the CPU cores?

* Do you do performance testing also in conditions that hit TDP limits?


	- Eero

[1]  For them power usage is performance problem only if you start
hitting TDP limit with CPUs alone, or you hit temperature limits.

For CPUs alone to hit TDP limits, our test-case needs to be utilizing 
multiple cores and device needs to have lowish TDP compared to the
performance of the chip.

TDP limiting adds test results variance significantly, but that's
a property of the chips themselves so it cannot be avoided. :-/

Temperature limiting might happen on small enclosures like the ones used
for the SKL HQ devices i.e. laptops & NUCs, but not on servers.   In our
testing we try to avoid temperature limitations when its possible (=
extra cooling) as it increases variance so much that results are mostly
useless (same devices are also TDP limited i.e. already have high
variance).
