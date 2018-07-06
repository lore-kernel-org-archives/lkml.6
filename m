Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8677EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7B124019
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmU9CojK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7B124019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeGFK4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:56:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeGFK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:56:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so3754964wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gVoIOe/g30vIwtLigrLzjGyhrUJT5fzH5mcKflRFHRo=;
        b=KmU9CojKhE9B5Sig0T07c6cTBD/Dj8Q3kiEl9GZnwx/67Txb+mDZ1KVOAcp8jdFz4Y
         wumBm3T/Mj93wbmQoPS7AtTb96RlU5fDjOPU6127I2GTfpCJbNqMGxUoQ7WCvOt15qmJ
         pSbpNszUyzno3CZlV1bluAYexo3sfhJi8hXZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gVoIOe/g30vIwtLigrLzjGyhrUJT5fzH5mcKflRFHRo=;
        b=BV9yJcuPOSCXle7jbMsmYFgk8+oQrndCX/11uSE0mbzjiL+qYr0DqJV1oE2EMqtPul
         FiPujbsLv07tgi4wrYkeLc4otLyEf9szLaltiGHXyElW9EcZ/KhLZ7WwPmVOVm2wPlHH
         oaQ/U+cC9EuUJCdxMfO5t9qVan6/cmOxpYXm69qMHa1KicW7EXCwhDXQXckAGTSWMKz4
         oHQvyYTo7vtl78XzgssLaoH4Hvs0MJ8eaJKotBoeBEUH2dEjdB1tME9Aze7UJibPX42W
         Vk0UainuXu+WbRhN7b+RLpsYpdCYC4vVIxJe7+Yo8y7NYfxaYYLRaoLGB0g66VYKJBIK
         hQ9w==
X-Gm-Message-State: APt69E3OzY9vllWD+7O7naLbmHBDL6vrshLgcKk4g802ddiIb97GfO3k
        g7z6byt0bxlVx5qTU000FNGGBw==
X-Google-Smtp-Source: AAOMgpeYffsZRymI/RfV1AZfqEPe/Hio9gOh0DaoKyPeaVPQFbvoPoKU70m9+Ktjlt7GOcfhlj6vRg==
X-Received: by 2002:adf:aadb:: with SMTP id i27-v6mr6953184wrc.149.1530874596294;
        Fri, 06 Jul 2018 03:56:36 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id u13-v6sm11222267wri.72.2018.07.06.03.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 03:56:35 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:56:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180706105633.GX496@dell>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
 <20180706060913.GU496@dell>
 <20180706102312.GB11209@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706102312.GB11209@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Matti Vaittinen wrote:

> On Fri, Jul 06, 2018 at 07:09:13AM +0100, Lee Jones wrote:
> 
> [snip]
> '
> > page trying to find your response was a little painful.  TIA.
> 
> Acronyms can be confusing for non native english speakers like me.
> Luckily we have the internet =)
> 
> https://www.acronymfinder.com/Slang/TIA.html
> 
> From these options I would go for:
> "This Is Awkward" or "That Is Alright" - depending on my mood =] Or
> maybe it was "Today I Ate"?

Ha, fair point.

In this instance it means, "thanks in advance". :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
