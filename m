Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B3C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE3D21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvryxChV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQGVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:21:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeJQGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:21:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id j17-v6so22470816lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8av6zKVYvkvBpD4ClCMKJhVmc8vpe/bcRKibuvdHDc=;
        b=nvryxChVqkmeuQEso/yTDDSEjkfhGM4X3THS201m7AKJAp9/b6fTgPHuNcREejY0ub
         4EMk7BT9pS/kmBMQZ1FKSM6echB91eRQ4iPQ4Ze2ELwhzjFH6v14Trl60y0bj5o5PyMZ
         BwqulhHfZGolmo0ksJRUA9ir752ZcSzDbL/SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8av6zKVYvkvBpD4ClCMKJhVmc8vpe/bcRKibuvdHDc=;
        b=cB9ofm+ZQY1as2A+rRhnBlpi4HVQcjo/HGcxiSpnMOK8Yuh6okuqLcn3FDTxjZut1C
         l5dZbV1LhasAPFiqsSg4eh6wCsMfW8qrlVUnVLOGRgRQRtEOlGnR8MEpnJ/qqL6auB5T
         O9IMFnfVJdbFDSV0yINTFx/D5zLR5r4oXXHtCH9ClXUKPTEiCRgKoGhwuhmgwOKig85C
         dSXy7md93M1/p/5fR1YGQW+pOZmpk4C2t8D8wcZDOG5HG8pCL0Xb8uBsJk/Ll7ojk60I
         pA909G/9AGTA9ieERmeHsA6pA0jxA2iXPOVgtyAifvG2vpa3Bs1UMBEapeGN86weXOwC
         lmVg==
X-Gm-Message-State: ABuFfojA0Fg5Hg71dGhuFWB1zUzWAnYVn2eoLrbK9IGpzS/xk1ljot+j
        e0mtW8McHxqvjxG3C58X2vkD6UQbrkU=
X-Google-Smtp-Source: ACcGV62/n3doEd9vvnUJApMh4uqaSyOX2TiNbmOxDRVmKAOhkVSdp8tywEv46BLScRUnCtlktVBxaw==
X-Received: by 2002:a2e:215a:: with SMTP id h87-v6mr16393714ljh.102.1539728926655;
        Tue, 16 Oct 2018 15:28:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a18-v6sm3427071ljk.80.2018.10.16.15.28.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:28:45 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p143-v6so7214740lfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:28:44 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr13188603lfc.16.1539728924223;
 Tue, 16 Oct 2018 15:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org> <1539005138-32560-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1539005138-32560-3-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 16 Oct 2018 15:28:07 -0700
X-Gmail-Original-Message-ID: <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
Message-ID: <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:26 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 6918e70..1eb70c0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -234,6 +234,7 @@ struct sdhci_msm_variant_ops {
>   */
>  struct sdhci_msm_variant_info {
>         bool mci_removed;
> +       bool uses_sdcdc10;

What does that flag mean? Couldn't this just be called something like
restore_dll_config?

>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
>  };
> @@ -264,6 +265,8 @@ struct sdhci_msm_host {
>         u32 vmmc_level[2];
>         bool vqmmc_load;
>         u32 vqmmc_level[2];
> +       bool uses_sdcdc10_dll;
> +       bool restore_sdr_dll_cfg;

restore_sdr_dll_cfg appears to not be used.

>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1031,6 +1034,36 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>         return ret;
>  }
>
> +static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
> +{
> +       struct mmc_ios ios = host->mmc->ios;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       /*
> +        * SDR DLL comes into picure only if clock frequency is greater than
> +        * 100MHz. And its needed only for SDR104, HS200 and HS400 cards.
> +        * Its not needed for HS400es cards.
> +        */
> +       if (host->clock <= CORE_FREQ_100MHZ ||
> +           !(ios.timing == MMC_TIMING_MMC_HS400 ||
> +           ios.timing == MMC_TIMING_MMC_HS200 ||
> +           ios.timing == MMC_TIMING_UHS_SDR104) ||
> +           ios.enhanced_strobe)
> +               return 0;
> +
> +       /* Reset the tuning block */
> +       ret = msm_init_cm_dll(host);

Is this reinit required? It's kind of meaty.

> +       if (ret)
> +               return ret;
> +
> +       /* Restore the tuning block */
> +       ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
> +
> +       return ret;
> +}
> +
>  static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -1075,7 +1108,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 if (rc)
>                         return rc;
>
> -               msm_host->saved_tuning_phase = phase;
>                 rc = mmc_send_tuning(mmc, opcode, NULL);
>                 if (!rc) {
>                         /* Tuning is successful at this tuning point */
> @@ -1100,6 +1132,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 rc = msm_config_cm_dll_phase(host, phase);
>                 if (rc)
>                         return rc;
> +               msm_host->saved_tuning_phase = phase;
>                 dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>                          mmc_hostname(mmc), phase);
>         } else {
> @@ -1807,19 +1840,39 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
>
>  static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>         .mci_removed = false,
> +       .uses_sdcdc10 = false,
> +       .var_ops = &mci_var_ops,
> +       .offset = &sdhci_msm_mci_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_mci_sdcdc10_var = {
> +       .mci_removed = false,
> +       .uses_sdcdc10 = true,
>         .var_ops = &mci_var_ops,
>         .offset = &sdhci_msm_mci_offset,
>  };
>
>  static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>         .mci_removed = true,
> +       .uses_sdcdc10 = false,
> +       .var_ops = &v5_var_ops,
> +       .offset = &sdhci_msm_v5_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_v5_sdcdc10_var = {
> +       .mci_removed = true,
> +       .uses_sdcdc10 = true,
>         .var_ops = &v5_var_ops,
>         .offset = &sdhci_msm_v5_offset,
>  };
>
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
> +       {.compatible = "qcom,sdhci-msm-v4-sdcdc10",
> +                                           .data = &sdhci_msm_mci_sdcdc10_var},
>         {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
> +       {.compatible = "qcom,sdhci-msm-v5-sdcdc10",
> +                                           .data = &sdhci_msm_v5_sdcdc10_var},
>         {},
>  };
>
> @@ -1880,6 +1933,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         var_info = of_device_get_match_data(&pdev->dev);
>
>         msm_host->mci_removed = var_info->mci_removed;
> +       msm_host->uses_sdcdc10_dll = var_info->uses_sdcdc10;
>         msm_host->var_ops = var_info->var_ops;
>         msm_host->offset = var_info->offset;
>
> @@ -2124,9 +2178,18 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
>
> -       return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>                                        msm_host->bulk_clks);

It might be nicer to just put an if (ret) return ret; here, instead of
rolling it into the next conditional.

> +       /*
> +        * Whenever core-clock is gated dynamically, it's needed to
> +        * restore the SDR DLL settings when the clock is ungated.
> +        */
> +       if (!ret && msm_host->uses_sdcdc10_dll && msm_host->clk_rate)
> +               ret = sdhci_msm_restore_sdr_dll_config(host);
> +
> +       return ret;
>  }
>  #endif
>
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
