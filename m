Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MByEUMky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfAaH2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:28:43 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46434 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbfAaH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:28:42 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so688334uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UhmrgpuCf61ZN7FlcS2wJd8jJNzFJecIFpigFP5fms=;
        b=MByEUMkyCrMKA19fhWdZ2BRfe21MPRxLosZXKGkIkmZC96WncdViKS1dDHFqmdIgh0
         ExqCod0SKJXIrQPLo+0JcoSk3g4e+WKC/UBFEkLOAb6+RsEO7b9H1Br2b2U35/Jegug5
         /Vh6Fd0KQwcauYiAMXatAPEOVbNlgd+z/7yQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UhmrgpuCf61ZN7FlcS2wJd8jJNzFJecIFpigFP5fms=;
        b=qrifTWqgCErAOKVqiqnUYi3iKHi7O9S717ZXzALtOV3bIqDLxsK+N5Ldsj0gAlod2k
         S/9ovKbYIkBPnTUAsKq67E4+eWrNAS8nmbgdNItsAwXdIlDG0f1ULRPV209pMt7GLFqf
         V2dRnyVGIFFzo4474JpI1CkA5QXsNf7ErWtj8m9WTNP+nKCP7sH9AIdiLBOaxWxyZ/F0
         uOLERlXtjbJuJ5L2FCV7BRfIjYcfUaflnSAMxW3k2/XLfAq9X0jjpPgpa7vTUomUOjvt
         8ouNE+yMimxHEPoU0RV8A1cGwyd4WU/x/AaMP9k8Ni0qoghnJ4fNldiQNL23SdE8lODV
         FPsg==
X-Gm-Message-State: AJcUukcbFzpCeDi39ErIasTNmznLhdyjPITRoHOy+hfLeMyrx8rPYV2W
        mFcCKWDwOer50qVQhhzMEMl8Tnsuxmq709FQ/wymcA==
X-Google-Smtp-Source: ALg8bN4pHK78VGU0+XcDtRfkB287AAFJli9/FR+bL/0FAWaulHjKlFGjccJwPntz8A9redMDZAnojAgrnVZKAX40lUE=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr14222334uan.107.1548919720451;
 Wed, 30 Jan 2019 23:28:40 -0800 (PST)
MIME-Version: 1.0
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com> <1548271854-1765-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1548271854-1765-3-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 08:28:04 +0100
Message-ID: <CAPDyKFpZ1Y+n58v4SrHgJWeKv-JLT59-xSNzSLwWNhsohBWNYQ@mail.gmail.com>
Subject: Re: [PATCH V11 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled host
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 20:31, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Below are the supported DMA types in Host Control1 Register
> with Version 4 enable
> b'00 - SDMA
> b'01 - Not Used
> b'10 - ADMA2
> b'11 - ADMA2 or ADMA3
>
> ADMA3 uses Command Descriptor to issue an SD command.
> A multi-block data transfer is performed by using a pair of CMD
> descriptor and ADMA2 descriptor.
>
> ADMA3 performs multiple of multi-block data transfer by using
> Integrated Descriptor which is more suitable for Command Queuing
> to fetch both Command and Transfer descriptors.
>
> Host Capabilities register indicates the supports of ADMA3 DMA.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  [V11]: Fixed typo in commit message of this patch.
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
>         into seperate patch
>
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a22e11a65658..c6afe793399e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3353,7 +3353,14 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>         ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -       if (host->flags & SDHCI_USE_64_BIT_DMA)
> +       /*
> +        * Host from V4.10 supports ADMA3 DMA type.
> +        * ADMA3 performs integrated descriptor which is more suitable
> +        * for cmd queuing to fetch both command and transfer descriptors.
> +        */
> +       if (host->v4_mode && (host->caps1 & SDHCI_CAN_DO_ADMA3))
> +               ctrl |= SDHCI_CTRL_ADMA3;
> +       else if (host->flags & SDHCI_USE_64_BIT_DMA)
>                 ctrl |= SDHCI_CTRL_ADMA64;
>         else
>                 ctrl |= SDHCI_CTRL_ADMA32;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6cc9a3c2ac66..4070be49d947 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -88,6 +88,7 @@
>  #define   SDHCI_CTRL_ADMA1     0x08
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
> +#define   SDHCI_CTRL_ADMA3     0x18
>  #define   SDHCI_CTRL_8BITBUS   0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
> @@ -230,6 +231,7 @@
>  #define  SDHCI_RETUNING_MODE_SHIFT             14
>  #define  SDHCI_CLOCK_MUL_MASK  0x00FF0000
>  #define  SDHCI_CLOCK_MUL_SHIFT 16
> +#define  SDHCI_CAN_DO_ADMA3    0x08000000
>  #define  SDHCI_SUPPORT_HS400   0x80000000 /* Non-standard */
>
>  #define SDHCI_CAPABILITIES_1   0x44
> --
> 2.7.4
>
