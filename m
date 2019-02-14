Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121132229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440207AbfBNVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:31:59 -0500
Received: from foss.arm.com ([217.140.101.70]:51058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392871AbfBNVb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:31:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF0CEEBD;
        Thu, 14 Feb 2019 13:31:57 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E103F557;
        Thu, 14 Feb 2019 13:31:55 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To:     Douglas Anderson <dianders@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        evgreen@chromium.org, tfiga@chromium.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190214204433.155715-1-dianders@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
Date:   Thu, 14 Feb 2019 21:31:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214204433.155715-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> Right now the only way to disable the iommu bypass for the ARM SMMU is
> with the kernel command line parameter 'arm-smmu.disable_bypass'.
> 
> In general kernel command line parameters make sense for things that
> someone would like to tweak without rebuilding the kernel or for very
> basic communication between the bootloader and the kernel, but are
> awkward for other things.  Specifically:
> * Human parsing of the kernel command line can be difficult since it's
>    just a big runon space separated line of text.
> * If every bit of the system was configured via the kernel command
>    line the kernel command line would get very large and even more
>    unwieldly.
> * Typically there are not easy ways in build systems to adjust the
>    kernel command line for config-like options.
> 
> Let's introduce a new config option that allows us to disable the
> iommu bypass without affecting the existing default nor the existing
> ability to adjust the configuration via kernel command line.

I say let's just flip the default - for a while now it's been one of 
those "oh yeah, we should probably do that" things that gets instantly 
forgotten again, so some 3rd-party demand is plenty to convince me :)

There are few reasons to allow unmatched stream bypass, and even fewer 
good ones, so I'd be happy to shift the command-line burden over to the 
esoteric cases at this point, and consider the config option in future 
if anyone from that camp pops up and screams hard enough.

Cheers,
Robin.

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c |  3 ++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 46fcd75d4364..c614beab08f8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -359,6 +359,28 @@ config ARM_SMMU
>   	  Say Y here if your SoC includes an IOMMU device implementing
>   	  the ARM SMMU architecture.
>   
> +config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> +	bool "Default to disabling bypass on ARM SMMU v1 and v2"
> +	depends on ARM_SMMU
> +	default n
> +	help
> +	  Say Y here to (by default) disable bypass streams such that
> +	  incoming transactions from devices that are not attached to
> +	  an iommu domain will report an abort back to the device and
> +	  will not be allowed to pass through the SMMU.
> +
> +	  Historically the ARM SMMU v1 and v2 driver has defaulted
> +	  to allow bypass by default but it could be disabled with
> +	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
> +	  still present and can be used to override this config
> +	  option, but this config option allows you to disable bypass
> +	  without bloating the kernel command line.
> +
> +	  Disabling bypass is more secure but presumably will break
> +	  old systems.
> +
> +	  Say N if unsure.
> +
>   config ARM_SMMU_V3
>   	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>   	depends on ARM64
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..930c07635956 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -110,7 +110,8 @@ static int force_stage;
>   module_param(force_stage, int, S_IRUGO);
>   MODULE_PARM_DESC(force_stage,
>   	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> -static bool disable_bypass;
> +static bool disable_bypass =
> +	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
>   module_param(disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> 
