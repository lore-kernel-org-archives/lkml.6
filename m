Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65861C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB3218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfAVJhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:37:05 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36805 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfAVJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:37:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id v205so14313302vsc.3;
        Tue, 22 Jan 2019 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFZAKS9g2bkldfbHPWcJeB9c/pHa9RksLWPOsbWn8zI=;
        b=Aq44rrYWgGsGUm+EUezJvfCz+ypm2ATPQj3p9+rRRibdttn5q8JcvyrpIApJOKBCCq
         MPTEhKLa8boqkltHnSGKyJVpksEO2QlSSZS99PK0R2RHzxruEk6fahDqSOTFuxOVI2h2
         /42WddYUNiMly5y5yJ8QXIMSTIIpEW06fg06UEFDsjiBPu7CiGa0MeFq+1+5M9yqfyp/
         D3LHzZo+RTqHg9Ll8xL2zlVJN7+POtR3ItNan8ayxQSEZRf3YQmcql6VAzmA289EPQUG
         8/1QbSFLGSr/k9PSHtroysZpISFywYelP7Y32y6Sr3XDUXPsA69hu3X4tHPrwABXdVfA
         wQ8g==
X-Gm-Message-State: AJcUukf2AK3jHQ2AKLTlQFSUNp4BDSP43t+M24cukeiKNd8XbLcKpupK
        Vp5Q75SkHxbAsI0iRGAxrUCGdzdLLn926gD69Z8uKMs+
X-Google-Smtp-Source: ALg8bN6S+aH37LsCepXrzpQ3KPhqUVyOW2ytY/GYW9gFqIQjZJ4AAyLAMVcmmZN2pM89nP7DCf3+kCrDteXa4p1d8CE=
X-Received: by 2002:a67:f43:: with SMTP id 64mr13785461vsp.166.1548149822720;
 Tue, 22 Jan 2019 01:37:02 -0800 (PST)
MIME-Version: 1.0
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
In-Reply-To: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jan 2019 10:36:50 +0100
Message-ID: <CAMuHMdUiaNrQo3zWiR45VBANhUdkHMNhXLb9pPBLQ7tCtx1JDg@mail.gmail.com>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:36 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> I have noticed that system suspend has started failing consistently on a
> couple Tegra boards over the last few days with the linux-next branch.
> The following error is seen on on entering suspend ...
>
> [   58.222033] spi_master spi1: could not stop message queue
> [   58.222038] spi_master spi1: queue stop failed
> [   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
> [   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
> [   58.222057] PM: Some devices failed to suspend, or early wake event detected
>
> Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
> waking pump thread from spi_sync instead run teardown delayed") and
> reverting this on top of -next fixes the problem. I have not had chance
> to dig any further but wanted to report this issue to see if you have
> any thoughts.

I can confirm this on r8a7791/koelsch:

    PM: suspend entry (deep)
    PM: Syncing filesystems ... done.
    Freezing user space processes ... (elapsed 0.010 seconds) done.
    OOM killer disabled.
    Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
    spi_master spi0: could not stop message queue
    spi_master spi0: queue stop failed
    dpm_run_callback(): rspi_suspend+0x0/0xc returns -16
    PM: Device e6b10000.spi failed to suspend: error -16
    PM: Some devices failed to suspend, or early wake event detected

In addition, after boot, when the QSPI device is idle (the only activity
was the initial probe), the device is no longer runtime-suspended, as
witnessed by the following change to
/sys/kernel/debug/pm_genpd/pm_genpd_summary:

    -    /devices/platform/soc/e6b10000.spi                  suspended
    +    /devices/platform/soc/e6b10000.spi                  active

and by the following change to /sys/kernel/debug/clk/clk_summary:

    -             qspi                     0        1        0
97500000          0     0  50000
    -                qspi_mod              0        1        0
97500000          0     0  50000
    +             qspi                     1        1        0
97500000          0     0  50000
    +                qspi_mod              1        1        0
97500000          0     0  50000

Reverting 412e60373245 also fixes that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
