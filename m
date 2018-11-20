Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12DC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4813204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnbqNFqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4813204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKUDHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:07:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33909 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeKUDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:07:19 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so1466475vsi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2k28Ts3MexBcbLfREdkTducpd8c3acvdROsqjJEBeo=;
        b=TnbqNFqtK+Sb9ndC3xYQsq9HA9x9cdwmGlFtKOCOTvcrK25cmIG8tFIcreBVV0dchI
         QRRs0qGyhetswjZjyNZTAE6RWbY6Kud9rXaUoZ60FIlVK+hLNTd1o+FP0eHnOZBmNqBP
         iGBNYEwBcICGWHw8aUWEVhEBOvbgbg/HWe+L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2k28Ts3MexBcbLfREdkTducpd8c3acvdROsqjJEBeo=;
        b=HO8hTiOxTKUojgpy/CJUAGj7bC038uFJdc1hcKf9GgDdVrCY+MtFQXJAvZWvLFD0qM
         FDgpnJr+hiJ4mnkTpreUf7QqvEBqs2LxuK/rYiHtJVegvMJRk71CS5floL/w9OxE5LXE
         xb8dBa1zHJVDTOjbTbYHLh7pdpFQ5kmztSv2nQiTN9RhnRYr168WIKjfVLy9N25PV0cz
         nTm/hRKjo1c6LXzMXoRjgPQkJ/BwY687k8ig/8ZWy19wHiM4/9n65/U5ijvHvChHcSQ6
         EfBTwwowc+SFMPGDCmAxJZc+ao+lEb5txcGtx1aDlchHGq9vN0Sj4WQmluO7PqhcJyAy
         6gAQ==
X-Gm-Message-State: AGRZ1gIev1sFdu4VsihOj151xWNTxGuHbewjbm6F0tbdANWtHV5PwTc1
        yvf2LPjqiUg1SF37XEJ9bf4wn/xbyAs=
X-Google-Smtp-Source: AJdET5dDmzZJS0vay/jUiLiyJPJjTBlPCsTKXaibb1lBq0UKmTGW7UkCe/dEePOV/nV0kRt3VKo0mg==
X-Received: by 2002:a67:b749:: with SMTP id l9mr1177017vsh.123.1542731837426;
        Tue, 20 Nov 2018 08:37:17 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id g23sm10190246vkc.3.2018.11.20.08.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:37:16 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 197so549473vkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:37:16 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr1104895vke.73.1542731835988;
 Tue, 20 Nov 2018 08:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
In-Reply-To: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:37:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
Message-ID: <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
Subject: Re: Applied "regulator: core: add enable_count for consumers to debug
 fs" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    regulator: core: add enable_count for consumers to debug fs
>
> has been applied to the regulator tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From f556213bad39e3e28fe62a8126eb04c0d64e0b5b Mon Sep 17 00:00:00 2001
> From: Douglas Anderson <dianders@chromium.org>
> Date: Mon, 19 Nov 2018 16:26:52 -0800
> Subject: [PATCH] regulator: core: add enable_count for consumers to debug fs
>
> Now that consumers all keep track of their own enable count, let's add
> it into the regulator_summary.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index ff5ca185bb8f..76ae6c0d734d 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5225,8 +5225,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
>
>                 switch (rdev->desc->type) {
>                 case REGULATOR_VOLTAGE:
> -                       seq_printf(s, "%37dmA %5dmV %5dmV",
> +                       seq_printf(s, "%3d %33dmA%c%5dmV %5dmV",
> +                                  consumer->enable_count,
>                                    consumer->uA_load / 1000,
> +                                  consumer->uA_load && !consumer->enable_count ?
> +                                  '*' : ' ',

Hold up!  How does this compile for you?  It looks as if you landed it
before ("regulator: core: Only count load for enabled consumers")
which is the patch that adds "enable_count" to the consumer structure.

I'm just working on my replies to you about the dependencies on these
patches but they're definitely not separate...

-Doug
