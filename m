Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1EA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOPcpB9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1EA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeJBC4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:56:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38035 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:56:33 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so122462ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEsiSruzq3xfSNbpG6aqyL0GFc/jYw/djP3g2ZpcJGw=;
        b=aOPcpB9KTdxa25QIZ25XDAV4LZqAy0tU3nyHSeS0Hi1fV6POvxKh5hVSvI2locY3mS
         VYR1lns+QO7NjSQ2ULiUW5ao6PkesheDqHB+vawDKWnE7a9YP25hrwQn/d7w14QIBGdy
         CCgk2reUc3mBa+Ql8LNR+lpFawnyPPVIw3RiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEsiSruzq3xfSNbpG6aqyL0GFc/jYw/djP3g2ZpcJGw=;
        b=pRDlJ50Y7SU4hh6cvc5MIou/rXSKdqVVZr6MSDTQtGcLCdA76s0wXITl8g8c0Td07C
         cU+K9hbCKicHhpT2kdu5plro+8i9xJDBeKWZtRzSSZyMQOrsrS6VRgzxagV5/NOrba3M
         Jfg9CcKWh+rPELCCTrXNkKaFpks/8h2QGVhXrcbxRfhYfVkrD8sotJGOeAQf+4GI8SFM
         DjrPwFzy+WVK296IuR59OFR1gjUnrRvH8Qb97Nk+yojZV20qQKWGfMnXQAU9FJfhsdfq
         Ox/Dtv5NZby3iuOR79DPcld1uhisEuGCcVM40efyurmCCYXn5OixAIMuUKvsIvtiYs0r
         rwPw==
X-Gm-Message-State: ABuFfoi3BQuZ22l7+bndjArO9qWw61sOn6YXw96Pw0PjKM/0HB7WCCWL
        ONYXC0kyYb9UoEQW2lFdini93DodbMvcQcJSdD94aQ==
X-Google-Smtp-Source: ACcGV61TTD3cumQaTXyBiFs80mXl/Mi4MNyZ3to9YYJ5cg45JlTrbyTW2xQU+K73NdQyGEEdULS6X3S+Xigz+n9V5D8=
X-Received: by 2002:a02:3d8e:: with SMTP id n136-v6mr3454928jan.87.1538425023158;
 Mon, 01 Oct 2018 13:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180906122436.25610-1-linus.walleij@linaro.org> <afd78fe6a5e168cc9190afe3e27d12286e0dfafa.camel@nxp.com>
In-Reply-To: <afd78fe6a5e168cc9190afe3e27d12286e0dfafa.camel@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 22:16:51 +0200
Message-ID: <CACRpkdbcBrjKar4CDg+yEVuCNE3RiGD61UkPasZ35SSmSNsUBA@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     leonard.crestez@nxp.com, John Stultz <john.stultz@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:53 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:

> This patch seems to break network booting on imx6sx-sdb in linux-next
> because the enet phy regulator is not on. Reverting the patch fixes
> boot.

Thanks for reporting.

John Stultz reported the same problem I'm trying to debug it.

> Here is the regulator definition:
>
> reg_enet_3v3: regulator-enet-3v3 {
>         compatible = "regulator-fixed";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_enet_3v3>;
>         regulator-name = "enet_3v3";
>         regulator-min-microvolt = <3300000>;
>         regulator-max-microvolt = <3300000>;
>         gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> };

This is a bit odd actually, the GPIO_ACTIVE_LOW flag will
be ignored as you see:

> [    0.153171] reg_fixed_voltage_probe(179): regulator-enet-3v3 call gpiod_get_optional gflags=0x7 ena_gpio_invert
> [    0.153218] regulator-enet-3v3 GPIO handle specifies active low - ignored
> [    0.153233] of_gpio_flags_quirks(83): regulator-enet-3v3 set active low because !enable-active-high

Because regulators don't specify active high/low in the second
cell because of legacy bindings.

So this should not be in the device tree anyway, it should be
GPIO_ACTIVE_HIGH or just 0.

> That "gpio_value: 30 set 1" tracepoint is wrong, the line is set high.
>
> It seems that gpiod_set_value will check FLAG_ACTIVE_LOW and
> automatically invert
(...)
>so maybe ena_gpio_invert should not be used if a
> full gpiod is passed to regulator?
(...)
> -       cfg.ena_gpio_invert = !config->enable_high;

Indeed. I will look closer so it's the right fix and provide a patch.

> All these high/low inversions and flags are extremely confusing to me.

Yeah it's what I'm trying to get rid of with these patches,
this is just the first patch in a series that move inversion over
to the GPIO library.

Yours,
Linus Walleij
