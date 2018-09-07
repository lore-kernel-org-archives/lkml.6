Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89F5206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z69EaHtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89F5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIGODh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:03:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35662 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:03:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id 14-v6so5165996ywe.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPMX2U/+GDmuntzdpi16LobMjhTM3x3EDMSFlNOCPmI=;
        b=Z69EaHtr1C4HiEmd6XGQPnqrgi2tb6Jyy3RHxWbcYZv7LC0MUHKt+MWFYMmrLFdXmq
         YSF5EF9KKiQ75rJIRGVLYTrdIDt1k/oabsRUB97A6hFQ4ujJ+scpYNl3AmMNigXS+Ev/
         +Smedr4L0Ob83lP20SwsIU+Mk0c7JoEBHtZsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPMX2U/+GDmuntzdpi16LobMjhTM3x3EDMSFlNOCPmI=;
        b=rtcr4uGThhx07XO81zvpZcejOxlTDZQ1Qcq46BgMcpmWOEGNiQnqImIWjcFvWMGFs/
         ahSGVcARf1Q2AjrCZGqUnaqx6moIKKxB/O8S5tesiuVaXNX1WdBCmw0dJ5E9SuGgDhdN
         sF5xuq8HCjuVDBLFmCsKvyvFVscrTHPsyZxDneTeKHKLNfhy7aiBanGeBGkBDfskc6jI
         FTJnrB/3e4F+jk4+u4JBHvOf5ksdxlYduGJQ7EB5wHh7Wlr6+Cl3vdDFIE7ro3NLw04u
         57H1wgYt+5b3Da+vV4f8foUz0k7n6pD7lrGCJ9jJUcHX4OVPqMLM3SPId9l4+lyHLq96
         qDUg==
X-Gm-Message-State: APzg51Bz8tnv21JV9EgLPGRxgrQ23GLuzv07Ha2Jbbg+aPVZ8LZ6D/93
        uFbnO41gXPpWLC9GNvOFBwN1s/q3tdN5+w==
X-Google-Smtp-Source: ANB0VdYmGE4W8Pw0NPbEFQ6M+3lbX+Ju+PshLJ2xXwWfHO39eUEoCbtswpIwGqCmybu+eOJeNodAng==
X-Received: by 2002:a81:5dc1:: with SMTP id r184-v6mr3438697ywb.122.1536312213113;
        Fri, 07 Sep 2018 02:23:33 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id q194-v6sm2605936ywg.91.2018.09.07.02.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 02:23:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o17-v6so5228022yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:23:32 -0700 (PDT)
X-Received: by 2002:a25:acc6:: with SMTP id x6-v6mr441205ybd.293.1536311808369;
 Fri, 07 Sep 2018 02:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180830144541.17740-3-vivek.gautam@codeaurora.org>
In-Reply-To: <20180830144541.17740-3-vivek.gautam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 7 Sep 2018 18:16:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
Message-ID: <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
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

Hi Vivek,

On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
> Global locks are also initialized before enabling runtime pm as the
> runtime_resume() calls device_reset() which does tlb_sync_global()
> that ultimately requires locks to be initialized.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 81 insertions(+), 8 deletions(-)
[snip]
> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>         if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>                 dev_err(&pdev->dev, "removing device with active domains!\n");
>
> +       arm_smmu_rpm_get(smmu);
>         /* Turn the thing off */
>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +       arm_smmu_rpm_put(smmu);
> +
> +       if (pm_runtime_enabled(smmu->dev))
> +               pm_runtime_force_suspend(smmu->dev);
> +       else
> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
>
> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);

Aren't we missing pm_runtime_disable() here? We'll have the enable
count unbalanced if the driver is removed and probed again.

Also, if we add pm_runtime_disable(), we can reorder things a bit and
simplify into:

       arm_smmu_rpm_get(smmu);

       /* Turn the thing off */
       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);

       if (pm_runtime_enabled())
               pm_runtime_disable();
        arm_smmu_rpm_put(smmu);

        clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);

Best regards,
Tomasz
