Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CEA2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfA2J0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:26:11 -0500
Received: from foss.arm.com ([217.140.101.70]:60824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfA2J0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:26:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9726880D;
        Tue, 29 Jan 2019 01:26:10 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7F0D3F7A6;
        Tue, 29 Jan 2019 01:26:05 -0800 (PST)
Subject: Re: [PATCHv5 4/7] coresight: etm4x: Add support to enable ETMv4.2
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <980aaf18c0fe92a667930e3a035394442af74869.1548419933.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <342fa449-124e-7581-dfff-ef5d382f1f6b@arm.com>
Date:   Tue, 29 Jan 2019 09:26:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <980aaf18c0fe92a667930e3a035394442af74869.1548419933.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 19:14, Sai Prakash Ranjan wrote:
> SDM845 has ETMv4.2 and can use the existing etm4x driver.
> But the current etm driver checks only for ETMv4.0 and
> errors out for other etm4x versions. This patch adds this
> missing support to enable SoC's with ETMv4x to use same
> driver by checking only the ETM architecture major version
> number.
> 
> Without this change, we get below error during etm probe:
> 
> / # dmesg | grep etm
> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
> 
> With this change, etm probe is successful:
> 
> / # dmesg | grep etm
> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..fe76b176974a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>   
>   static bool etm4_arch_supported(u8 arch)
>   {
> -	switch (arch) {
> +	/* Mask out the minor version number */
> +	switch (arch & 0xf0) {
>   	case ETM_ARCH_V4:
>   		break;
>   	default:
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


