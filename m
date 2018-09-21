Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8028AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B69921479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wu17u2VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B69921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbeIVCAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:00:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43636 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391379AbeIVCAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:00:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id m84-v6so12955335lje.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YxlSywtCN2UHo5Eu8ka4WVPkHcpkmvZKUXH4DiP7/w=;
        b=Wu17u2VQx50PZEYDv3uAYyZ+AhLYYXB+p2w+Rl/gyYfW82LfFBXENgbG06IEzNHgRA
         wh9tRRKVYwRzBXGXCmb44wBl/SJ170qKj8NRg/uWAHJw7eORCwTN5EsTjzctRvGrCAeF
         +jo22dlvRH6kDLuWF/yO5PW9BZG/uWq8OTQhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YxlSywtCN2UHo5Eu8ka4WVPkHcpkmvZKUXH4DiP7/w=;
        b=H8+WDUxMi3nRVsVcZdVr7+9yRAZ6Jvmpkyv9SAO0KQyJw4dqKpp5BU6RT8giz8C1nW
         J7EgGvDmqrNUDwpTPhsq37eItImTzzLFk/RVYLKjzF1y4FitLsNYdnOwiMzVnXrcpCTk
         9iuBK6j4eeb8PYNHPb2oJYydkNQe0uSed/s5njaQMNfNKGfVL0DEQR0/Pfba6Z+K/ih/
         JIHK8/h99ZRhu1SNVKErplvCrzhbImZasvTnBPYxrgN1Zd65EcWQ6oYjGXsZC2mR31Pv
         PpG7W3BvlHrRLh1/5wzYdiGPlt7DsXGQNUslWvi0tWG7ApxSOFpcpv4HykokqoePvdnc
         C95w==
X-Gm-Message-State: ABuFfoh1wUWP/JMb6zG0LZxympptuBdKQVVcEcJ0OlxiG+sw68xmO2gm
        2Wus5+e95LK0hxFJEh5veQMZdR7MR3Y=
X-Google-Smtp-Source: ACcGV62HV60SsB+UJ092I7r1j0VUD9LDwDsg/hXM+u2rXkyipj9qdpZ2s8tw42rGInWiNGYfncBa/w==
X-Received: by 2002:a2e:6c17:: with SMTP id h23-v6mr3326623ljc.81.1537560626005;
        Fri, 21 Sep 2018 13:10:26 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m8-v6sm5147761ljj.10.2018.09.21.13.10.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:10:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y17-v6so12973931ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:10:24 -0700 (PDT)
X-Received: by 2002:a2e:5554:: with SMTP id j81-v6mr788822ljb.53.1537560624224;
 Fri, 21 Sep 2018 13:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org> <1537424558-17989-4-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1537424558-17989-4-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 21 Sep 2018 13:09:46 -0700
