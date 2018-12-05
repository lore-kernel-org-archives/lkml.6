Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BCFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C91C20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqvROuPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C91C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeLEOYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:17 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33081 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLEOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so12180942vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tx9svm+R+Z4dHCVb3oKE3dFVpmtYVldg9Mntx0Ihc60=;
        b=MqvROuPp6IFiibCtjtyV6jg1RmIJr/g40/gmqdVUj8dSSJyIvoQTd9zziY8vq0hhjj
         8sj/fyVFX4KPNPbS+/ZxGnaeTwBMlafOTkeU5wlMCsXjP2ucct4DFhmXvWA/ERIpidE2
         c6g0GfFr+ury5prSEN6P/uhNr7Ou1LlVR5//4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx9svm+R+Z4dHCVb3oKE3dFVpmtYVldg9Mntx0Ihc60=;
        b=g1+fbGSjcrsbdSUn5o/Th75o0faqOFNK5FcJtkaaMBWlbfmC4U9/q5yUKExkVLr9KW
         Sbqj9piM8lS8H+F5leKZzwfbAW3VGVh1lojsePkL9w/l7JyrIKB2qXLRIFYAo0qICc3i
         CXKpHHzgLAEa2cX3a/8Qb+sSIjdVn6Aoa8rrCR38ydcukg+rqCiCOpzLnHxF1r9Z+sf5
         1++3l3WNeVVKTs0lxE1PHOwNTM/hVpj0MWYeZje47y03LGM2y8yvpFGOthyKSC8lDc8I
         ht+OhBS4Vk5A2BRBbo4Z1kGfWOaX1RGrQpVMFxmlyur5A/ulrGgMI9XJLGVlH4lx5PrE
         KULA==
X-Gm-Message-State: AA+aEWY5py82p6zRDuoFim6emh3E61D2oD8lCch8bykqeKq1h1wV7F9T
        Q8xGj9NsD0h2Ib6c4bWsZbI/3XtuKZLo4bE9JuaahQ==
X-Google-Smtp-Source: AFSGD/WhKDpdqumiciLVNXRck36rcKe9URJE2u/EsA0by5jQCrTE+jKgxrsYfQ1GVo1+Nhoelo/2s4rFSjQSXPWq3+c=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr10686472vsi.191.1544019852800;
 Wed, 05 Dec 2018 06:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20181118201919.14401-1-aaro.koskinen@iki.fi> <20181119231400.2375-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181119231400.2375-1-aaro.koskinen@iki.fi>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:23:36 +0100
Message-ID: <CAPDyKFpULaDSEx+d1anEHT51+f5+8FpppEva26pdvekFDH7K5Q@mail.gmail.com>
Subject: Re: [PATCH v2] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Tony Lindgren <tony@atomide.com>, ladis@linux-mips.org,
        balrogg@gmail.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 00:14, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Since v2.6.22 or so there has been reports [1] about OMAP MMC being
> broken on OMAP15XX based hardware (OMAP5910 and OMAP310). The breakage
> seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
> omap to use MMC_POWER_ON") that changed clock enabling to be done
> on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
> the hardware doesn't seem to like it and the MMC just stops responding.
> Fix by memorizing the power mode and do the init only when necessary.
>
> Before the patch (on Palm TE):
>
>         mmc0: new SD card at address b368
>         mmcblk0: mmc0:b368 SDC   977 MiB
>         mmci-omap mmci-omap.0: command timeout (CMD18)
>         mmci-omap mmci-omap.0: command timeout (CMD13)
>         mmci-omap mmci-omap.0: command timeout (CMD13)
>         mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
>         mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
>         mmcblk0: error -110 requesting status
>         mmci-omap mmci-omap.0: command timeout (CMD8)
>         mmci-omap mmci-omap.0: command timeout (CMD18)
>         mmci-omap mmci-omap.0: command timeout (CMD13)
>         mmci-omap mmci-omap.0: command timeout (CMD13)
>         mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
>         mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
>         mmcblk0: error -110 requesting status
>         mmcblk0: recovery failed!
>         print_req_error: I/O error, dev mmcblk0, sector 0
>         Buffer I/O error on dev mmcblk0, logical block 0, async page read
>          mmcblk0: unable to read partition table
>
> After the patch:
>
>         mmc0: new SD card at address b368
>         mmcblk0: mmc0:b368 SDC   977 MiB
>          mmcblk0: p1
>
> The patch is based on a fix and analysis done by Ladislav Michl.
>
> Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
> and OMAP2420 (Nokia N810).
>
> [1] https://marc.info/?t=123175197000003&r=1&w=2
>
> Fixes: 46a6730e3ff9 ("mmc-omap: Fix omap to use MMC_POWER_ON")
> Reported-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: Andrzej Zaborowski <balrogg@gmail.com>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
>         v2: Corrected commit message: OMAP5912 => OMAP5910
>             Added Tested-by and Acked-by tags.
>
>         v1: https://marc.info/?t=154258870700045&r=1&w=2
>
>  drivers/mmc/host/omap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index adf32682f27a..c60a7625b1fa 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -104,6 +104,7 @@ struct mmc_omap_slot {
>         unsigned int            vdd;
>         u16                     saved_con;
>         u16                     bus_mode;
> +       u16                     power_mode;
>         unsigned int            fclk_freq;
>
>         struct tasklet_struct   cover_tasklet;
> @@ -1157,7 +1158,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         struct mmc_omap_slot *slot = mmc_priv(mmc);
>         struct mmc_omap_host *host = slot->host;
>         int i, dsor;
> -       int clk_enabled;
> +       int clk_enabled, init_stream;
>
>         mmc_omap_select_slot(slot, 0);
>
> @@ -1167,6 +1168,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 slot->vdd = ios->vdd;
>
>         clk_enabled = 0;
> +       init_stream = 0;
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
>                 mmc_omap_set_power(slot, 0, ios->vdd);
> @@ -1174,13 +1176,17 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_POWER_UP:
>                 /* Cannot touch dsor yet, just power up MMC */
>                 mmc_omap_set_power(slot, 1, ios->vdd);
> +               slot->power_mode = ios->power_mode;
>                 goto exit;
>         case MMC_POWER_ON:
>                 mmc_omap_fclk_enable(host, 1);
>                 clk_enabled = 1;
>                 dsor |= 1 << 11;
> +               if (slot->power_mode != MMC_POWER_ON)
> +                       init_stream = 1;
>                 break;
>         }
> +       slot->power_mode = ios->power_mode;
>
>         if (slot->bus_mode != ios->bus_mode) {
>                 if (slot->pdata->set_bus_mode != NULL)
> @@ -1196,7 +1202,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         for (i = 0; i < 2; i++)
>                 OMAP_MMC_WRITE(host, CON, dsor);
>         slot->saved_con = dsor;
> -       if (ios->power_mode == MMC_POWER_ON) {
> +       if (init_stream) {
>                 /* worst case at 400kHz, 80 cycles makes 200 microsecs */
>                 int usecs = 250;
>
> @@ -1234,6 +1240,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>         slot->host = host;
>         slot->mmc = mmc;
>         slot->id = id;
> +       slot->power_mode = MMC_POWER_UNDEFINED;
>         slot->pdata = &host->pdata->slots[id];
>
>         host->slots[id] = slot;
> --
> 2.17.0
>
