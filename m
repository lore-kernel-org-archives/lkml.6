Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9768C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE12075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="WZC49s0P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAFKZkEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEE12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIITYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:24:10 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41419 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIITYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:24:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so35479423oiw.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JtKl1FJg14a2/S1PMbDfDzs+zQfywGg12uBh/CRBdM8=;
        b=WZC49s0P4+rrZMCdl2m42NekFfll9hCBE6o37uf57tN3tgc7j77FF0gi9UPsvavkYb
         kWali4dbf3S5/MWqIbPq/MnCwLNzQYJxmXEBUXDRIG/LWU3ao1/uJRGQTcFO/vU3udhI
         2JMj/SpkiFI/HLj8kp8e9WmQ+umw77aVwp5d9lPAQjU8dUHDPB52otK64YPjK/BUlnCp
         ZX1nOZGd1ouh4jO+iX+54jhEXWIEFsDHHAy953Pz6BHRO/YNpInfLc4H9FYZY4PZQ9al
         1hf/hHRz8q9UOBgGwrW5PUXKnhROYsXmcfyzvsXc08eylZjf+I7EN8n6CcFAiiJg0/hn
         yeiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JtKl1FJg14a2/S1PMbDfDzs+zQfywGg12uBh/CRBdM8=;
        b=fAFKZkEcFioLAk00FfeufVCHEadCBfOXr2OywW+xcxSE9iRKbSJOOJnXOswDvU8CE0
         MMa/fqkCFq1cDFfBTLFWydJHfPkAc4wI9banr9cmSl9fuERIK4aHfxlFMJddSUQa+tC2
         ZTQYrEPV1DXtgxNTlPGwtRBkJC2gnP/UXLGdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JtKl1FJg14a2/S1PMbDfDzs+zQfywGg12uBh/CRBdM8=;
        b=AopWcbkGOVidtpdSwtglVvLE3u8K/E435gM1IhYNLgTj6PtDI2l/fAQ38UzU1aDaAU
         esQvs65uVBcrR7t8pTKlpIqjE81+wtbLnp5CTXevGljgqfGChjE+PCOmfVviP7BcR+Um
         QWZUvU8nYbAkzXIyzUafRcQumWxv6/dd+3dDr2w96WW903mjro9HjbOhadqP+lwJ6l3O
         5np7dh1XY9RUlX/3w1RZAd24HaiPpP+fx3Fk3upShtQdrB6muKwlSe4vJTW6FNRZpL1f
         KDq5rQNi597YXTG2/ML1SlXNRQPDrmqZXE9RgnzxiJkEvh3sCRRsL7UU78hi5AV6lPfz
         4ZXA==
X-Gm-Message-State: APzg51AtHK345ik3EjA3NlVzoy0Rjq6PEsLHFA/5gLnOlZ8QE+huB5lG
        d5xl2kUoEcdqgeUNtDGo3sXC6O7u0wVlGD27eCrwJQ==
X-Google-Smtp-Source: ANB0VdYHAKVz7KVj5nVtrZJdEXdbuP3uQLImtSZF6M4Msb3PJBRY68ddVQ0VCX+O3Vyj6gZ/mZ0Le79+Z66SOoY6ZGw=
X-Received: by 2002:aca:a6d4:: with SMTP id t81-v6mr16641157oij.113.1536503656902;
 Sun, 09 Sep 2018 07:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:e05:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 07:34:16 -0700 (PDT)
In-Reply-To: <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org> <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sun, 9 Sep 2018 20:04:16 +0530
X-Google-Sender-Auth: Pp5SVTg4LRWXw01nnBQSfd_wUwc
Message-ID: <CAHLCerOAXeiYPKxvLVWrjUtHU8vTqGCESkAZXRixh-492MBCUg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>, evgreen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

How much have you stressed this driver?

I tried it on top of an integration branch based on 4.19-rc2 that we
maintain[1] and was able to get the board to reboot fairly easily with
just a few "yes > /dev/null &" instances running in the background.

I even tried with interconnect framework disabled to be sure, and it
still reboots.

I'll continue trying to pinpoint the source of the problem, but it
would be nice to know what tree you're testing against.

Regards,
Amit
[1] https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=integration/qcomlt-automerge-result

