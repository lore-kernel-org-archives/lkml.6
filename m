Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCBBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89D120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E38PWl8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89D120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeHaNVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:21:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54660 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeHaNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:21:16 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so6269076ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqc3wX8JBE3xxl60w0r8Z7EC6M3lE33h9kTqazogcZI=;
        b=E38PWl8lGr9I+qJHEzz7ASNkjoDKOoUMmE2LHPMSJrtH61+QCkfCiI6PJQfpJpz3i+
         QyRCvgVl9TzhRegOqRCaKhA5EPhVuBfbvDi4CKqf3ZODat2M+PmvbCL3mB/fnVWT7HxH
         XsQDzcxlsFg4/xM38iv08w2C6LUzWnw1LoFo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqc3wX8JBE3xxl60w0r8Z7EC6M3lE33h9kTqazogcZI=;
        b=c1ZHlFeV9jsTT0SoISPcOr6KtqamN3mpnkQHj3Oe0dNpUHg9yzQsFjrRIFrdJ3/f3N
         SLOAKcIBUfGVHrwHPKEEJB+p+K4C1LBT9IJnE+Ih/FlWgOajNVz8j0/9vLL+sKVa6CQn
         Ev94ZML2ANNq9d4Kvhogsd5Z/eHQnP8gsoCnz2cBJZIh/ODzYIPimHm7aTD/eoNh93HC
         e/NIgdLTJfIQMu9ZwiBzh/y2q1WTLyV/7U8xyAfWuwrsfahmjIQ7upQX0MSZOm5kxzQM
         G5FzMoEte2Hduvo7jRHpqelco4x5pYFoIKXN+IT9l/2NujBcOWaSH1DaJZGxfhuxv810
         jo7g==
X-Gm-Message-State: APzg51DXJyUiOnZUzEH52MG+e8Vlv0sJlKben7rCgDYKdEXTraCZa4DY
        HyMFKfpK0yKZHlyXY3YlZKU5g28C2llQpidguNzxZg==
X-Google-Smtp-Source: ANB0VdZdIoBJrJINrn4lloNMBwDfGpoDCLWysa07mlmrthaJTunEepVwcZUbM9QORD8bqxuelhSd+DXI30GjEFzhJus=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr11825626jag.112.1535706883400;
 Fri, 31 Aug 2018 02:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Aug 2018 11:14:31 +0200
Message-ID: <CACRpkdYmd=Efh4-YsTzRAhtKLWHuhJ-9D6iVagkg=+zxU=KLHA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:48 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

So it's no secret that I strongly fancy this patch set.

What would be great at this point is to have some people test
that the drivers still work as expected, even better if they can do
some benchmarking.

> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 9;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);

This seems fine to me, but I understand the comment that the
code becomes harder to read.

I think part of it is those __assign_bit() and __clear_bit() with
the double-underscore of unclear meaning. The meaning is
"non atomic" IIRC, so maybe I should move forward
with my plan to send a sed script to Torvalds just renaming all
of those to something sane in the next merge window.

Like __assign_bit() -> assign_bit_nonatomic()

Yours,
Linus Walleij
