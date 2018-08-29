Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DE1206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyYZvu0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DE1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeH2NCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:02:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51471 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeH2NC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:02:29 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so6652696itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nCCW7PjC30hwiANm30p2mlSlsyygQ9x7haCF7BG4DQ=;
        b=QyYZvu0Iy1V6hrQ2yG/lChI0ukc/LtQgG9VFhAOHn62Mw7W/nxp2Aj4u0ZfAHd28WY
         fY7HMREv/wfFv4MBCIEUT4//npLBmsOcW3Y9/OsxXSP21He4Tn5+QQtHb4xmSwlBG/WJ
         ZdCG8Z2iHwu6JzqoZq/vWfCtsSmEMpujWDW/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nCCW7PjC30hwiANm30p2mlSlsyygQ9x7haCF7BG4DQ=;
        b=jB8NY3Kp8xaGn2AzPigWEUnMvfqyvti/8o2FfevLT4r0JVmjEbTdEeUe1A+1RnuUDv
         KQSe6n4zxvZdon6kAdJzQ8DwfROQT6aZLj9L/FIcRu5a5IwKVMH6DdS0ibWSAPeMp4Rv
         oCHD8VTRMnlJkvJn1awO3DNmRvxwe/iwin3SKmfjnbfNEaEF9tFoAPASD2X/WdDoQXBp
         v4M8UlCss0ght732rugm00PRdLAptw/IDEhxZn9Yo5Xc6dasoqKvT9fTkpYS0v6CgSOR
         h5JPzh9Cbs+xcqsdk5sjUYsPNgvEe8ZYadhIIY2IlVcLpcQZuWCVxPpT+Q9wMzUshQ5Q
         EmFA==
X-Gm-Message-State: APzg51BqiBjhINEu3dwzxeQY2ooB7tR8QFOthqNoAN48AIbg/egaN4qY
        jUTcA8SHa68Zfcj0lzLBLAB5YRMZ6PQfNWdbVfSutw==
X-Google-Smtp-Source: ANB0VdYZDmStsbb9O1uH5F6jRk+4BCzMkRqleCcaw2x6nhaQcqCZqyEXgXnjf6dcynIJrd3elBxp0B/PqYjSmGcfcCw=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4257633itk.62.1535533594134;
 Wed, 29 Aug 2018 02:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com>
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 11:06:21 +0200
Message-ID: <CACRpkdbgY6VNP-K-c5ErQtmO7E83D6c=49TN5siF8VTNh_66Jg@mail.gmail.com>
Subject: Re: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 1:42 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This series is a follow up of the former "mtd: rawnand: ams-delta: Use
> gpio-omap accessors for data I/O" which already contained some changes
> to gpiolib.  Those previous attempts were commented by Borris Brezillon
> who suggested using GPIO API modified to accept bitmaps, and by Linus
> Walleij who suggested still more great ideas for further immprovement
> of the proposed API changes - thanks!
>
> The goal is to boost performans of get/set array functions while
> processing GPIO arrays which represent pins of a signle chip in
> hardware order.  If resulting performance is close to PIO, GPIO API
> can be used for data I/O without much loss of speed.

Hands down, this is a very pretty patch set. I'm a big fan already.

This is mainly because it fulfills the requirement for libraries
to be narrow and deep, which is what we want.
This refers to John Ousterhouts software design philosophy,
here is a great lecture if you haven't seen it already:
https://www.youtube.com/watch?v=bmSAYlu0NcY

Let's get this into v1 and get some testing and merge it for v4.20
ASAP so we get some proper testing before the v4.20 merge
window. It would be excellent if some of the current users of
the array API could provide tested-by's or at least ACKs.

For example ts-nbus.c must be a big benefactor.

Yours,
Linus Walleij
