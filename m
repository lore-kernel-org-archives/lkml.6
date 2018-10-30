Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DEFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ADE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nw4XZf6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ADE20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJ3U7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:59:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeJ3U7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:59:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id a28-v6so8064462ljd.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLQSdcEls+mBlGEQFOcPvN6Qp0nCYaM+a3gIIuK7UX8=;
        b=Nw4XZf6bGidUvG8CRi9aD++e87bkl9zzNOq69xLafK9gXE5ypzF2cgrgs1+rVDP9lL
         OzvOnNV2gi//LmkCrdMk+N93dwv7Ybi+AF8tAt+MANMe97zxobAJ8WUiaaymNgzk0eJB
         5tI2pA6VsIbg7cvqbqof3wXLQiYC7y/7EAdL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLQSdcEls+mBlGEQFOcPvN6Qp0nCYaM+a3gIIuK7UX8=;
        b=WJR5334t3U0dukHTowt2fJlNZ8udEM7BQ1KXVf8ncI59wKWAWgMX7v8bGPcZ+rSGcr
         m4WSGTIqOENqgmSyfvWrZsgrcnk4dHzaRr7dCyjTywQv4GFmfUxE4B9KZK8y/Mie3kR1
         dRC6oLQPxHv3kbtKI2hRt4pYF4KIY14g5KThj963zXX8b4FGMT5L4NtKaIUYF2LySoBR
         sScviGnepQOPCux8XXyNUs18ADdYbTn/cYpCSGZ5+WvTaFsnoH2K76TzwknDZL6UntRs
         HsH8THjfpubSQzm9y7qhVph7NcfiUoocM43t5tJZeHDWJfccNhSPGRpPnwY1/s+omPZd
         KjDg==
X-Gm-Message-State: AGRZ1gIwI0B/K94AljMVT2feBsACvVr50RCpVRRcQ36NmnLaqOiqUhgL
        o2cMVaPrh46SVdymYU1lLbPKFcmu1AOuyZrt+F14dA==
X-Google-Smtp-Source: AJdET5cgRgi+RrpFz4n14x+KVxkHCHkKyL+iJh57Ghlyg7jdhOw//RYZG3kA2PyNSqZorWiJ4H/o7+lYPzRJdwInVdk=
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr6510691ljc.120.1540901200086;
 Tue, 30 Oct 2018 05:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181017213012.233957-1-kunyi@google.com> <20181017213012.233957-2-kunyi@google.com>
In-Reply-To: <20181017213012.233957-2-kunyi@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 13:06:27 +0100
Message-ID: <CACRpkdbzhRMB1gr6CUVdref15v1S5DjHaUxi6=BOYoc3f_ZCrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-mmio: Allow volatile shadow regs
To:     kunyi@google.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        avifishman70@gmail.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:30 PM Kun Yi <kunyi@google.com> wrote:

> Currently the generic GPIO driver stores the direction and data shadow register
> when the driver probes. However, in embedded SOCs the GPIO pins are often
> interleaved with pins muxed to other functions, and pinctrl driver might
> toggle the direction/data register values for these pins. With GPIO
> driver being not the only owner, it should read the shadow registers
> before updating them, otherwise some pin states would be overwritten.
>
> This patch adds a flag BGPIOF_VOLATILE_REG to allow a pinctrl driver that uses
> the generic GPIO interface to indicate the need of read-before-update.
>
> Signed-off-by: Kun Yi <kunyi@google.com>

Hi Kun,

as you see the build robot has problems with the patch, please look
into it.

Architecturally I'm not so sure about this, we are introducing more
and more "shadow registers" and I feel what happens at the end
of the day is that we end up reimplementing regmap-mmio.

Please look into switching gpio-mmio.c to use regmap-mmio
and add more registers based on that.

It might be a bit complex but is a way better way forward for
everyone.

Yours,
Linus Walleij
