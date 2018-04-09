Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDIEWY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 00:22:24 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:43398 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeDIEWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 00:22:22 -0400
X-Google-Smtp-Source: AIpwx4+cpi11kJNlcdpOlHwln9rtSCAOZ/mnOGU3JL8HD5UPWaGHKQ1uW73UG3xiwEMCC58fYR1XuA==
MIME-Version: 1.0
References: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20180322102204.14760-1-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 09 Apr 2018 04:22:09 +0000
X-Gmail-Original-Message-ID: <CAAFQd5CDY5p8oBz4QC5f6GsKiiYqdenCHGCqKhuWn10JwKjOpw@mail.gmail.com>
Message-ID: <CAAFQd5CDY5p8oBz4QC5f6GsKiiYqdenCHGCqKhuWn10JwKjOpw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>, Lukas Wunner <lukas@wunner.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Robin,

On Thu, Mar 22, 2018 at 7:22 PM Vivek Gautam <vivek.gautam@codeaurora.org>
wrote:

> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using the
> recently introduced device links patches, which lets the smmu's
> runtime to follow the master's runtime pm, so the smmu remains
> powered only when the masters use it.
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.

> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.

> Took some reference from the exynos runtime patches [1].

> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.

> Previous version of this patch series is @ [5].

> [v11]
>     * Some more cleanups for device link. We don't need an explicit
>       delete for device link from the driver, but just set the flag
>       DL_FLAG_AUTOREMOVE.
>       device_link_add() API description says -
>       "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
>       automatically when the consumer device driver unbinds."
>     * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
>     * Dropped the patch [10] that introduced device_link_del_dev() API.

As far as I can see, this version addresses all the earlier comments. Do
you think this is something that you could apply?

Best regards,
Tomasz
