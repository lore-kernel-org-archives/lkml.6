Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeCIKxU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:53:20 -0500
Received: from foss.arm.com ([217.140.101.70]:50334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbeCIKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:53:19 -0500
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
To: Saravana Kannan <skannan@codeaurora.org>
Cc: will.deacon@arm.com, mark.rutland@arm.com, robh@kernel.org,
        sudeep.holla@arm.com, mathieu.poirier@linaro.org, peterz@infradead.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, leo.yan@linaro.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, rananta@codeaurora.org,
        avilaj@codeaurora.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5AA1CE48.5030203@codeaurora.org>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <a466d82b-2a0f-ffba-f9f7-c76c6c787bb5@arm.com>
Date: Fri, 9 Mar 2018 10:53:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5AA1CE48.5030203@codeaurora.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: Lorenzo, Charles.

On 08/03/18 23:59, Saravana Kannan wrote:
> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
>> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
>> The DSU integrates one or more cores with an L3 memory system, control
>> logic, and external interfaces to form a multicore cluster. The PMU
>> allows counting the various events related to L3, SCU etc, along with
>> providing a cycle counter.
>>
>> The PMU can be accessed via system registers, which are common
>> to the cores in the same cluster. The PMU registers follow the
>> semantics of the ARMv8 PMU, mostly, with the exception that
>> the counters record the cluster wide events.
>>
>> This driver is mostly based on the ARMv8 and CCI PMU drivers.
>> The driver only supports ARM64 at the moment. It can be extended
>> to support ARM32 by providing register accessors like we do in
>> arch/arm64/include/arm_dsu_pmu.h.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

> 
> Looking at the code, I didn't see any specific handling of cluster power collapse. AFAIK, the HW counters do not retain config (what event they are counting) or value (the current count) across power collapse. Wouldn't you need to register for some kind of PM_ENTER/EXIT notifiers to handle that?

Good point, yes *somebody* needs to save-restore the registers. But who ? As far
as the kernel is concerned, it doesn't control the DSU states. Also, as of now
there is no reliable way to get the "ENTER/EXIT" notifications for the DSU power
domain state changes. All we do is use the PMU, assuming it is available. AFAIT,
it should really be done at EL3, which manages the DSU, but may be I am wrong.

Sudeep, Lorenzo, Charles,

Please feel free to share your thoughts.

Cheers
Suzuki
