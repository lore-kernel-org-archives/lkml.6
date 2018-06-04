Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeFDNJX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:09:23 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41964 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeFDNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:09:20 -0400
X-Google-Smtp-Source: ADUXVKKK6stFVJg9Pvip+aj/ZDoaXPaebfemBEzL8fqbyvYwE4o3LC+plUXHa1+Lh6WFNezE+19h4A==
MIME-Version: 1.0
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org> <1527884768-22392-5-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1527884768-22392-5-git-send-email-vgarodia@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 4 Jun 2018 22:09:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AKy8X0Dd47fOKxTUaLuErtWv005_AGbB=O5SP+F+rrgA@mail.gmail.com>
Message-ID: <CAAFQd5AKy8X0Dd47fOKxTUaLuErtWv005_AGbB=O5SP+F+rrgA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] media: venus: add no TZ boot and shutdown routine
To: vgarodia@codeaurora.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        andy.gross@linaro.org, bjorn.andersson@linaro.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On Sat, Jun 2, 2018 at 5:27 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
[snip]
> +int venus_boot_noTZ(struct venus_core *core, phys_addr_t mem_phys,
> +                                                       size_t mem_size)
> +{
> +       struct iommu_domain *iommu;
> +       struct device *dev;
> +       int ret;
> +
> +       if (!core->fw.dev)
> +               return -EPROBE_DEFER;

Is it really possible that the device appears after the probe is retried?

> +
> +       dev = core->fw.dev;
> +
> +       iommu = iommu_domain_alloc(&platform_bus_type);
> +       if (!iommu) {
> +               dev_err(dev, "Failed to allocate iommu domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = iommu_attach_device(iommu, dev);
> +       if (ret) {
> +               dev_err(dev, "could not attach device\n");
> +               goto err_attach;
> +       }
> +
> +       ret = iommu_map(iommu, VENUS_FW_START_ADDR, mem_phys, mem_size,
> +                       IOMMU_READ|IOMMU_WRITE|IOMMU_PRIV);
> +       if (ret) {
> +               dev_err(dev, "could not map video firmware region\n");
> +               goto err_map;
> +       }

I'm not very familiar with translation capabilities of ARM SMMU, so
that might be an elementary question, but could you explain how this
works? Will this make the firmware device (transfers with firmware
PASID) use different page directory from the main device (all the
other PASIDs; used with DMA mapping API)?

+Will and Robin, just in case.

> +       core->fw.iommu_domain = iommu;
> +       venus_reset_hw(core);
> +
> +       return 0;
> +
> +err_map:
> +       iommu_detach_device(iommu, dev);
> +err_attach:
> +       iommu_domain_free(iommu);
> +       return ret;
> +}
[snip]
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index 0916826..67fdd89 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -14,10 +14,15 @@
>  #ifndef __VENUS_FIRMWARE_H__
>  #define __VENUS_FIRMWARE_H__
>
> +#define VENUS_PAS_ID                   9

Shouldn't this normally be given in DT?

Best regards,
Tomasz
