Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74517C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428FE20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd3Uf0T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfA3Jkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:40:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45456 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfA3Jkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:40:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so20070907ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0Gtl+xDttyfrB7pGNj2Ceaent7H42g1imoJp399rlM=;
        b=Rd3Uf0T+bIYn/K+Qx2B8Zj2mEk38sNW5EX5F3CNImhauEkoLSuKOV1a0Vwubm61opP
         EA0+9WcdUfhaw7puQOzzVUOMdwUd91TChNh8KitlJBwGyphERrhpmc9WFGz9Lpc8eTpj
         BB6XvrWXptQOD6yhP1/4BAKg1LIrW9kAu8bbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0Gtl+xDttyfrB7pGNj2Ceaent7H42g1imoJp399rlM=;
        b=Veb7PaPSmUOeOAouTaxCStDUwrHUs7Hbd9dxrNwgo3gLek8oEnQ3AtpDg6H2Nh1PKe
         mPz8GwmLjVXTJeKo1SYV4/72QFXmO7rgE13+WYv3VpKvX112ZgWZwV0NQkxB+vGzgW6j
         iuXhrrhE4kv4c1B+seoFYSC8HDrIoB0PRf1+ppDFqg5Vhjb0Lpr3hth5TIG59YjxT45E
         5sDIT6mZf31HJDwUndmyRNGoDZHRQ17/1NYHX/QpwqYThblPBBNjt3z4Iv2lefIFVbNu
         Zw4Bdcvh3EsZPDxM7OgAntGJfe76kuKPILvJPAnB08OVKStPdXMOWTqBIrkylsmX7s2w
         Lvng==
X-Gm-Message-State: AJcUukeObJ3hU3PIvCEh+bpcT7fxWrOpCfLaDZugAYJenXoS2rqUBW9i
        6DPEsCW5snxOMiyjeNbOPw3UvB7c6fNzlqDFMVfsJQ==
X-Google-Smtp-Source: ALg8bN7xTq9SQtCKKudoGVJ7xnq475vh/ZHzeAEObLb8jFQdZTJhdYR+FL/CjLa/9tDx9+MDT4Wb6YkLyraHuvqchP0=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr22991975ljt.107.1548841244007;
 Wed, 30 Jan 2019 01:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-12-brgl@bgdev.pl>
In-Reply-To: <20190129133545.1931-12-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:40:32 +0100
Message-ID: <CACRpkdaLukm0RNh587e6U9v419+3V4ikkzcb=yC4nvnBdMgh+w@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] gpio: max77650: add GPIO support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 2:36 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
