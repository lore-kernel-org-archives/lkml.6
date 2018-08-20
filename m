Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE132C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C5721534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsHF9ZWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C5721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeHTMwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:52:03 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38683 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:52:03 -0400
Received: by mail-yb0-f195.google.com with SMTP id c1-v6so2677591ybq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpR7X0cMcSd9QTtBZD/OgxGKK+yYoZT/jF4ELA5luSg=;
        b=gsHF9ZWIx2uS69taxUsPm0F0he2hvAUUNdDzcrpUAckls86G2EEluNWJ3eEBbDuFVd
         kJNNDqdgshYYgYWGR24ufwIyLwaZ5LAvaQW+a55kRGB7PIenozkH5jetxPWt8rprbABn
         pVUnVJqTXb2B/pTEx4wpmRdQqo+XWNZd/5mGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpR7X0cMcSd9QTtBZD/OgxGKK+yYoZT/jF4ELA5luSg=;
        b=PvwCeeQVcKBR2qXRi65cGnbqwJrGOq/iyWVTRriyKvmmYqBBwV+AkBUY7+lE0PC2Dz
         Y7jQePfRs9EyR//p8vawwVwompfzrZ5E2Qyg7/YXWFKcmgV6991GlkoLVdQ5zbiSobKg
         eM8JIWXCwJ3TuWJ3/bxVZfRxS4rft4BxPFmZYlvpI4SKUIDXsqNQY65/eKSLPPel4Ve2
         QDlEIH9Oks7gGCMR5poJfDJNty+iE56D2Gccxg4jjtLxCJs17sQDywg4BG45XmjGBpyc
         Syo8+vxrdPGw3xqIcbxv/w7qHBKvfIplnmh+Ax6olGwY8zH0fgBMAxEEAYy02uHyqAxd
         zPNg==
X-Gm-Message-State: AOUpUlGKJddQdsVpGCeHetuIFUFHZGH1YQ7SEbdppcvK+uuAvzKThznr
        LHEPsPr2ZCfZ9Jx6Mqgub9NPtBIFNnDeoA==
X-Google-Smtp-Source: AA+uWPyn8H+NU+FCem2+kqU7SUUotVZBrPpGm8ZQBDhXinWsveslpG8poyl26KUamcH5Hy4e+VdbhQ==
X-Received: by 2002:a25:4d89:: with SMTP id a131-v6mr24465361ybb.452.1534757828771;
        Mon, 20 Aug 2018 02:37:08 -0700 (PDT)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com. [209.85.213.179])
        by smtp.gmail.com with ESMTPSA id o204-v6sm5318920ywd.16.2018.08.20.02.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 02:37:08 -0700 (PDT)
Received: by mail-yb0-f179.google.com with SMTP id v13-v6so2880270ybq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 02:37:08 -0700 (PDT)
X-Received: by 2002:a25:3486:: with SMTP id b128-v6mr14267850yba.373.1534757474847;
 Mon, 20 Aug 2018 02:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 20 Aug 2018 18:31:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
Message-ID: <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Jul 27, 2018 at 4:02 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using
> device links between smmu and client devices. The device link
> framework keeps the two devices in correct order for power-cycling
> across runtime PM or across system-wide PM.
>
> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
> (available in linux-next of Rafael's linux-pm tree [9]), the device links
> created between arm-smmu and its clients will be automatically purged
> when arm-smmu driver unbinds from its device.
>
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.
> Otherwise, the clocks are turned to be always on in .probe until .remove.
> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
>
> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
>
> Previous version of this patch series is @ [2].
>
> Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
> linux-next[9] and Joerg's iommu next[10] branches, and related changes for
> device tree, etc.
>
> Hi Robin, Will,
> I have addressed the comments for v13. If there's still a chance
> can you please consider pulling this for v4.19.
> Thanks.
>
> [v14]
>    * Moved arm_smmu_device_reset() from arm_smmu_pm_resume() to
>      arm_smmu_runtime_resume() so that the pm_resume callback calls
>      only runtime_resume to resume the device.
>      This should take care of restoring the state of smmu in systems
>      in which smmu lose register state on power-domain collapse.

It's been a while since this series was posted and no more comments
seem to be left anymore. Would you have some time to take a look
again? Thanks.

Best regards,
Tomasz
