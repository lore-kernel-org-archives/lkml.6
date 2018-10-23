Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B1CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1C7207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N6jNKXQm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iu6gY1J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1C7207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeJWUgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:36:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32972 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:36:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B194160BDE; Tue, 23 Oct 2018 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540296810;
        bh=LGd3pdIQnNSaMT0A5cA25FVM4y1/CBogXgOcKKVA4KU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N6jNKXQmsKVL3IMuOmFVnnoWEj8pF/nOT132PSCq6EEus4yn9IWG4D5EGDaMqdPww
         jdtEOve3jMis7vs0Gs0Pb0sco4RmCh2WWnvTBhnEybnowF1O0yAlppE7OOEisiewu0
         gtLZ3Q/XJH/sVbDX5UeciuTM+In/9a8+zLCYfObI=
Received: from [10.252.221.155] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BBE960364;
        Tue, 23 Oct 2018 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540296809;
        bh=LGd3pdIQnNSaMT0A5cA25FVM4y1/CBogXgOcKKVA4KU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iu6gY1J/h5CBxjXM93bIoM8lQcVCeHngfzdIkoZR0L+8M9xyqNCsTBabQw1qCz3If
         U/t1mgLqigD4ae4VkaGE3c6Gmo5TWlmmPvq27BTtWK5YnsxV40DRPobFeSStGUgVS/
         781hcFIeuSsQKszx0OEdG6mTmjXw/eKCV/DkjSi0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BBE960364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated
 dynamically
To:     Evan Green <evgreen@chromium.org>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
 <1539005138-32560-3-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <f816f58d-19f0-b0c9-40bb-3e436f0968a7@codeaurora.org>
