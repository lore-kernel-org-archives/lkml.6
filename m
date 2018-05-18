Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEROw3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:52:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:48533 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbeEROw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,415,1520924400";
   d="scan'208";a="42042628"
Subject: Re: [PATCH] perf/x86/intel/uncore: allocate pmu index for pci device
 dynamically
To: Eric Ren <renzhen@linux.alibaba.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, kan.liang@intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org
References: <20180518052359.48756-1-renzhen@linux.alibaba.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <83d84444-83a3-0c90-5e8a-b7d543beaa90@linux.intel.com>
Date: Fri, 18 May 2018 10:52:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518052359.48756-1-renzhen@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 1:23 AM, Eric Ren wrote:
> Some boxes/devices of uncore are exported as pcie devices. However,
> the box number is different on different micro-architecture. For
> example, the max memory channels for Broadwell is up to 8. However,
> there are only 2 channels for Broadwell-DE, 4 channels for Broadwell-EP,
> and 8 channels for Broadwell-EX.
> 
> The current code allocates pmu index statically so that on Broadwell-EP
> machine "perf list|grep uncore" shows discontinuous iMC number, which
> doesn't look nice:
> 
> Test on Broadwell-EP using "ls /sys/devices | grep -i imc":
> 
> Without this patch,
>      uncore_imc_0
>      uncore_imc_1
>      uncore_imc_4
>      uncore_imc_5
> 
> To maintain pmu index dynamically, move index allocation logic to
> uncore_pci_probe(). As a result, we can get continuous index of iMC
> devices under /sys/devices directory:
> 
> Applied this patch:,
>      uncore_imc_0
>      uncore_imc_1
>      uncore_imc_2
>      uncore_imc_3
> 
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> ---

I only have one small suggestion.
Except that, the patch looks good to me.
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

>   arch/x86/events/intel/uncore.c | 7 ++++++-
>   arch/x86/events/intel/uncore.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index a7956fc..88d390e 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -818,7 +818,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>   
>   	for (i = 0; i < type->num_boxes; i++) {
>   		pmus[i].func_id	= setid ? i : -1;
> -		pmus[i].pmu_idx	= i;
> +		/* The pmu idx will be decided at probe for pci device. */
> +		if (setid)
> +			pmus[i].pmu_idx	= i;

I think we may use the same way as func_id to check the pmu_idx.
pmus[i].pmu_idx	= setid ? i : -1;

>   		pmus[i].type	= type;
>   		pmus[i].boxes	= kzalloc(size, GFP_KERNEL);
>   		if (!pmus[i].boxes)
> @@ -957,6 +959,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
>   	if (atomic_inc_return(&pmu->activeboxes) > 1)
>   		return 0;
>   
> +	/*  Count the real number of pmus for pci uncore device */
> +	pmu->pmu_idx = type->num_pmus++;
> +

	if (pmu->pmu_idx < 0)
		pmu->pmu_idx = type->num_pmus++;
	else
		WARN_ON_ONCE(1);

>   	/* First active box registers the pmu */
>   	ret = uncore_pmu_register(pmu);
>   	if (ret) {
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 414dc7e..c4f54fb 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -40,6 +40,7 @@ struct intel_uncore_type {
>   	const char *name;
>   	int num_counters;
>   	int num_boxes;
> +	int num_pmus; /* for pci uncore device */
>   	int perf_ctr_bits;
>   	int fixed_ctr_bits;
>   	unsigned perf_ctr;
> 
