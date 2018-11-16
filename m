Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4F3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600D92146F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCfOzI2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600D92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeKPKV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:21:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41650 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:21:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so18795726ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqNdbPQk8fZa8U2kCLK3D+S52jGbzSuJA0n5LZYX6C0=;
        b=ZCfOzI2Fn6YoN4LOPWLy1AuVgjwz2NTCyz6As5Vi3XbftcmwrD6zJ2ECozR/g9U/np
         1bCUvCyvrJX4KHovvX4T9M4zGE03x7prWPyrrz62RsCQrOm5Io/6SdzxC20Sli8mFmc5
         ihOGtDjlsCVmWduKR0bscrnEWD3laMKkn4He4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqNdbPQk8fZa8U2kCLK3D+S52jGbzSuJA0n5LZYX6C0=;
        b=TCnE2sfkTeKCYdSUhK2qb7my8uKTd0FFFOWafFw2qWV2SO2t+YRxZPVarH2uTubE+z
         tA3y3buTOlsvq3wzR6jFjWNXj9NesQPOuMS5PHbTQ9BULQFLQeQbCM4Ul+cCotPJ8OtZ
         mXD1VjORV++8k/sKtfTgeIgUTrSi5SKV1kA3XuQyNk7UWtkB1r1Uz72J9npFlk5LihAl
         o0JiroqtL80lvvrqikl1Yob0/SDTpgORPPxHDluFuKFq5nWLnYCjmAYhX/7DnFEN+GYa
         YXSjd78mIsxpk80MLCIpsCLQlw+bQ8ppy2hrqKm1SWHx7nw16kfyp9Fj/BHmBsvMny8n
         w0ZA==
X-Gm-Message-State: AA+aEWbXB2+I4MundNJBJ3rA3m/djMil/R9wsWZl/ldi1s38wFvMYVbG
        w1ZbZpl98xSdxPdOxrER4AiFKhiDcyy2HMlJZJbvxQ==
X-Google-Smtp-Source: AFSGD/VivQocTB18yTiYAsyFDN6uifU+J3nTmpXM4DHGnUMvlgjku6aYO+U6hGS/Ees1ZxyZoRwL4T40osJgoBNll2U=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr262432ljk.4.1542327112586;
 Thu, 15 Nov 2018 16:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20181115232747.23566-1-linus.walleij@linaro.org> <20181116000740.GT2089@sirena.org.uk>
In-Reply-To: <20181116000740.GT2089@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 01:11:40 +0100
Message-ID: <CACRpkdZ4wVu+1bSXJQJGpUrf0LFndRGV9oKexjv80cNAb+YGaw@mail.gmail.com>
Subject: Re: [PATCH 5/9 v7] regulator: fixed/gpio: Pull inversion/OD into gpiolib
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        ext Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 1:08 AM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Nov 16, 2018 at 12:27:47AM +0100, Linus Walleij wrote:
>
> > ChangeLog v6->v7:
> > - Fix a missed .enable_high on OMAP1.
> > - Resending just this patch.
>
> It's much easier if you can resend the entire series (or at least the
> bits that aren't applied) - having just one patch isolated makes it
> harder to keep track of what the current version of the series is, which
> versions of which patches need to get included.  Could you resend
> please?

No problem, I'll fix!

I just wait a bit more and see if the build robot find even more
secondary build nits.

Yours,
Linus Walleij
