Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C64C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D652321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMdYNz68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfAKSwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:52:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbfAKSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:52:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so7362425pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fkP7KSO3NnYaf3RE7vBcqke3e+ie8uaZNN3XWfX5JfI=;
        b=MMdYNz68V2eQ6qhbcfnjC4OwK9noyptl3TDZvf4dSghRT0U9vhTUoOwPnClglF2MEW
         9iVgPlsm7QPFulsP8Hb9j51goHvpUSc4i1nAaQNE/hCb8w6llaItEk60qwO2ixqRPyef
         TcyZdDcG3htPagLln/iZQhjrA24E/KPNJanXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fkP7KSO3NnYaf3RE7vBcqke3e+ie8uaZNN3XWfX5JfI=;
        b=FHWbg/AxA8Sx4FRiKFa2Sr5bYetUmFTXSYotNO3qslktOUn0+FUV92zHRTupc+Tqt8
         nkXwGDSchMEZRXGZwdFRqffyVqjDfXU3vz6ZZweVNtVCS4TwO9ikdh2vozDjbvtwLCkj
         RoNM2Jo4uaUGv+k+f91Nj7ojExG6SjrkBVXJfDXwojpM8la7Pzr+7uUGsbHlwdFiO0/l
         sUDNqy29qNV/4lQWnlQOqOa/YNUc5aySHIN+sbsci/GjrXl4/8mEtaZj7nb7+l3eE4K4
         JjN/Ucdyg/9hSR4EgW8SkbbPxfl5IGhHxpwNzx7wVSic/fjz5sK/BdZuTBedyrJqaw0t
         GLGg==
X-Gm-Message-State: AJcUukcdHAQa6zbPsPxYy//YkxdajHiQ20pbgTT37Non9Bl80cWOKR2P
        24o5KhdqxGCmo5vaxbsA+f/D/9FgdZiHdQ==
X-Google-Smtp-Source: ALg8bN62UX24xjnS6ISv4Cp7pxuePTmaXC70wW5Kaq3x0/29OMmmT6QAos1AyloFhHl22LDT1Bk/Bw==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr14153015pgh.394.1547232765484;
        Fri, 11 Jan 2019 10:52:45 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f67sm118770644pfc.141.2019.01.11.10.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 10:52:44 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:52:42 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] coresight: etm4x: Add support to enable ETMv4.2
Message-ID: <20190111185242.GB22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:16:48PM +0530, Sai Prakash Ranjan wrote:
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
> / # dmesg | grep coresight
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
>  drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..40cf17df5023 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1021,7 +1021,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	cpus_read_unlock();
>  
> -	if (etm4_arch_supported(drvdata->arch) == false) {
> +	if (etm4_arch_supported(drvdata->arch >> 4) == false) {

I think it would be better to simply mask out the minor version number bits in
function etm4_arch_supported().  That way we can add more intelligence in there 
in the future if we have to and we don't have to touch the calling code again.

Thanks,
Mathieu

>  		ret = -EINVAL;
>  		goto err_arch_supported;
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 52786e9d8926..05d4bd330881 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -136,7 +136,7 @@
>  #define ETM_MAX_RES_SEL			16
>  #define ETM_MAX_SS_CMP			8
>  
> -#define ETM_ARCH_V4			0x40
> +#define ETM_ARCH_V4			0x4
>  #define ETMv4_SYNC_MASK			0x1F
>  #define ETM_CYC_THRESHOLD_MASK		0xFFF
>  #define ETM_CYC_THRESHOLD_DEFAULT       0x100
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
