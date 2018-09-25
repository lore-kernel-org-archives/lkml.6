Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A3A20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+3HjSln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A3A20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeIYNmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:42:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39693 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbeIYNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:42:42 -0400
Received: by mail-io1-f67.google.com with SMTP id l7-v6so19698678iok.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCm7BeXOUDEkTOHXuzWK1bry9Ki+594JELty5nhAsys=;
        b=L+3HjSln+0GJwWymYlInU5nsR5Mh9PhhEk6F3FjawCqrkJYDM7AE+Oavp4NPue3Ua7
         QGwf/Kit2/IbdDDos9LiWnamHk8cNgOGJrFNowCtPLNlCRbItBUfWUOkonlqvhFEAoru
         go28r4tlKFedp0WI39na2vOFUxD4PKP7ekFRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCm7BeXOUDEkTOHXuzWK1bry9Ki+594JELty5nhAsys=;
        b=aA82XykvFT8pu+jVKJvdUeIiHAHoQf6iYupkuS/vcFx14GNa6GJEsKlgeg0MhxAHGM
         62GTALP1tiWWwOKd498jkm9xFJM1YyCiEtlwfQn+Ye7QexTjp8nrChrtXJGO1Lx1U8xZ
         QzL2Aq7wIB405IK/N3IrU70QFzuJOlLSCVIkbmKBl89T5BE0x3aju+9XoEML6741rf28
         MLe1NHdvRIbCYvqrxVuGBYv6Nseno27N5WMrR55D+xJBa4l44ZdBlJFIxB3euoscVOxK
         uPEfNZwz8hdyqjHjoo397lrTc7YF+ByYaA1pPhGBuQoxXLPk2wgPofG4f9fFtFAQOOnz
         Dr1Q==
X-Gm-Message-State: ABuFfogTGn45sawvUF9flzbp3dxkRDvsYovlRKUJQEIN/G6oxntQhM/A
        SL2YXStWo/+NKvKIZDlY/bQ774TQb/yave5rJu4iEFE9
X-Google-Smtp-Source: ACcGV60aXqXgPco0KKgu/NrjxK93WyMJNl9lqPWOMisHCUUt0Qk9cDapy7W8/408Xu1fhJYlpN9NtoJ+7EeJzpAuLd0=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr1950772iof.304.1537860987416;
 Tue, 25 Sep 2018 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 09:36:14 +0200
Message-ID: <CACRpkdbOUgvrC7GduKj2fOo6kn1HdtODvQ22NVnxw4pV6uivhA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix gpio_direction_* for single direction GPIOs
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

thanks for the patch and sorry for taking time before responding.

On Fri, Sep 21, 2018 at 12:36 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> GPIOs with no programmable direction are not required to implement
> direction_output nor direction_input.
>
> If we try to set an output direction on an output-only GPIO or input
> direction on an input-only GPIO simply return 0.
>
> This allows this single direction GPIO to be used by libgpiod.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

It makes perfect sense, patch applied.

I'll go in and add some comments to the code so I understand it
right as well in the future.

Yours,
Linus Walleij