Date:   Tue, 23 Oct 2018 17:43:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4tWoMTUwvLWLL6k0x1AqbBTM=5=dAckEEHiu6zLXskGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/2018 3:58 AM, Evan Green wrote:
> On Mon, Oct 8, 2018 at 6:26 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> On few SDHCI-MSM controllers, the host controller's clock tuning
>> circuit may go out of sync if controller clocks are gated which
>> eventually will result in data CRC, command CRC/timeout errors.
>> To overcome this h/w limitation, the DLL needs to be re-initialized
>> and restored with its old settings once clocks are ungated.
>>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 67 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 6918e70..1eb70c0 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -234,6 +234,7 @@ struct sdhci_msm_variant_ops {
>>    */
>>   struct sdhci_msm_variant_info {
>>          bool mci_removed;
>> +       bool uses_sdcdc10;
> What does that flag mean? Couldn't this just be called something like
> restore_dll_config?

'sdcdc10' is the DLL code-name that is being used in SDHC controller on 
SDM845.
I should have named it as uses_sdcdc10_dll.
I will update the name to be more meaningful.

>
>>          const struct sdhci_msm_variant_ops *var_ops;
>>          const struct sdhci_msm_offset *offset;
>>   };
>> @@ -264,6 +265,8 @@ struct sdhci_msm_host {
>>          u32 vmmc_level[2];
>>          bool vqmmc_load;
>>          u32 vqmmc_level[2];
>> +       bool uses_sdcdc10_dll;
>> +       bool restore_sdr_dll_cfg;
> restore_sdr_dll_cfg appears to not be used.

Yes, this needs to be removed, will remove it. Thanks for pointing.

>>   };
>>
>>   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
>> @@ -1031,6 +1034,36 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>>          return ret;
>>   }
>>
>> +static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
>> +{
>> +       struct mmc_ios ios = host->mmc->ios;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       int ret;
>> +
>> +       /*
>> +        * SDR DLL comes into picure only if clock frequency is greater than
>> +        * 100MHz. And its needed only for SDR104, HS200 and HS400 cards.
>> +        * Its not needed for HS400es cards.
>> +        */
>> +       if (host->clock <= CORE_FREQ_100MHZ ||
>> +           !(ios.timing == MMC_TIMING_MMC_HS400 ||
>> +           ios.timing == MMC_TIMING_MMC_HS200 ||
>> +           ios.timing == MMC_TIMING_UHS_SDR104) ||
>> +           ios.enhanced_strobe)
>> +               return 0;
>> +
>> +       /* Reset the tuning block */
>> +       ret = msm_init_cm_dll(host);
> Is this reinit required? It's kind of meaty.

DLL re-initialization is very-much needed.
Its as per DLL h/w team instructions to support sdcdc10 DLL (10nm DLL)

>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Restore the tuning block */
>> +       ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
>> +
>> +       return ret;
>> +}
>> +
>>   static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>   {
>>          struct sdhci_host *host = mmc_priv(mmc);
>> @@ -1075,7 +1108,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                  if (rc)
>>                          return rc;
>>
>> -               msm_host->saved_tuning_phase = phase;
>>                  rc = mmc_send_tuning(mmc, opcode, NULL);
>>                  if (!rc) {
>>                          /* Tuning is successful at this tuning point */
>> @@ -1100,6 +1132,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                  rc = msm_config_cm_dll_phase(host, phase);
>>                  if (rc)
>>                          return rc;
>> +               msm_host->saved_tuning_phase = phase;
>>                  dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>>                           mmc_hostname(mmc), phase);
>>          } else {
>> @@ -1807,19 +1840,39 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
>>
>>   static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>>          .mci_removed = false,
>> +       .uses_sdcdc10 = false,
>> +       .var_ops = &mci_var_ops,
>> +       .offset = &sdhci_msm_mci_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_mci_sdcdc10_var = {
>> +       .mci_removed = false,
>> +       .uses_sdcdc10 = true,
>>          .var_ops = &mci_var_ops,
>>          .offset = &sdhci_msm_mci_offset,
>>   };
>>
>>   static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>>          .mci_removed = true,
>> +       .uses_sdcdc10 = false,
>> +       .var_ops = &v5_var_ops,
>> +       .offset = &sdhci_msm_v5_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_v5_sdcdc10_var = {
>> +       .mci_removed = true,
>> +       .uses_sdcdc10 = true,
>>          .var_ops = &v5_var_ops,
>>          .offset = &sdhci_msm_v5_offset,
>>   };
>>
>>   static const struct of_device_id sdhci_msm_dt_match[] = {
>>          {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>> +       {.compatible = "qcom,sdhci-msm-v4-sdcdc10",
>> +                                           .data = &sdhci_msm_mci_sdcdc10_var},
>>          {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
>> +       {.compatible = "qcom,sdhci-msm-v5-sdcdc10",
>> +                                           .data = &sdhci_msm_v5_sdcdc10_var},
>>          {},
>>   };
>>
>> @@ -1880,6 +1933,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>          var_info = of_device_get_match_data(&pdev->dev);
>>
>>          msm_host->mci_removed = var_info->mci_removed;
>> +       msm_host->uses_sdcdc10_dll = var_info->uses_sdcdc10;
>>          msm_host->var_ops = var_info->var_ops;
>>          msm_host->offset = var_info->offset;
>>
>> @@ -2124,9 +2178,18 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>          struct sdhci_host *host = dev_get_drvdata(dev);
>>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>          struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +       int ret;
>>
>> -       return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>>                                         msm_host->bulk_clks);
> It might be nicer to just put an if (ret) return ret; here, instead of
> rolling it into the next conditional.

Sure. Will update it.

>
>> +       /*
>> +        * Whenever core-clock is gated dynamically, it's needed to
>> +        * restore the SDR DLL settings when the clock is ungated.
>> +        */
>> +       if (!ret && msm_host->uses_sdcdc10_dll && msm_host->clk_rate)
>> +               ret = sdhci_msm_restore_sdr_dll_config(host);
>> +
>> +       return ret;
>>   }
>>   #endif
>>
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>

