Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A010C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0783020989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGLdF5bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfA2Obv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:31:51 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44263 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfA2Obv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:31:51 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so12029785vsp.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZM6OVgxv/IBmtJypwoYcCJZu0u9rAyQfSsjwtcLSkM=;
        b=dGLdF5bXTIm9Lr3os3sri+AADTTshoVLNLq3wu64hl7s5JVkNOxDHFNh/v1+O7/BOE
         e1xI/A4xH4KP/wGAbJalszKC2cmfAgIVFOc2YzBfK7MBygoGDTD5nmJVRgX0qxjtyurf
         0NNnBB6Wq5LyvrJ6EgDr25Sx0NO10Xc0Mto6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZM6OVgxv/IBmtJypwoYcCJZu0u9rAyQfSsjwtcLSkM=;
        b=sHBZA2yEDqdOTAAzb82Yir8s9tyTZ8JYH2ZYvEO59IoXOMw6eEue3pC4GSj0HKDj6e
         yKFKGdEXh6n3+p2u0ULDgvGCBuKdQ4bSroIAF27w5txOALVosLN/uNYNvwJGXHJ982Ps
         BUaCiai9P03qaeCBjo2yO8cmvWylVPtMjuvLMrVgAGnCEX7e+Bx/rugBkfnTLxAOrx91
         DfHtEpsTo7CgCmgnrh2aagsmVFXmdheiru6N6FqoSTPlQCcwwz41Kj8cAw4aIJTMGYFa
         Rj1dxheW4PMvxMGXEXKTfqfqp/TMcOLbQ9XWTJLuBG7RCbmSSZdpX8aV8jUTncW6cqin
         tD9w==
X-Gm-Message-State: AJcUukfSM1BNtTmapxYX+UCRMr7Ib2JcVnWBAN1D8AysR8QsAEwFw34r
        QQh7oN9VON/TFZGRu3fNf0KSpkG0CJ8sy6sedjilqp02
X-Google-Smtp-Source: ALg8bN5SaNX6wpE3yPb8T94cks8htxcsY1y8H73reD0IgY6DGw6mMeWXRcn6W4aWJKWQuAHw2auvp0v0FgpK6g7XT3U=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10779714vsh.200.1548772309791;
 Tue, 29 Jan 2019 06:31:49 -0800 (PST)
MIME-Version: 1.0
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com> <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jan 2019 15:31:12 +0100
Message-ID: <CAPDyKFoqjNZXgAGQe+aT4xE=7Q69msowambNNM+6qGWjXa9Qmg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: mmci: send stop command to clear the dpsm
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The current approach with sending a CMD12 (STOP_TRANSMISSION) to
> complete a data transfer request, either because of using the open
> ended transmission type or because of receiving an error during a data
> transfer, isn't sufficient for the STM32 sdmmc variant.
>
> More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine")
> needs to be cleared by sending a CMD12, also for the so called ADTC
> commands. For this reason, let the driver send a CMD12 to complete
> ADTC commands, in case it's set (depend of cmdreg_stop variant property).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  2 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e352f5a..4e5643d 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -58,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
>  #else
>  static inline void sdmmc_variant_init(struct mmci_host *host) {}
>  #endif
> +static void
> +mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
>
>  static unsigned int fmax = 515633;
>
> @@ -572,9 +574,37 @@ void mmci_dma_error(struct mmci_host *host)
>                 host->ops->dma_error(host);
>  }
>
> +static int mmci_stop_command(struct mmci_host *host, struct mmc_request *mrq)
> +{
> +       u32 dpsm;
> +
> +       /*
> +        * If an error happens on command or data transmission
> +        * the DPSM stay enabled. The CPSM required a stop command
> +        * to reinitialize the DPSM.
> +        */
> +       dpsm = readl_relaxed(host->base + MMCISTATUS);
> +       dpsm &= MCI_STM32_DPSMACTIVE;
> +
> +       if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
> +                    (mrq->data && mrq->data->error))) {
> +               mmci_start_command(host, &host->stop_abort, 0);
> +               return -EBUSY;
> +       }

Unless I have got it wrong, I think there are several problems with
the above code and how you call it.

1) We may be reading the MMCISTATUS register when we don't need to
(because there are no errors).

2) Nothing prevents keep sending the CMD12 over and over again, for
the same request. This could happen, as long as the
MCI_STM32_DPSMACTIVE remains set. I guess it simply shouldn't happen,
but I rather prevent this being possible altogether, as to avoid a
potential hang. It's better to propagate errors.

3) There is a scenario when the DPSM has been enabled, while we fail
with the "sbc" command, this isn't covered, but I think should, right?

4) host->stop_abort.error needs to be reset to zero, in-between
sending the internal CMD12 command. Otherwise, we may end up re-using
an error code from a failed CMD12 command, over and over again.

> +
> +       return 0;
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       /*
> +        * For variant with cmdstop bit, a stop command could be needed
> +        * to finish the request.
> +        */
> +       if (host->variant->cmdreg_stop && mmci_stop_command(host, mrq))
> +               return;
> +
>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1956,6 +1986,13 @@ static int mmci_probe(struct amba_device *dev,
>                 mmc->max_busy_timeout = 0;
>         }
>
> +       /* prepare the stop command, used to abort and reinitialized the DPSM */
> +       if (variant->cmdreg_stop) {
> +               host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
> +               host->stop_abort.arg = 0;
> +               host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
> +       }
> +
>         mmc->ops = &mmci_ops;
>
>         /* We support these PM capabilities. */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 2422909..35372cd 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -161,6 +161,7 @@
>  #define MCI_ST_CEATAEND                (1 << 23)
>  #define MCI_ST_CARDBUSY                (1 << 24)
>  /* Extended status bits for the STM32 variants */
> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>  #define MCI_STM32_BUSYD0       BIT(20)
>
>  #define MMCICLEAR              0x038
> @@ -377,6 +378,7 @@ struct mmci_host {
>         void __iomem            *base;
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
> +       struct mmc_command      stop_abort;
>         struct mmc_data         *data;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
> --
> 2.7.4
>

To fix the issues I pointed out above, I decided to try out something
myself. So, I will post a patch in a few minutes, can you please give
it try at your end?

Kind regards
Uffe
