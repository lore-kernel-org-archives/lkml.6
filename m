Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE87A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409165AbeKWUYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:24:39 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38346 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbeKWUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:24:39 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so6825660vsa.5;
        Fri, 23 Nov 2018 01:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=any4FmYY/LdNJ7dv+5oFEsPFV8qJ+56k6WaJQexK4eM=;
        b=CipdJNnKbJhKrkPNcyQKShnp6v41ePsnewO62Eod5I2pW0qRRtH3LeHhHdXV+biq5B
         XiyV13UHVie8rjEBB6oSQyMOlmvea0oCCJOK/4Cd9ALuF/Iv6B+Xvo8lHfE8J/0qgJRS
         TczljCzhbABrxzLI+eP+0UUBnjuObZbTrzDvskVwLZZ370BCPdT360nETFNdQCRM1NOE
         MIsdQOHm/kWdD0roz9lXW3msPRaSsdVnZK0BcFpqS7TSvmUPzBKec27dunxkSwIDakv6
         opCQ5uE/v/pRmGKvfitmfz9EB6b+g9vtyqFJbfF+O/mHX0icIoL25Cu1/qPHT9YyjVmF
         W5qw==
X-Gm-Message-State: AGRZ1gJjRU0pm4usyDTsmJOoFlK4RlswtxKsDPoqE4UfxyHTe6vNEqPM
        bdmnqJWWA8RqycO4T4MXjJZelX3+EkhuYhwZVSs=
X-Google-Smtp-Source: AFSGD/X1p7Hr1iX1CA9zXAFwmNAnnxqxvgEugjb45JhumqGzs300AKR3mrL13MESNWqm7QQPbBmeup35PsUzpaXs9hA=
X-Received: by 2002:a67:3885:: with SMTP id n5mr5537835vsi.96.1542966068343;
 Fri, 23 Nov 2018 01:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
In-Reply-To: <20181119161838.10610-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Nov 2018 10:40:56 +0100
Message-ID: <CAMuHMdU2ski3S4FhD5kOhtzxvpin8M5MoYwK7X5gqYZ+HoL0DA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Thanks for your patch!

On Mon, Nov 19, 2018 at 5:18 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> This fixes the check for unused mdio bus setting and the following static
> checker warning:
>  drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
>  warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max >= 0)'
>
> It also fixes the return var when calling of_get_child_count()

I think this should be a separate patch.

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, I have a question about rzn1_pinctrl_mdio_select():

static void rzn1_pinctrl_mdio_select(struct rzn1_pinctrl *ipctl, int mdio,
                                     u32 func)
{
        if (ipctl->mdio_func[mdio] >= 0 && ipctl->mdio_func[mdio] != func)
                dev_warn(ipctl->dev, "conflicting setting for mdio%d!\n", mdio);
        ipctl->mdio_func[mdio] = func;

        dev_dbg(ipctl->dev, "setting mdio%d to %u\n", mdio, func);

        writel(func, &ipctl->lev2->l2_mdio[mdio]);
}

The check warns the user if it overrides an already initialized MDIO function
with a different value.
However, there is no method to uninitialize (reset to -1) mdio_func[], to
avoid getting the warning.

For a use case, I was thinking about a DT overlay that would cause the
MDIO function to be initialized on loading, and needs to uninitialize the
MDIO function on removing.

Perhaps that is very unlikely or even impossible, given the function of the
pins controlled by the MDIO function?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
