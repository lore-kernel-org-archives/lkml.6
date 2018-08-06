Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33ACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FDD21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ym/G8g80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FDD21A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbeHGBzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:55:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53872 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbeHGBzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:55:37 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so19740210itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++aIMYHofQKiYz4ikdgVTDWQ3caOYUTmMuvbnRUAtAA=;
        b=Ym/G8g80gCdozhE7OK/rwY2mYmsx5f7zkJ1KTQSrZUQvf/MXu3WEDWUmTH3O7lZjBe
         z9VOThcX9srVfEJ22kZ5OrEoXLabU7A75RAQCAEVVdPqgGR++zfnjIgy2vAq1J7V8uSG
         Lgt7tdMm3wKQ32n10q+nU41UyjJH5EE0rZHHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++aIMYHofQKiYz4ikdgVTDWQ3caOYUTmMuvbnRUAtAA=;
        b=l8ktFV9DjhYdo+Sf2aYTNVjYa8UwCqauvqYJotHhuaQmeuSYm7HpamRucyYLxH2ZD4
         O6tSrlBeCacEAlRfvVZFw/AHdc33DYRasm1g0PQ23+bLSjfuuJHh9AYh+ywyX81vvriC
         wbT1XEd1mUP5KNvOQsAEBkgwlg79wB9cBwTWP8buX9FFd+bffemmCctwggPsE+UpvxtO
         JZxKYIT5z1QLeQrnyjHmCIl/7NwzuJykR0PVaPrEyZZoGymMz0piurOEZK9CxxqlOHgA
         Q6aSWmrV3pzgp8S8RjoUu9d0K8V4xdOJKwncbCrrK8XsuXjnmoF1T7n3mEtVwd2Y9pZe
         s1cA==
X-Gm-Message-State: AOUpUlHP9kqk3mxLfP7VrrSedvbmKEpfaEq8Nux0tBCmnnHZgJfJFW8C
        gxSgtlRF4CzmvtZpY/ukqWW6+a1EhMHG0C9kTqmsVw==
X-Google-Smtp-Source: AA+uWPy2M4C4XfWz577qk970s50rGrmt8qFMBKjpo7TWD6qMyO3HuldXBZ2GMDbBw03rwO8jAkQj3Sx+n59pRGJq+3A=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr136215itb.38.1533599049517;
 Mon, 06 Aug 2018 16:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-13-jmkrzyszt@gmail.com>
In-Reply-To: <20180806222918.12644-13-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Aug 2018 01:43:56 +0200
Message-ID: <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap
 API functions
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

Hi Janusz!

> Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> information on a single GPIO chip driving array member pins in hardware
> order.  In such cases, bitmaps of values can be passed directly to the
> chip callback functions without wasting time on iterations.
>
> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

I think it would be disappointing to leave all the users of the old
array API without the performance improvement. I think we need to
deal with this in a way such that everyone can benefit from it.

Also it is kludgy if users (consumers) would need to handle the case
where all lines are on the same chip separately, through the bitmap
API.

What we need is an API that:

- All drivers handling arrays can use (including current users).

- Enables speed-up if the lines are all on the same chip/register.

- Doesn't require consumers to know if they are all on the same
  chip or not.

This means a deep API with a small surface.

How do we achieve this the best way?

Yours,
Linus Walleij
