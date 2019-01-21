Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B7C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQz7B0Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfAUNDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:03:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32877 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfAUNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:03:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so17492934ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdFiZuWaxfqFGK/S79Zdz69u4l1Z7n/w7nt4uOGGh0c=;
        b=cQz7B0XpJjd9Zrx/xvsSL6DoLW5Dk2y0oUxg2PoimvS6dcCS5nZBKQHiV55JC81kal
         tXe8eRZdgS+oEk0xrojHBu9HPUE2vlFcd7sutmt+5gHzX2WZJR9vDENN6F0BYxAflUuN
         yUZlVmu29Y8xf29vrmEiHCxhmp9c4eblCcLW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdFiZuWaxfqFGK/S79Zdz69u4l1Z7n/w7nt4uOGGh0c=;
        b=tD5xYb8apheVW1QE7B9zEZ/OV1PQ+Mu/LjEBvm+DSAujY8Py8CYDBWBB8k2KQDz1QI
         Le/cXcAJPWL4qQ2Eb4iQVAT3FW+UmoAVFVNQQUuKvULtBXJcLDXi+pRywi8jHXJNb6B7
         WM4rzqTV/SwgbNyguP3c4dsOIfAW8pGutCMQqYddSzOpp4KDYtLdzCtofJMVCQB4joAt
         G7Xnxu5vA5O88pUH+kxgJsLXLzsPIaZJYom+FJ9xY4bc63KbRRn9H07u2lErtwhBshY1
         JY/p1t+dJm+E9Fi/J+DrJ3ll96BeDOcGOQFRlYCqf6oXwoP63IgmHTlTG3x4awPNjKcL
         DFWw==
X-Gm-Message-State: AJcUukci67idywJEyl2yixDh5u4lJxsyDzIhL4MSQ5ku040ITHW93UX+
        MbLlFbVjDZ01OAj4gTWizm8e3rUP+z4c2G1M0F+HEA==
X-Google-Smtp-Source: ALg8bN4XSIdZjgfbvyMRa2MMd+PvLtbDtObCldgrIL6nzJGuyustya7uxxWQL0cSXGJO/6/6axoEIFE+HMHTEcSvxR4=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr17589671ljc.66.1548075801301;
 Mon, 21 Jan 2019 05:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:03:09 +0100
Message-ID: <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 11:52 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> New quirk enforces search for GPIO based on its type,
> i.e. iterate over GpioIo resources only.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> - it was sent few weeks ago to Hans for testing, but better to re-test
> - it's supposed to go via ASoC subsystem due to recent changes made for
>   sound driver
>
> v2:
> - Expand explanation why this quirk might be needed (Mika)

I tried to apply this but it doesn't apply on the GPIO devel
branch.

I suppose because of Hans de Goede's
commit 72893f0c6bd399ce84e3c1c9fc69d234fe37d098
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Mon Dec 31 21:55:21 2018 +0100

    gpiolib-acpi: Preserve non direction flags when updating gpiod_flags

Could you rebase and resend?

(Also pick up Mika's ACK.)

PS I'm a bit split about pure ACPI patches, part of me see it as an
"intel thing" so that you could very well collect it in the Intel
GPIO tree and send me pull requests, on the other hand it is
ACPI and sometimes applied in Rafael's tree. Maybe just as good
that I keep picking them separately like this?

Yours,
Linus Walleij
