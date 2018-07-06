Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120CB23D71
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHi7Ajuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120CB23D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeGFHGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:06:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53962 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbeGFHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:06:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so13808910wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CUF6PKWgqc9l+y7u++J+qlhkxc/I0+Rvdp33BIeSV6Q=;
        b=FHi7AjuorQLOjOZ//GNK4aEBdlTShwcfu63Jyy/WnGlQtqnz6cw5S9dFSOCC0DPsMi
         LldyaCVwerCyAT7ctFeVWUaJ1C/sPPJeKVbJYLhEO/OrvB+iVN49BdWLueedax8eUaiW
         oX/Skiuxp2As/qNTNEomaQp41Si1j4uAzQ/YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CUF6PKWgqc9l+y7u++J+qlhkxc/I0+Rvdp33BIeSV6Q=;
        b=lVCpkinbSX8Cw8nNoKE0kz9t62AZbg3NMhdBWqD+8lJkLnfXzAoxxXwK/f3nP/IhMH
         xzZ+V4BZ7R0RqwTTQl2EeKHmuJqlRX8hjEbujhlUO0vxGVUwtV3i71F8q71CXjLyfjKR
         6Z4eAheiXSJVXaHHBb0s897wf4bfcfzY5g/vLqXbSbWPDlcfnhMuNm8Uhxpov240+fHL
         sLSjEZqx15oGDb/raNnFlJ4YwnzKxtSLuhYoZshH7BLQH05/WIJ/8Iy6/Bv+b0dT9/zW
         8R51H+VvtT+vGLJPHEBJqIciPdioUKeCYpFdqowIF0o8JE8uSDbve1+gwyvU77HcxtH0
         7ypg==
X-Gm-Message-State: APt69E3kkrCCBHOhPJ5O7Rgsn9CKgJ7ssiF0wU/SJp9N2bK5avKVN20+
        o5dogVczO7vYX2w1JSH/WD12hQ==
X-Google-Smtp-Source: AAOMgpcxsZyBbr8KyQTkOzMmpBna8g1Bl8X9IGwQhvzcvHgFKkAbssiWkot3r9IWbKqZgyWF+ZOxQQ==
X-Received: by 2002:a1c:7501:: with SMTP id o1-v6mr6133212wmc.133.1530860762710;
        Fri, 06 Jul 2018 00:06:02 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id z193-v6sm11071740wmc.14.2018.07.06.00.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 00:06:01 -0700 (PDT)
Date:   Fri, 6 Jul 2018 08:05:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180706070559.GW496@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180704145623.zgei3ehrwdpcu26r@penguin>
 <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com>
 <20180705075650.GA7683@localhost.localdomain>
 <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Dmitry Torokhov wrote:

> On July 5, 2018 12:56:50 AM PDT, Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> wrote:
> >On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
> >> Missatge de Dmitry Torokhov <dmitry.torokhov@gmail.com> del dia dc.,
> >4
> >> de jul. 2018 a les 17:10:
> >> >
> >> > Hi Enric,
> >> >
> >> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra
> >wrote:
> >> > > Hi Matti,
> >> > >
> >> > > Thanks for the patch, a few comments below, some are feedback I
> >> > > received when I sent some patches to this subsystem.
> >> > >
> >> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> >del
> >> > > dia dt., 19 de juny 2018 a les 12:57:
> >> > > > +};
> >> > > > +
> >> > > > +/* bd71837 multi function cells */
> >> > > > +static struct mfd_cell bd71837_mfd_cells[] = {
> >> > > > +       {
> >> > > > +               .name = "bd71837-clk",
> >> > > > +       }, {
> >> > > > +               .name = "bd718xx-pwrkey",
> >> > > > +               .resources = &irqs[0],
> >> > > > +               .num_resources = ARRAY_SIZE(irqs),
> >> > > > +       }, {
> >> > > > +               .name = "bd71837-pmic",
> >> > > > +       },
> >> > > nit: no comma at the end
> >> >
> >> > Actually, trailing comma is preferred on structures/arrays without
> >> > sentinels, because if one needs to add a new entry/new member, then
> >in
> >> > the diff there will have only one new line added, instead of one
> >line
> >> > being changed (adding now necessary comma) and one added.
> >> >
> >> 
> >> Many thanks for sharing your knowledge! That looks to me a good
> >> reason.
> >
> >So in this specific ecample leaving the comma does not help. The
> >opening
> >brace for new array element would be added to same line where the comma
> >is, right?
> 
> Ah, yes,  you are right. We usually have either:
> 
>         { /* element 1 */ },
>         { / *element 2 */ },
>         ...
> 
> or:
> 
>         {
>                 /* element 1 */
>         },
>         {
>                 /* element 2 */
>         },
> 
> but I do not think that it is codified in the CodingStyle.

FWIW, my *strong* preference for single line entries in the
aforementioned single line format.  Then Dmitry's explanation rings
true.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
