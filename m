Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeEUJwZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:52:25 -0400
Received: from foss.arm.com ([217.140.101.70]:45834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeEUJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:52:22 -0400
Subject: Re: [PATCH v3 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
To: Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <20180518143913.26306-5-marc.zyngier@arm.com>
 <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <1a87b643-67ec-dce8-1f44-d831c8302afc@arm.com>
Date: Mon, 21 May 2018 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 10:34, Vladimir Murzin wrote:
> On 18/05/18 15:39, Marc Zyngier wrote:
>> +static inline int read_pmuver(void)
>> +{
>> +	/* PMUVers is not a signed field */
>> +	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
>> +	return (dfr0 >> 24) & 0xf;
>> +}
> 
> Should we rule out versions prior v3 here or in __armv8pmu_probe_pmu()?

I'm in two minds about it: The ARM ARM is quite clear about the fact
that this is not legal ("In any ARMv8 implementation the values 0001 and
0010 are not permitted."), and DT clearly lied to us in that case.

If we want to consistently handle that case, it should probably be done
in __armv8pmu_probe_pmu, bailing out if the version is our of scope for
the driver.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
