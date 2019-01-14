Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3990C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FEF2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD7BUv/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfANPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:17:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36527 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:17:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so15864556lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ead8LSWG66DphT0GLyzfFRHfp2cmEwD0BAU+nVi378=;
        b=LD7BUv/wG7xDyC47T+6D8/d/xO5Mzy2eH7bmx5svjDtl0ZPuSjt7Rc82NM6Ts46tq4
         xM1AJlk8hqFyL1sN8+J21mFqRLNkNySMjvgszHcTnXL5TWYMjKhaaPQrErz600xYHl/r
         rIGiYmvU6+6nNwwmhPuUIOJ9vWvCopomZCOT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ead8LSWG66DphT0GLyzfFRHfp2cmEwD0BAU+nVi378=;
        b=eStWDeAF7k9Rt9mu48TYGOyFzmfISdrLKFEY9JPwTV+njgO9QSuW0Z/KcfbSHnTa6j
         Dzm4BjBz5CEav6urAOTNXoyApPQrLa8utcx1mDFw5vZ7ee4xswYFQoUGE0UgkdFsAOOr
         4JpKCBOaJ2mqIPs6CWm1CJeD4St+92WImJmfJr/laBEaXOW2gIO8lKDBEGVXvPcAZIr8
         R+ka6pMk5yB/UV4ZF5HvP3P6lkAj9AczBhOM/3JjKYDkmPUmqSJMUeZJ1hlXyeA9egyQ
         DSBoAM+QoNkbzrug+q/UUb8wOnry1YxjTXc4p5QvUCO2U1aNsTNd6GrKmRhQjuIM77CY
         lpIw==
X-Gm-Message-State: AJcUukd895lWOH5XVqbUZd7XNOsEVM+pixtuGYR4r3uu8QspfM1LAtmN
        hMRhiQ86+ONkoOPVINA+zTVcaPw3bfGegaiIY+6y5g==
X-Google-Smtp-Source: ALg8bN6baeAcO2Y4iwM/cwg8J9P8BijOQY3CwAVhwt+ksxWZpz8UiiolIKzvyrOTOE/7W9qAXajM6tBeRvM5j8rK8JE=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr14614209lfa.32.1547479021918;
 Mon, 14 Jan 2019 07:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20190113095723.25295-1-wens@csie.org> <20190113095723.25295-2-wens@csie.org>
In-Reply-To: <20190113095723.25295-2-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 16:16:50 +0100
Message-ID: <CACRpkdbJRV2hL2gZ84izY_30XCdWvXZ7T5pzxNHJTqLPk2BWzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: sunxi: Consider pin_base when calculating
 regulator array index
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 10:57 AM Chen-Yu Tsai <wens@csie.org> wrote:

> On most newer Allwinner SoCs, there are two pinctrl devices, the PIO and
> R_PIO. PIO covers pin-banks PA to PI (PJ and PK have not been seen),
> while R_PIO covers PL to PN. The regulator array only has space for 12
> entries, which was designed to cover PA to PL. On the A80, the pin banks
> go up to PN, which would be the 14th entry in the regulator array.
> However since the driver only needs to track regulators for its own pin
> banks, the array only needs to have 9 entries, and also take in to
> account the value of pin_base, such that the regulator for the first
> pin-bank of the pinctrl device, be it "PA" or "PL" uses the first entry
> of the array.
>
> Base the regulator array index on pin_base, such that "PA" for PIO and
> "PL" for R_PIO both take the first element within their respective
> device's regulator array.
>
> Also decrease the size of the regulator array to 9, just enough to cover
> "PA" to "PI".
>
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>
>   - Take in to account pin_base when handling regulator array index
>     instead of enlarging the array to encompass PA - PN.

Patch applied.

Yours,
Linus Walleij
