Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286E320839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286E320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeHaQpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:45:10 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46703 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:45:09 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so5397444vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROogf4dBD+V3Y8YdSEq1DSLU3/vmDRe1rmPYLFlfL3g=;
        b=LivmcaYdpABdppOBEez14ZUZy4HotODj+2pkNQeyvzjyeHtAIkEsdaWP97JotcoTE+
         ptiLeqT/T/HqRxmIQ8xFQw4hxbXoOqbSrKm2+qC5AwxOulY7hhtpvlhLOk0LvIEcXAWS
         uxLEw75+agC7GSnPhCW6w1QA6icoaPVnKOXwIWGqP6YT1mIc7v/W89N9mKtNtB64tJFc
         MdurAkzNqJus7z4ZYXlFXc686EUIQ51EQrqETaUWG2HEu5WVU6gvQ6nzppygaabP2GXC
         fZuB34kF+MTPIc/D84dKDD9jvD+aZkdjZ7stEs96xEFI1Eu1y1VCXQ0FSKPrtHtcmJew
         794w==
X-Gm-Message-State: APzg51Bj3sfGldR3jI2xjllVGjRhON7zuntaqJpq+2JpcNmR2Vdfj9u+
        tnJQORoGDoUFlA3DYs5Tu4Sf/bvfsSfuX3NDxsI=
X-Google-Smtp-Source: ANB0VdbnDV2ypi5Ae/jdk+1qVLtNqv8fST/kXAayh9eUz0E6gNN+9nktq+bfNG1SkDXyrY7vQHDXrEF47lBW+SH+K5k=
X-Received: by 2002:a1f:8ad3:: with SMTP id m202-v6mr8936433vkd.9.1535719070773;
 Fri, 31 Aug 2018 05:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180831123402.9494-1-p.zabel@pengutronix.de>
In-Reply-To: <20180831123402.9494-1-p.zabel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Aug 2018 14:37:39 +0200
Message-ID: <CAMuHMdVnQ5tKwYx6HqWdTYnEVU4+epxf0iAQ6OwsCXj_3erkvg@mail.gmail.com>
Subject: Re: [PATCH] regulator: da9063: fix DT probing with constraints
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Fri, Aug 31, 2018 at 2:34 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> reordered the da9063_regulator_info[] array, but not the DA9063_ID_*
> regulator ids and not the da9063_matches[] array, because ids are used
> as indices in the array initializer. This mismatch between regulator id
> and da9063_regulator_info[] array index causes the driver probe to fail
> because constraints from DT are not applied to the correct regulator:
>
>   da9063 0-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
>   DA9063_BMEM: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO9: Bringing 3300000uV into 2500000-2500000uV
>   DA9063_LDO1: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO1: failed to apply 3300000-3300000uV constraint(-22)

My apologies for failing to notice that.

> This patch reorders the DA9063_ID_* as apparently intended, and with
> them the entries in the da90630_matches[] array.
>
> Fixes: 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
