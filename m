Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DCECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82D1208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bvq7qf/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82D1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeGMHsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:48:42 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55307 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeGMHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:48:42 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so10307426itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHAGnefy7E92VPzrX1VhkpL22y0Cx+XeiZ7CKSrubOE=;
        b=Bvq7qf/cdb9fnt/Dx7eg6uBfUzJAmJZWg1YC6EU7BIyh9+3qU8Z2DMoTLbauMC7E1Q
         xpm+gP0ISI+e2qhEQp5AWWNmVkn6sNUcR2wXqurAQiSOrK4lkDhD/owPIYIwDk78wgAz
         5FEcb5+9Rp6soYiIRggyPKVzoCQfPBOiRPJ3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHAGnefy7E92VPzrX1VhkpL22y0Cx+XeiZ7CKSrubOE=;
        b=HpQMzRwUnoRU9IkD03T1FO795o2GOJpB9ayhKJkZTpmnDIMK77usMC5qAcYq+mQnZ0
         7ne+i1p+XzmrbdDRlHjd7Mbl7O6hwNlrWFIslUhsNZ5smVQ7k3qgDwpgKgXTwkZF7DHE
         pcLU2CXyzvAqHY5sB18hPepnctwukbBGTKLDYJXzWN/LQjEGDRmtU3dMAyHXrtaBaJCK
         4XFvMWlJnuIV07OXWCWHj8rv34BWmgg1co3Qn0ZPk/8EEB8vKjlbUl13D+QEOOUTOI07
         REL+/fTXlHRc5D1PcF2yPRfTOiIQxvjVHjDvT7clTmEF4z7pSHRxrBXk/u2YGbL0yO3w
         azMA==
X-Gm-Message-State: AOUpUlEywusCz+/rOfY3zNNuXLklbj5cWNkDFQ/ZhKUDsstgfAmivD1s
        IhFxUs2u0aLA6RSjdgds3TcwvfydSnmAk7CnCSKdXf+F2iQ=
X-Google-Smtp-Source: AAOMgpc8IVm1bf1UwqS66To487CRWbXLqJHNycCY8ak6JnVj9jVXlGRboMb0q8L+uOQhJ+hc3KD4DzMD8cMJBQeSbYs=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr3837350itb.38.1531467318882;
 Fri, 13 Jul 2018 00:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180710061112.28736-1-linus.walleij@linaro.org> <5893595.ygSzo8aE2W@z50>
In-Reply-To: <5893595.ygSzo8aE2W@z50>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:35:06 +0200
Message-ID: <CACRpkdZbT-CpvaG4ZG76T0vkU_uyt20W_=vD-n9T3=Xy_5WqOg@mail.gmail.com>
Subject: Re: [PATCH v4] regulator: fixed: Convert to use GPIO descriptor only
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 7:56 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> > -     .gpio                   = AMS_DELTA_GPIO_PIN_MODEM_NRESET,
>
> This is OK but not enough for clean build of board-ams-delta.c when merged
> into current linux-next as one more struct fixed_voltage_config introduced there
> recently - keybrd_pwr_config - needs removal of .gpio member (respective lookup
> table with NULL function name is already there).
>
> > @@ -538,6 +546,7 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
> >  };
> >
> >  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> > +     &ams_delta_nreset_gpiod_table,
>
> That is also OK but may raise a conflict when merged into current linux-next
> where late_gpio_tables[] has been removed from board-ams-delta.c  and its
> content integrated into ams_delta_gpio_tables[].
>
> >       &ams_delta_lcd_gpio_table,
> >       &ams_delta_nand_gpio_table,
> >  };
>
> If that makes your life easier, I can prepare a fix for board-ams-delta.c on
> top of your patch.  In that case you can add my:
> Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Hm it's a bit of cross-tree conflict going on here I guess.

Do you have some idea about how serious the conflicts will be?
Is it just one patch to the ARM SoC OMAP tree or several?

It's a bit of Mark's pick, there are several ways to go about it:

1. Simply defer this to the next kernel cycle when your change is upstream
  and avoid all fuzz (totally OK as long as one is not impatient).
  I'm definately not in a hurry.

2. Mark applies this, conflicts appear in linux-next, you help Stephen
  to solve it and later on Torvalds has to solve it. Then we need to
  know how serious the conflicts are.

3. Apply this patch with fixes to the ARM SoC tree. Which makes it hard to
  pull out so I'm not so sure about that.

4. An immutable branch with the ARM SoC change for Mark to pull
  before applying this so I can rebase this patch on that.

5. Pick some patch from ARM SoC and apply it *also* to the regulator
  tree and then this on top so I can rebase the changes and avoid
  all conflicts. (We do this sometimes as some last resort.)

6. ...?

BTW I like your OMAP1 cleanups a lot!

Yours,
Linus Walleij
