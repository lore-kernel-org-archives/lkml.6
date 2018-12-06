Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0D2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF4ub2H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLFHzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:55:43 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34925 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbeLFHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:55:42 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so13760693vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkKSRRpEsZCidqNF4K0KMGnSPUzimeR9xlWMlP7d9T0=;
        b=KF4ub2H9nF1cKT6gU9Oa0upzX4PmQlQKNM6LzjI2xUfwA0Q4Hcpr/h2VeMlVbCqP5h
         QVI3aSMYyjXOJ+hQoPVclnD0hJCinhpW6Ey8Jw7GNd57+qrFK7KFd6R9ZfKw52TqIuvu
         leaHx8DjLKMN4bWXxgsDXJ2A4r/2W2hWvIcJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkKSRRpEsZCidqNF4K0KMGnSPUzimeR9xlWMlP7d9T0=;
        b=fQbH++yvDq+TMcMgVA1E645s9JyO7brgaX22s3l+v/huhnY4GZtFo7tAwKlnXrIWn+
         7MPnn/N+gdFP56jFJ833wUI/KXzIxzGK33ihw4BlcuzSkGcXy/PKFtDk++8frzRI8vMr
         hgt6n0ZqNwONhitpKEKGVYAgkgJZxVuzYuO3mwzOTmAjpPMzgaa6ar9i2tT/dz4Q5JOv
         BPaZLPSCtWDqu4YL5F/8K25AOI2F8zVkotkza4ODPX2qSKZ0oX98OBY5AM3w1gVbp+O9
         NWI8rJFneSvrZhw4RT8FyFu9ddtr+h2wOCF1ym1dSxnTO7i97MVRIB43Iezyx7PIwzVD
         Ynjg==
X-Gm-Message-State: AA+aEWZp88oDcyL9k7+xyT5W6FHfvOUElVjSHmxy1Y+qvFZzMW3qaBCu
        RJn9J29gt33wNyd5g1ewhXfrWZQf16ehuwiMvdNkZw==
X-Google-Smtp-Source: AFSGD/UOq747tYmYxI1hrKv3AL9yclay++K2q4WjCLw86Ld54joaLkPpmaV6EeKz7X7mssx6xNUWAzSQ3an4XBgyWnI=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr12056828vsa.165.1544082941099;
 Wed, 05 Dec 2018 23:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130150028.732896d8@xdu1-mobl> <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl> <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
 <20181201134251.26573207@xdu1-mobl> <20181204090120.63b5f0a4@xdu1-mobl>
 <229dc468-1155-b81f-9fda-b71402387e3f@intel.com> <20181205111450.300e0478@xdu1-mobl>
 <CAPDyKFot12Fc83R5wNsHYSu1-5mopNauYusu0RTQ9bjcUere5w@mail.gmail.com> <20181206073318.049065a8@xdu1-desk>
In-Reply-To: <20181206073318.049065a8@xdu1-desk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Dec 2018 08:55:04 +0100
Message-ID: <CAPDyKFoVXCfyRMFgQ6LLmNyQKTdnbBuCC1FSZXKdAQy4zvWCyQ@mail.gmail.com>
Subject: Re: [PATCH V3 rebase] mmc: sdhci: fix the timeout check window for
 clock and reset
To:     alek.du@intel.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 00:33, Du, Alek <alek.du@intel.com> wrote:
>
> From a081e783383adf1179c71bc37b4e199d087af643 Mon Sep 17 00:00:00 2001
> From: Alek Du <alek.du@intel.com>
> Date: Fri, 30 Nov 2018 14:02:28 +0800
> Subject: [PATCH] mmc: sdhci: fix the timeout check window for clock and reset
>
> We observed some premature timeouts on a virtualization platform, the log
> is like this:
>
> case 1:
> [159525.255629] mmc1: Internal clock never stabilised.
> [159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> ...
> [159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> From the clock control register dump, we are pretty sure the clock was
> stablized.
>
> case 2:
> [  914.550127] mmc1: Reset 0x2 never completed.
> [  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002
>
> After checking the sdhci code, we found the timeout check actually has a
> little window that the CPU can be scheduled out and when it comes back,
> the original time set or check is not valid.
>
> Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")
> Cc: stable@vger.kernel.org      # v4.12+
> Signed-off-by: Alek Du <alek.du@intel.com>

I am still not able to apply this, however the reason is not that a
rebase is needed.

Instead it seems like the patch is malformed, exactly why I don't
know. I am using patchwork to fetch the patch, but I even tried
fetching it directly via my gmail client, no luck. In both case it
can't be applied and checkpatch is also complaining.

Could you check at your side and see what can be wrong? If there is
too much hazzle I can manually fixup the patch next week, as one time
thing.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..451b08a818a9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -216,8 +216,12 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>         timeout = ktime_add_ms(ktime_get(), 100);
>
>         /* hw clears the bit when it's done */
> -       while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Reset 0x%x never completed.\n",
>                                 mmc_hostname(host->mmc), (int)mask);
>                         sdhci_dumpregs(host);
> @@ -1608,9 +1612,13 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>
>         /* Wait max 20 ms */
>         timeout = ktime_add_ms(ktime_get(), 20);
> -       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> -               & SDHCI_CLOCK_INT_STABLE)) {
> -               if (ktime_after(ktime_get(), timeout)) {
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
>                         pr_err("%s: Internal clock never stabilised.\n",
>                                mmc_hostname(host->mmc));
>                         sdhci_dumpregs(host);
> --
> 2.17.1
