Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EECECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666DA20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCbVl9r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666DA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeJaXDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:03:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbeJaXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:03:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so11722908lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN+6YV+OMjp80WdLrE8aVhZjMXxtYnYHjuP3Sh5/dEw=;
        b=XCbVl9r6otnG5CSfiOU4cJEWPVgjvruKHZ+oSGzOZgcfepxg8qbA9D9r7d06NUKPeD
         U9NIHbIs16qDMCrmbQMI3K6bTgVoNFpJUdRDunkEn5WrXRE0N1xn0aSH7unyfClhokLT
         TNvaqlnOFNOWTql+gX+WIr1NHtseDtGdZueds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN+6YV+OMjp80WdLrE8aVhZjMXxtYnYHjuP3Sh5/dEw=;
        b=SfjxkUQ4zY2JzOmFXP725s0j/nwFhBpu0L5DgSECSS1waCAxa5UKsTQ3sUGyrKSKHu
         oHulX8wiFXnC6w1qRMWuH4K+xobNEhaBoBnqDdzihYLyK7gVNevunualWvPB9K9+6+fm
         8iRF04eLrF708zOsefIUsOAvm6XDwydChwPKFpSXOzDEJS/CSzKgWYYEO5oGm/D0PrIZ
         6kbcz+Jro/KevxjMgX+rTRAIdljbSP4KYQoZpJkOneWgN5MFdGbZOZH+i6WVN360iJ/n
         NI/yPnGJzD/odCPMHnaS0RrxU+W8ZlO/83QBM/1qPno1GX+i8JV0oZ0RWzAF4h+9JVac
         Xq8w==
X-Gm-Message-State: AGRZ1gIU5c5jxFkEuF+o/IELAgeDEz98azwUP0WdzunnxCtznksTStmJ
        SkJiP11MU2LfYFB7h876vPiEVJtfZa2guZydmWBlpw==
X-Google-Smtp-Source: AJdET5dqO4+BF90GXY+LmenNhoOmIKluffvWZJd5Jld+ZRNgshNAAKxI0HaAckTifnfJmSSRQsnw+H+tP1AceP7d28w=
X-Received: by 2002:a19:c801:: with SMTP id y1mr1898467lff.53.1540994728036;
 Wed, 31 Oct 2018 07:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181029151340.9087-1-jbrunet@baylibre.com>
In-Reply-To: <20181029151340.9087-1-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 15:05:16 +0100
Message-ID: <CACRpkdYJW34oRmm0ZBivwsa7mMXhrj8hxz+ovXNwnOETs3xrog@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: meson: fix pull bits
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 4:13 PM Jerome Brunet <jbrunet@baylibre.com> wrote:

> This patchset fixes the inversion between pull (up/down) and pull enable
> bits on the GPIO AO bank of all amlogic when have, except the axg family.
>
> The problem has been found while testing bias setting on the libretech
> aml-s905x-cc on GPIO_AO 5. Unfortunately the bias register of this bank is
> not described in the public datasheet of the s905x, but it is in the
> one of the A113D, which gave a clue.
>
> This was tested on gxl libretech aml-s905x-cc. Since all Amlogic we have
> got so far derive from each other, there is no reason for things to be
> any different on the meson8(b).
>
> I would have preferred to make a single patch to fix this but the commit
> introducing the mistake the is different for each SoC, so a single patch
> could be more difficult/annoying to backport.

All patches applied for fixes.
Thanks for drilling into this!

Yours,
Linus Walleij
