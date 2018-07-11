Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95C1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FBA2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuOYaHut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FBA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeGKNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:03:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:47088 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbeGKNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:03:30 -0400
Received: by mail-yw0-f196.google.com with SMTP id e23-v6so8581436ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDLeo/868n8Rwo3UbTW1G8tdmWnKLZnbd2H1n9G1yQA=;
        b=cuOYaHutfm+MS4zKflr6ijokGsoA1kEMsezZEkye5LitrefdeK1tnV3vZmGaP9ftBM
         21eCApKSGuZEvoxIF31buQX5fXCQZnoelAK9jup+3/Ygnfd6Unm1M+0y1Q3UYVLKWLkj
         qHurnkde0AXoeKWtYduJ6sIwVf3XlZqeDyCow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDLeo/868n8Rwo3UbTW1G8tdmWnKLZnbd2H1n9G1yQA=;
        b=ovizCFOtXJLbocEasrZYioNAzeXnF3HR/h466045+u+QwyvqyYhMK40BUCMYBbNb7t
         8VmGGnWmydLSEKT1YJmZpW4GASGKoRI2I7c2y2T4iEmeQhrzjTnOZm930J/nYy3m5wEq
         g56sUttm9SUTbkiMlxTlGBgFjW2gfeXq4QYzCRx0SzSVaIIf+o+X7rb3++5EZ8TCUjxj
         R9/rXRN6TOVn5NUYHiLyY6srQu/n+q2V6mg9NFU0KQKDCjce+Ncpdc/GnEtpIovWOQdL
         TUJlHCE7UHHq9apUwv2A4TNKK5zfwwpo+ReHyxiP+CCFQmW4EtfykpTwpKDua2+cLsmW
         s1oA==
X-Gm-Message-State: APt69E2d921i26wDG3L/x/VPTYQVXbHCpqtPu6DtLKyBNnwXaFHBkc1C
        80pQKEjmOcGbNqua7tnt5YC5/oQDIEc=
X-Google-Smtp-Source: AAOMgpdCB3HDEnVbrS1xpWAjy7W7uG7zBew2HH+iaZq9bPCT3YtC8ktOQX/cNb7+u0wkUYQyuAYHJw==
X-Received: by 2002:a81:5ac6:: with SMTP id o189-v6mr13798589ywb.444.1531313955362;
        Wed, 11 Jul 2018 05:59:15 -0700 (PDT)
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com. [209.85.213.173])
        by smtp.gmail.com with ESMTPSA id q12-v6sm1385714ywl.26.2018.07.11.05.59.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:59:15 -0700 (PDT)
Received: by mail-yb0-f173.google.com with SMTP id c10-v6so8208723ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:59:15 -0700 (PDT)
X-Received: by 2002:a25:7146:: with SMTP id m67-v6mr12450695ybc.226.1531313510809;
 Wed, 11 Jul 2018 05:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com> <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 11 Jul 2018 21:51:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
