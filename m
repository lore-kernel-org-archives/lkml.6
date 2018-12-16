Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D412171F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUzsjTjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbeLPAVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 19:21:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39120 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeLPAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 19:21:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so7974921ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cd0w1axHMjJPNG2+w1TjFrNBZW5a87HobhXB4XxXiaA=;
        b=UUzsjTjmNkQNyj2FrtWFA2gV6B/e1mjRXtSFOKke18vdFndreay9OnoHvaNV9QsN+a
         fCdMXh483WZju3ZV10svIICSKAmrXJw4xPzUIyPZwxCGH545FsPQ2p/nsieyU8wNKtjp
         LdcytJmLsdgmKlZ1RK0OJ/BDo5CRSvwqk91OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cd0w1axHMjJPNG2+w1TjFrNBZW5a87HobhXB4XxXiaA=;
        b=rI03MC0MRAnHi5QPu/bWDpFp/JMNucDC1zDWOHb6V8zCLr7KGDbijQ4twBvryf26Ok
         1iPVEZWFNUYI7Z3sNmBJt2ujRZPPG5RsoKxmRBFWljncelr16M5YXJ6Or5se7s6EyAxz
         KFduLd7kSRM9BKUpUqTDcNBSXM4CSSJQj3XOKwVz6GT5wRDKM2hvAAbqaUPIEBZ8hbdR
         wq54dQHggpv6x0KY/5I9Lt9iAvbMn7rkRSNnZWnoddrKJeUdzg6rkJTHI+GYFVDY9v83
         N7rG1qK8YBCYPrWt35Fprvr8JrVVjw45mYtSbIWSU/DqmuD7FemVFg8lUmu6fn33zSqB
         Cn4Q==
X-Gm-Message-State: AA+aEWYA+Swskiw+XyzhpXoF4EMpMuxobRpp7p/b1z3LpAC9ai/oL4nq
        oJPyCb1ZyW5qMk6G1Txej327NtapN5OeTHEV5Srj0qH6m1Y=
X-Google-Smtp-Source: AFSGD/UAbCKm0+DmwFa45zSiPOwZUxjjMBRh9d0duhFSAs26UTxocDOupBeW1g0IPKM2P3bCOymD1FDrnt1Q1eY/NiA=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr4544380ljc.66.1544919661923;
 Sat, 15 Dec 2018 16:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20181210165005.27965-1-nsaenzjulienne@suse.de>
In-Reply-To: <20181210165005.27965-1-nsaenzjulienne@suse.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Dec 2018 01:20:50 +0100
Message-ID: <CACRpkdY_RcZXt=Rk3rdRLxnjGGuBz3ggSjAq9oVZS3CPidsXzA@mail.gmail.com>
Subject: Re: [PATCH] gpio: raspberrypi-exp: decrease refcount on firmware dt node
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:50 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

> We're getting a reference RPi's firmware node in order to be able to
> communicate with it's driver. We should decrease the reference count on
> the dt node after being done with it.
>
> Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Patch applied.

Yours,
Linus Walleij
