Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB013C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZw8P00p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405064AbfAPPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:49:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35783 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405040AbfAPPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:49:18 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so4202761vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0LKnHhEAo1Zg5SyA+dBZ+txrenPWIeLyQvrzPfqWUI=;
        b=EZw8P00px9kBeqe/8GFdu+UQBh7+Z0kbo7UrXB9JBsirPlAvWLtxtrcM+iM0Fvvjon
         LwYes8BWmNVildhrob8KdHcd3Lpp4iZ8kc9iJMpAEqz2h+Dh78IgUYHUNUhZyoAkzLB+
         tkOaqSmMdXMmHp8G7Mp0ug54FMytzYdLnM1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0LKnHhEAo1Zg5SyA+dBZ+txrenPWIeLyQvrzPfqWUI=;
        b=EsXFdEf+TMMx7FSpkWRp+BMozNb0+Js0dVywLgeeEubO5e7u2j2qkyetbxJEbiSAtA
         DdelE56RmaMBZf4S2Aom8pJPa8URQu9ryvGSKkBb8m7p+KyNs9QncK4aGi1bnORSV3Hp
         2qi0qk5oYtejrOGzwtagzF/AfDvhQpVy1ski87F004VWKqxMnakc6L0xhVSxuFYXcbRR
         jRTMUYY1L3JiQQLkHBDfFE/+B5t3yakxza74elrQ/NORBJ+w/XB7R2AeaWVDDOVr31y7
         rl3IksUhmfRD83hV+W29rdjkbub6fjG9tUM19dUm9uSP4uLNV89nOulD9+El8UxNH5WD
         yo4A==
X-Gm-Message-State: AJcUukdHxTI4vEr9CYCnxl579FojCvU/aBM9yc9DJJ00LLydNA+cKLO7
        8Rv0Gg9SRYmRXlMwvk9qj+DxxgwKvz8jKHPHDVHw9Q==
X-Google-Smtp-Source: ALg8bN7o2u+KA+zkb9oL5j5FLNxHvyd/QM5H6X9P8pSwU2ctMqw8238As8GtV/b3kFz9S5PH0xG/R0Hh9CUTQCIFFqg=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr4203543vsc.34.1547653756405;
 Wed, 16 Jan 2019 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20190116113723.15668-1-ulf.hansson@linaro.org> <20190116154311.GP5544@atomide.com>
In-Reply-To: <20190116154311.GP5544@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Jan 2019 16:48:40 +0100
Message-ID: <CAPDyKFpAc=xSsLKgMm-2H4WkD34ieRS91wH4GbwD=GH01-pt3A@mail.gmail.com>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
To:     Tony Lindgren <tony@atomide.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org,
        Ricardo Salveti <rsalveti@rsalveti.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jan Kiszka <jan.kiszka@web.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 16:43, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [190116 11:37]:
> > During "wlan-up", we are programming the FW into the WiFi-chip. However,
> > re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> > is made in-between the programmings.
> >
> > To conform to this requirement and to fix the regression in a simple way,
> > let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> > (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> > current code is to treat this scenario as an error, but unfortunate this
> > doesn't work as expected, so let's fix this.
> >
> > The other part is to guarantee that a power cycle of the SDIO card has been
> > completed when wl12xx_sdio_power_on() returns, as to allow the FW
> > programming to succeed. However, relying solely on runtime PM to deal with
> > this isn't sufficient. For example, userspace may prevent runtime suspend
> > via sysfs for the device that represents the SDIO card, leading to that the
> > mmc core also keeps it powered on. For this reason, let's instead do a
> > brute force power cycle in wl12xx_sdio_power_on().
> >
> > Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Keep the SDIO host claimed when calling mmc_hw_reset().
> >       - Add a fixes tag.
>
> This v2 version works for me as tested with:
>
> # while [ 1 ]; do ifconfig wlan0 down; ifconfig wlan0 up; done
> [  181.364990] wlcore: down
> [  182.116424] wlcore: firmware booted (Rev 6.3.10.0.141)
> [  182.151641] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [  182.166778] wlcore: down
> [  182.773132] wlcore: firmware booted (Rev 6.3.10.0.141)
> [  182.811096] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> ...
>
> Thanks for fixing this issue properly, and feel free to add:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing, great news!

Before queuing this as fix, let's also see what the Hikey folkz thinks
of this. I have pinged Anders and he is currently running a test
suite.

Kalle, can you please tag this for stable as well?

Kind regards
Uffe
