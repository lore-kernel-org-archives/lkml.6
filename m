Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B178EC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5236920881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k16TDRkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5236920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeG2WQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:16:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40011 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeG2WQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:16:14 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so14136087ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+nB2kG60q1S99d5DA0vKgpccrOIC4fcn3RuZpQMn+M=;
        b=k16TDRkCMzebNyfyOe7Dd1OmIwpTcc2QiyoUZjIzWLbwHNipQr1IYCZ5Ax0BbbCk8N
         dO0GWHNruYfvMt/RgD4bIbRySzudgLYlDQR4H1TJtTOXOBjsAb3A+OFzUsALO6Ww3gaO
         pNXHr4pnTZD89YJnQNwi/yslJprgHYgP5rnX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+nB2kG60q1S99d5DA0vKgpccrOIC4fcn3RuZpQMn+M=;
        b=KJMxE5KC0epwHDMrDwxdOEGtJVNwLaSs7oRIop2iz5XjDwq2CrPapQLebGV+8+ezHP
         GgjB49PiKk0Bya2xbJnHvwGEx4CL2cNvYC+XuRQHOREKlqPD9l+2uRFuBS/vreEjtWN3
         /WwakgDXLKXC7qT7e1+hnqi2q+TQ+5wFa4USC9iIwoO/u5h+kUVTY+Ck+WljcaeaDON1
         NeIFn/CPojWhiumWeb4N501ll4WruHsDNW7RjVwDGnPXhcpJMvZ6nSvgA1Rxg34IzFuE
         gB7iXYLJj20tyY4mNri64/sSuQZs/DFKeAubHHttGvk9LgYLycFwxDW2jQeOltebDbvw
         5ZTA==
X-Gm-Message-State: AOUpUlFcClSqLcCbaB2NDQ01xQEJZjqz4jvNkZeOe/gDw8pfslVmGHIl
        rXN7//IaJE+tgT2ufd/aOSfnPZJSkqJanARuh0WrXg==
X-Google-Smtp-Source: AAOMgpd74ZazA/mAzhUJYGl2cRT6SkWku9i6i1IUeNMElI7euFE66ee/m/bklm4pVeFwK5R/kGqIlpwLUTJGLb7/CHA=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr12104707itb.38.1532897069127;
 Sun, 29 Jul 2018 13:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180717005719.258905-1-djkurtz@chromium.org>
In-Reply-To: <20180717005719.258905-1-djkurtz@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:44:17 +0200
Message-ID: <CACRpkdbL85B9aGAbJ4U146jsxXgDSdojEO8=y5h94edpsXwsPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl/amd: only handle irq if it is pending and unmasked
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>, Daniel Drake <drake@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 2:57 AM Daniel Kurtz <djkurtz@chromium.org> wrote:

> The AMD pinctrl driver demultiplexes GPIO interrupts and fires off their
> individual handlers.
>
> If one of these GPIO irqs is configured as a level interrupt, and its
> downstream handler is a threaded ONESHOT interrupt, the GPIO interrupt
> source is masked by handle_level_irq() until the eventual return of the
> threaded irq handler.  During this time the level GPIO interrupt status
> will still report as high until the actual gpio source is cleared - both
> in the individual GPIO interrupt status bit (INTERRUPT_STS_OFF) and in
> its corresponding "WAKE_INT_STATUS_REG" bit.
>
> Thus, if another GPIO interrupt occurs during this time,
> amd_gpio_irq_handler() will see that the (masked-and-not-yet-cleared)
> level irq is still pending and incorrectly call its handler again.
>
> To fix this, have amd_gpio_irq_handler() check for both interrupts status
> and mask before calling generic_handle_irq().
>
> Note: Is it possible that this bug was the source of the interrupt storm
> on Ryzen when using chained interrupts before commit ba714a9c1dea85
> ("pinctrl/amd: Use regular interrupt instead of chained")?
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Patch applied with TGLX ACK.

Yours,
Linus Walleij
