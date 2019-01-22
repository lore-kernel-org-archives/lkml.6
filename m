Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA10C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEFF20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7J5lrzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAVHs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:27 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37219 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfAVHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:24 -0500
Received: by mail-vs1-f68.google.com with SMTP id n13so14175298vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Fj7V4uR4zDVxAcqQmEZpuLZxv6qogc8rxDYD0HVgLE=;
        b=G7J5lrzdoGS2LiFNCQ2qPtYcBAG8kC4fkYTeImDFCYv/XjsAMhcbs0LHNSOLV4hMZV
         FMnTPtzvuR5Zssw4Gs3jFqjQOeFAWrE1Y57DMlz4lShoB6g0pIqbhZ96rDG47ltQfRsD
         VqV8vCBCe6HsMCZVm+Z7i418TiuFuRUwTJsW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Fj7V4uR4zDVxAcqQmEZpuLZxv6qogc8rxDYD0HVgLE=;
        b=eabjvqaBfb/2a8WtaQXEYhU4hHbK0o0oLdmyGdAcU0cp7oz1GMqiziq5qgmdRAgdSX
         7hIBGdWbDKd6qjVZ2EIq81R11su/EFBWxbi/kqjdTvN/ik7pWiRwg8G0vPjIEFK8lI4N
         EJjIXauYQ4p4spA7bX61f54ZicS/3tNxwvoupQ4cCWX0kF/2ujqYKXnLI+xH2ADYB61W
         MCoBqbK259c3nCZBPg9swXpysxoCnVS42NNxxHDWhKPmtJYNTylW3+swzPjMxXLP0pVg
         TnKItmENgUCIMKIM/3ITr0yW34/BwGSKldPhQ2elSlvsEg2bwIM9WbqtGSJkB4O1Hiko
         exIQ==
X-Gm-Message-State: AJcUukcIlYNnzgKMWrmhGDf30o3hAgDO/3OINAVMncrUIEc80J9PE+2l
        zvYW6ip2JH4r/6HazdKSWymw4qfk8ZEFygT4L1wMkQ==
X-Google-Smtp-Source: ALg8bN4Ow+6307DaNUnpEKRGrWV0BCYXrvNNVEtjX3stzEfnK0Tgz764Gla80NureTz9Kyz5QVzh50q3wmXzaHrg82w=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr14170118vsc.34.1548143303456;
 Mon, 21 Jan 2019 23:48:23 -0800 (PST)
MIME-Version: 1.0
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com> <1547160363-25323-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1547160363-25323-3-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:47:47 +0100
Message-ID: <CAPDyKFphCv6J-rE1HCqhmDyc1TvvmQ3qeD+bshd1pSYOt7h3PQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] mmc: tegra: SDMMC pads auto-calibration
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
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

