Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69422C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D820671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foyqbtKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2D820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeGYHoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:44:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46548 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeGYHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:44:37 -0400
Received: by mail-yb0-f195.google.com with SMTP id c3-v6so2588040ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mJjIVMdy3w79SCdcdJvyk1zoUdFhh8Wc701DOEGbps=;
        b=foyqbtKuHTcc/mh6IslxQglpG1zVAogkmo0Fw7VXOVESK+SmtIiwFW6LvTRAbD49t1
         g+zXFL0iXAGIZFf3YsdsaJgoVmGF1M2+E38IWHxVCILNZbQqqrsovL+SIMI0q9lvntRr
         RcDNlF0nfu+K1FlbVyXNplFGWsnQkPyIsPrn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mJjIVMdy3w79SCdcdJvyk1zoUdFhh8Wc701DOEGbps=;
        b=i8TEzdA7ZsCytvYRwdy943h2LYMcRZIwQjQqRc2Wx9bMCmYERMDBEeE8ImyRYY+6AT
         Ggbfb67B8z5/6LhcLgI094AZj20HfABCNKXa1SHEEyW2iZhsa/XcTlPDgMBCtuWSp7QG
         atI53Uo9uKq8kT80mYvWlfKQpMihHJNeM5MehKmeNZHhR49K7otQ+U3UT5nGYrJTCD2C
         8IRpsU1d13RtxOEjZAXOXtng087RJ8xrpXYHTJfuEA3U2pZfU431xNszNeG44WodhYr3
         kWaqXBYsMPcKwg1czWDYnjjkAtBi6sKFBDHO90HrSRPzjMYSwei8oBXkm8TQ8cNfMYJc
         65LA==
X-Gm-Message-State: AOUpUlHWsVYxLP/TPuNr4keXrz1Jh7eAeOpVoIJowwHoYjHCI7KdKIS7
        6cwv1xV309YULl6zur4mrGbDC8kJLQimxQ==
X-Google-Smtp-Source: AAOMgpfo6QRv1lHNaNJQQ7WyUV8yQuitmgdeZGWiSRBdXRA6JHuunzyVVbgkizd3R2RfftDNtRKogw==
X-Received: by 2002:a25:b904:: with SMTP id x4-v6mr4837571ybj.56.1532500464921;
        Tue, 24 Jul 2018 23:34:24 -0700 (PDT)
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com. [209.85.161.173])
        by smtp.gmail.com with ESMTPSA id k2-v6sm1829350ywa.93.2018.07.24.23.34.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 23:34:24 -0700 (PDT)
Received: by mail-yw0-f173.google.com with SMTP id e23-v6so2474394ywe.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 23:34:24 -0700 (PDT)
X-Received: by 2002:a0d:e7c1:: with SMTP id q184-v6mr10235582ywe.435.1532500127860;
 Tue, 24 Jul 2018 23:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
 <20180719101539.6104-2-vivek.gautam@codeaurora.org> <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
