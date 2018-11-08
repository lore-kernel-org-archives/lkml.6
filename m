Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A3020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A3020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKIDEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:04:46 -0500
Received: from foss.arm.com ([217.140.101.70]:46174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbeKIDEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:04:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8EC80D;
        Thu,  8 Nov 2018 09:28:15 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CD2D3F5CF;
        Thu,  8 Nov 2018 09:28:14 -0800 (PST)
Subject: Re: [PATCH v2 4/4] coresight: etm3x: Release CLAIM tag when operated
 from perf
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
 <1541632132-1252-5-git-send-email-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <597b9fba-5c3f-1718-072a-c984d5709e68@arm.com>
Date:   Thu, 8 Nov 2018 17:28:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541632132-1252-5-git-send-email-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2018 23:08, Mathieu Poirier wrote:
> This patch deals with the release of the CLAIM tag when the ETM is
> operated from perf.  Otherwise the tag is left asserted and subsequent
> requests to use the device fail.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 4f638d81a66a..d7f452e62193 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -602,6 +602,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   	 * power down the tracer.
>   	 */
>   	etm_set_pwrdwn(drvdata);
> +	coresight_disclaim_device_unlocked(drvdata->base);

Thanks for fixing this. IIUC, I think we have a problem in general with
mixing perf vs sysfs. Once a perf session uses the etm3x, we overwrite
the drvdata->config with the perf event specific controls and the sysfs
user may not be aware of that. We may have to do something similar we do
for ETR buf for sysfs/perf sessions. And then we may be able to merge
the enable/disable routines.

For this patch:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
