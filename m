Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7537321479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYYBy2rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7537321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeLFK1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:27:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43913 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbeLFK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:27:32 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so13940271vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiZbs/IWyJmPT+sDvCny8fkscFvsHrRENfmDgBKbIiQ=;
        b=bYYBy2rlDwrimwH6KDutik+LW6SYbPhHr2f/V8NeUcpIlcRB8NvwUo+aStV4N0rkAZ
         Z0lXL9g9MemCTSPo6uM0mR/7tI2aMP4qGsIAmxNhbvLvLWzzhYRG4fiWPfts7HIB1XA2
         uGNsq17oY3mGXUFO7m50RCmnku3ZbXF9pfL+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiZbs/IWyJmPT+sDvCny8fkscFvsHrRENfmDgBKbIiQ=;
        b=jUGH46eIntiDet/RStjfJh7+lLevKGwP0e6XBZGtuVpKFM6VPNk7KwYoiNrlXeK5WN
         +FjFAMBXDmWNwOdlPGjccOlp+YgnA+SCIhmAeCIiGc816aP+co1/2GNiGy8aGZwYWX1X
         CnC79OGlpdpmGisPoUwghWWw2TL6Vp4FdOLtZOw+oICOPECos0IjaStTtgVgI5ohj+Za
         TBM6Y9ApvgMLB2k89MFd4oHzYoIVpjUw91khBdPJL6yw6ILdnrMrwXFY1qYn22sg7Duw
         IUUL+hvNg9QA08qou+xM4mQ19XCNOprXh2Fi+/cJ/SvcSTsWVkGfHsDjZ8IEt/F9RgFO
         PY9g==
X-Gm-Message-State: AA+aEWZCb51uhyxDnHKlFk38NmJKlrvoEsXauyQy7xRpIlp9aHuIA7SM
        WSECFG7kDAeW24KMd80t4649FJ1e2DEONKLDxFeoJQ==
X-Google-Smtp-Source: AFSGD/X4ZTTtP3ZD5vm+cvTCLSYeA+AcIOuW26rSp5NdcNpqYQ91bNzyFQQHkoRsO1zd/BiLdhzuRcpchR6pzjuXAlE=
X-Received: by 2002:a67:7685:: with SMTP id r127mr12304642vsc.35.1544092050476;
 Thu, 06 Dec 2018 02:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20181206092459.26202-1-alek.du@intel.com>
In-Reply-To: <20181206092459.26202-1-alek.du@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Dec 2018 11:26:54 +0100
Message-ID: <CAPDyKFrRm-hxJDE41aU7Rs3RSmz-K5Gvr5hJu5Ph9WmZ35vTSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fix the timeout check window for clock and reset
To:     alek.du@intel.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 10:25, <alek.du@intel.com> wrote:
>
> From: Alek Du <alek.du@intel.com>
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

Yes, now it works better!

Applied for fixes and by adding Adrian's ack, thanks!

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
>
