Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477192086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM/QUXjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477192086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeKQHxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:53:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38233 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeKQHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:53:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so8774849lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOlbw16AD1pP557NigRO1K3EOe6O+16JSf4qRZZE6KQ=;
        b=fM/QUXjYy2O82G/IJRaPUZaj4EV3mBYoZgRQY4de1fsRGgNV+5IVIbgMjYnspFiyid
         H1NzK3ebocRApVwJRUkwQizEJXR+r2+N52lOaltc9qHG+y9Gt63TOjO2oDMgMuul9Jue
         OSas+D8RQ4waCS/o5IGWBizdyLlRPFpeoj9L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOlbw16AD1pP557NigRO1K3EOe6O+16JSf4qRZZE6KQ=;
        b=JpahWn8jLvBb2w4RntJ+XUbQm9tNqNeDJ6LnZtdArRN9Ytl3qL97xJ6PrAR2lMzTQN
         M5gImKMCHVE9yl9oXfn66jU21ruQJxsYyOu1BG6/Mf6hpEPhgCo3/BKPYgJOkT42Znq0
         qjrZKBmBGy+nAFm4X7B3c/JHdZmKGZSpCVTV62zLMAaeChl/uQjOwgdyclBQpI4oNcJu
         ee2T5Dg46O06JIdIdO18t8pkBmTjiLIVtZt1jpY1B7MA+Fdq3wlJvuYUOb3vYlfO8ptx
         +oLwAly7gZbC4+VTXEeUzTd2SlseQMtvNWCTwVJKjr3PQvNBOluQJotxoFnfGCV+nFb/
         ITqg==
X-Gm-Message-State: AA+aEWbbgqh6RdUymndASodozglO91dYFQPLa9fscbuGCQ0twrAmjdFx
        aC8LV3odqB5vdvVLlacE+z7lRRE2YFKkpiVlluMDkg==
X-Google-Smtp-Source: AFSGD/VQwB5IGFQOMIzKj8ATUDyDrbnTXJQI8hUi6kxhr0zpkLQn8Up1N97Fw/1+/0c4J53QKMBfybVf/XOAzy2AEtM=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr2468224ljk.4.1542404339389;
 Fri, 16 Nov 2018 13:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-2-brgl@bgdev.pl>
In-Reply-To: <20181108165255.9940-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:38:47 +0100
Message-ID: <CACRpkdYNW7BsZO71WBAz9FCP=zOuP6oVf8pbj5rsAV7izkreUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mockup: fix indicated direction
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
> beginning") fixed an existing issue but broke libgpiod tests by
> changing the default direction of dummy lines to output.
>
> We don't break user-space so make gpio-mockup behave as before.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Patch applied for fixes.

I browsed the debate here. I think this should be applied for
fixes, then if the test should be changed, we can do that for
devel in that case.

Yours,
Linus Walleij