In-Reply-To: <e17fdcb7-2632-753f-4e2e-f81bcded36f1@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 25 Jul 2018 15:28:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AwrNL7CbBXMYEWcHMuSsENhDuQEJvuypn3nbCzWw5v4Q@mail.gmail.com>
Message-ID: <CAAFQd5AwrNL7CbBXMYEWcHMuSsENhDuQEJvuypn3nbCzWw5v4Q@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukas Wunner <lukas@wunner.de>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:21 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 19/07/18 11:15, Vivek Gautam wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu needs to be functional only when the respective
> > master's using it are active. The device_link feature
> > helps to track such functional dependencies, so that the
> > iommu gets powered when the master device enables itself
> > using pm_runtime. So by adapting the smmu driver for
> > runtime pm, above said dependency can be addressed.
> >
> > This patch adds the pm runtime/sleep callbacks to the
> > driver and also the functions to parse the smmu clocks
> > from DT and enable them in resume/suspend.
> >
> > Also, while we enable the runtime pm add a pm sleep suspend
> > callback that pushes devices to low power state by turning
> > the clocks off in a system sleep.
> > Also add corresponding clock enable path in resume callback.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Signed-off-by: Archit Taneja <architt@codeaurora.org>
> > [vivek: rework for clock and pm ops]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >
> > Changes since v12:
> >   - Added pm sleep .suspend callback. This disables the clocks.
> >   - Added corresponding change to enable clocks in .resume
> >    pm sleep callback.
> >
> >   drivers/iommu/arm-smmu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 73 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index c73cfce1ccc0..9138a6fffe04 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -48,6 +48,7 @@
> >   #include <linux/of_iommu.h>
> >   #include <linux/pci.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >
> > @@ -205,6 +206,8 @@ struct arm_smmu_device {
> >       u32                             num_global_irqs;
> >       u32                             num_context_irqs;
> >       unsigned int                    *irqs;
> > +     struct clk_bulk_data            *clks;
> > +     int                             num_clks;
> >
> >       u32                             cavium_id_base; /* Specific to Cavium */
> >
> > @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >   struct arm_smmu_match_data {
> >       enum arm_smmu_arch_version version;
> >       enum arm_smmu_implementation model;
> > +     const char * const *clks;
> > +     int num_clks;
> >   };
> >
> >   #define ARM_SMMU_MATCH_DATA(name, ver, imp) \
> > -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> > +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
> >
> >   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> >   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> > @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >   };
> >   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >
> > +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> > +                                const char * const *clks)
> > +{
> > +     int i;
> > +
> > +     if (smmu->num_clks < 1)
> > +             return;
> > +
> > +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> > +                               sizeof(*smmu->clks), GFP_KERNEL);
> > +     if (!smmu->clks)
> > +             return;
> > +
> > +     for (i = 0; i < smmu->num_clks; i++)
> > +             smmu->clks[i].id = clks[i];
> > +}
> > +
> >   #ifdef CONFIG_ACPI
> >   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> >   {
> > @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
> >       data = of_device_get_match_data(dev);
> >       smmu->version = data->version;
> >       smmu->model = data->model;
> > +     smmu->num_clks = data->num_clks;
> > +
> > +     arm_smmu_fill_clk_data(smmu, data->clks);
> >
> >       parse_driver_options(smmu);
> >
> > @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >               smmu->irqs[i] = irq;
> >       }
> >
> > +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> > +     if (err)
> > +             return err;
> > +
> > +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> > +     if (err)
> > +             return err;
> > +
> >       err = arm_smmu_device_cfg_probe(smmu);
> >       if (err)
> >               return err;
> > @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >
> >       /* Turn the thing off */
> >       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> > +
> > +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> > +
> >       return 0;
> >   }
> >
> > @@ -2189,15 +2225,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
> >       arm_smmu_device_remove(pdev);
> >   }
> >
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> > +{
> > +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>
> If there's a power domain being automatically switched by genpd then we
> need a reset here because we may have lost state entirely. Since I
> remembered the otherwise-useless GPU SMMU on Juno is in a separate power
> domain, I gave it a poking via sysfs with some debug stuff to dump sCR0
> in these callbacks, and the problem is clear:
>
> ...
> [    4.625551] arm-smmu 2b400000.iommu: genpd_runtime_suspend()
> [    4.631163] arm-smmu 2b400000.iommu: arm_smmu_runtime_suspend: 0x00201936
> [    4.637897] arm-smmu 2b400000.iommu: suspend latency exceeded, 6733980 ns
> [   21.566983] arm-smmu 2b400000.iommu: genpd_runtime_resume()
> [   21.584796] arm-smmu 2b400000.iommu: arm_smmu_runtime_resume: 0x00220101
> [   21.591452] arm-smmu 2b400000.iommu: resume latency exceeded, 6658020 ns
> ...
>
> > +}
> > +
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +     clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +
> > +     return 0;
> > +}
> > +
> >   static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> >   {
> >       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     if (!pm_runtime_suspended(dev)) {
> > +             ret = arm_smmu_runtime_resume(dev);
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       arm_smmu_device_reset(smmu);
>
> This looks a bit off too - if we wake from sleep when the SMMU was also
> runtime-suspended, it appears we might end up trying to restore the
> register state without clocks enabled. Surely we need to always enable
> clocks for the reset, then restore the previous suspended state?
> Although given my previous point, it's probably not worth doing anything
> at all here for that case.

With a reset added to arm_smmu_runtime_resume(), we wouldn't need the
reset here anymore. With that, the code below should work.

    if (pm_runtime_suspended(dev))
        return 0;
    return arm_smmu_runtime_resume(dev);

Best regards,
Tomasz
