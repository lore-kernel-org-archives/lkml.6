Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E06EC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0592F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7Ornk5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0592F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeG2WFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:05:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40247 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeG2WFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:05:44 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so14116829ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pqUoOULaUm7F4BE8xvA9BguWkhy4WDnmsqZO7JuL+8=;
        b=j7Ornk5ZHJ4KVbyEH6fXJHxtr9/QqfFxWZ2NjiHzcjYsd+WmxNXDoAndvg+MryoYMT
         6awh1X2R4ix+i11UOoW+NzOKScZ4exuvHeh6oDQgztQTQFcpdOSwYUD1t+qLV5Uu/4tT
         b838T58U5vov0FwF1HklWuLw7mgVmoDf9GOik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pqUoOULaUm7F4BE8xvA9BguWkhy4WDnmsqZO7JuL+8=;
        b=rx5gBSwywiZ0dkX7LVs9/lp3SO7cO0p5zJXhW338JkFtUnj9/fetyiCYdcrKj76JNa
         cjIJMB4dKwGP89MGO/rdmECnlGH65T64FeXiqRbjpxktMNpZSl72bWmoc8Df3Qm0pyvj
         vXAMF5c36Ap27ccMoijh6nN/S3idzI/+0rdhYVVynWS/Q+YdMzFbow8+vqmWTsbtqrAE
         ADMbttrKcwj8zgkwiVJFPNVVFGdv90CFmGCVfOCMef65tDqwX3sFw/WKSDRgblV/lrzc
         HYzAJlwkVpnG+0zPyQkr9u+yYctyIMdqRWr2k3CCqcNJfrgFDJWyYfTfyoeJ1aOaid3t
         7M+Q==
X-Gm-Message-State: AOUpUlEm/OLKm6xpkjjCdR5KQZJ5JhrmA4YMrYiaSB3cGnyIwSmXQ61v
        bupH5HGvcb50ULM4pdwgKymRJM2V1BSF7ni9dOxznQ==
X-Google-Smtp-Source: AAOMgpddztxUqNt/YsoaiLTIJtEN1FySTWkIu8DNHI4zWL/nrSkz+nuFDospcXKh2Jkss4guwol6F0hmaLkOBmsTetI=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr12090215itb.38.1532896440367;
 Sun, 29 Jul 2018 13:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-8-jmkrzyszt@gmail.com>
In-Reply-To: <20180718235710.18242-8-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:33:48 +0200
Message-ID: <CACRpkdZ316o4rwCftOWsRMNd3B+4v0mWGbdMFvp1mm7yaFsccA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz!

Nice work overall! Some feedback:

On Thu, Jul 19, 2018 at 1:57 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> +#include <linux/gpio/driver.h>

Let's skip that.

> +       /*
> +        * For acceptable performance require the data GPIO
> +        * chip to support get/set_multiple() callbacks.
> +        */
> +       if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
> +               err = -EINVAL;
> +               dev_err(&pdev->dev,
> +                       "data GPIO chip does not support get/set_multiple()\n");
> +               goto out_mtd;
> +       }

Since we know which platform it is, we know that we applied the previous
get/set multiple patch, so we need not check this if the patches are
applied in sequence.

As long as all patches go in the same merge window, no problem.

I'm BTW ready to apply the get/set multiple patch already.

Yours,
Linus Walleij