On Thu, 10 Jan 2019 at 23:46, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Program initial drive code offsets which will be used by auto
> calibration process.
>
> Program fixed drive strengths for SDMMC pads in pad control
> register when auto cal timeouts.
> Fixed settings are based on Pre-SI analysis of the pad design.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 160 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 119 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e6ace31e2a41..7d681a8fa4ba 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -75,6 +75,7 @@
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK   0x0000000f
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL    0x7
>  #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD  BIT(31)
> +#define SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK         0x07FFF000
>
>  #define SDHCI_TEGRA_AUTO_CAL_STATUS                    0x1ec
>  #define SDHCI_TEGRA_AUTO_CAL_ACTIVE                    BIT(31)
> @@ -121,6 +122,8 @@ struct sdhci_tegra {
>         struct pinctrl *pinctrl_sdmmc;
>         struct pinctrl_state *pinctrl_state_3v3;
>         struct pinctrl_state *pinctrl_state_1v8;
> +       struct pinctrl_state *pinctrl_state_3v3_drv;
> +       struct pinctrl_state *pinctrl_state_1v8_drv;
>
>         struct sdhci_tegra_autocal_offsets autocal_offsets;
>         ktime_t last_calib;
> @@ -411,6 +414,76 @@ static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
>         sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>  }
>
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
> +                                  bool state_drvupdn)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       struct sdhci_tegra_autocal_offsets *offsets =
> +                                               &tegra_host->autocal_offsets;
> +       struct pinctrl_state *pinctrl_drvupdn = NULL;
> +       int ret = 0;
> +       u8 drvup = 0, drvdn = 0;
> +       u32 reg;
> +
> +       if (!state_drvupdn) {
> +               /* PADS Drive Strength */
> +               if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +                       if (tegra_host->pinctrl_state_1v8_drv) {
> +                               pinctrl_drvupdn =
> +                                       tegra_host->pinctrl_state_1v8_drv;
> +                       } else {
> +                               drvup = offsets->pull_up_1v8_timeout;
> +                               drvdn = offsets->pull_down_1v8_timeout;
> +                       }
> +               } else {
> +                       if (tegra_host->pinctrl_state_3v3_drv) {
> +                               pinctrl_drvupdn =
> +                                       tegra_host->pinctrl_state_3v3_drv;
> +                       } else {
> +                               drvup = offsets->pull_up_3v3_timeout;
> +                               drvdn = offsets->pull_down_3v3_timeout;
> +                       }
> +               }
> +
> +               if (pinctrl_drvupdn != NULL) {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                                       pinctrl_drvupdn);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "failed pads drvupdn, ret: %d\n", ret);
> +               } else if ((drvup) || (drvdn)) {
> +                       reg = sdhci_readl(host,
> +                                       SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +                       reg &= ~SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK;
> +                       reg |= (drvup << 20) | (drvdn << 12);
> +                       sdhci_writel(host, reg,
> +                                       SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
> +               }
> +
> +       } else {
> +               /* Dual Voltage PADS Voltage selection */
> +               if (!tegra_host->pad_control_available)
> +                       return 0;
> +
> +               if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                               tegra_host->pinctrl_state_1v8);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "setting 1.8V failed, ret: %d\n", ret);
> +               } else {
> +                       ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +                                               tegra_host->pinctrl_state_3v3);
> +                       if (ret < 0)
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "setting 3.3V failed, ret: %d\n", ret);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -437,6 +510,7 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>                         pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
>         }
>
> +       /* Set initial offset before auto-calibration */
>         tegra_sdhci_set_pad_autocal_offset(host, pdpu);
>
>         card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
> @@ -460,19 +534,15 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>         if (ret) {
>                 dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>
> -               if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> -                       pdpu = offsets.pull_down_1v8_timeout << 8 |
> -                              offsets.pull_up_1v8_timeout;
> -               else
> -                       pdpu = offsets.pull_down_3v3_timeout << 8 |
> -                              offsets.pull_up_3v3_timeout;
> -
> -               /* Disable automatic calibration and use fixed offsets */
> +               /* Disable automatic cal and use fixed Drive Strengths */
>                 reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>                 reg &= ~SDHCI_AUTO_CAL_ENABLE;
>                 sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>
> -               tegra_sdhci_set_pad_autocal_offset(host, pdpu);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, false);
> +               if (ret < 0)
> +                       dev_err(mmc_dev(host->mmc),
> +                               "Setting drive strengths failed: %d\n", ret);
>         }
>  }
>
> @@ -511,26 +581,46 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>                         &autocal->pull_up_3v3_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> +                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_up_3v3_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>                         &autocal->pull_down_3v3_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> +                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_down_3v3_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
>                         &autocal->pull_up_1v8_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> +                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_up_1v8_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
>                         &autocal->pull_down_1v8_timeout);
> -       if (err)
> +       if (err) {
> +               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> +                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> +                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> +                               mmc_hostname(host->mmc));
>                 autocal->pull_down_1v8_timeout = 0;
> +       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-sdr104",
> @@ -743,32 +833,6 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>         return mmc_send_tuning(host->mmc, opcode, NULL);
>  }
>
> -static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
> -
> -       if (!tegra_host->pad_control_available)
> -               return 0;
> -
> -       if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -                                          tegra_host->pinctrl_state_1v8);
> -               if (ret < 0)
> -                       dev_err(mmc_dev(host->mmc),
> -                               "setting 1.8V failed, ret: %d\n", ret);
> -       } else {
> -               ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> -                                          tegra_host->pinctrl_state_3v3);
> -               if (ret < 0)
> -                       dev_err(mmc_dev(host->mmc),
> -                               "setting 3.3V failed, ret: %d\n", ret);
> -       }
> -
> -       return ret;
> -}
> -
>  static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>                                                    struct mmc_ios *ios)
>  {
> @@ -778,7 +842,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>         int ret = 0;
>
>         if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>                 if (ret < 0)
>                         return ret;
>                 ret = sdhci_start_signal_voltage_switch(mmc, ios);
> @@ -786,7 +850,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>                 ret = sdhci_start_signal_voltage_switch(mmc, ios);
>                 if (ret < 0)
>                         return ret;
> -               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +               ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
>         }
>
>         if (tegra_host->pad_calib_required)
> @@ -805,6 +869,20 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 return -1;
>         }
>
> +       tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
> +       if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
> +               if (PTR_ERR(tegra_host->pinctrl_state_1v8_drv) == -ENODEV)
> +                       tegra_host->pinctrl_state_1v8_drv = NULL;
> +       }
> +
> +       tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
> +       if (IS_ERR(tegra_host->pinctrl_state_3v3_drv)) {
> +               if (PTR_ERR(tegra_host->pinctrl_state_3v3_drv) == -ENODEV)
> +                       tegra_host->pinctrl_state_3v3_drv = NULL;
> +       }
> +
>         tegra_host->pinctrl_state_3v3 =
>                 pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
>         if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
> --
> 2.7.4
>
