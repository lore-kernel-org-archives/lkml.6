Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC0C2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6130D2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxzoqaWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfAUNUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:20:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41470 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAUNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:20:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so15463511lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlutyYu8Foj1+Lu/ha0RenldfaRM0X15+ku/9bdlSeU=;
        b=WxzoqaWoRgiOaaVjvegzUqGuUqKr9Jwjyp3mvYkLOZcawXt2kA2VDXyh6TkTukVeyI
         kkn1yHFopkd8AFvyZSoscIVWL4ig7e7uQsLd67SaWFaB1yIYaLrguHLRbta5XblAruMp
         FyKWEp312ROXamvO4wSc+DXSQ9tD+qe1m6Zjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlutyYu8Foj1+Lu/ha0RenldfaRM0X15+ku/9bdlSeU=;
        b=SFqMtkOO88Ige8oNgAcG7VYkMZnmozLdcgwGRFgxaiBfMtThq57iX5D7CObJEs20EL
         P3GbUl/hAV0F22SiBXPsbkfzB3Eg0RaNevsT31bUPu0+xsfH5sPVFQpJ4g8Z1NVHRbQa
         uJSuJ8oCwFJ3TzUSrdqEWPgSgM7YFIVOjPAgGgq1bix+mskswEn5X7U4uk35vkMuUhGE
         eIzWBtexl4GQPs3fhN8g9yPnGdsRFUURitv7VGTCOkazN34gOB4unXwVUOcYHyi8v24r
         SJXj1PJltD5p6qw0+Mt0lyZcdfyjEeoh7kf0qNqwChqgOFWbQ6dflNDHJFNu3a7jFZ24
         WOQg==
X-Gm-Message-State: AJcUukf2N/GrRF0rp0yEFW08yP8TATnGhCtze2MgXr+ANotgW9YO5aZx
        be6UorXM7madS47FWVIHzub2XyYgvq/jlvXBgaXdADY5
X-Google-Smtp-Source: ALg8bN7VwxG+SFQgO8Wzt9AFTSrlAySg1aDf+lHUgeQwYhD1MeIcW2yAZKvNOJP4RM4See++fQJswqpQ+PpS80cd3pI=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr9657008lfa.32.1548076801005;
 Mon, 21 Jan 2019 05:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20190111162516.28197-1-poeschel@lemonage.de>
In-Reply-To: <20190111162516.28197-1-poeschel@lemonage.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:19:49 +0100
Message-ID: <CACRpkdZFFu=wgHw0BqXUHiC5euGwWuYbr5bH60zDvFr+q394=w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Allocate irq_chip dynamic
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 4:16 PM Lars Poeschel <poeschel@lemonage.de> wrote:

> Keeping the irq_chip definition static shares it with multiple instances
> of the mcp23s08 gpiochip in the system. This is bad and now we get this
> warning from gpiolib core:
>
> "detected irqchip that is shared with multiple gpiochips: please fix the
> driver."
>
> Hence, move the irq_chip definition from being driver static into the
> struct mcp23s08. So a unique irq_chip is used for each gpiochip
> instance.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Patch applied.

Yours,
Linus Walleij
