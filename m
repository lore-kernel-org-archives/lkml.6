Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5792080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnPJDe65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5792080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLLJUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:20:30 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44439 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeLLJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:20:29 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so6177246uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeol+VVDzQN8dM9GNSfdZ9JwQqbZHozQ9KgJBWv1TzM=;
        b=LnPJDe65wWrMf0VC6R8YXMU6Kb9shYYFUtKl8UvwGBo40fEbVS33i0Pz0+MgYlMxjp
         uYcglJSbt3tonO13vvmiWyqme40Hj4fKk4JTUw8fRr41d6kWsjJ9qhn7z9VKzN6Qea2j
         CkFPkkzw4EH/yEFhFUdmvncZ944TAHiI5AP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeol+VVDzQN8dM9GNSfdZ9JwQqbZHozQ9KgJBWv1TzM=;
        b=NrRKmWZ3KPNSGy8VvvpFTLMtulMz7X8k0fk77U4x9g5fCFFmwHp0G3aIJfwFpmmL9F
         G2DzJNOedYQ1L9KMH12vdJOKutq+bnt6UYD4gt0ttbCxJDxa+PoRrHiu6Cc5jy3r5p5E
         sBcMBzqsW6IdML8ehmnz3JQ3juG0kouu4KBst5w6c0M/P/4IKufSLiMgoDvS63PUa14N
         SLEanKMsuikmTMG1ojHbhh0qq5OzXnKcxn3CiuCjA6Q/iqONMDXvOqP80FPxbt3wkSuE
         GMQxP7e41bk9FyiHO9mzz5V+5GJyhgUXdj49+49DIIWV71xcK5Qvhe1Vwt27xCKZTOni
         ZLPA==
X-Gm-Message-State: AA+aEWY/sjcsIKKxGK2am5ZJyoos30+jY+awxMRcS+oaOEPKXGlJHGfs
        2u/bSbBa3M/AnaUEDVL5nyR60T7NGLXdMaVq4TrJ0A==
X-Google-Smtp-Source: AFSGD/UQ34ygIbWFn6gZTHLUcZ94EDWYS2PLb+gF7xQDWWJIg6nlmq3ExYYAMUtTGtlRwxbWEa9VZt8yG+z/8fPn3bU=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr8603104uad.119.1544606428271;
 Wed, 12 Dec 2018 01:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20181211142253.23747-1-faiz_abbas@ti.com> <20181211142253.23747-3-faiz_abbas@ti.com>
In-Reply-To: <20181211142253.23747-3-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Dec 2018 10:19:51 +0100
Message-ID: <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Thermal maintainers

On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> unexpected tuning pattern errors. A small failure band may be present
> in the tuning range which may be missed by the current algorithm.
> Furthermore, the failure bands vary with temperature leading to
> different optimum tuning values for different temperatures.
>
> As suggested in the related Application Report (SPRACA9B - October 2017
> - Revised July 2018 [2]), tuning should be done in two stages.
> In stage 1, assign the optimum ratio in the maximum pass window for the
> current temperature. In stage 2, if the chosen value is close to the
> small failure band, move away from it in the appropriate direction.
>
> References:
> [1] http://www.ti.com/lit/pdf/sprz426
> [2] http://www.ti.com/lit/pdf/SPRACA9
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/Kconfig      |  2 +
>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5fa580cec831..d8f984483ab0 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
>  config MMC_SDHCI_OMAP
>         tristate "TI SDHCI Controller Support"
>         depends on MMC_SDHCI_PLTFM && OF
> +       select THERMAL
> +       select TI_SOC_THERMAL
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's DRA7 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index f588ab679cb0..b75c55011fcb 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sys_soc.h>
> +#include <linux/thermal.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct sdhci_host *host = mmc_priv(mmc);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +       struct thermal_zone_device *thermal_dev;
>         struct device *dev = omap_host->dev;
>         struct mmc_ios *ios = &mmc->ios;
>         u32 start_window = 0, max_window = 0;
> +       bool single_point_failure = false;
>         bool dcrc_was_enabled = false;
>         u8 cur_match, prev_match = 0;
>         u32 length = 0, max_len = 0;
>         u32 phase_delay = 0;
> +       int temperature;
>         int ret = 0;
>         u32 reg;
> +       int i;
>
>         /* clock tuning is not needed for upto 52MHz */
>         if (ios->clock <= 52000000)
> @@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>                 return 0;
>
> +       thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");

I couldn't find a corresponding call to a put function, like
"thermal_zone_put()" or whatever, which made me realize that the
thermal zone API is incomplete. Or depending on how you put it, it
lacks object reference counting, unless I am missing something.

For example, what happens if the thermal zone becomes unregistered
between this point and when you call thermal_zone_get_temp() a couple
of line below. I assume it's a known problem, but just wanted to point
it out.

> +       if (IS_ERR(thermal_dev)) {
> +               dev_err(dev, "Unable to get thermal zone for tuning\n");
> +               return PTR_ERR(thermal_dev);
> +       }
> +
> +       ret = thermal_zone_get_temp(thermal_dev, &temperature);
> +       if (ret)
> +               return ret;
> +

[...]

Anyway, I have applied this for next, thanks!

Kind regards
Uffe