Message-ID: <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     rafael@kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > Hi Rafael,
> >
> >
> > On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
> >>> From: Sricharan R <sricharan@codeaurora.org>
> >>>
> >>> The smmu needs to be functional only when the respective
> >>> master's using it are active. The device_link feature
> >>> helps to track such functional dependencies, so that the
> >>> iommu gets powered when the master device enables itself
> >>> using pm_runtime. So by adapting the smmu driver for
> >>> runtime pm, above said dependency can be addressed.
> >>>
> >>> This patch adds the pm runtime/sleep callbacks to the
> >>> driver and also the functions to parse the smmu clocks
> >>> from DT and enable them in resume/suspend.
> >>>
> >>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> >>> [vivek: Clock rework to request bulk of clocks]
> >>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >>> ---
> >>>
> >>>  - No change since v11.
> >>>
> >>>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  1 file changed, 58 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >>> index f7a96bcf94a6..a01d0dde21dd 100644
> >>> --- a/drivers/iommu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm-smmu.c
> >>> @@ -48,6 +48,7 @@
> >>>  #include <linux/of_iommu.h>
> >>>  #include <linux/pci.h>
> >>>  #include <linux/platform_device.h>
> >>> +#include <linux/pm_runtime.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/spinlock.h>
> >>>
> >>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
> >>>       u32                             num_global_irqs;
> >>>       u32                             num_context_irqs;
> >>>       unsigned int                    *irqs;
> >>> +     struct clk_bulk_data            *clks;
> >>> +     int                             num_clks;
> >>>
> >>>       u32                             cavium_id_base; /* Specific to Cavium */
> >>>
> >>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >>>  struct arm_smmu_match_data {
> >>>       enum arm_smmu_arch_version version;
> >>>       enum arm_smmu_implementation model;
> >>> +     const char * const *clks;
> >>> +     int num_clks;
> >>>  };
> >>>
> >>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
> >>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> >>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
> >>>
> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> >>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >>>  };
> >>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >>>
> >>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> >>> +                                const char * const *clks)
> >>> +{
> >>> +     int i;
> >>> +
> >>> +     if (smmu->num_clks < 1)
> >>> +             return;
> >>> +
> >>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> >>> +                               sizeof(*smmu->clks), GFP_KERNEL);
> >>> +     if (!smmu->clks)
> >>> +             return;
> >>> +
> >>> +     for (i = 0; i < smmu->num_clks; i++)
> >>> +             smmu->clks[i].id = clks[i];
> >>> +}
> >>> +
> >>>  #ifdef CONFIG_ACPI
> >>>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> >>>  {
> >>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
> >>>       data = of_device_get_match_data(dev);
> >>>       smmu->version = data->version;
> >>>       smmu->model = data->model;
> >>> +     smmu->num_clks = data->num_clks;
> >>> +
> >>> +     arm_smmu_fill_clk_data(smmu, data->clks);
> >>>
> >>>       parse_driver_options(smmu);
> >>>
> >>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>               smmu->irqs[i] = irq;
> >>>       }
> >>>
> >>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>>       err = arm_smmu_device_cfg_probe(smmu);
> >>>       if (err)
> >>>               return err;
> >>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>>
> >>>       /* Turn the thing off */
> >>>       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >>> +
> >>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> >>> +
> >>>       return 0;
> >>>  }
> >>>
> >>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> >>>       return 0;
> >>>  }
> >>>
> >>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> >>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> >>> +{
> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >>> +
> >>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
> >>> +}
> >>> +
> >>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> >>> +{
> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >>> +
> >>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> >>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
> >>
> >> This is suspicious.
> >>
> >> If you need a runtime suspend method, why do you think that it is not necessary
> >> to suspend the device during system-wide transitions?
> >
> > Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
> > In that case the clocks have to be enabled in the resume path too.
> >
> > I remember Tomasz pointed to that we shouldn't need clock enable in resume
> > path [1].
> >
> > [1] https://lkml.org/lkml/2018/3/15/60

That was an answer for a different question. I don't remember
suggesting having no suspend function. Although, given the PM
subsystem internals, the suspend function wouldn't be called on SMMU
implementation needed power control (since they would have runtime PM
enabled) and on others, it would be called but do nothing (since no
clocks).

>
> Honestly, I just don't know. :-)
>
> It just looks odd the way it is done.  I think the clock should be
> gated during system-wide suspend too, because the system can spend
> much more time in a sleep state than in the working state, on average.
>
> And note that you cannot rely on runtime PM to always do it for you,
> because it may be disabled at a client device or even blocked by user
> space via power/control in sysfs and that shouldn't matter for
> system-wide PM.

User space blocking runtime PM through sysfs is a good point. I'm not
100% sure how the PM subsystem deals with that in case of system-wide
suspend. I guess for consistency and safety, we should have the
suspend callback.

Best regards,
Tomasz