On Tue, Jul 24, 2018 at 4:12 PM, Taniya Das <tdas@codeaurora.org> wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0cd8eb7..93a9d72 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -298,3 +298,14 @@ config ARM_PXA2xx_CPUFREQ
>           This add the CPUFreq driver support for Intel PXA2xx SOCs.
>
>           If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_HW
> +       bool "QCOM CPUFreq HW driver"
> +       depends on ARCH_QCOM
> +       help
> +        Support for the CPUFreq HW driver.
> +        Some QCOM chipsets have a HW engine to offload the steps
> +        necessary for changing the frequency of the CPUs. Firmware loaded
> +        in this engine exposes a programming interface to the OS.
> +        The driver implements the cpufreq interface for this HW engine.
> +        Say Y if you want to support CPUFreq HW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c1ffeab..ca48a1d 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)    += tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)     += tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)           += ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ) += vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)      += qcom-cpufreq-hw.o
>
>
>  ##################################################################################
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..ea8f7d1
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define INIT_RATE                      300000000UL
> +#define LUT_MAX_ENTRIES                        40U
> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 16)
> +#define LUT_ROW_SIZE                   32
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
> +       struct device *dev;
> +       void __iomem *reg_bases[REG_ARRAY_SIZE];
> +       cpumask_t related_cpus;
> +       unsigned int max_cores;
> +       unsigned long xo_rate;
> +};
> +
> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> +       [REG_ENABLE]            = 0x0,
> +       [REG_LUT_TABLE]         = 0x110,
> +       [REG_PERF_STATE]        = 0x920,
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +                            unsigned int index)
> +{
> +       struct cpufreq_qcom *c = policy->driver_data;
> +
> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +
> +       return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +{
> +       struct cpufreq_qcom *c;
> +       struct cpufreq_policy *policy;
> +       unsigned int index;
> +
> +       policy = cpufreq_cpu_get_raw(cpu);
> +       if (!policy)
> +               return 0;
> +
> +       c = policy->driver_data;
> +
> +       index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +       index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static unsigned int
> +qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +                           unsigned int target_freq)
> +{
> +       struct cpufreq_qcom *c = policy->driver_data;
> +       int index;
> +
> +       index = policy->cached_resolved_idx;
> +       if (index < 0)
> +               return 0;
> +
> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_qcom *c;
> +
> +       c = qcom_freq_domain_map[policy->cpu];
> +       if (!c) {
> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
> +               return -ENODEV;
> +       }
> +
> +       cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +       policy->fast_switch_possible = true;
> +       policy->freq_table = c->table;
> +       policy->driver_data = c;
> +
> +       return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       &cpufreq_freq_attr_scaling_boost_freqs,
> +       NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> +       .flags          = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +                         CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +       .verify         = cpufreq_generic_frequency_table_verify,
> +       .target_index   = qcom_cpufreq_hw_target_index,
> +       .get            = qcom_cpufreq_hw_get,
> +       .init           = qcom_cpufreq_hw_cpu_init,
> +       .fast_switch    = qcom_cpufreq_hw_fast_switch,
> +       .name           = "qcom-cpufreq-hw",
> +       .attr           = qcom_cpufreq_hw_attr,
> +       .boost_enabled  = true,
> +};
> +
> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
> +                                   struct cpufreq_qcom *c)
> +{
> +       struct device *dev = &pdev->dev;
> +       void __iomem *base;
> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +                               sizeof(*c->table), GFP_KERNEL);
> +       if (!c->table)
> +               return -ENOMEM;
> +
> +       base = c->reg_bases[REG_LUT_TABLE];
> +
> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +               data = readl_relaxed(base + i * LUT_ROW_SIZE);
> +               src = (data & GENMASK(31, 30)) >> 30;
> +               lval = data & GENMASK(7, 0);
> +               core_count = CORE_COUNT_VAL(data);
> +
> +               if (src)
> +                       c->table[i].frequency = c->xo_rate * lval / 1000;
> +               else
> +                       c->table[i].frequency = INIT_RATE / 1000;
> +
> +               cur_freq = c->table[i].frequency;
> +
> +               dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> +                       i, c->table[i].frequency, core_count);
> +
> +               if (core_count != c->max_cores)
> +                       cur_freq = CPUFREQ_ENTRY_INVALID;
> +
> +               /*
> +                * Two of the same frequencies with the same core counts means
> +                * end of table.
> +                */
> +               if (i > 0 && c->table[i - 1].frequency ==
> +                  c->table[i].frequency && prev_cc == core_count) {
> +                       struct cpufreq_frequency_table *prev = &c->table[i - 1];
> +
> +                       if (prev_freq == CPUFREQ_ENTRY_INVALID)
> +                               prev->flags = CPUFREQ_BOOST_FREQ;
> +                       break;
> +               }
> +               prev_cc = core_count;
> +               prev_freq = cur_freq;
> +       }
> +
> +       c->table[i].frequency = CPUFREQ_TABLE_END;
> +
> +       return 0;
> +}
> +
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +       struct device_node *cpu_np, *freq_np;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_np = of_cpu_device_node_get(cpu);
> +               if (!cpu_np)
> +                       continue;
> +               freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +               of_node_put(cpu_np);
> +               if (!freq_np)
> +                       continue;
> +
> +               if (freq_np == np)
> +                       cpumask_set_cpu(cpu, m);
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +                                  struct device_node *np, unsigned int cpu,
> +                                  unsigned long xo_rate)
> +{
> +       struct cpufreq_qcom *c;
> +       struct resource res;
> +       struct device *dev = &pdev->dev;
> +       const u16 *offsets;
> +       int ret, i, cpu_first, cpu_r;
> +       void __iomem *base;
> +
> +       if (qcom_freq_domain_map[cpu])
> +               return 0;
> +
> +       c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +       if (!c)
> +               return -ENOMEM;
> +
> +       offsets = of_device_get_match_data(&pdev->dev);
> +       if (!offsets)
> +               return -EINVAL;
> +
> +       if (of_address_to_resource(np, 0, &res))
> +               return -ENOMEM;
> +
> +       base = devm_ioremap_resource(dev, &res);
> +       if (!base)
> +               return -ENOMEM;
> +
> +       for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> +               c->reg_bases[i] = base + offsets[i];
> +
> +       /* HW should be in enabled state to proceed */
> +       if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
> +               dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +               return -ENODEV;
> +       }
> +
> +       ret = qcom_get_related_cpus(np, &c->related_cpus);
> +       if (ret) {
> +               dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +               return ret;
> +       }
> +
> +       c->max_cores = cpumask_weight(&c->related_cpus);
> +       if (!c->max_cores)
> +               return -ENOENT;
> +
> +       c->xo_rate = xo_rate;
> +
> +       ret = qcom_cpufreq_hw_read_lut(pdev, c);
> +       if (ret) {
> +               dev_err(dev, "%s failed to read LUT\n", np->name);
> +               return ret;
> +       }
> +
> +       qcom_freq_domain_map[cpu] = c;
> +
> +       /* Related CPUs */
> +       cpu_first = cpumask_first(&c->related_cpus);
> +
> +       for_each_cpu(cpu_r, &c->related_cpus) {
> +               if (cpu_r != cpu_first)
> +                       qcom_freq_domain_map[cpu_r] =
> +                               qcom_freq_domain_map[cpu_first];
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +       struct device_node *np, *cpu_np;
> +       struct clk *clk;
> +       unsigned int cpu;
> +       int ret;
> +
> +       clk = devm_clk_get(&pdev->dev, "xo");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_np = of_cpu_device_node_get(cpu);
> +               if (!cpu_np) {
> +                       dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
> +                               cpu);
> +                       continue;
> +               }
> +
> +               np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +               of_node_put(cpu_np);
> +               if (!np) {
> +                       dev_err(&pdev->dev, "Failed to get freq-domain device\n");
> +                       return -EINVAL;
> +               }
> +
> +               ret = qcom_cpu_resources_init(pdev, np, cpu, clk_get_rate(clk));
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       devm_clk_put(&pdev->dev, clk);
> +
> +       return 0;
> +}
> +
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +       int rc;
> +
> +       /* Get the bases of cpufreq for domains */
> +       rc = qcom_resources_init(pdev);
> +       if (rc) {
> +               dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +               return rc;
> +       }
> +
> +       rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +       if (rc) {
> +               dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +               return rc;
> +       }
> +
> +       dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> +       { .compatible = "qcom,cpufreq-hw", .data = &cpufreq_qcom_std_offsets },
> +       {}
> +};
> +
> +static struct platform_driver qcom_cpufreq_hw_driver = {
> +       .probe = qcom_cpufreq_hw_driver_probe,
> +       .driver = {
> +               .name = "qcom-cpufreq-hw",
> +               .of_match_table = qcom_cpufreq_hw_match,
> +       },
> +};
> +
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +       return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);
> +
> +MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
