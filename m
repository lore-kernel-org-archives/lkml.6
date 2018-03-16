Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeCPGl5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:41:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46083 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeCPGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:41:54 -0400
X-Google-Smtp-Source: AG47ELtgOOKZWwAJQtNP7EGrjFAemBNaO195mt1uNnlQjZK/+88VbySnYF4BxuRNq+2r40Jsh/X+MQ==
MIME-Version: 1.0
In-Reply-To: <20180314081434.30875-5-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org> <20180314081434.30875-5-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 16 Mar 2018 15:41:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AAgCE7avK=bR45Kjd=LhJ-qe+kD1otPWPaXUo7_JR65g@mail.gmail.com>
Message-ID: <CAAFQd5AAgCE7avK=bR45Kjd=LhJ-qe+kD1otPWPaXUo7_JR65g@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        rafael.j.wysocki@intel.com, Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Wed, Mar 14, 2018 at 5:14 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
>
> Changes since v9:
>  - Using device_link_del_dev() to delete the device link, instead of
>    doing it in two steps - device_link_find() to first find the link, and
>    then calling device_link_del().
>
>  drivers/iommu/arm-smmu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 56a04ae80bf3..4cf270ffd449 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
>
>         iommu_device_link(&smmu->iommu, dev);
>
> +       if (pm_runtime_enabled(smmu->dev)) {
> +               struct device_link *link;
> +
> +               /*
> +                * Establish the link between smmu and master, so that the
> +                * smmu gets runtime enabled/disabled as per the master's
> +                * needs.
> +                */
> +               link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
> +               if (!link) {
> +                       dev_warn(smmu->dev,
> +                                "Unable to add link to the consumer %s\n",
> +                                dev_name(dev));
> +                       ret = -ENODEV;
> +                       goto out_unlink;
> +               }
> +       }

If it's an error, we should use dev_err(). Also, as per Robin's
comment for v9 could we make it as follows?

if (pm_runtime_enabled(smmu->dev) &&
    !device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME)) {
        dev_err(smmu->dev,
                         "Unable to add link to the consumer %s\n",
dev_name(dev));
        ret = -ENODEV;
        goto out_unlink;
}

Best regards,
Tomasz
