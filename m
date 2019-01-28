Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D08CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuyoevGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfA1Nr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:47:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43165 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1Nr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:47:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so14256098lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 05:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nSJhovzmv2yQ0lL68aVZPNBzA6Yw/IQyBcYR9dgDbZU=;
        b=AuyoevGV3abxHR3a8b5VD4QJTd2YUMrehAgoGoIaXdbd/aBsDv4Bktb1w7dntPBYWQ
         Yn4BWH9tyD7fAFJqbHkvF6Of4q1mhhc4DKuJ9rELk3QzQS+qks1ZpG2SslUBcCcidb/1
         4+9BsPDpxIim3V5maNkTxZnmzpCwJhFGMERto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nSJhovzmv2yQ0lL68aVZPNBzA6Yw/IQyBcYR9dgDbZU=;
        b=T1g+LuLCxl5IQdaeFybGjKyjqrfTAqdkRIu/c2knW8SB9oT2hJbl5Y7lR29+maGhQf
         6rWoChZ3HPCZ0vX/4wshmyPzag9AMylY1uEdN7sLNTrsZItbeGe8L56xojJJdo2Wjg3c
         dw+Zy7SR0sJRp91cxClGkRBbqutloYHRHSfy5gbcfSKNaalEDd6TGtDyr70p15UyHcRY
         Dzt7tNULn5BDqXFi/PXgsN4s9zPJtxiWh7okqoJDrMHN7M6+XYrTgdHLZIYGVoo7/7Kc
         UJXZqg9BE73uiQNLx6X/lMUyqeJJf4cxV8AD466IY7CI0bUIdLBK+TvsQ56cjtwzz+UU
         n34Q==
X-Gm-Message-State: AJcUukdjFmB2Oy/JQFp3x3aeGC04T6+krhrrHKoMw81fw3vbTDV4vINF
        ZP5kkfuXjoG5qxWLSgL1Gf8PcJeOx5vM5SKFKzuN1A==
X-Google-Smtp-Source: ALg8bN6mVAV/KgIgomUBRzNGCt+nVx/1OthdUVRdGY3K/DUBNJzQ7b4wyGsyhXEwdZV9I6cV8qesCQclaEVx7BVmcxM=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr17324769ljb.153.1548683274535;
 Mon, 28 Jan 2019 05:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20190123141538.29408-1-brgl@bgdev.pl>
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 14:47:43 +0100
Message-ID: <CACRpkdYCrLap=+cAxqnq=+jsWwe7YfZ1b8s+wQ==sQKSxXq9-w@mail.gmail.com>
Subject: Re: [PATCH 0/9] gpio: mockup: improve the user-space testing interface
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 3:15 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This series aims at reworking the gpio-mockup debugfs interface. The
> reason for that is the fact that certain known problems with this
> testing module exist and the user-space tests are broken anyway
> after commit fa38869b0161 ("gpiolib: Don't support irq sharing
> for userspace") which made it impossible for gpio-mockup to ignore
> certain events (e.g. only receive notifications about rising edge
> events).
>
> The first three patches improve the interrupt simulator. The first one
> makes the struct irq_chip part of the irq_sim structure so that we can
> support multiple instances at once. The second delegates the irq number
> mapping to the irq domain subsystem. The third patch provides a helper
> that will allow users to check the current configuration of a dummy
> interrupt and decide whether it should be fired depending on external
> logic.
>
> Next six patches improve the gpio-mockup module. Patches 4-5 have been
> reviewed before but missed the last merge window. Patch 6 is there
> because we're already breaking the debugfs interface anyway and it
> removes a link that has no users. Patches 7-8 are minor tweaks.
>
> Last patch introduces a rework of the debugfs interface. With this
> change each mockup chip is represented by a directory named after the
> chip's device name under <debugfs mount point>/gpio-mockup/. Each line
> is represented by a file using the line's offset as the name under the
> chip's directory. Reading from the line's file yields the current
> *value*, writing to the line's file changes the current "pull". Default
> pull for mockup lines is down. More info on that can be found in the
> comment added by this change to the gpio-mockup code.
>
> This is somewhat inspired by the idea of the gpio-simulator by
> Uwe Kleine-K=C3=B6nig except that I strongly belive that when testing
> certain user API code paths we should not be using the same paths for
> verification. That's why there's a separate interface (debugfs) sharing
> as little as possible with the character device that allows to check if
> various operations (reading and setting values, events) work as
> expected instead of two connected dummy chips sharing the same
> interface.
>
> If accepted this will of course require major modification of user-space
> tests in libgpiod once upstream.

I like how this is developing and how I see the two major contributors
to simulated GPIOs cooperating on this :)

It'd be nice to get Marc's feedback on the irqchip changes so we
can solidify that part.

Yours,
Linus Walleij
