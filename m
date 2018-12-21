Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED17AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB32F218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuWB2aR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbeLUKlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:41:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35819 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbeLUKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:41:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4311909ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIvqPSsZOybkj0dcwPZoMds3ZWz8q9/fchfuKkuCcJU=;
        b=OuWB2aR19ekRnyOpO0NPwfqUd9HVOQuF75LCCQYp0tGKRSI6p2at9ODFOzrh4eql4u
         Li2zFxoad8HO4f4KKzNd61H2lc91++U1kriPoqUb3rC6Jzf2dlEGv6hw5j0HEro2D3mK
         WuNJfarm9t/TyXjjenZI8b9DLoPPq1zfMZawI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIvqPSsZOybkj0dcwPZoMds3ZWz8q9/fchfuKkuCcJU=;
        b=AkiH3Lndb65Sdd1v4ARnTsmQ6vCfQagiy70GptURO2Xnm/vreM7uNYkkPpuQYIQFy8
         7por4kEA1+njmOZCyPoGD2OVGb//aghPLUnM2vrbBs4mBAQCrk0cBGeeRkZXzp61/acW
         1UQ6cfi0gA25HlgwKWyB5aCZqP/v5+hh6Vca+cX7CMsmVXkNw9I2Wz2vDfSgGInZXWv0
         TGOcN70TRBGENtXu0hxluiV148bRzycJIhnzYJTzfhT5C9jjqMOVvajAtz8e7DGIOrXy
         4iFduKYajYJLm/cA5ji101YK0kZ8D7cCUAox+cuDgYIlzoheqdkasB3jRy29yNzXfqUr
         aXQQ==
X-Gm-Message-State: AJcUukedU1o96uXWNzMWXHLrBUJKOFgmQ0cCw/3hNbDfV6FeKmvUH+nG
        TAjAqdXHsGGmQGNzGVi3clY090+S4TtlUkFDuK4CEA==
X-Google-Smtp-Source: ALg8bN4KRS5dk5k1F7zHau9YhZ70sAuMip8rb40M1GJnaA0xPr2wIzjRM09rg7Bwc9CfxiwwDBNEOiRa9Mxg9H0kx1k=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr1253683ljp.12.1545388899381;
 Fri, 21 Dec 2018 02:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20181218161042.16366-1-jank@cadence.com> <20181218161042.16366-3-jank@cadence.com>
In-Reply-To: <20181218161042.16366-3-jank@cadence.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:41:27 +0100
Message-ID: <CACRpkdat7h2xWXm-1Hr46rYywy5Bdd751qu4yKk3i7f72nG9xA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: Add Cadence GPIO driver
To:     Jan Kotas <jank@cadence.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 5:11 PM Jan Kotas <jank@cadence.com> wrote:

> This patch adds a driver for Cadence GPIO controller.
>
> It can be enabled with GPIO_CADENCE Kconfig option.
> It uses generic GPIO infrastructure and works
> as an interrupt controller.
> At the moment it only supports level sensitive irqs.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>

Pulled out the v2 and applied this v3 instead.

Yours,
Linus Walleij
