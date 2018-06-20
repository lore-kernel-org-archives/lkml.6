Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507EA20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZpHvuJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507EA20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFTFxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:53:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45671 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeFTFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:53:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so1021199pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=wnUgWklWPxxpCzmmwhK3cK6YQBQtl7x9kQ/ovr7XLuw=;
        b=nZpHvuJ4quzT0ThLFCNSSXR33ZBQUUqYnK0YCjjbraHgzmqgP7wjZo/J0h1OQRZ3dl
         9eKPVRC4Lq58ISZ3lnJf6xL/ZmcUBnDVpfIBChdn4HTMYpxVOqq+DP3NfhpoA+3I8GO3
         D7OJIbkIIYIBR8hq8lj8huiy6IP0sM2venRag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=wnUgWklWPxxpCzmmwhK3cK6YQBQtl7x9kQ/ovr7XLuw=;
        b=pq72A1/XZ0U/iOOzZqQqIaSwOMJFlKVs2HgUYZWGNCKSvEzJBMZ/v1vwQwlHSmA/l+
         UJPy8T92V3MYxRJX36DiN0wLlTwGxjV+Y2oKnHXl4n5xOpH8jId+9LN3oXP0TK5x+s25
         RTvfgaN9JScdjEPOyaOhgq3xo/4xODxyGPa+4nlgodBKUMYEKtsrnSeoVzfkHPFK/177
         WEOiQwEgh6jFEJ+cUCsCyRglZY4F3dPNSKoMkvYM994qYtnH313iim22wXILmKtTkp5z
         TipQXFtdXi3Dg0MNVs8FKTZUqRHq5QHuV4runmeosBABoTfGqVJFhpc0gIPpNQJjNQiR
         ht1A==
X-Gm-Message-State: APt69E0N/1gepFNS++ON3JaWgMol/5F1FWjhXaGThLkIaj0NFoPdIlPO
        nBsA1zo2zTrB1/SXDLkl1qlzRg==
X-Google-Smtp-Source: ADUXVKI1J0M7qC0nON2Zr7mc/8dYDEJnlS/mU3qvrK2SekqwoiBGZlfWw+yCQa8HpPomA0yCKx19Cg==
X-Received: by 2002:a65:5cc8:: with SMTP id b8-v6mr17447222pgt.85.1529473986505;
        Tue, 19 Jun 2018 22:53:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id v27-v6sm2346691pfi.23.2018.06.19.22.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 22:53:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=VjqvPQA5jTUyiMzmetk2br-4fiPQdM4cVzb6ivWcta9A@mail.gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <CAD=FV=VpFR4hpREnWpvG2MQAONheKtNfLkyNM8-AFXMcGD7OPQ@mail.gmail.com>
 <152944311714.16708.13638961630238512631@swboyd.mtv.corp.google.com>
 <CAD=FV=VjqvPQA5jTUyiMzmetk2br-4fiPQdM4cVzb6ivWcta9A@mail.gmail.com>
Message-ID: <152947398496.16708.16250874897441295979@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Tue, 19 Jun 2018 22:53:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-06-19 14:38:57)
> On Tue, Jun 19, 2018 at 2:18 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Doug Anderson (2018-06-18 16:54:49)
> >>
> >> Is there a reason why you'd want to return 0 instead of some sort of
> >> error code?  Wouldn't you want to know that this pin can't be a GPIO?
> >
> > On ACPI there aren't any functions and thus all pins are GPIO mode and
> > only GPIO mode if they're used as GPIOs. At least that's my
> > understanding of how the ACPI version of this driver works.
> =

> OK.  I have no understanding of how the ACPI version of this driver
> works, so your understanding is much more likely to be right than
> mine.  I guess this is just "pinctrl-qdf2xxx.c"?
> =


Yes that's the single ACPI driver.

> =

> >> Another non-ACPI example is sdc2 on sdm845 and it seems like you'd
> >> want to know if someone tried to set one of those as a GPIO.
> >>
> >> ...oh, but I guess ufs_reset also has no funcs but it still probably
> >> wants to use the GPIO framework to write something.  Hrmmm...  Maybe
> >> check if either in_bit or out_bit is not -1?
> >
> > ufs_reset and sdc2 aren't in the GPIO chip's numberspace so I don't
> > think we need to care? At least I can't convince myself that those pins
> > would eventually call into the this function. We could check if offset
> > is greater than ngpios for the chip but that seems useless if higher
> > layers are handling this already.
> =

> Ah, I see what you mean.  These pins do have numbers in the code:
> =

> PINCTRL_PIN(150, "SDC2_CLK"),
> PINCTRL_PIN(151, "SDC2_CMD"),
> PINCTRL_PIN(152, "SDC2_DATA"),
> PINCTRL_PIN(153, "UFS_RESET"),
> =

> ...but those are effectively made up numbers and they are all past the
> "ngpios" (150).  ...and the higher level code seems to be already
> checking that.

Right. Hopefully that saves us from this trouble.

> =

> =

> OK, thought I've already proven my cluelessness about this driver,
> FWIW this patch makes sense to me now so FWIW:
> =

> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> =


Thanks!

