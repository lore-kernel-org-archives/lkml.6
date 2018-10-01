Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61C320666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjXPLla+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeJASkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:40:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41895 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJASkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:40:20 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so9132797iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+BFsasdfgWa2uNaN+YYk2GM5/zNh77X4JcT+Otj08CI=;
        b=kjXPLla+Oc5i/KukVUSF/mM95kM0Y7nrP1HpaiY9Wu+Iip75Xv8vYEYb6XhGsmAWKV
         GEI3hONKZsXG/pCCFlIojlq9UtxNJ1kskaB/CQwgw+y6QpB1Qd0oDLOwBMGQ/9OU8BTv
         Kg0a3ywGrlMvb+UY9H/Bpaj4SGqAl+7AKPkEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+BFsasdfgWa2uNaN+YYk2GM5/zNh77X4JcT+Otj08CI=;
        b=RkipeRjv+hJ7oXzApba57Zs/gDmq284EogLUGN1Hn9J4ybEbWrl5cVzQ2tjtlKnaxY
         2KxsrV0I+eipnLJ0ytTOdt8vKi23Q8J7h8FJ0KzJj/wXH4K0gFpgXMuls389yZ1avG3J
         0TCqWM/KeK0KyceW8fOj0Opx8yVfzcIgc0CoLDrkLe5DlK8FOwzcMJsieufaPjvRqUOD
         PBexISyLlF71R37GltV6Uj3Dv1mxZ42JFIFkLQIuMEBNLzlZwBQx0G1ZJBj94qkvVfn/
         87WKysfIMopqvsvwk+H+O/wqL05IGfr5UKLCgdb9R9sstv+o88Zf/+M0jB5WpQFwlK7T
         2ZqA==
X-Gm-Message-State: ABuFfojCdSOfA35o9Xtn0Uxq6iXIHjyS1SBTEg2ifsq+H8vRaxYVZtck
        +Ra+gW0ZkANDoUk1E9TdeL2kZFgABdqmDIuL4vJ2VQ==
X-Google-Smtp-Source: ACcGV60wdNxSpDz7CteqsU57bxwUYFh4F9s6q7WFwqse2RcnZb7ifTNYjnrJcXKPIHqkexNfp4pwvOtz4gyLdQG8V1A=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr6498611ioc.131.1538395372043;
 Mon, 01 Oct 2018 05:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 05:02:11 -0700 (PDT)
In-Reply-To: <CAFp+6iFJbQZ1MrNWD6g+GNp9TOMXuq0oDdzQ9XUMTmY67tNgWg@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
 <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com> <CAFp+6iFJbQZ1MrNWD6g+GNp9TOMXuq0oDdzQ9XUMTmY67tNgWg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 14:02:11 +0200
Message-ID: <CAPDyKFpd4c+Qk5Fm7AdSU=pA4w=u0SE7XO7fc9PM9iHR67U6=A@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 12:32, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> On Mon, Oct 1, 2018 at 11:19 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> HI Ulf,
>>
>> On Fri, Sep 28, 2018 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >
>> > On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>> > > From: Sricharan R <sricharan@codeaurora.org>
>> > >
>> > > The smmu needs to be functional only when the respective
>> > > master's using it are active. The device_link feature
>> > > helps to track such functional dependencies, so that the
>> > > iommu gets powered when the master device enables itself
>> > > using pm_runtime. So by adapting the smmu driver for
>> > > runtime pm, above said dependency can be addressed.
>> > >
>> > > This patch adds the pm runtime/sleep callbacks to the
>> > > driver and also the functions to parse the smmu clocks
>> > > from DT and enable them in resume/suspend.
>> > >
>> > > Also, while we enable the runtime pm add a pm sleep suspend
>> > > callback that pushes devices to low power state by turning
>> > > the clocks off in a system sleep.
>> > > Also add corresponding clock enable path in resume callback.
>> > >
>> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> > > Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> > > [vivek: rework for clock and pm ops]
>> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> > > ---
>> > >  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
>> > >  1 file changed, 74 insertions(+), 3 deletions(-)
>> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> >
>> > [...]
>> >
>> > > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> > > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> > >  {
>> > >         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> > > +       int ret;
>> > > +
>> > > +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
>> > > +       if (ret)
>> > > +               return ret;
>> > >
>> > >         arm_smmu_device_reset(smmu);
>> > > +
>> > >         return 0;
>> > >  }
>> > >
>> > > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> > > +{
>> > > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> > > +
>> > > +       clk_bulk_disable(smmu->num_clks, smmu->clks);
>> > > +
>> > > +       return 0;
>> > > +}
>> > > +
>> > > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> > > +{
>> > > +       if (pm_runtime_suspended(dev))
>> > > +               return 0;
>> >
>> > Looks like you should be able use pm_runtime_force_resume(), instead
>> > of using this local trick. Unless I am missing something, of course.
>> >
>> > In other words, just assign the system sleep callbacks for resume, to
>> > pm_runtime_force_resume(). And vice verse for the system suspend
>> > callbacks, pm_runtime_force_suspend(), of course.
>>
>> Thanks for the review. I will change this as suggested.
>
> Coming back at this - actually Rafael suggested _not_ to use
> pm_runtime_force_suspend/resume() when Marek had suggested
> the same [1].

I see.

> He also mentioned few caveats/limitations of using these APIs
> for system sleep ops.
> Let me know your opinion. Thanks.

>
> [1] https://lkml.org/lkml/2018/7/11/978
> [2] https://lkml.org/lkml/2018/7/23/334

Me and Rafael have been discussing these topics historically as well.
I don't want to get that discussion started again here.

If your device is attached to the PCI bus or the ACPI PM domain (and
also gets runtime PM enabled), then I suggest you to stick to the
currently suggested approach. Otherwise it should be perfectly fine to
switch to the *force helpers.

Kind regards
Uffe