X-Gmail-Original-Message-ID: <CAE=gft483AkgBcF5P5EADzWFmjSqsxhzKjoQfmKxmrHyWSBApQ@mail.gmail.com>
Message-ID: <CAE=gft483AkgBcF5P5EADzWFmjSqsxhzKjoQfmKxmrHyWSBApQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] mmc: sdhci-msm: Use internal voltage control
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        venkatg@codeaurora.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Vijay Viswanath <vviswana@codeaurora.org>
>
> Some sdhci-msm controllers require that voltage switching be done after
> the HW is ready for it. The HW informs its readiness through power irq.
> The voltage switching should happen only then.
>
> Use the quirk for internal voltage switching and then control the
> voltage switching using power irq.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 211 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 203 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3cc8bfe..486462d 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -43,7 +43,9 @@
>  #define CORE_PWRCTL_IO_LOW     BIT(2)
>  #define CORE_PWRCTL_IO_HIGH    BIT(3)
>  #define CORE_PWRCTL_BUS_SUCCESS BIT(0)
> +#define CORE_PWRCTL_BUS_FAIL    BIT(1)
>  #define CORE_PWRCTL_IO_SUCCESS BIT(2)
> +#define CORE_PWRCTL_IO_FAIL     BIT(3)
>  #define REQ_BUS_OFF            BIT(0)
>  #define REQ_BUS_ON             BIT(1)
>  #define REQ_IO_LOW             BIT(2)
> @@ -258,6 +260,10 @@ struct sdhci_msm_host {
>         bool mci_removed;
>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
> +       bool vmmc_load;
> +       u32 vmmc_level[2];
> +       bool vqmmc_load;
> +       u32 vqmmc_level[2];
>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1211,6 +1217,74 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>                 sdhci_msm_hs400(host, &mmc->ios);
>  }
>
> +static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
> +                             struct mmc_host *mmc, int level)
> +{
> +       int load = msm_host->vmmc_level[level];
> +       int ret;
> +
> +       if (IS_ERR(mmc->supply.vmmc))
> +               return 0;
> +
> +       if (msm_host->vmmc_load) {
> +               ret = regulator_set_load(mmc->supply.vmmc, load);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);

This is new, isn't it? Could you explain why this is needed?

> +out:
> +       if (ret)
> +               pr_err("%s: vmmc set load/ocr failed: %d\n",
> +                               mmc_hostname(mmc), ret);
> +
> +       return ret;
> +}
> +
> +static int sdhci_msm_set_vqmmc(struct sdhci_msm_host *msm_host,
> +                             struct mmc_host *mmc, int level)
> +{
> +       int load = msm_host->vqmmc_level[level];
> +       int ret;
> +       struct mmc_ios ios;
> +
> +       if (IS_ERR(mmc->supply.vqmmc))
> +               return 0;
> +
> +       if (msm_host->vqmmc_load) {
> +               ret = regulator_set_load(mmc->supply.vqmmc, load);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       /*
> +        * The IO voltage regulator maynot always support a voltage close to

s/maynot/may not/

> +        * vdd. Set IO voltage based on  capability of the regulator.

remove extra space between on and capability.

> +        */
> +       if (level) {
> +               if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> +                       ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
> +               else if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
> +                       ios.signal_voltage = MMC_SIGNAL_VOLTAGE_180;
> +               if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
> +                       pr_debug("%s: %s: setting signal voltage: %d\n",
> +                                       mmc_hostname(mmc), __func__,
> +                                       ios.signal_voltage);
> +                       ret = mmc_regulator_set_vqmmc(mmc, &ios);
> +                       if (ret)
> +                               goto out;
> +               }
> +               ret = regulator_enable(mmc->supply.vqmmc);
> +       } else {
> +               ret = regulator_disable(mmc->supply.vqmmc);
> +       }
> +out:
> +       if (ret)
> +               pr_err("%s: vqmmc failed: %d\n", mmc_hostname(mmc), ret);
> +
> +       return ret;
> +}
> +
>  static inline void sdhci_msm_init_pwr_irq_wait(struct sdhci_msm_host *msm_host)
>  {
>         init_waitqueue_head(&msm_host->pwr_irq_wait);
> @@ -1314,8 +1388,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_host *mmc = host->mmc;
>         u32 irq_status, irq_ack = 0;
> -       int retry = 10;
> +       int retry = 10, ret = 0;
>         u32 pwr_state = 0, io_level = 0;
>         u32 config;
>         const struct sdhci_msm_offset *msm_offset = msm_host->offset;
> @@ -1351,14 +1426,34 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>
>         /* Handle BUS ON/OFF*/
>         if (irq_status & CORE_PWRCTL_BUS_ON) {
> -               pwr_state = REQ_BUS_ON;
> -               io_level = REQ_IO_HIGH;
> -               irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +               ret = sdhci_msm_set_vmmc(msm_host, mmc, 1);
> +               if (!ret)
> +                       ret = sdhci_msm_set_vqmmc(msm_host, mmc, 1);

Should you put vmmc back to 0 if setting vqmmc to 1 fails?

> +
> +               if (!ret) {
> +                       pwr_state = REQ_BUS_ON;
> +                       io_level = REQ_IO_HIGH;
> +                       irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +               } else {
> +                       pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
> +                                       mmc_hostname(mmc), ret, irq_status);
> +                       irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +               }
>         }
>         if (irq_status & CORE_PWRCTL_BUS_OFF) {
> -               pwr_state = REQ_BUS_OFF;
> -               io_level = REQ_IO_LOW;
> -               irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +               ret = sdhci_msm_set_vmmc(msm_host, mmc, 0);
> +               if (!ret)
> +                       ret = sdhci_msm_set_vqmmc(msm_host, mmc, 0);
> +
> +               if (!ret) {
> +                       pwr_state = REQ_BUS_OFF;
> +                       io_level = REQ_IO_LOW;
> +                       irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> +               } else {
> +                       pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
> +                                       mmc_hostname(mmc), ret, irq_status);
> +                       irq_ack |= CORE_PWRCTL_BUS_FAIL;
> +               }
>         }
>         /* Handle IO LOW/HIGH */
>         if (irq_status & CORE_PWRCTL_IO_LOW) {
> @@ -1370,6 +1465,15 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>                 irq_ack |= CORE_PWRCTL_IO_SUCCESS;
>         }
>
> +       if (io_level && !IS_ERR(mmc->supply.vqmmc) && !pwr_state) {
> +               ret = mmc_regulator_set_vqmmc(mmc, &mmc->ios);
> +               if (ret)
> +                       pr_err("%s: IO_level setting failed(%d). signal_voltage: %d, vdd: %d irq_status: 0x%08x\n",
> +                                       mmc_hostname(mmc), ret,
> +                                       mmc->ios.signal_voltage, mmc->ios.vdd,
> +                                       irq_status);
> +       }
> +
>         /*
>          * The driver has to acknowledge the interrupt, switch voltages and
>          * report back if it succeded or not to this register. The voltage
> @@ -1605,6 +1709,91 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>         pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>
> +static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
> +{
> +       int ret = 0;
> +
> +       ret = mmc_regulator_get_supply(msm_host->mmc);
> +       if (ret)
> +               return ret;
> +       if (device_property_read_u32_array(&msm_host->pdev->dev,
> +                       "qcom,vmmc-current-level-microamp",
> +                       msm_host->vmmc_level, 2) >= 0)
> +               msm_host->vmmc_load = true;
> +       if (device_property_read_u32_array(&msm_host->pdev->dev,
> +                       "qcom,vqmmc-current-level-microamp",
> +                       msm_host->vqmmc_level, 2) >= 0)
> +               msm_host->vqmmc_load = true;
> +
> +       sdhci_msm_set_regulator_caps(msm_host);
> +
> +       return 0;
> +
> +}
> +
> +static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
> +                                     struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u16 ctrl;
> +
> +       /*
> +        * Signal Voltage Switching is only applicable for Host Controllers
> +        * v3.00 and above.
> +        */
> +       if (host->version < SDHCI_SPEC_300)
> +               return 0;
> +
> +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               if (!(host->flags & SDHCI_SIGNALING_330))
> +                       return -EINVAL;
> +               /* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +               ctrl &= ~SDHCI_CTRL_VDD_180;
> +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +               /* 3.3V regulator output should be stable within 5 ms */
> +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               if (!(ctrl & SDHCI_CTRL_VDD_180))
> +                       return 0;
> +
> +               pr_warn("%s: 3.3V regulator output did not became stable\n",
> +                       mmc_hostname(mmc));
> +
> +               return -EAGAIN;
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               if (!(host->flags & SDHCI_SIGNALING_180))
> +                       return -EINVAL;
> +
> +               /*
> +                * Enable 1.8V Signal Enable in the Host Control2
> +                * register
> +                */
> +               ctrl |= SDHCI_CTRL_VDD_180;
> +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +               /* 1.8V regulator output should be stable within 5 ms */
> +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               if (ctrl & SDHCI_CTRL_VDD_180)
> +                       return 0;
> +
> +               pr_warn("%s: 1.8V regulator output did not became stable\n",
> +                       mmc_hostname(mmc));
> +
> +               return -EAGAIN;
> +       case MMC_SIGNAL_VOLTAGE_120:
> +               if (!(host->flags & SDHCI_SIGNALING_120))
> +                       return -EINVAL;

