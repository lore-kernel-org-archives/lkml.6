Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8016FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FF72083B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAkp56qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfAaH2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:28:49 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45326 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731543AbfAaH2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:28:47 -0500
Received: by mail-ua1-f65.google.com with SMTP id e16so688264uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHMWg5PiWrBn0qM+Dim9xZ7u4No7IH7sRfoNUu5/jj8=;
        b=cAkp56qpnFJPVKI/3DbqI1LMttaGS+/61Y7+7tf2Tecrp2yKJdeIuUOOaYv20FVOik
         rwdiWz2/0iMgMffN3orWXqQiTfzubHblvBVAo0ZPvOBiJAzRAv9Hhsyj1SzI48sMCXxb
         X/FLpx6BzWfTfm3bLZ9bu5AksbXzRwivVzn0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHMWg5PiWrBn0qM+Dim9xZ7u4No7IH7sRfoNUu5/jj8=;
        b=i3tiOfz3gZj7gc1idBfHKGlR5nYyfOC9nArhz/gJkNjZ+z7ECSjNv5Pnsz070CTETq
         XYGhxSOgY108ckSh7NzSLC7vNiqEjdMrT80au0JqyV7/nrz0VGj6gdo9/k6NAWJU6pTs
         395PbDRfR72DyD0Roffo0qsmvLB1sM9xlunG9+g9VXkDiGd0VeT5b7jhSptFZCWKV8DR
         arcOnZcLEDMrBA3XAlym3mhK9dkk5ErBgTbLghe0SC9sxETIzxP2upo39/3Mz6BxB/4L
         5smNkSp2MvKnpaL/pBeaD+VUPcGo/LN+IDtqm8AbqWdj4j7jIfJRblxtK7NqzyAR8g5q
         s0gw==
X-Gm-Message-State: AJcUukewMjfgkHKUeTv6rLQibSSUU7J8k9OHoruvMepIhNFGRxjLm7Jn
        JNhDjwQifCFuW7LfCbjlRrm34BjXuciQXbSe9QQH+A==
X-Google-Smtp-Source: ALg8bN471GZije7/aWvnFabP+4s5pkAYUHOdmfM9A5ZAWmvuc902dkcZFiycABtZEjyA2p65UUYh3tDr8tCWZxU1X4w=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr13320782uad.119.1548919725756;
 Wed, 30 Jan 2019 23:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com> <1548271854-1765-4-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1548271854-1765-4-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 08:28:09 +0100
