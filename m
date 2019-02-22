Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DEDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4877020818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBVDkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:40:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:43029 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBVDkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:40:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 19:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="126321256"
Received: from sgdharne-mobl2.gar.corp.intel.com (HELO [10.252.84.57]) ([10.252.84.57])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2019 19:40:32 -0800
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Avoid a u32 overflow
To:     Rajat Jain <rajatja@google.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com
References: <20190216001920.178053-1-rajatja@google.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <6dc61237-5424-506c-2d31-11658cc52caf@linux.intel.com>
Date:   Fri, 22 Feb 2019 09:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190216001920.178053-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Feb-19 5:49 AM, Rajat Jain wrote:
> The register (SLP_S0_RES) at offset slp_s0_offset is a 32 bit register.
> The pmc_core_adjust_slp_s0_step() could overflow the u32 value while
> returning it after adjusting the step. Thus change to u64, this is
> already accounted for in debugfs attribute (that wants to output a
> 64 bit value).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

> ---
>   drivers/platform/x86/intel_pmc_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 22dbf115782e..f90f4dd25151 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -328,9 +328,9 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int
>   	writel(val, pmcdev->regbase + reg_offset);
>   }
>   
> -static inline u32 pmc_core_adjust_slp_s0_step(u32 value)
> +static inline u64 pmc_core_adjust_slp_s0_step(u32 value)
>   {
> -	return value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
> +	return (u64)value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
>   }
>   
>   static int pmc_core_dev_state_get(void *data, u64 *val)
>
>
