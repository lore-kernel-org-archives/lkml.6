Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C76ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200621476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSQnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:43:15 -0400
Received: from foss.arm.com ([217.140.101.70]:48596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeJSQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:43:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B196980D;
        Fri, 19 Oct 2018 01:38:09 -0700 (PDT)
Received: from [10.37.12.214] (unknown [10.37.12.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90B23F5D3;
        Fri, 19 Oct 2018 01:38:07 -0700 (PDT)
Subject: Re: [PATCH] coresight: tmc: Fix bad register address for CLAIM
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
References: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9b6a508d-5c4b-ffd8-7f6b-3f4e6db26571@arm.com>
Date:   Fri, 19 Oct 2018 09:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 10/19/2018 05:56 AM, Leo Yan wrote:
> Commit 4d3ebd3658d8 ("coreisght: tmc: Claim device before use") uses
> CLAIM tag to validate if the device is available, it needs to pass
> the device base address to access related registers.
> 
> In the function tmc_etb_disable_hw() it wrongly passes the driver data
> pointer as register base address, thus it's easily to produce the kernel
> warning info like below:
> 
> [   83.579898] WARNING: CPU: 4 PID: 2970 at drivers/hwtracing/coresight/coresight.c:207 coresight_disclaim_device_unlocked+0x44/0x80
> [   83.591448] Modules linked in:
> [   83.594485] CPU: 4 PID: 2970 Comm: uname Not tainted 4.19.0-rc6-00417-g721b509 #110

Oops! Thanks for fixing !


> 
> This patch is to fix this bug by using 'drvdata->base' as the
> register base address for CLAIM related operation.
> 
> Fixes: 4d3ebd3658d8 ("coreisght: tmc: Claim device before use")
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 53fc83b..5864ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -86,7 +86,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   
>   static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   {
> -	coresight_disclaim_device(drvdata);
> +	coresight_disclaim_device(drvdata->base);
>   	__tmc_etb_disable_hw(drvdata);
>   }
>   
> 

