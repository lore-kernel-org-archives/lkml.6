Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DEB20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeEY0/95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfAQKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:21:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42239 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfAQKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:21:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so4614361pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqgQwgs6rpK2rfGYhVxoq0wejotpg6+UVg0B/eSnCeE=;
        b=jeEY0/959wN0YxccsGI/CTJT2VzDCV/l6S1FQ8sSHUBi48H+rBqDrdX7nCbGHbVfMB
         wb0w9wJ27i4ZPLv8Q9Pn9Z5jcuwVrrBg+UmYLSahDRnCpr4jH05BIs4fEFXW3ZJ8KNYc
         Mdyq3wYjtMaNpOWyhvEw2tLuBKZsUd3Bc0vDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqgQwgs6rpK2rfGYhVxoq0wejotpg6+UVg0B/eSnCeE=;
        b=b+3vaXC+/Gwkk+wGPxcOlgJdWdZIdv6Ajv0u+jZB6w0Iej/jFBfOP/FQAr0V86MP26
         Roe0sCdw+asMWEyl1vznjTJBoLOsib5KOC/8wXlrefSLYBqEtq2ISTWN8+geYNweFxkt
         pT6v+Z1UKzDGkAwZOI1UEJomJyCEFPkXx6MrUQfFluY//T4nsdWwS23ivDDNz0sLMWqu
         lnj0uwk8tJnVLAgkNJ+iFTFxwpizwib0qaexnA+ycBkzp30dlBvK86K1ugJBfoB8MORG
         4Dr843IEnKF6KIs/mcgGBjFOigw1X/tCfuku3GgMSq01Q7LJNyLfAhTQJ4jZhN6J3ycl
         d0dA==
X-Gm-Message-State: AJcUukd5iQ6Flz+Y95+5gASOhCV7W+RrRmlwIv2M6DQV5+vY+jQxTCg3
        sD1KTNIfu2Ayn1/+xEoV7RRWoQ==
X-Google-Smtp-Source: ALg8bN6MTC7thPoTs7+Xox6pv36amOnDc5uTXBe37RUBTUz9BctIb26+Ih9VFUT9liltJE2q3pUeRA==
X-Received: by 2002:a62:d885:: with SMTP id e127mr14258586pfg.197.1547720470387;
        Thu, 17 Jan 2019 02:21:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id r66sm2754116pfk.157.2019.01.17.02.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:21:09 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:51:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117102107.2n5liu325alisxhd@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 11:08, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
> 
> Sorry, but this makes my teeth hurt.

I knew it :)

> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
> 
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
> 
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

That causes recursive-dependency issues:

drivers/thermal/Kconfig:5:error: recursive dependency detected!
drivers/thermal/Kconfig:5:      symbol THERMAL is selected by CPU_THERMAL
drivers/thermal/Kconfig:16:     symbol CPU_THERMAL depends on THERMAL_OF
drivers/thermal/Kconfig:70:     symbol THERMAL_OF depends on THERMAL
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

something like this works though:

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..ee9f9f2a795b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -13,6 +13,20 @@ menuconfig THERMAL
          All platforms with ACPI thermal support can use this driver.
          If you want this support, you should say Y or M here.
 
+config CPU_THERMAL
+       bool "generic cpu cooling support"
+       depends on CPU_FREQ
+       select THERMAL_OF
+       select THERMAL
+       help
+         This implements the generic cpu cooling mechanism through frequency
+         reduction. An ACPI version of this already exists
+         (drivers/acpi/processor_thermal.c).
+         This will be useful for platforms using the generic thermal interface
+         and not the ACPI interface.
+
+         If you want this support, you should say Y here.
+
 if THERMAL
 
 config THERMAL_STATISTICS
@@ -148,19 +162,6 @@ config THERMAL_GOV_POWER_ALLOCATOR
          Enable this to manage platform thermals by dynamically
          allocating and limiting power to devices.
 
-config CPU_THERMAL
-       bool "generic cpu cooling support"
-       depends on CPU_FREQ
-       depends on THERMAL_OF
-       help
-         This implements the generic cpu cooling mechanism through frequency
-         reduction. An ACPI version of this already exists
-         (drivers/acpi/processor_thermal.c).
-         This will be useful for platforms using the generic thermal interface
-         and not the ACPI interface.
-
-         If you want this support, you should say Y here.
-
 config CLOCK_THERMAL
        bool "Generic clock cooling support"
        depends on COMMON_CLK


What about make CONFIG_THERMAL bool instead ? Who wants it to be a module ?

$ git grep "CONFIG_THERMAL=m"
arch/arm/configs/mini2440_defconfig:CONFIG_THERMAL=m
arch/arm/configs/omap2plus_defconfig:CONFIG_THERMAL=m
arch/arm/configs/pxa_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip22_defconfig:CONFIG_THERMAL=m
arch/mips/configs/ip27_defconfig:CONFIG_THERMAL=m
arch/unicore32/configs/unicore32_defconfig:#CONFIG_THERMAL=m

Not sure if they really want this code out :(

-- 
viresh
