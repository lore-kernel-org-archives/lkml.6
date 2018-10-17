Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296A7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C846D21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZykQjsmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C846D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeJRHaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:30:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42945 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeJRHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:30:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so13395774plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=XMjGW6Li7J3FvUwJidAyL43P81ZaRORDgnkifpDbAqs=;
        b=ZykQjsmrvoLQaL0hqOpdsCZeDbhi7P0tjEpWuznTAt3DaALL4HRaxNgUdRJh7bpHZm
         h8iHCLnEtnA4vvRv1gwc8W1Gf7rvZqiazIEmZxV5krUQkr09jGl20H9j/j32L0a4yumx
         F/Sz9Y2I2/VX61D+eaAQUNPI3ARky+y3BkTWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=XMjGW6Li7J3FvUwJidAyL43P81ZaRORDgnkifpDbAqs=;
        b=KyqmgFokdKnSc9OlrZFUA7zvSh2lq0H3rztBLzsEu6qt5YQ/nK0FTTFOmHss5teoPC
         TwTYfXwm14qIjpJKvQJ4p6s72OrHNWvemur++PrYu7gUq4n/6zReiP+GI4uxirglRXxC
         2snrFcdSWTSRkGMV+t/yNyTIrb04G9Ue5TilIqasnbt42tdrRJN9xPCeuEJ/MZmSWyjt
         Hfvq4uNplbkBNM3dSiW06tYVG4NCzbPwvvZoj3un0h3z8gFnBKNKJnGbCxeZfLZxoE8E
         d5zqCcllAahSDhmyEPZGLioCm/xAii3dVT7eyGsseXoVagzNIYIpk8LfKHO6JzjrUAjq
         3iNw==
X-Gm-Message-State: ABuFfoj2EMSJOSZvag1JopNVxwH8bbnEqukxv5ht/Bt7qjlFGUW6EFg1
        vyw58//t8pL+FKWYGagZ5WEWjg==
X-Google-Smtp-Source: ACcGV61rPCspo5hjZZwTqozBgbVMAZ3qsEINjiUPy36hemKMdA9/NIo6GRi1OZhIybqfH9WYhT3odw==
X-Received: by 2002:a17:902:788d:: with SMTP id q13-v6mr26532368pll.329.1539819156008;
        Wed, 17 Oct 2018 16:32:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id m18-v6sm25166895pfk.149.2018.10.17.16.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 16:32:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Wed, 17 Oct 2018 16:32:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-11 04:36:01)
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> =

>           If in doubt, say N.
> =

> +config ARM_QCOM_CPUFREQ_HW
> +       bool "QCOM CPUFreq HW driver"

Is there any reason this can't be a module?

> +       depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Support for the CPUFreq HW driver.
> +         Some QCOM chipsets have a HW engine to offload the steps
> +         necessary for changing the frequency of the CPUs. Firmware load=
ed
> +         in this engine exposes a programming interface to the OS.
> +         The driver implements the cpufreq interface for this HW engine.
> +         Say Y if you want to support CPUFreq HW.
> +
>  config ARM_S3C_CPUFREQ
>         bool
>         help
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpu=
freq-hw.c
> new file mode 100644
> index 0000000..fe1c264
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define LUT_MAX_ENTRIES                        40U
> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 1=
6)
> +#define LUT_ROW_SIZE                   32
> +#define CLK_HW_DIV                     2
> +
> +enum {
> +       REG_ENABLE,
> +       REG_LUT_TABLE,
> +       REG_PERF_STATE,
> +
> +       REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_qcom {
> +       struct cpufreq_frequency_table *table;
> +       void __iomem *reg_bases[REG_ARRAY_SIZE];
> +       cpumask_t related_cpus;
> +       unsigned int max_cores;
> +       unsigned long xo_rate;
> +       unsigned long cpu_hw_rate;
> +};
> +
> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {

Is this going to change in the future?

> +       [REG_ENABLE]            =3D 0x0,
> +       [REG_LUT_TABLE]         =3D 0x110,
> +       [REG_PERF_STATE]        =3D 0x920,
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +                            unsigned int index)
> +{
> +       struct cpufreq_qcom *c =3D policy->driver_data;
> +
> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);

Why can't we avoid the indirection here and store the perf_state pointer
in probe? Then we don't have to indirect through a table to perform the
register write.

> +
> +       return 0;
> +}
> +
[..]
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +       struct device_node *cpu_np;
> +       struct of_phandle_args args;
> +       struct clk *clk;
> +       unsigned int cpu;
> +       unsigned long xo_rate, cpu_hw_rate;
> +       int ret;
> +
> +       clk =3D clk_get(&pdev->dev, "xo");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       xo_rate =3D clk_get_rate(clk);
> +
> +       clk_put(clk);
> +
> +       clk =3D clk_get(&pdev->dev, "cpu_clk");

Sad that the name is cpu_clk, instead of something like 'backup' or
whatever the name really is in hardware.

