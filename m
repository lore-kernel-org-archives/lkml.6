Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8021784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIJJOUvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D8021784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeHCTWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:22:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54829 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeHCTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:22:22 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so9301042itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2NAUnRoIsdwobCyBEqidc4JYudFIVHILUTepkSMRVs=;
        b=CIJJOUvdhUdBbggU3H/RbZDBcfx6mSVFczc15Kh+AvoUIQwII1kzAvXbH+bNfO4LbF
         aA2kKTiP8J/RlDMjAugzKVigJY4J1WW9KLHGHcbqVAfdglRcEARuKviKfPS7AwAXljZw
         ra5WccZ44D65IulWK3sTy6pm+WpEW8OV+deCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2NAUnRoIsdwobCyBEqidc4JYudFIVHILUTepkSMRVs=;
        b=aq9PiyqFq2fUKiQCLA75yBaYV+NH5cNTA2P9bF2LY1gayiDminyV6DfQjlcqlLVph4
         xjdslAw7oMVgbb4RcKE9rOGbVfeQzYLxe4MxcXr+QKwvUVjifnH9U5l5UovadjpwEx24
         u+QfUwJ7D6cL3uDzMO2WJuCPRRpzcYqGSVEgaMDjo02wupwUgJyQ5OFyKhC3qElnqP9a
         vndHrgPN214igASdNysDka1EhXgj0Hnxvxb5EsP06ekCYf4SOVd0rXGcOXA9z7ScJ0xc
         rs3enq/AqT2wBQxD6q7QEpDDLC3E2848cUyj2Xg9kcVA7PwAoV2+j2yVw5+a/dWWaE/G
         MtQA==
X-Gm-Message-State: AOUpUlGUQ0WnuKIs+Gh7cSvIL8/NmJZY14KObP18BvT6J91WmVW3r/FN
        +up7sy1LVTVFXBZUS5lY204U0N7aURppR72IR78b9A==
X-Google-Smtp-Source: AAOMgpfL7FThXQOpllOh2Ys1chN1rVPMPXQryWGuMd0iI13GIGRpmNYCat7YATpRQKTGJM+BmOpy7Hrhi88ZdZePqwg=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr4234089jag.112.1533317109011;
 Fri, 03 Aug 2018 10:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180802111144.12512-1-digetx@gmail.com> <20a52a0461e32e776e526171c250551a@agner.ch>
In-Reply-To: <20a52a0461e32e776e526171c250551a@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:24:56 +0200
Message-ID: <CACRpkda+t=0aJMSKre+U-GHN2d47pV3b_g13PcinXScP_UX5Ng@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to
 arch_init level
To:     Stefan Agner <stefan@agner.ch>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 1:31 PM Stefan Agner <stefan@agner.ch> wrote:

> A while back at least using those init lists were not well received even
> for GPIO/pinctrl drivers:
>
> https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J_azOic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba

You shouldn't listen too much to that guy he's not trustworthy.

> I still think we should make an exception for GPIO/pinctrl and use
> earlier initcalls. Platform GPIO/pinctrl drivers provide basic
> infrastructure often used by many other drivers, we want to have them
> loaded early. It avoids unnecessary EPROBE_DEFER and hence probably even
> boots faster.

When we have the pin control and GPIO at different initlevels it makes me
uneasy because I feel we have implicit init dependencies that seem more
than a little fragile.

My recent thinking has involved the component method used in DRM drivers
such as drivers/gpu/drm/vc4/vc4_drv.c where a few different component
subdrivers are linked together at bind time (not probe time!) into a master
component.

Rob was no big fan of this but the DRM people like it and I was thinking to
make a try at it.

This way we could at least probe and bind the pin control and GPIO drivers
at the *same* initlevel and express the dependencies between them
somewhat.

> This should definitely go in, at least as a stop gap solution.

Agreed. (And patch applied.)

Yours,
Linus Walleij
