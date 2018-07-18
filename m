Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD34220684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1//MqjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeGRFUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:20:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38566 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbeGRFUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:20:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id v15-v6so1582487pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 21:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=atCpzx5y1dvl6zYDV6sQXojA3LiOBcbKhV9xSGOTmMU=;
        b=U1//MqjMwN2ZYhZHg0jDmM7UbCjXpaXhy19ajC8Kaljy6iB/SxL9aoikNO7pKQmkJG
         /BauG07LjKzBCPhaCyfl+OVPfxcKnL606+IVn0YXUeYK1pREgM6Jc3BAd4C1l4VYJaVa
         2deWTiq8WduiQQjVa3+qs6hB8k2UK5tDBwA6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=atCpzx5y1dvl6zYDV6sQXojA3LiOBcbKhV9xSGOTmMU=;
        b=fF4vuRMF6t0QWRrbWrWGuv2GJ2W49/DHd+j9yikVokTfHOD1ClpxVoBMl6td+FlWNT
         g76pXVRTgk0kmVbd9Sf8bVcb6qzGsNgZS1bwFGxEg9VpA2hhFifFXm7MUbQUB30FscUH
         5GmX3R2U/36WvIYTW9uYOEQkjMBhH2SZbAy7mViG8eMuRH/vn9JLbWZKjsitNME0dOtI
         fZfbnhA1ckRixaGiwgZ8/nh7bvAoPHjZiwk5NkYqQ7hdP6ApsZelFgWAV7kYYFxGRSWV
         NtEtMlh6iwVsd28ptZZqHyxkEIbxhaRZrHihjSl9SPmEzzMAByEUF+Qlcf3P9jbJdfzs
         IqnA==
X-Gm-Message-State: AOUpUlF2AxZBM51pRJWnVkGp+VRV97OiE0MvcV/Z+IIHs1Il4FFptQWR
        AR6YpNWfwXZ7gTGw2D/JhGCr5A==
X-Google-Smtp-Source: AAOMgpeIqBMmovSYqEB/0HnTYTIcHoVZQk35rn5jjgrfrJbywXzmLwEBUonvmvcZQJXeHvWxuSwESQ==
X-Received: by 2002:a62:283:: with SMTP id 125-v6mr3587594pfc.51.1531889065000;
        Tue, 17 Jul 2018 21:44:25 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id g4-v6sm3783919pgc.8.2018.07.17.21.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 21:44:24 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:14:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
Message-ID: <20180718044422.6j4nmluynopcpqfx@vireshk-i7>
References: <20180717204821.15987-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717204821.15987-1-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 22:48, Niklas Cassel wrote:
> If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
> error message. Just be silent in this case.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389accf3e9..b8d1e6875f16 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>  	of_node_put(np);
>  	if (IS_ERR(speedbin_nvmem)) {
> -		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> -			PTR_ERR(speedbin_nvmem));
> +		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> +			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> +				PTR_ERR(speedbin_nvmem));
>  		return PTR_ERR(speedbin_nvmem);
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
