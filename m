Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E16FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6BC2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PHdd8CnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6BC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJQGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:07:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38862 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:07:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id v7-v6so22432816ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6JbG2sp0e0IFeWUIUaiWIJ7cuieKbtdn1VVTtOKY7k=;
        b=PHdd8CnOj8A1EFhkUrsgtNFDaue8m6u8+4MN67/TLISRZCsD97dB/FvNDojVKtOL/g
         eb2BhrD2ju89L0UpjvETZYghfIpnBZdTGK+3PAchB/Sj87D49wZx3o6OqYRIh3coNnq1
         6kmO+HZG8pO4DooGAfbpQescAMwGFZhvZr3Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6JbG2sp0e0IFeWUIUaiWIJ7cuieKbtdn1VVTtOKY7k=;
        b=l3O57hmZX4wSvnipNyxGOk40OODB/Bei3B6AUqCQLzWWy4djlNfSM6yT3FBMmsIU5o
         NFIwAPZR1c2EIUJJKW+YUB/xQlLwVNodHCFDYxbN4FsY35OcG7OTYU2j7Gv3K+3ySeRm
         ijdrzOmYq3L1ZR43WjbBF2bDq8ks36+oJBEBD7rKr/5PJIV0RCfFvihCoVPo4hymAeUw
         KjKxHRf0FE23Niy0CVWZEpel3HNGbdRP4LuoFUuGUiSdpOpUjoB0QWO6e/tGTrLL54xN
         iVwwAni56jTCfS0aJzKj1VzBYkFplk00JIqqCUiw3E7R73CNvdSlTXhbkay1aS2gCLI6
         Xw5g==
X-Gm-Message-State: ABuFfohpXuec1NjVQjEb+Oh/IBkU/4IQ97TTFvx6Et1BSUAkJgpByfXN
        F6cprQjEjwchj6rR4QrvaQhIdMe+ss4=
X-Google-Smtp-Source: ACcGV61Dqf3JBmTaDfPIWOdjxDvyfcuwWmwB0YisEIxej9Jtt5OEJCPaPg0BD1aRs/Ze3bSpEW5hnA==
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr13330919ljh.154.1539728118629;
        Tue, 16 Oct 2018 15:15:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a2-v6sm3264171lfi.23.2018.10.16.15.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:15:18 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d4-v6so18257509lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:15:18 -0700 (PDT)
X-Received: by 2002:a19:274b:: with SMTP id n72-v6mr13444803lfn.153.1539727792369;
 Tue, 16 Oct 2018 15:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org> <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 16 Oct 2018 15:09:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
Message-ID: <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage switching
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, Doug Anderson <dianders@google.com>,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vviswana@codeaurora.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:22 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Vijay Viswanath <vviswana@codeaurora.org>
>
> Some controllers can have internal mechanism to inform the SW that it
> is ready for voltage switching. For such controllers, changing voltage
> before the HW is ready can result in various issues.
>
> During setup/cleanup of host, check whether regulator enable/disable
> was already done by platform driver.
>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++-------------
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae5..ea7ce1d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3616,6 +3616,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>         unsigned int override_timeout_clk;
>         u32 max_clk;
>         int ret;
> +       bool enable_vqmmc = false;
>
>         WARN_ON(host == NULL);
>         if (host == NULL)
> @@ -3629,9 +3630,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>          * the host can take the appropriate action if regulators are not
>          * available.
>          */
> -       ret = mmc_regulator_get_supply(mmc);
> -       if (ret)
> -               return ret;
> +       if (!mmc->supply.vqmmc) {
> +               ret = mmc_regulator_get_supply(mmc);
> +               if (ret)
> +                       return ret;
> +               enable_vqmmc  = true;
> +       }

Did you not like my suggestion in the previous patch of changing
mmc_regulator_get_supply to only get supplies that were not set
previously? What you have here is almost the same, except you've got
this weird coupling where if vqmmc is already present, you implicitly
skip looking at vmmc entirely (since mmc_regulator_get_supply does
more than just get vqmmc).

>
>         DBG("Version:   0x%08x | Present:  0x%08x\n",
>             sdhci_readw(host, SDHCI_HOST_VERSION),
> @@ -3880,7 +3884,15 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> -               ret = regulator_enable(mmc->supply.vqmmc);
> +               if (enable_vqmmc) {
> +                       ret = regulator_enable(mmc->supply.vqmmc);
> +                       if (ret) {
> +                               pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
> +                                       mmc_hostname(mmc), ret);
> +                               mmc->supply.vqmmc = ERR_PTR(-EINVAL);
> +                       }
> +                       host->vqmmc_enabled = !ret;
> +               }
>
>                 /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>                 if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
> @@ -3893,12 +3905,6 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
>                                                     3600000))
>                         host->flags &= ~SDHCI_SIGNALING_330;
> -
> -               if (ret) {
> -                       pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
> -                               mmc_hostname(mmc), ret);
> -                       mmc->supply.vqmmc = ERR_PTR(-EINVAL);
> -               }
>         }
>
>         if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
> @@ -4136,7 +4142,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>         return 0;
>
>  unreg:
> -       if (!IS_ERR(mmc->supply.vqmmc))
> +       if (host->vqmmc_enabled)
>                 regulator_disable(mmc->supply.vqmmc);
>  undma:
>         if (host->align_buffer)
> @@ -4154,7 +4160,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
>
> -       if (!IS_ERR(mmc->supply.vqmmc))
> +       if (host->vqmmc_enabled)
>                 regulator_disable(mmc->supply.vqmmc);
>
>         if (host->align_buffer)
> @@ -4287,7 +4293,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>
>         tasklet_kill(&host->finish_tasklet);
>
> -       if (!IS_ERR(mmc->supply.vqmmc))
> +       if (host->vqmmc_enabled)
>                 regulator_disable(mmc->supply.vqmmc);
>
>         if (host->align_buffer)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b001cf4..3c28152 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -524,6 +524,7 @@ struct sdhci_host {
>         bool pending_reset;     /* Cmd/data reset is pending */
>         bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>         bool v4_mode;           /* Host Version 4 Enable */
> +       bool vqmmc_enabled;     /* Vqmmc is enabled */

I still don't love this, since it doesn't mean what it says. Everyone
else that has a vqmmc_enabled member uses it to actually mean "vqmmc
is enabled", but this doesn't mean that. For example, you don't clear
this when you disable the regulator in patch 3, so this would be set
even if the regulator is disabled, and you don't set it when sdhci
enables the regulator, so the regulator is on when this flag is not
set.

At the very least, I think a rename is in order. I'm struggling with
the rename, since
"vqmmc_pltfrm_enable_but_feel_free_to_call_set_voltage_anywhere" is
too long. I guess vqmmc_pltfrm_enabled is the best I've got for now.

>
>         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>         struct mmc_command *cmd;        /* Current command */
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
