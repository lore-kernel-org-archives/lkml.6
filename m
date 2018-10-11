Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9261C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F61521480
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaEZCO9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F61521480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeJKVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:34:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45526 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeJKVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:34:45 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so6644645iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UQV1qy5OgBmh0gbeb60UhcC41PZScPfWtmnUdm+xUOw=;
        b=BaEZCO9RGu629nfl4raf4ZW+bmsrcPCphnM9qRpKU7fwZY/Fa/S8C3eQAf1vYa7M8c
         UkziqAYyFSdVpfP9lmM0JL0RfFR5nJae0GQUCpLVTihoehLMTLH+B66ckLK+7F1xhxw+
         VW/mBeRcb4wbyCOPBywHyTwDMeW0p+lPlPhrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UQV1qy5OgBmh0gbeb60UhcC41PZScPfWtmnUdm+xUOw=;
        b=G7tyzteWKEi61M6ijxCmfUG7ERMn8cLVJAsLZRarnIqbkE3RKQDtkXHbAe91Ls8Rl9
         KbgXR3gxt4eFWPaAJNzVo3FF/TYc2iDnvsKbz7uoRCdL/Pa6E85OgDJsfLY4Ybjffk4j
         +3Q+fV67r/c3RnNJrpuFzKQlqdpJImIEGQOxTqLS6vj2CAu9XEpUlsaOHJACGHQ9sYIo
         TWV1GxNSZIE0PxpRtcOICuZkae3KjrlCMPmIYAeb+hauYbzP+K2hsRoCZ00lHX4imuzw
         14QX1Unb4w4R9QMLxpocFTN9w6/QzyA1qu+t57eDFhXLFUsfu/hR/7k9QfIXaIvPPgBF
         V//Q==
X-Gm-Message-State: ABuFfogm+uFFU24syoFboGenJSYnLOwwHEDgiHzO1AIgl8DYp+yepKFV
        RiFIzFA1aj6ujXf5ucEp95Tm3YIhRpXi3pwjexR1GA==
X-Google-Smtp-Source: ACcGV63Gh9XXj3qrNDOVSNu/qxIrLtHbYrDWcVM9skOmlUmYYSAkggVtEJOgV7BpNU41h1SuXDBZK7KYufIjaX/7mKo=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr1243746iod.266.1539266843294;
 Thu, 11 Oct 2018 07:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 07:06:42
 -0700 (PDT)
In-Reply-To: <20181011120336.9129-1-georgi.djakov@linaro.org>
References: <20181011120336.9129-1-georgi.djakov@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Oct 2018 16:06:42 +0200
Message-ID: <CAPDyKFopGLrbKjqizs+BEX8pqhA0G62y5yGo92fBaRBzWaKpmQ@mail.gmail.com>
Subject: Re: [RFC] mmc: host: sdhci-msm: Use the interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 October 2018 at 14:03, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
>
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the SD host controller and report the needed bandwidth
> based on the clock rate, bus width and mode.

Overall, this makes sense to me!

>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>
> This depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444
>
> TODO: Use macros for converting and rounding to icc units instead of
> converting between kilobits and kilobytes in the consumer drivers.
>
>  drivers/mmc/host/sdhci-msm.c | 46 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3cc8bfee6c18..8ca99ccdb035 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -20,6 +20,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/interconnect.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
>
> @@ -258,6 +259,7 @@ struct sdhci_msm_host {
>         bool mci_removed;
>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
> +       struct icc_path *path;
>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1627,6 +1629,30 @@ static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>         .offset = &sdhci_msm_v5_offset,
>  };
>
> +static int sdhci_msm_icc_update(struct sdhci_msm_host *msm_host)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(&msm_host->pdev->dev);
> +       struct mmc_host *mmc = host->mmc;
> +       struct mmc_ios *ios = &mmc->ios;
> +       unsigned char bus_width = 1 << ios->bus_width;
> +       u32 bw;
> +
> +       /* calculate the needed bandwidth */
> +       bw = host->clock;

According to my understanding of the code, host->clock doesn't
necessarily reflect the actual set clock rate. For example,
clk_set_rate() doesn't mean that requested rate is set exactly to the
requested rate.

Moreover, it may not be evident, but from mmc core perspective, it's
strongly recommended for mmc host drivers to set ->actual_clock to the
"actual clock rate" in the corresponding struct mmc_host. I suggest
sdhci-msm convert to that, in a first step. Once that is done, I would
rather move the below computations, to find the bandwidth, into a
helper function inside the mmc core.

> +
> +       if (host->timing == MMC_TIMING_UHS_DDR50 ||
> +           host->timing == MMC_TIMING_MMC_DDR52) {
> +               bw *= 2;
> +       }
> +
> +       if (bus_width == 4)
> +               bw /= 2;
> +       else if (bus_width == 1)
> +               bw /= 8;
> +
> +       return icc_set(msm_host->path, 0, bw / 1000);
> +}
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
> @@ -1698,16 +1724,27 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>
> +       msm_host->path = of_icc_get(&pdev->dev, "sdhc-mem");
> +       if (IS_ERR(msm_host->path)) {
> +               ret = PTR_ERR(msm_host->path);
> +               goto pltfm_free;
> +       }
> +       ret = sdhci_msm_icc_update(msm_host);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "Interconnect setup failed (%d)\n", ret);
> +               goto icc_disable;
> +       }
> +
>         /* Setup SDCC bus voter clock. */
>         msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>         if (!IS_ERR(msm_host->bus_clk)) {
>                 /* Vote for max. clk rate for max. performance */
>                 ret = clk_set_rate(msm_host->bus_clk, INT_MAX);
>                 if (ret)
> -                       goto pltfm_free;
> +                       goto icc_disable;
>                 ret = clk_prepare_enable(msm_host->bus_clk);
>                 if (ret)
> -                       goto pltfm_free;
> +                       goto icc_disable;
>         }
>
>         /* Setup main peripheral bus clock */
> @@ -1883,6 +1920,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
>                 clk_disable_unprepare(msm_host->bus_clk);
> +icc_disable:
> +       icc_put(msm_host->path);
>  pltfm_free:
>         sdhci_pltfm_free(pdev);
>         return ret;
> @@ -1902,6 +1941,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> +       icc_put(msm_host->path);
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -1917,6 +1957,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>
> +       icc_set(msm_host->path, 0, 0);
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>
> @@ -1929,6 +1970,7 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>
> +       sdhci_msm_icc_update(msm_host);
>         return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>                                        msm_host->bulk_clks);
>  }

Besides the above, this makes sense to me.

Kind regards
Uffe
