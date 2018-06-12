Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EDAC9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2320891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGBSrvtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D2320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeFLXga (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:36:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35023 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934156AbeFLXg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:36:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so382890plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=MBLkYk+UYcukUYp+a02nL6VvNnbJn/CRGl/DZ2O7Lik=;
        b=AGBSrvtP9UCiVQIX7A52djkYTEQRhYVLOnOhfhUJngp7EI8lBrk1PAoEuNz9ix3vKU
         9xlCmF2RTIENkx77hOfsg0NUo6HLW06IfXPlX6WS1GtUE85nx1OKrI2Td4vhelbO09bq
         aFfmBuF8ILKDELXXF1+AA1eTaYF740uNNrqjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=MBLkYk+UYcukUYp+a02nL6VvNnbJn/CRGl/DZ2O7Lik=;
        b=MHlXmtjIqIyqwEE26dJVej2RQfw6fEnCWyYmjrOj5tsEV6upIJzRtLEduJN5rH1iZw
         To+JCVtFVy9f+9tdEbZNsaarcL5pNaSnyr62UTrnHkt0WEw5nffWOf9MxAyG/Vy8FXs1
         7pIte7rPui/BCwLNagq/VYVfX7WjGm55ixvw29G0W64fJle5oh8t9l2NOxKaR9adbYfZ
         r/eItzAhnI6yIobkjMu+jxmfZ19C17vxadlkdKjZulrvrXkRyS2LUeTc7dzOhusAaC7W
         5/+nYc3Qzl9jenzJ3IWloegubOHm/o4oTQEGqwfDYnAAPujEbigY68TjDk1MJ+ENekTd
         ZvFQ==
X-Gm-Message-State: APt69E1FhXbP2YZxboMpzgKuteuF7bcvZyeID6FzUfp36lprhRDoN2Mm
        DlxxHvPLDa4A6NK1udkogUi1LQ==
X-Google-Smtp-Source: ADUXVKJv41QFrHsA7UGm0QNCU3FWBbwOg7RWS2jEgfgJeyNePmfLU3ejtJvOE9MnXllF+6cR1p/mTQ==
X-Received: by 2002:a17:902:8602:: with SMTP id f2-v6mr2588892plo.5.1528846587945;
        Tue, 12 Jun 2018 16:36:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id u14-v6sm1549392pfd.103.2018.06.12.16.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:36:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vijay Viswanath <vviswana@codeaurora.org>, adrian.hunter@intel.com,
        mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
Message-ID: <152884658650.16708.8327586252448186103@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and data
 structures
Date:   Tue, 12 Jun 2018 16:36:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijay Viswanath (2018-05-29 02:52:39)
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4050c99..2a66aa0 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
>         .core_ddr_config_2 =3D 0x1bc,
>  };
>  =

> +struct sdhci_msm_variant_ops {
> +       u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> +       u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
> +       void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 o=
ffset);
> +       void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
> +                       u32 offset);
> +};
> +
> +/*
> + * From V5, register spaces have changed. Wrap this info in a structure
> + * and choose the data_structure based on version info mentioned in DT.
> + */

This is sort of odd. Usually we have a read/write function that swizzles
based on register variants, and that's contained with that function. Now
it's the other way.

> +struct sdhci_msm_variant_info {
> +       bool mci_removed;
> +       const struct sdhci_msm_variant_ops *var_ops;
> +       const struct sdhci_msm_offset *offset;
> +};
> +
>  struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
> @@ -245,8 +263,45 @@ struct sdhci_msm_host {
>         wait_queue_head_t pwr_irq_wait;
>         bool pwr_irq_flag;
>         u32 caps_0;
> +       bool mci_removed;
> +       const struct sdhci_msm_variant_ops *var_ops;
> +       const struct sdhci_msm_offset *offset;
>  };
>  =

> +/*
> + * APIs to read/write to vendor specific registers which were there in t=
he
> + * core_mem region before MCI was removed.
> + */
> +static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
> +               u32 offset)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +
> +       return readl_relaxed(msm_host->core_mem + offset);

Is core_mem assigned in the new hardware? Maybe that needs to be
'repurposed' for vendor specific registers on v5 and renamed to
something like msm_host::vendor_base or something like that.

> +}
> +
> +static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
> +               u32 offset)
> +{
> +       return readl_relaxed(host->ioaddr + offset);
> +}
> +
> +static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
> +               struct sdhci_host *host, u32 offset)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +
> +       writel_relaxed(val, msm_host->core_mem + offset);
> +}
> +
> +static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
> +               struct sdhci_host *host, u32 offset)
> +{
> +       writel_relaxed(val, host->ioaddr + offset);
> +}
> +
>  static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *h=
ost,
>                                                     unsigned int clock)
>  {
> @@ -1481,6 +1536,28 @@ static void sdhci_msm_set_regulator_caps(struct sd=
hci_msm_host *msm_host)
>         pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>  }
>  =

> +static const struct sdhci_msm_variant_ops mci_var_ops =3D {
> +       .msm_readl_relaxed =3D sdhci_msm_mci_variant_readl_relaxed,
> +       .msm_writel_relaxed =3D sdhci_msm_mci_variant_writel_relaxed,
> +};
> +
> +static const struct sdhci_msm_variant_ops v5_var_ops =3D {
> +       .msm_readl_relaxed =3D sdhci_msm_v5_variant_readl_relaxed,
> +       .msm_writel_relaxed =3D sdhci_msm_v5_variant_writel_relaxed,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_mci_var =3D {
> +       .mci_removed =3D 0,

Please use true and false instead of 0 and 1 when the type is bool.

> +       .var_ops =3D &mci_var_ops,
> +       .offset =3D &sdhci_msm_mci_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdhci_msm_v5_var =3D {
> +       .mci_removed =3D 1,
> +       .var_ops =3D &v5_var_ops,
> +       .offset =3D &sdhci_msm_v5_offset,
> +};
