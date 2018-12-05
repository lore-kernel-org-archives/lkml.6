Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32A2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuXGc6eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B32A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLEAja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:39:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37163 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLEAja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:39:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so17833812wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/3cE4rCN9+eLwAO3lu4KxUEsOiK0ad9DJriKIqnR6I=;
        b=RuXGc6eqXjW/8RKLBuVemvjuppJ3H1T/mMRQX+H34B/tu51HFV68Wvxpwmk9OuD9zq
         MeBtlcQmBT6v2KRVEh8xZufbJYttn06dLMD4LVhtfI8gGJW5l1BXI97MvhlezUT3KCGc
         1uExx4jy4BvRaVCeU0GUfTsFfstdr/HPBZOXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/3cE4rCN9+eLwAO3lu4KxUEsOiK0ad9DJriKIqnR6I=;
        b=M9Xr92ZDrDbBd4mtfYlRLRUdB8s/4wDcGPRf7jAChhNKVsoQcGM4u1tRUYGy///TBJ
         vdHMYTRIPrBi7GTdAcXgsR3cmWsEB7znNwjRvKL9nnz1DXIXAkq94Tmk2uj8xYVYTkT9
         awvUQfdNAnKul+I4IjoaCDpqFHMO176vcYu1BHUzXEi0SMAzPo9Pt8YR35Q3rpyHNMBK
         Za6UlYEk5yZ0n+qQMciHlI0uZj8mfETkD5NksNVsaKa+ocGXBqU2Htjct7k0hwPWv1l5
         cyNWd5HMn4G15RiEDUV3Cr7a5AM4grEmSdxVsKqk/veuUr3RFYCRs0L5SzrC7fxjtZFB
         JziA==
X-Gm-Message-State: AA+aEWZTet6utu3fXoQrP7gq6Oj14CFkm9xXgbb1tZlmVQjC2dNTpwHx
        2BYXwboS7H18H1F520pU+OGzCA==
X-Google-Smtp-Source: AFSGD/XV5wE3XWClPP3b249uQPUL8fKgBt5VQEPysWjKCWernyOQ9wlo3GbJRODNCYpZlZFZ7+1Kyw==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr4609495wrr.326.1543970368643;
        Tue, 04 Dec 2018 16:39:28 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id j8sm15329980wmd.0.2018.12.04.16.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 16:39:27 -0800 (PST)
Date:   Wed, 5 Dec 2018 08:39:21 +0800
From:   leo.yan@linaro.org
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] coresight: stm: remove set but not used variable
 'res_size'
Message-ID: <20181205003921.GC11628@leoy-ThinkPad-X240s>
References: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 08:39:45AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
> drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
>  variable 'res_size' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

FWIW, Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index ef339ff..f07825d 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct stm_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct resource ch_res;
> -	size_t res_size, bitmap_size;
> +	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
>  	struct device_node *np = adev->dev.of_node;
>  
> @@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
>  
> -	if (boot_nr_channel) {
> +	if (boot_nr_channel)
>  		drvdata->numsp = boot_nr_channel;
> -		res_size = min((resource_size_t)(boot_nr_channel *
> -				  BYTES_PER_CHANNEL), resource_size(res));
> -	} else {
> +	else
>  		drvdata->numsp = stm_num_stimulus_port(drvdata);
> -		res_size = min((resource_size_t)(drvdata->numsp *
> -				 BYTES_PER_CHANNEL), resource_size(res));
> -	}
> +
>  	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
>  
>  	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
> 
> 
> 
