Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C85C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A215E2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwvBC3sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A215E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeKBSbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:31:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42854 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBSbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:31:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so855390lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWXVLUlksolGge10ty0kIKsFAE+aHiOuK0mIv+77Vn8=;
        b=EwvBC3sjf/xOjjBqxGMZQVU1yfoIkod6OLAgM5IXviDN6DUogrIiEU5AWBmtqA1w7Z
         KaOnvdb2WPuJk7dqU0WYoUCJ/rMBFnyPyZtbKLU7cdsI7wKtXtfI94hrWU+f5brZhKlP
         Al4ghh3ZYLFWEL9811UdYKqbEiCIm6y4q6Kt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWXVLUlksolGge10ty0kIKsFAE+aHiOuK0mIv+77Vn8=;
        b=btqLyDZRlM/aIkWrlMuAd9JvoWIVhSXq2u6HNRGKVWf0bXmnr1rgkrbiAxezneDm/Z
         5JQoepBYlzamP2rF7J+4pmPbktaVBTTxRb8j4sIdPOvLotw5pDFteJ6MUlol5PZEoI2u
         EXGernitj7sVWONi6iWxNbQiggc1Fd6MXonH+Gbaeq0HIGvWVcO/PUWo5MEuUbYJDbMx
         nCqNRpC446AVBmAYELb6Gi1+di1nw2vAYK0034BpEK8bkrsfdctCSj9Az05msxXdmD6i
         QD38DTylkuzW/gLa6qypy762VrIT8arRTBLjeZgLjpKMl82OWNokN2oZLxpjtJuwh924
         sRxQ==
X-Gm-Message-State: AGRZ1gIZFyzanucftASzwG2aaAo6SZ2I2Wpa2LjrugdyYUHfTU+xpq8Q
        eTIlwitZUQ+1YnHWTgqHf5pJg8MT8DjSKJHKyOgBrQ==
X-Google-Smtp-Source: AJdET5dftK3G321TUCSQBBlJwqLEV0adHgM/4O95wHprJFMbVsI+dtmhlv5ik77Z+uZ50iWbxh4bqQFkFOtV8Vj2344=
X-Received: by 2002:a19:f813:: with SMTP id a19mr6213855lff.67.1541150706776;
 Fri, 02 Nov 2018 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181101131250.41636-1-smuchun@gmail.com> <CACRpkdaURruTj6W=ozXpKEvLpxLa=6tLdDywac1uj61Hg8ZKpA@mail.gmail.com>
In-Reply-To: <CACRpkdaURruTj6W=ozXpKEvLpxLa=6tLdDywac1uj61Hg8ZKpA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Nov 2018 10:24:53 +0100
Message-ID: <CACRpkdZ_jrNNB7n0DOuL6n_JtupiwacbMxWcockTak9F8fdAjA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix possible use after free on label
To:     smuchun@gmail.com, Nicolas Pitre <nico@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 4:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 1, 2018 at 2:13 PM Muchun Song <smuchun@gmail.com> wrote:
>
> > gpiod_request_commit() copies the pointer to the label passed as
> > an argument only to be used later. But there's a chance the caller
> > could immediately free the passed string(e.g., local variable).
> > This could trigger a use after free when we use gpio label(e.g.,
> > gpiochip_unlock_as_irq(), gpiochip_is_requested()).
> >
> > To be on the safe side: duplicate the string with kstrdup_const()
> > so that if an unaware user passes an address to a stack-allocated
> > buffer, we won't get the arbitrary label.
> >
> > Also fix gpiod_set_consumer_name().
> >
> > Signed-off-by: Muchun Song <smuchun@gmail.com>
>
> I am still a bit worried about the kstrdup_const() that this
> introduces.

Forget it. I realized after actually reading the code
for kstrdup_const() that it really does exactly
what we want.

I should stop assuming things are syntactic sugar
in the kernel, we have some really smart people
working with it...

Patch applied.

Yours,
Linus Walleij
