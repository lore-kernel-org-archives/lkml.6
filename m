Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeBAMsk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:48:40 -0500
Received: from foss.arm.com ([217.140.101.70]:49672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbeBAMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:48:39 -0500
Subject: Re: [PATCH v3 14/18] firmware/psci: Expose SMCCC version through
 psci_ops
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-15-marc.zyngier@arm.com>
 <87705115-ca05-4d35-a169-51e1f3676133@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <83ae5571-c3a2-65df-b7d8-4c7dccb1fb02@arm.com>
Date: Thu, 1 Feb 2018 12:48:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87705115-ca05-4d35-a169-51e1f3676133@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 12:32, Robin Murphy wrote:
> On 01/02/18 11:46, Marc Zyngier wrote:
>> Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
>> let's do that at boot time, and expose the version of the calling
>> convention as part of the psci_ops structure.
>>
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   drivers/firmware/psci.c | 19 +++++++++++++++++++
>>   include/linux/psci.h    |  6 ++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index e9493da2b111..8631906c414c 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -61,6 +61,7 @@ bool psci_tos_resident_on(int cpu)
>>   
>>   struct psci_operations psci_ops = {
>>   	.conduit = PSCI_CONDUIT_NONE,
>> +	.smccc_version = SMCCC_VERSION_1_0,
>>   };
>>   
>>   typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>> @@ -511,6 +512,23 @@ static void __init psci_init_migrate(void)
>>   	pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
>>   }
>>   
>> +static void __init psci_init_smccc(u32 ver)
>> +{
>> +	int feature;
>> +
>> +	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
>> +
>> +	if (feature != PSCI_RET_NOT_SUPPORTED) {
>> +		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
>> +		if (ver != ARM_SMCCC_VERSION_1_1)
>> +			psci_ops.smccc_version = SMCCC_VERSION_1_0;
> 
> AFAICS, unless you somehow run psci_probe() twice *and* have 
> schizophrenic firmware, this assignment now does precisely nothing.

That's a leftover of a previous tracing hack I had...  Embarrassing.

> With the condition flipped and the redundant else case removed (or an 
> explanation of why I'm wrong...)
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
