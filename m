Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeC1ODB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:03:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41288 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbeC1OC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:02:59 -0400
X-Google-Smtp-Source: AIpwx49dWl0qIDlwVyJHk6GfGc46wkMkCg5/r/uP/xErop+1Mt/0MGt5U2KitDE1NHJapJ9AMF1bdRYn56bHlkhP2dY=
MIME-Version: 1.0
In-Reply-To: <20180328091226.GD28871@arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org> <20180328091226.GD28871@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 28 Mar 2018 16:02:38 +0200
Message-ID: <CAKfTPtCXPM75N27WzDHSc7rkaNEo8cTU4YO9h1X6ckL-=WkL_w@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 March 2018 at 11:12, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 28, 2018 at 09:46:55AM +0200, Vincent Guittot wrote:

>>
>> The SD_ASYM_PACKING flag is disabled by default and I'm preparing another patch
>> to enable this dynamically at boot time by detecting the system topology.
>>
>>  arch/arm64/kernel/topology.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 2186853..cb6705e5 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -296,6 +296,33 @@ static void __init reset_cpu_topology(void)
>>       }
>>  }
>>
>> +#ifdef CONFIG_SCHED_MC
>> +unsigned int __read_mostly arm64_sched_asym_enabled;
>> +
>> +int arch_asym_cpu_priority(int cpu)
>> +{
>> +     return topology_get_cpu_scale(NULL, cpu);
>> +}
>> +
>> +static inline int arm64_sched_dynamiq(void)
>> +{
>> +     return arm64_sched_asym_enabled ? SD_ASYM_PACKING : 0;
>> +}
>> +
>> +static int arm64_core_flags(void)
>> +{
>> +     return cpu_core_flags() | arm64_sched_dynamiq();
>> +}
>> +#endif
>> +
>> +static struct sched_domain_topology_level arm64_topology[] = {
>> +#ifdef CONFIG_SCHED_MC
>> +     { cpu_coregroup_mask, arm64_core_flags, SD_INIT_NAME(MC) },
>
> Maybe stick this in a macro to avoid the double #ifdef?

ok, I will do that in next version

Vincent

>
> Will
