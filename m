Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeBAMZH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:25:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeBAMZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:25:06 -0500
Subject: Re: [PATCH v3 13/18] firmware/psci: Expose PSCI conduit
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
 <20180201114657.7323-14-marc.zyngier@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <434a53f3-0109-8a5f-414b-0f697bc153d6@arm.com>
Date: Thu, 1 Feb 2018 12:25:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201114657.7323-14-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 11:46, Marc Zyngier wrote:
> In order to call into the firmware to apply workarounds, it is
> useful to find out whether we're using HVC or SMC. Let's expose
> this through the psci_ops.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/firmware/psci.c | 28 +++++++++++++++++++++++-----
>   include/linux/psci.h    |  7 +++++++
>   2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 8b25d31e8401..e9493da2b111 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -59,7 +59,9 @@ bool psci_tos_resident_on(int cpu)
>   	return cpu == resident_cpu;
>   }
>   
> -struct psci_operations psci_ops;
> +struct psci_operations psci_ops = {
> +	.conduit = PSCI_CONDUIT_NONE,
> +};
>   
>   typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>   				unsigned long, unsigned long);
> @@ -210,6 +212,22 @@ static unsigned long psci_migrate_info_up_cpu(void)
>   			      0, 0, 0);
>   }
>   
> +static void set_conduit(enum psci_conduit conduit)
> +{
> +	switch (conduit) {
> +	case PSCI_CONDUIT_HVC:
> +		invoke_psci_fn = __invoke_psci_fn_hvc;
> +		break;
> +	case PSCI_CONDUIT_SMC:
> +		invoke_psci_fn = __invoke_psci_fn_smc;
> +		break;
> +	default:
> +		WARN(1, "Unexpected PSCI conduit %d\n", conduit);
> +	}
> +
> +	psci_ops.conduit = conduit;
> +}
> +
>   static int get_set_conduit_method(struct device_node *np)
>   {
>   	const char *method;
> @@ -222,9 +240,9 @@ static int get_set_conduit_method(struct device_node *np)
>   	}
>   
>   	if (!strcmp("hvc", method)) {
> -		invoke_psci_fn = __invoke_psci_fn_hvc;
> +		set_conduit(PSCI_CONDUIT_HVC);
>   	} else if (!strcmp("smc", method)) {
> -		invoke_psci_fn = __invoke_psci_fn_smc;
> +		set_conduit(PSCI_CONDUIT_SMC);
>   	} else {
>   		pr_warn("invalid \"method\" property: %s\n", method);
>   		return -EINVAL;
> @@ -654,9 +672,9 @@ int __init psci_acpi_init(void)
>   	pr_info("probing for conduit method from ACPI.\n");
>   
>   	if (acpi_psci_use_hvc())
> -		invoke_psci_fn = __invoke_psci_fn_hvc;
> +		set_conduit(PSCI_CONDUIT_HVC);
>   	else
> -		invoke_psci_fn = __invoke_psci_fn_smc;
> +		set_conduit(PSCI_CONDUIT_SMC);
>   
>   	return psci_probe();
>   }
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index f724fd8c78e8..f2679e5faa4f 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -25,6 +25,12 @@ bool psci_tos_resident_on(int cpu);
>   int psci_cpu_init_idle(unsigned int cpu);
>   int psci_cpu_suspend_enter(unsigned long index);
>   
> +enum psci_conduit {
> +	PSCI_CONDUIT_NONE,
> +	PSCI_CONDUIT_SMC,
> +	PSCI_CONDUIT_HVC,
> +};
> +
>   struct psci_operations {
>   	u32 (*get_version)(void);
>   	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -34,6 +40,7 @@ struct psci_operations {
>   	int (*affinity_info)(unsigned long target_affinity,
>   			unsigned long lowest_affinity_level);
>   	int (*migrate_info_type)(void);
> +	enum psci_conduit conduit;
>   };
>   
>   extern struct psci_operations psci_ops;
> 