So the state of SDHCI_CTRL_VDD_180 doesn't matter when trying to set
1.2V? I tried looking at the SDHC spec, but it was similarly silent
about 1.2V. So I guess it's fine?


> +               return 0;
> +       default:
> +               /* No signal voltage switch required */
> +               return 0;
> +       }
> +
> +}
> +
>  static const struct sdhci_msm_variant_ops mci_var_ops = {
>         .msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>         .msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
> @@ -1644,6 +1833,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>         .set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>         .write_w = sdhci_msm_writew,
>         .write_b = sdhci_msm_writeb,
> +       .set_power = sdhci_set_power_noreg,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
> @@ -1818,6 +2008,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                                 msm_offset->core_vendor_spec_capabilities0);
>         }
>
> +       ret = sdhci_msm_register_vreg(msm_host);
> +       if (ret)
> +               goto clk_disable;
> +
>         /*
>          * Power on reset state may trigger power irq if previous status of
>          * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
> @@ -1862,11 +2056,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                                          MSM_MMC_AUTOSUSPEND_DELAY_MS);
>         pm_runtime_use_autosuspend(&pdev->dev);
>
> +       host->mmc_host_ops.start_signal_voltage_switch =
> +               sdhci_msm_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto pm_runtime_disable;
> -       sdhci_msm_set_regulator_caps(msm_host);
>
>         pm_runtime_mark_last_busy(&pdev->dev);
>         pm_runtime_put_autosuspend(&pdev->dev);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
