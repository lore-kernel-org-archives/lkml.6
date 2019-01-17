Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXTQ10Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfAQKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:08:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfAQKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:08:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4594257pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HjIxHy2YTkkHug9kwKKVx+R4/lzJQ2zziaHnfwNtT0=;
        b=gXTQ10XnlhXUwSxfQybKblMRmC9bRikmPdTT7rRHBFXGAyRW9/ly/WqIiLeziMB9UH
         N+JNiE0z4eITRZIaIFp+hRVpGVi4mrgjQBRwgPGLxrOqU4iDNE0762Ba/nI1nGgwd2RG
         OZFVQTJzmUO1x4Z8F8AIsErji3dEtamnF2Jnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HjIxHy2YTkkHug9kwKKVx+R4/lzJQ2zziaHnfwNtT0=;
        b=HSFWlXupTwF1T77QfpnqVW7let9NoTOE34rrXoguzSRHOUOjCb7kaA8KYj0ieOiFp+
         KeRZDUKN2gA/aoICMkS4I83ShrByF8cTrRHbU+XM5h3PzdBZD66ot7WiJtqBXxkTrbGq
         tkRnGFKIr1ew/E9xMkP29RRlYdQbO67cKQEHyunXWL2zGwHsk6lN0/nFI8Y123FImmIk
         Tpb4r0oAmB35JBxryvZhQG9GcCm8uowDdxt2O2/GEDQ3OObw+PXzwOFtju6zxzsQLb5L
         9Fwu3DXUZY22rGid/OYgbOBd5Rtyjljy7XrH7GIHrtKFxdlbPGqdx6HIB4FCKZe/f946
         d2Fw==
X-Gm-Message-State: AJcUukekPqlR3zPvEp3T7kLuj5rgf2xmv9vWAFYxVTPcXTeic9vPINSe
        d/xcOIhaKpHGLr2O6tKCXfeKbQ==
X-Google-Smtp-Source: ALg8bN5vOOzlmwPiCQJiExLQG1QkeO2rcKXMrjtF1L3GCzHIDBhN9sVTDkpwnm2Z2MIRxvddiFJlLA==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr14268347pfc.38.1547719690261;
        Thu, 17 Jan 2019 02:08:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y89sm3127863pfa.136.2019.01.17.02.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:08:09 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:38:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 09:38, Jorge Ramirez wrote:
> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
> to disable the clocks that were enabled by the firwmare and not by the
> drivers.
> 
> the cpufreq driver does not enable the cpu clock.
> 
> so when clk_change_rate is called, the enable_count counter is not
> incremented and therefore it just remains null since this was enabled by
> the firmware.
> 
> I tried doing:
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb..5a9f83e 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -124,6 +124,10 @@ static int resources_available(void)
>                 return ret;
>         }
> 
> + ret = clk_prepare_enable(cpu_clk);
> + if (ret)
> +         return ret;
> +
>         clk_put(cpu_clk);
> 
>         name = find_supply_name(cpu_dev);
> 
> 
> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
> the system wide consequences of that change to cpufreq.

If the cpufreq driver enables it then it should disable it on exit as
well, right ? And in that case if you unload your driver's module, you
will hang the system as the clock will get disabled :)

Every other platform must either be marking it with CLK_IGNORE_UNUSED
or they must be doing clk_enable from somewhere, maybe the CPU online
path, not sure though.

-- 
viresh
