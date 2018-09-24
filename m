Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6927CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9092145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT32eHns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9092145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeIXOOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:14:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33950 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIXOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:14:09 -0400
Received: by mail-io1-f65.google.com with SMTP id h16-v6so6597133ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuCpIlcdQTeV/K7rYvlgsPf7U0bVlHvEfKgiDfhDHvs=;
        b=VT32eHnsqo34eMWXwaJmjSagmgbjREwJEg3Oo655D0ogCmuCOq3AUW7CXZRJk4yHZW
         tyCdK19SnYanYL4kGt8YMw4cDC9bPfRxbCobVkISd9lPVRoNbBUZ3MDDVMbrC3Omjlh4
         Ypy6dKJLFUtLRhgABiSr8N3xSUzzR6cs+xDM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuCpIlcdQTeV/K7rYvlgsPf7U0bVlHvEfKgiDfhDHvs=;
        b=c0XvaFjvAht5+0n3Fm7QNlImRvN3fYap6Ta3dAtSDrZyGYLYTbRw4zPwVVa/wj0otf
         Cxf4CLdDjjE4bcUUiX5I2h1mDTVUj5ddMjigZ40MzyFX1L/6DMYZf1tojwByNdXZgxHn
         uj+hVSssjpnlsR8sgbSGb2YNJvVRNfJPG7TyDe71aTgmzfdnGvX6iroAsLXxTszXZarv
         fTWKlkRXOCdSldyoinOYBlW/N5ishMF2m58ASAxQMnzjGJJH/cNALzASeTwQ+7dnHdOm
         fhYBO0UgvdRYLtgZPJSRja6njkwLkvRJ0pe5BxEnylvLv0Z+FsH//sk3S9FNiAZpZ5dd
         6oag==
X-Gm-Message-State: ABuFfohRb8e9vhaH7M6eM22Yed5CWaz0A8LHfcW+x3kNMbybuRyyvr8V
        5VYY8KWP7LyQB28T1kFDHW7PjInZHndbabaUeTG98w==
X-Google-Smtp-Source: ACcGV60jffR0gaxbH3Vbw/lU1LGhXZ36zx4v91f3ANt16Mo8JSUuDe3E9mRsPPUwcyg0oa6ijdsqsjzeDzVZ2kEPnaw=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr7161376iog.175.1537776795785;
 Mon, 24 Sep 2018 01:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <2785169.v6aIfS3K2k@z50> <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180923235336.22148-3-jmkrzyszt@gmail.com>
In-Reply-To: <20180923235336.22148-3-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Sep 2018 10:13:02 +0200
Message-ID: <CACRpkdbF=Yda3Wqii6dkDjqPzuh43Vb4nvPVrxLet3MYo0qUrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: Fix array members of same chip processed separately
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 1:52 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> New code introduced by commit bf9346f5d47b ("gpiolib: Identify arrays
> matching GPIO hardware") forcibly tries to find an array member which
> has its array index number equal to its hardware pin number and set
> up an array info for possible fast bitmap processing of all arrray
> pins belonging to that chip which also satisfy that numbering rule.
>
> Depending on array content, it may happen that consecutive array
> members which belong to the same chip but don't have array indexes
> equal to their pin hardware numbers will be split into groups, some of
> them processed together via the fast bitmap path, and rest of them
> separetely.  However, applications may expect all those pins being
> processed together with a single call to .set_multiple() chip callback,
> like that was done before the change.
>
> Limit applicability of fast bitmap processing path to cases where all
> pins of consecutive array members starting from 0 which belong to the
> same chip have their hardware numbers equal to their corresponding
> array indexes.  That should still speed up processing of applications
> using whole GPIO banks as I/O ports, while not breaking simultaneous
> manipulation of consecutive pins of the same chip which don't follow
> the equal numbering rule.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied!

Yours,
Linus Walleij
