Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFF421019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFF421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeK2BcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:32:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:49611 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeK2BcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:32:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 06:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="278253767"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 06:30:29 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <eb6ed521-8e04-924d-f9a8-5729b88e2bec@linux.intel.com>
Date:   Wed, 28 Nov 2018 08:32:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127101145.7682-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 4:11 AM, Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
> 
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
> We pull all the information about clocks from device tree.
> 
> Also, while we enable the runtime pm add a pm sleep suspend
> callback that pushes devices to low power state by turning
> the clocks off in a system sleep.
> Also add corresponding clock enable path in resume callback.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [Thor: Rework to get clocks from device tree]
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> [vivek: rework for clock and pm ops]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/arm-smmu.c | 100 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5a28ae892504..e47c840fc6a8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -44,10 +44,12 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_clk.h>
>   #include <linux/of_device.h>
>   #include <linux/of_iommu.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>  <snip>

Thanks! Tested the device tree clock portions on Intel SOCFPGA Stratix10 
DevKit.

Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
