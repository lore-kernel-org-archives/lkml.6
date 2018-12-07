Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D7C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456E120892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456E120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGJdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:33:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34023 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLGJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:33:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id z23so1188416uam.1;
        Fri, 07 Dec 2018 01:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Xz8Yr7xxwUL+gvEbf/2Q205o6A+0qsw8dRMIAadsks=;
        b=bbzX+BX54L+tndi2580pn6VWexk8zzK/+Haq8kgIgXbsjVXzknGcpj74pUEKf0ozSY
         rP4GMf5VSKHyR1D6lsrYLykma3MaydjOug2dPspf0xEZhL1+S+MloDsbu6AQCO54PDNg
         u7bckfoM8bhPI3GB3OeSAPEObA1CPB8oV1CFtq4cNvgkZVtr73smgAwQZDwXo+9tJAwm
         O1ZEtePgb4GK0blki2v7+X7R6wGnIrOQmoBugM4UQlHebIaJsmxu+PmVk6I6UQqlxxa1
         NZ4AUcZz4QfkGn84g+RxT2Dwww362SBa7XS+MNY3rnfF9bDKfnB4Or6ZP8f6qafyffzQ
         HlAw==
X-Gm-Message-State: AA+aEWYtKREbUkX8hdwwkmLUaHcepSS+ns3ZVoVwhgO+Fd0zpNO+pqOR
        TTfgC+Z8jMJqFAkIEe6t45TsCTsW8+yvUccjszA=
X-Google-Smtp-Source: AFSGD/WjpZ29qZK5oRYupyTDzvamFqLXN3ioFUg6Lcc46Si3XJ3MjT/91fdDrj5A3CedCLCIq9nUiH2cFp7r+h0YC/k=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr574511uad.78.1544175183780;
 Fri, 07 Dec 2018 01:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1543077033-7016-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543077033-7016-1-git-send-email-hofrat@osadl.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Dec 2018 10:32:50 +0100
Message-ID: <CAMuHMdVe9xdNbMvH+8ZhWJQWKakDM96HEyki2GN6Ebvap9mnUQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rza1: report if devm_kasptrinf() fails
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On Sat, Nov 24, 2018 at 5:35 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> devm_kasprintf() may return NULL on failure of internal allocation
> thus the assignments are not safe if not checked. On error
> rza1_pinctrl_register() respectively rza1_parse_gpiochip() return
> negative values so -ENOMEM in the (unlikely) failure case of
> devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")

Thanks for your patch!

> The dev_err() for this unlikely case is added so that a failures of
> rza1_pinctrl_register() respectively rza1_parse_gpiochip() can be
> understood as currently the negative return value is simply passed up
> the call stack but it would be hard to identify the cause.

Adding the dev_err() is not needed, as the memory management core
print a message on memory allocation failures anyway.
Hence please remove it.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
