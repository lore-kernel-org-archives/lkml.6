Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D08BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891F21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ia/AA+YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0891F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbeIVB7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:59:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37030 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbeIVB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:59:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so12986814ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+BSJ2tuav+b9ZW+KMyDw7Bg3ZiHYzuj2cR1M0NTFbk=;
        b=ia/AA+YUNHFZMNAd87m56981xiKMVI/573oScCjgcreQnlrB563qWG09bIKtMbiFnY
         S2hMkLD5Ly85DCcSM0O8NoH4e77yEdTDYdrGBPw881N7HpBJFDMKVKkL4ikUQNVXchdP
         GRHcC5dSLwWoxbdCgycaiTcTnOdw+0G1MInT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+BSJ2tuav+b9ZW+KMyDw7Bg3ZiHYzuj2cR1M0NTFbk=;
        b=orX95EP0sWy/ZTqQESxDZxFZQWV2wVMLUh6qT40SeCHfHjKkMA9VvPyK72siLFAByl
         m/jR8/8rHoMa+waZclBnHA5b9sGNr73lfxVQFGwmhsBALkfWnCQTbxhGyF9fC2PNdiNe
         F90uGNzBwAQVQUCyZwaQZZsqY2ooY0dLBZLujsR9u2pvsbcXkwnK192lBBDwxOw3MnIL
         fapM9m2FYB8QlSIbxC6UDbobetaf71cTy9fSmdtqn80oPb19H/TIzQoKEcn8vGToAmj5
         uAG48gDEBa5ke3qZ7huTS9mFwlcYhO+8TNg/qvzSZq5E3kAtdg0IU/w+6CEz/7cHl581
         26xA==
X-Gm-Message-State: APzg51CnD/9D8ooFUx7HN2zLLCCSHbVV3vT2Sj9lWJLOvQ3F4i2bDtD1
        Pxp8wwgRlqTYSlmx5Bc+nJ3v8H6dEj0=
X-Google-Smtp-Source: ANB0Vdbw7vQyh5A2iRIeFOnaMBvznjfIKh5AE4Wj2zjBNjm/z5/wyYSTnaiAVzjeEjM+QM1dK1jMFA==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr3610921ljc.145.1537560563256;
        Fri, 21 Sep 2018 13:09:23 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h16-v6sm5235187ljh.26.2018.09.21.13.09.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:09:23 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y17-v6so12970441ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:09:22 -0700 (PDT)
X-Received: by 2002:a2e:8103:: with SMTP id d3-v6mr3401992ljg.3.1537560561575;
 Fri, 21 Sep 2018 13:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org> <1537424558-17989-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1537424558-17989-2-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 21 Sep 2018 13:08:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft7k6gsX-xbW1cr+z2SYeHh=zbmNoUxxXOuG9zZz+DYcWQ@mail.gmail.com>
Message-ID: <CAE=gft7k6gsX-xbW1cr+z2SYeHh=zbmNoUxxXOuG9zZz+DYcWQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] mmc: sdhci: Allow platform controlled voltage switching
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        linux-kernel@vger.kernel.org
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
>  drivers/mmc/host/sdhci.c | 22 +++++++++++++++-------
>  drivers/mmc/host/sdhci.h |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae5..04b3fd2 100644
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
> +       if (!mmc->supply.vmmc) {
> +               ret = mmc_regulator_get_supply(mmc);
> +               if (ret)
> +                       return ret;
> +               enable_vqmmc  = true;

The coupling of logic strikes me as a little bit odd, it's saying if
vmmc is already present, then don't turn on vqmmc. I guess what it's
trying to say is "hands off all the regulators, I've got this". It
might be cleaner to set enable_vqmmc based on whether or not
mmc->supply.vqmmc exists before the get_supply call, rather than
coupling it into whether or not vmmc exists.

Actually, what might be even nicer is to change
mmc_regulator_get_supply to only get supplies that it doesn't already
have. You'd still have your enable_vqmmc local, but the
mmc_regulator_get_supply call would be outside the conditional, and
the logic of "don't enable vqmmc if it existed before" would make more
sense.

> +       }
>
>         DBG("Version:   0x%08x | Present:  0x%08x\n",
>             sdhci_readw(host, SDHCI_HOST_VERSION),
> @@ -3880,7 +3884,11 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> -               ret = regulator_enable(mmc->supply.vqmmc);
> +               if (enable_vqmmc) {
> +                       ret = regulator_enable(mmc->supply.vqmmc);
> +                       host->vqmmc_enabled = !ret;
> +               } else
> +                       ret = 0;

I think it's preferred that if your "if" had curly braces, then the
else part needs it too. Actually, can you move the if (ret) pr_warn
stuff up and inside of your if statement above? That keeps the logic
together, and then you don't need an else case at all!

>
>                 /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>                 if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
> @@ -4136,7 +4144,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>         return 0;
>
>  unreg:
> -       if (!IS_ERR(mmc->supply.vqmmc))
> +       if (host->vqmmc_enabled)
>                 regulator_disable(mmc->supply.vqmmc);
>  undma:
>         if (host->align_buffer)
> @@ -4154,7 +4162,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
>
> -       if (!IS_ERR(mmc->supply.vqmmc))
> +       if (host->vqmmc_enabled)
>                 regulator_disable(mmc->supply.vqmmc);
>
>         if (host->align_buffer)
> @@ -4287,7 +4295,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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

This is kind of unpleasant. It's confused by the fact that other host
controllers have a vqmmc_enabled member, but they use it to mean what
it sounds like, "is vqmmc currently enabled". Here you're really using
it to mean "don't ever disable vqmmc in sdhci, because the platform
code sort of owns vqmmc". It only "sort of" owns it in that sdhci is
still free to call regulator_is_supported_voltage and
mmc_regulator_set_vqmmc, but somehow not regulator_disable. Is there
any way to clean up the semantics here?

>
>         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>         struct mmc_command *cmd;        /* Current command */
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
