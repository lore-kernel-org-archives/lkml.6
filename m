Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A96C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F63E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhSHVMKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfAWKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:34:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33166 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfAWKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:34:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so902963pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fk6aq1ppOxhhxqCHlTP60qWOo08K+VExh0HNxQY7j24=;
        b=jhSHVMKM/89QZpmpJWp9cpgHxs7sY9pax2LUOuAgLuqRCQR8zw/q1c8c1C/IKjPq9R
         XupvggCx+6VRFLXGcU8y0vZhHr7wb9bmM4Xs6g7v3kIWyPJ/D1QsKhKj6IsLuuOSFo6L
         ZHGd8b/IbiYS5r7pwSQd4Bo19ehr5GmTVS5BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fk6aq1ppOxhhxqCHlTP60qWOo08K+VExh0HNxQY7j24=;
        b=GE95+mrJYo3845jwt78YfqBSCzWZjRPm9o0JBP9sDxJhD/Pwz8dWMIuXsaK9oJ2whh
         KB0ldmDYQ4J9nRTdf1lz3lEZ3C5Z22AR0He/YTYegwxMTbcmOpqXkqjS93mLmazhuAQG
         vNDZGGDGqH7Yc1JTzzr2Yoq9dHn+Md6POZMAnWp2wsS/ERvG7vXdKjSRM5imkXAdq3Xb
         wSjZxLNvLzPyS5rvUAAbC7GPBG21KZpZW7vkbzMx0XJrWjx3METqG1WPrLNp/Oj6yl+4
         7qzk/c6I5+ZOfOp8Q8+/JJZiSF7AdJYvUGyLTS0mc2qQCB4Jovb5Y8YKUcUP6eAmnz4t
         HfTw==
X-Gm-Message-State: AJcUukd1n0LdSkugAYaN1v1TQH8nF9dli5+MtxCWC+2BQ4tCc8DP1Y1A
        ZcGebjEvC6BukB6O2FkZj1ILjQ==
X-Google-Smtp-Source: ALg8bN5PdzKWxSu7W0HEF0gsx58YpZV9BEdCnbnCwcRntir/a1RUO5eFZSBDjOzdlqCSffrgix5b8Q==
X-Received: by 2002:a62:1709:: with SMTP id 9mr1514789pfx.249.1548239694684;
        Wed, 23 Jan 2019 02:34:54 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id t29sm33574512pfa.158.2019.01.23.02.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:34:53 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:04:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be
 compiled in
Message-ID: <20190123103451.ap5vws3kj2ch4uba@vireshk-i7>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19, 21:10, Amit Kucheria wrote:
> The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
> driver to register as a cooling device and cool down the platform by
> throttling the CPU frequency. In order to be able to auto-register a
> cpufreq driver as a cooling device from the cpufreq core, we need access
> to code inside cpu_cooling.c which, in turn, accesses code inside
> thermal core.
> 
> CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
> (e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
> CONFIG_CPU_FREQ is compiled in. This leads to following error:
> 
> drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
> cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
> drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
> cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'
> 
> Given that platforms using CPU_THERMAL usually want it compiled-in so it
> is available early in boot, make CPU_THERMAL depend on THERMAL being
> compiled-in instead of allowing it to be a module.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 30323426902e..58bb7d72dc2b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -152,6 +152,7 @@ config CPU_THERMAL
>  	bool "generic cpu cooling support"
>  	depends on CPU_FREQ
>  	depends on THERMAL_OF
> +	depends on THERMAL=y
>  	help
>  	  This implements the generic cpu cooling mechanism through frequency
>  	  reduction. An ACPI version of this already exists

Please remove all Kconfig crap, which gets fixed with this, as well in
this patch itself. Like:

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 10bc5c798d17..40f8cc323996 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -40,8 +40,6 @@ config ARM_ARMADA_8K_CPUFREQ
 config ARM_BIG_LITTLE_CPUFREQ
        tristate "Generic ARM big LITTLE CPUfreq driver"
        depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-       # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
-       depends on !CPU_THERMAL || THERMAL
        select PM_OPP
        help
          This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.

-- 
viresh
