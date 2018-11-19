Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91AC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S31C3wLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91AC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeKSXnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:43:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42210 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbeKSXnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:43:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so17685430lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1qyTxNhdrmRSk9MZ4E6SPtXvLblgE/UgqGIyFweF+0=;
        b=S31C3wLzukTltn6cCtv/8is/AxiYzF22vpbsKfvyahBGQG+O990ebd2w+FPKainHz1
         +Z0qXswAZ0ad9DnqB1K7q4lWpPtlsyqnrVk6Psx1ji+GlmgnDuNxzEgEYIKUL9mUdwaC
         OtPEP4Yp+XNvUl3/1yUYKJ4+y/ylsabxtFDvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1qyTxNhdrmRSk9MZ4E6SPtXvLblgE/UgqGIyFweF+0=;
        b=RWe0OHCM1ZnQ8nnk1PqLlnw8xoUPrkp2TrKXSFpRt2M6UXV9qrvIPJ4MEP2eyKuEf5
         SGhE+dwyasfvUSSsIHf4hjjoTpysmMa1i4AQDVTOTeNiKtULp5OEjf5XTHzI3hl1vbAr
         Jg/n/QkyJqg7b9VsBRQY/JYyUCmOADgcQtOSTDTACZWvG1et8nnpMeg2RUzfvleEls4T
         biIT1+iPHrn4rZBJu25Mps37v3dknFGuqvfjm49HCGjKVlhommF1fvjaBXorLCuBd/KA
         rNt0Y8rfRpRsxcD7mGVQu9frhoXrOPEUGflaBxLMRhjXoYyGps/gdaQZrvNQmKUI+xv9
         sOQA==
X-Gm-Message-State: AGRZ1gI4yp7lOqI1/+ykeU+i4Gf/GBKZjng7ACE5hIW5T74jS/DMer9N
        R065qiDAS8c275o+VYwMFZTPuyS/Nmkke7ZindrwxA==
X-Google-Smtp-Source: AJdET5eXHi2ACHE3cLc14v8NkesLh8XOwPsWr1iR8BIlQzsyqUpXC63FsKkqr4dQrsgmxxcPpgk1fYPj/hSV+XTo6z4=
X-Received: by 2002:a19:4849:: with SMTP id v70mr8456439lfa.62.1542633577320;
 Mon, 19 Nov 2018 05:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl> <20181113135051.15308-3-brgl@bgdev.pl>
In-Reply-To: <20181113135051.15308-3-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:19:25 +0100
Message-ID: <CACRpkdZkZeVSi3O1AR-uZFcBEwp6BN95UxkgKHZz3FJbOHS3mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: davinci: restore a way to manually specify the
 GPIO base
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> automatic base selection") broke the network support in legacy boot
> mode for da850-evm since we can no longer request the MDIO clock GPIO.
>
> Other boards may be broken too, which I haven't tested.
>
> The problem is in the fact that most board files still use the legacy
> GPIO API where lines are requested by numbers rather than descriptors.
>
> While this should be fixed eventually, in order to unbreak the board
> for now - provide a way to manually specify the GPIO base in platform
> data.
>
> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this will be merged throug ARM SoC?

Yours,
Linus Walleij
