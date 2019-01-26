Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7CC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B321218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhHzdg0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfAZMXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:23:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41560 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:23:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so10509696ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bOb7nsjFUzGSkiYh+V9uTwKq2g9kmv5cPTmYVhmLy+g=;
        b=LhHzdg0a6V/7hnaUgrgQEnZVQJPIza+VB2dm94OlG+4RoUnRMF8c2Uj8xm70QAA9t7
         sDv7v9nlBMjYjpESmrXjtD2nXIqAsHTC5/FKOOvZ6ZWIBo4X8rr2HfK22mLY5+rtEv8x
         4TkCReyf9+tVWp+cWwaHS+qSvYZt9x+GCrmnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOb7nsjFUzGSkiYh+V9uTwKq2g9kmv5cPTmYVhmLy+g=;
        b=WKtuD7m7zhvfKYRiONFSRLyHMEjzYmfGRPxZZe9ajqixRsshNPgYmUXxZl3Ee2Qn/6
         wfSh6DnmdDAzqxm1zgV0M4ih7t4S+xRZz/trIBvnyDUUgHTEnWbjRlkfirxe2RIiRv6A
         03p6vcif2FLx+xvat+Bs3MrzF4lF09suuxbsF/uu+h3hEI9aWZGtLMXXwx5t/VR1rWE8
         azmjWax/9TNlUDR+xgazbz+fQ8b8lZ8mDE+dKCGz4BB/uUsPN/NZH2AWsK1PlWFmqnnV
         4TzMEhO5UH5XSIIo2ZgBTNonI/9lkMZDVxiqd7mu+90xdEUpo/VU69Bxu6vDFyf3jKS3
         uCpA==
X-Gm-Message-State: AJcUukcleDE5haFF+H2FvCF0ycxTqsuffUB4QIyM2U7AOPbOefV3tkNC
        a02hytXKd2J+VpXZ7O1oY1cfXZJdcYtj/iFpxhF5NA==
X-Google-Smtp-Source: ALg8bN54XySi5yOZHh/gGL2qee3F/e82TDdxrG+UMJALObB8q80xzKrTE/CHccLOMwrzuad79lDRoYN2hMtfGFFvziI=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr12612916lje.105.1548505388558;
 Sat, 26 Jan 2019 04:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20190121091206.18239-1-linus.walleij@linaro.org> <20190124175036.GF5641@sirena.org.uk>
In-Reply-To: <20190124175036.GF5641@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jan 2019 13:22:56 +0100
Message-ID: <CACRpkdauCup4U+vRcMj5JFiNCzMvBMoaAqg_ot7ZbHCDQU6V4g@mail.gmail.com>
Subject: Re: [PATCH 1/5 v9] regulator: gpio: Convert to use descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Petr Cvek <petr.cvek@tul.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul Parsons <lost.distance@yahoo.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 6:50 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jan 21, 2019 at 10:12:02AM +0100, Linus Walleij wrote:
> > This converts the GPIO regulator driver to use decriptors only.
>
> This patch breaks the build for me:
>
> drivers/regulator/gpio-regulator.c: In function =E2=80=98gpio_regulator_p=
robe=E2=80=99:
> drivers/regulator/gpio-regulator.c:256:33: error: =E2=80=98dev=E2=80=99 u=
ndeclared (first use in this function); did you mean =E2=80=98pdev=E2=80=99=
?
>   drvdata->gpiods =3D devm_kzalloc(dev, sizeof(struct gpio_desc *),

Hm that's fishy, I have compiled and boot tested so it must be that
this is somehow the wrong patch contents or I didn't properly
merge back some changes :/

OK I get back to double- and triplecheck the build on each patch.

Sorry for the mess.

Yours,
Linus Walleij
