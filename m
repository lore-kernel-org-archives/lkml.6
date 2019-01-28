Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C40FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F2207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548666214;
	bh=jbcCUxO+Knunp/+o3hWcWMG/jQ8OzXBQ10hlFHByubo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fQQHjggxiljVaN166rwLVyEIhRsReMAj1hyPm4d9UAYUMq1MpSZhMpEBKWgznde9f
	 rxv3L5UrF57+dKBJ8j60aQoQFpCaBgFe7o+MA3osItSMhG3UBhOdc6wjTb3kKoEnhy
	 ucllj8WtgfY6Q8qB0cNOO7bb31eXxr2Dw8kn4sGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA1JDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:03:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44617 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1JDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:03:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id g16so9979783otg.11;
        Mon, 28 Jan 2019 01:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nBaz/Bcq4l4WiiSXb0gHk8bFRn3sHCY5t8JqU4juzc=;
        b=Uv7vX3oCF+/XqgdFQehqDoPrZjsOxN6xaQ8u260Z6QbDrn1q+vktljxq6jeL0uS64c
         PeZuwvcHEyxQxTd1KABmSfWEn7w0eijh965F6PJSZleDIZDwCW0AZeht9wP4qZOKzUL0
         BwS9csM8fXrx5Har9AGhwyOvENl5mJO9rk+r+EIp5IJaHiZCo1Kfy7zLIeaLuX250YoX
         OgeYk33r/3gcbw6d3Mso1BCBTMLBXPBNgTgYpUJ8j/tv24M5hID982/A0ebvjXAdIXcU
         sJOve3A4QlnrHfSq5ALr3MJYGh5DL+pBhZ6rhMtcKfbInwBv6VOTrAdkRbR66iLX2MhW
         zXvg==
X-Gm-Message-State: AJcUuke3tR2gMGBVp7pwqF8FNoQWHbEqvP3H6A3jHIM3PbzCkhFI9Txu
        eveuLKVIaQ0u1CIqGgdmX4ZsGXyjJeETGfXR+TQ=
X-Google-Smtp-Source: ALg8bN6asjJdAJLpfcN/oAThzRzoBNwldOSQqsk4cVZME2W6WG8vlhEEr1QgDUjbcUdSN/RD/+0U+tDC80/7Lph6atk=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr14110828otf.124.1548666211031;
 Mon, 28 Jan 2019 01:03:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548654899.git.amit.kucheria@linaro.org> <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Jan 2019 10:03:19 +0100
Message-ID: <CAJZ5v0huESFqOADqyym-ci-XcWpL4tbcd9a-jxe_KArXKpHFyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 7:44 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
>
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..29ed78b0b77b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -1318,6 +1319,9 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
>
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)

It would be good to use IS_ENABLED(CONFIG_CPU_THERMAL) here and below
as a hint for the compiler.

> +               policy->cdev = of_cpufreq_cooling_register(policy);
> +
>         pr_debug("initialization complete\n");
>
>         return 0;
> @@ -1405,6 +1409,11 @@ static int cpufreq_offline(unsigned int cpu)
>                 goto unlock;
>         }
>
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               cpufreq_cooling_unregister(policy->cdev);
> +               policy->cdev = NULL;
> +       }
> +
>         if (cpufreq_driver->stop_cpu)
>                 cpufreq_driver->stop_cpu(policy);
>