Message-ID: <CAPDyKFoFxLGt70RmavYTq+_YJucRt=1aJAnHvGZ8XBuOj1=Xmw@mail.gmail.com>
Subject: Re: [PATCH V11 4/4] mmc: tegra: HW Command Queue Support for Tegra SDMMC
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
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  [v11]: Same as V10
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
>         into seperate patch
>
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 114 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..0739d26c001b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,7 @@ config MMC_SDHCI_TEGRA
>         depends on ARCH_TEGRA
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
> +       select MMC_CQHCI
>         help
>           This selects the Tegra SD/MMC controller. If you have a Tegra
>           platform with SD or MMC devices, say Y or M here.
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e6ace31e2a41..d400f158bee4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -33,6 +33,7 @@
>  #include <linux/ktime.h>
>
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>
>  /* Tegra SDHOST controller vendor register definitions */
>  #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL                  0x100
> @@ -89,6 +90,9 @@
>  #define NVQUIRK_NEEDS_PAD_CONTROL                      BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP                        BIT(8)
>
> +/* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
> +#define SDHCI_TEGRA_CQE_BASE_ADDR                      0xF000
> +
>  struct sdhci_tegra_soc_data {
>         const struct sdhci_pltfm_data *pdata;
>         u32 nvquirks;
> @@ -128,6 +132,7 @@ struct sdhci_tegra {
>         u32 default_tap;
>         u32 default_trim;
>         u32 dqs_trim;
> +       bool enable_hwcq;
>  };
>
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -595,6 +600,20 @@ static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>                 tegra_host->dqs_trim = 0x11;
>  }
>
> +static void tegra_sdhci_parse_dt(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (device_property_read_bool(host->mmc->parent, "supports-cqe"))
> +               tegra_host->enable_hwcq = true;
> +       else
> +               tegra_host->enable_hwcq = false;
> +
> +       tegra_sdhci_parse_pad_autocal_dt(host);
> +       tegra_sdhci_parse_tap_and_trim(host);
> +}
> +
>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -836,6 +855,49 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>                 tegra_host->pad_calib_required = true;
>  }
>
> +static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
> +{
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       u32 cqcfg = 0;
> +
> +       /*
> +        * Tegra SDMMC Controller design prevents write access to BLOCK_COUNT
> +        * registers when CQE is enabled.
> +        */
> +       cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
> +       if (cqcfg & CQHCI_ENABLE)
> +               cqhci_writel(cq_host, (cqcfg & ~CQHCI_ENABLE), CQHCI_CFG);
> +
> +       sdhci_cqe_enable(mmc);
> +
> +       if (cqcfg & CQHCI_ENABLE)
> +               cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +}
> +
> +static void sdhci_tegra_dumpregs(struct mmc_host *mmc)
> +{
> +       sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       int cmd_error = 0;
> +       int data_error = 0;
> +
> +       if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +               return intmask;
> +
> +       cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +       return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
> +       .enable = sdhci_tegra_cqe_enable,
> +       .disable = sdhci_cqe_disable,
> +       .dumpregs = sdhci_tegra_dumpregs,
> +};
> +
>  static const struct sdhci_ops tegra_sdhci_ops = {
>         .get_ro     = tegra_sdhci_get_ro,
>         .read_w     = tegra_sdhci_readw,
> @@ -989,6 +1051,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
>         .get_max_clock = tegra_sdhci_get_max_clock,
> +       .irq = sdhci_tegra_cqhci_irq,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> @@ -1030,6 +1093,54 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
>
> +static int sdhci_tegra_add_host(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       struct cqhci_host *cq_host;
> +       bool dma64;
> +       int ret;
> +
> +       if (!tegra_host->enable_hwcq)
> +               return sdhci_add_host(host);
> +
> +       sdhci_enable_v4_mode(host);
> +
> +       ret = sdhci_setup_host(host);
> +       if (ret)
> +               return ret;
> +
> +       host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +       cq_host = devm_kzalloc(host->mmc->parent,
> +                               sizeof(*cq_host), GFP_KERNEL);
> +       if (!cq_host) {
> +               ret = -ENOMEM;
> +               goto cleanup;
> +       }
> +
> +       cq_host->mmio = host->ioaddr + SDHCI_TEGRA_CQE_BASE_ADDR;
> +       cq_host->ops = &sdhci_tegra_cqhci_ops;
> +
> +       dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +       if (dma64)
> +               cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       if (ret)
> +               goto cleanup;
> +
> +       ret = __sdhci_add_host(host);
> +       if (ret)
> +               goto cleanup;
> +
> +       return 0;
> +
> +cleanup:
> +       sdhci_cleanup_host(host);
> +       return ret;
> +}
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *match;
> @@ -1077,9 +1188,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR;
>
> -       tegra_sdhci_parse_pad_autocal_dt(host);
> -
> -       tegra_sdhci_parse_tap_and_trim(host);
> +       tegra_sdhci_parse_dt(host);
>
>         tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
>                                                          GPIOD_OUT_HIGH);
> @@ -1117,7 +1226,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>
>         usleep_range(2000, 4000);
>
> -       rc = sdhci_add_host(host);
> +       rc = sdhci_tegra_add_host(host);
>         if (rc)
>                 goto err_add_host;
>
> --
> 2.7.4
>
