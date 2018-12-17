Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D916C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUTlzFlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeLQWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:10:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33370 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:10:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so10692520lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NIXs/U3mF9GoANWCrsK/997CoyKW4/zfNi2mUMxQ0E=;
        b=jUTlzFlHfyUXFXlpwTOO7JHFmyUSgtCuAQo6lUf5GZFbkZWsNS01T2ZcVmlnSOM/AD
         +XxXZZyUSQvHf6V4sD1LO4hyQ9uv3ZaWKMORiTdfxJEi0Jg+T1YXT6638GH0lfmhClMU
         IBAYep1ugNz3AXcvf0YqN6KsHbOqngCc3lHBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NIXs/U3mF9GoANWCrsK/997CoyKW4/zfNi2mUMxQ0E=;
        b=ufi1Cel/ggZ6UFE5+jovo+uvLXk2zdiovYzy22qoR006E8sR5yMSWavS5U0ue7r4dF
         w4RFKHRElfwtMO8GHSbqWRHtuvX4VYTdo/BDNoMx8BJ3RCXo3wj2XQBIVbTrPWPhD2kt
         za7fOMDmVgi0UD2499TJb+pNA9pPZADAjrp5m9RTPeZRgmkFFO+LcfKF1oj3yWV640xp
         Rk3zCjQQkscfVPFDJRME8dJ2c+GtQupv06Gh97vztrNaaUllaWdW9yodjNzvGumc059I
         ilavy0iTtMvv4OERkKelU0Yt7iDdSQKWI4ssKRk0xpyVJtVzGTAh8A3ZKe5WvW3sKf3U
         w6/g==
X-Gm-Message-State: AA+aEWa+1I/AzBZsZvu71Iccn3zG8uwnuXiBiO3OTqTtVDiEuzwo5EQo
        16IT2DfJtL0TwkzI5gqQraVdUoTusThK2Es1kbzQuA==
X-Google-Smtp-Source: AFSGD/XEeM9teiYQIZZkgwCVrASN3aR3aNa8L12NNMns4JhANxp7NrN8TxzN+2S9Naa7F1TicNxr1QK/ZUtlC6lKhzg=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr8945843lfa.32.1545084599429;
 Mon, 17 Dec 2018 14:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217213430.GA28450@embeddedor>
In-Reply-To: <20181217213430.GA28450@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Dec 2018 23:09:47 +0100
Message-ID: <CACRpkdYTKZo8jvwMFKh_j17KXNetz=-qHmLd+Y380rNMV6VMeg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix potential Spectre v1 vulnerabilities
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:34 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> offset and lineinfo.line_offset are indirectly controlled by user-space,
> hence leading to a potential exploitation of the Spectre variant 1
> vulnerability.

Goodness gracious me!

> This issue was detected with the help of Smatch:
>
> drivers/gpio/gpiolib.c:580 linehandle_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
> drivers/gpio/gpiolib.c:927 lineevent_create() warn: potential spectre issue 'gdev->descs' [r] (local cap)
> drivers/gpio/gpiolib.c:1053 gpio_ioctl() warn: potential spectre issue 'gdev->descs' [r] (local cap)
>
> Fix this by sanitizing both offset and lineinfo.line_offset before
> using them to index gdev->descs.
>
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Bartosz can you take this for a ride with libgpiod and see if we get
performance regressions from this speculation killing?

If you get some data on that I would like to include it with
the changelog.

Yours,
Linus Walleij
