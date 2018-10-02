Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B63C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECE320878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDKktDwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECE320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJBORH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:17:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40297 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:17:07 -0400
Received: by mail-it1-f196.google.com with SMTP id i191-v6so2345282iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oR3LpccgihYUDIYwOsXzXwrUkU+td+zzHOTgPNH/0BE=;
        b=fDKktDwer5dJQAdwkvWBCus9SStuDyV0El5E+3XUNbmcIV7dUwrMlv8t6QgxlFv8c9
         fvIyRgRdH1qB00nnH9VJqNJ9VXj+gsJ+irUJBLkY+k5nDjk9XXlN0OZL40aDf/tu70c+
         gfOWW36QNY1BxWlY4Y1pXH3jEVmugQhG4DK5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oR3LpccgihYUDIYwOsXzXwrUkU+td+zzHOTgPNH/0BE=;
        b=jdOXC/J43tfxU5nbDV/BQoPo4MqXiYQwtvzYHnACmTpF0GlFptbjHn0n0zZAX66zqv
         AK1PJ0H5Bz87ibSyMDfYfQddt5eFFQ0jGO8rwvcFCog4VZTeiQcOZvBfs1Hl7qCNeNgk
         Xa0quRxhZsy+2uLohTnlahypZPnqvHAEx0rKtl/Iy8EWcV9mZT3FMYvV8C7Mz6+Owywh
         f96j+MLCMIb8tySmSEP71pjAjDGdiZGSDCudZSFvV1/tksK9MzTMfm94/6z/RRY4sVaR
         zUB+iynH3J1d7GMN2kkc5oObE5r3AEHmSstCK/xEg4BhXEUYxew06Ux+EvNrB/rtBo24
         qISg==
X-Gm-Message-State: ABuFfohiInx3F+t8OsJfDK4K5AvdBkxAtaWBoGgO5S9NflP4Wj62U0+X
        mmmpBsSmovfI2OLr4DAURqLK/Vd85PI764kH3VNd6IobYWs=
X-Google-Smtp-Source: ACcGV60ilUbzcyEVW7yhcvCQgazrVy9gji+UqoC8SPi/nDVWaYkmO5+chALWYEcwUzX3rjIF+xXPLEg8YSTnG2FqZEU=
X-Received: by 2002:a24:97c8:: with SMTP id k191-v6mr1083186ite.130.1538465715171;
 Tue, 02 Oct 2018 00:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181002041437.2493192-1-taoren@fb.com>
In-Reply-To: <20181002041437.2493192-1-taoren@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 09:35:02 +0200
Message-ID: <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     taoren@fb.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, mine260309@gmail.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao, thanks for your patch!

On Tue, Oct 2, 2018 at 6:14 AM Tao Ren <taoren@fb.com> wrote:

> -       if (fttmr010->count_down)
> +       if (fttmr010->count_down) {
>                 writel(~0, fttmr010->base + TIMER1_LOAD);

This struct member "count_down" is a bit badly named now don't
you think?

The patch is fine semantically, but please rename this member
"is_aspeed" or something like that and update the code everywhere,
then insert a comments like

/* The Aspeed variant counts downward */
/* The Aspeed variant does not have a match interrupt */

in the code snippets so we see what is going on.

Yours,
Linus Walleij
