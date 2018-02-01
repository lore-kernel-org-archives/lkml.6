Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBAMci (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:32:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeBAMcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:32:35 -0500
Subject: Re: [PATCH v3 14/18] firmware/psci: Expose SMCCC version through
 psci_ops
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
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
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <87705115-ca05-4d35-a169-51e1f3676133@arm.com>
Date: Thu, 1 Feb 2018 12:32:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201114657.7323-15-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 11:46, Marc Zyngier wrote:
> Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
> let's do that at boot time, and expose the version of the calling
> convention as part of the psci_ops structure.
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/firmware/psci.c | 19 +++++++++++++++++++
>   include/linux/psci.h    |  6 ++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index e9493da2b111..8631906c414c 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -61,6 +61,7 @@ bool psci_tos_resident_on(int cpu)
>   
>   struct psci_operations psci_ops = {
>   	.conduit = PSCI_CONDUIT_NONE,
> +	.smccc_version = SMCCC_VERSION_1_0,
>   };
>   
>   typedef unsigned long (psci_fn)(unsigned long, unsigned long,
> @@ -511,6 +512,23 @@ static void __init psci_init_migrate(void)
>   	pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
>   }
>   
> +static void __init psci_init_smccc(u32 ver)
> +{
> +	int feature;
> +
> +	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> +
> +	if (feature != PSCI_RET_NOT_SUPPORTED) {
> +		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> +		if (ver != ARM_SMCCC_VERSION_1_1)
> +			psci_ops.smccc_version = SMCCC_VERSION_1_0;

AFAICS, unless you somehow run psci_probe() twice *and* have 
schizophrenic firmware, this assignment now does precisely nothing.

With the condition flipped and the redundant else case removed (or an 
explanation of why I'm wrong...)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +		else
> +			psci_ops.smccc_version = SMCCC_VERSION_1_1;
> +	}
> +
> +	pr_info("SMC Calling Convention v1.%d\n", psci_ops.smccc_version);
> +}
> +
>   static void __init psci_0_2_set_functions(void)
>   {
>   	pr_info("Using standard PSCI v0.2 function IDs\n");
> @@ -559,6 +577,7 @@ static int __init psci_probe(void)
>   	psci_init_migrate();
>   
>   	if (PSCI_VERSION_MAJOR(ver) >= 1) {
> +		psci_init_smccc(ver);
>   		psci_init_cpu_suspend();
>   		psci_init_system_suspend();
>   	}
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index f2679e5faa4f..8b1b3b5935ab 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -31,6 +31,11 @@ enum psci_conduit {
>   	PSCI_CONDUIT_HVC,
>   };
>   
> +enum smccc_version {
> +	SMCCC_VERSION_1_0,
> +	SMCCC_VERSION_1_1,
> +};
> +
>   struct psci_operations {
>   	u32 (*get_version)(void);
>   	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -41,6 +46,7 @@ struct psci_operations {
>   			unsigned long lowest_affinity_level);
>   	int (*migrate_info_type)(void);
>   	enum psci_conduit conduit;
> +	enum smccc_version smccc_version;
>   };
>   
>   extern struct psci_operations psci_ops;
> 
