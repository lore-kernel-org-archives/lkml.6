Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269AAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92892083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZcJ/+h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92892083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIGOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:32:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36865 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIGOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:32:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id x83-v6so5184593ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCTcRtKIKYnWBEwtSRALgT5bHp8nI4YE6AY85VqxoxM=;
        b=VZcJ/+h2Psh8AXDQ+nyiy7e2Ark7ARYv5uHFVwndput7eLhDaw5ZO4AXkKCae7dXGk
         gHnVBxJMO29ecVODFq9qpsfkCCwvO8snIUPc8kJ+xU42HCqI2Gpiy1q0fTeTur/6rcuO
         Z+NvG3RTDZCpZ/2O/oHEvrbRHIPwUosQKzZAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCTcRtKIKYnWBEwtSRALgT5bHp8nI4YE6AY85VqxoxM=;
        b=PPHE7yEnhKDiB0ND2wBAlO7qw4DFVM4NePFgSq0p6aUv4reYD3Kll0hWR7xEVuBnFQ
         wM8pIHDvOw+zWcGIoIjtGMIiUX7tCoNMNd2IpZ3fCDyEqmwJUAiVr9dS2ZAjfB4Fn2IX
         bMMMcpQJjEk+rcgaESMY6iEecfC/AmxeagOtJH56L/0FvKrN6P9cwh+bSBiyZklprB7G
         8/OBpTgd2sMfpezuvWUFNcnVCfAuCUY7IQktKPP3R5XroPb1NrRz9pqU687SW5cJAQla
         ZLQgJ9apy9o7g0KgiffNtV14vazDI/fomMYIFDGUVTYL1aujucuDMutur05Xg3I3+k4d
         fbyw==
X-Gm-Message-State: APzg51DMV1SH6Qt2SK6ZnU9uq1cEQIex7oJjQlPzeXEFxcsWBFfjMoaG
        EJ+f1R/FvuY1SG95LEmM6OBHuqSZphICfw==
X-Google-Smtp-Source: ANB0VdZ+NJmgQDwvI1q7hu5ZcvYVfJhCC3R5NAoJf+/d4NQJkZ1uK/6NMAk4HjfM8cS3DVjnCWAXVg==
X-Received: by 2002:a0d:ef01:: with SMTP id y1-v6mr3652489ywe.498.1536313940116;
        Fri, 07 Sep 2018 02:52:20 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o63-v6sm2464161ywc.36.2018.09.07.02.52.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 02:52:19 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id t10-v6so5253012ybb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:52:18 -0700 (PDT)
X-Received: by 2002:a25:acc6:: with SMTP id x6-v6mr485337ybd.293.1536313938375;
 Fri, 07 Sep 2018 02:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
 <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
In-Reply-To: <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 7 Sep 2018 18:52:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
Message-ID: <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Tomasz,
>
>
> On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> > Hi Vivek,
> >
> > On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >> From: Sricharan R <sricharan@codeaurora.org>
> >>
> >> The smmu device probe/remove and add/remove master device callbacks
> >> gets called when the smmu is not linked to its master, that is without
> >> the context of the master device. So calling runtime apis in those places
> >> separately.
> >> Global locks are also initialized before enabling runtime pm as the
> >> runtime_resume() calls device_reset() which does tlb_sync_global()
> >> that ultimately requires locks to be initialized.
> >>
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> [vivek: Cleanup pm runtime calls]
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> >>   1 file changed, 81 insertions(+), 8 deletions(-)
> > [snip]
> >> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>          if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
> >>                  dev_err(&pdev->dev, "removing device with active domains!\n");
> >>
> >> +       arm_smmu_rpm_get(smmu);
> >>          /* Turn the thing off */
> >>          writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >> +       arm_smmu_rpm_put(smmu);
> >> +
> >> +       if (pm_runtime_enabled(smmu->dev))
> >> +               pm_runtime_force_suspend(smmu->dev);
> >> +       else
> >> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
> >>
> >> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> >> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> > Aren't we missing pm_runtime_disable() here? We'll have the enable
> > count unbalanced if the driver is removed and probed again.
>
> pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
> wrong.
> And, as mentioned in a previous thread [1], we were seeing a warning
> which we avoided
> by keeping force_suspend().
>
> [1] https://lkml.org/lkml/2018/7/8/124

I see, thanks. I didn't realize that pm_runtime_force_suspend()
already disables runtime PM indeed. Sorry for the noise.

Best regards,
Tomasz
