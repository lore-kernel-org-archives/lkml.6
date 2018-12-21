Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FED218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCOiIs3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbeLUKfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:35:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37371 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbeLUKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:35:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so4283841ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVUYF/8jFUKF3l8k1m6bbFRl8oTfVHO8Ex5smAQ9TVk=;
        b=JCOiIs3NHZX+mGhpRUVtP7EQik2MB3menUC27F3JQt2LpyiRDsnrsmVv0K/46ZSl7B
         enxKDJRcbqbDWtLAC7rRixZeRaI5NpDgEHhyT7PhdSDK8tDzo21K0QncPWRhLZiFniyQ
         47TajbVyakn8pOJBbNVdO0yd5QHo2MUFQahVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVUYF/8jFUKF3l8k1m6bbFRl8oTfVHO8Ex5smAQ9TVk=;
        b=OQJnW52fR1Kr+TSyXBsgkqlUSDgFajoQodvrJ5R3NrrNBYaMgL/hL3L4fyAMCObk+f
         LKah6ktJdOybmgjeAR4rW6p8JJOKyYf4OC9l4vS/Vo8meglJUI/x2s3puN8bfeJwfPqn
         kQaeASVXTuUGr8LfKaMQf+wvTjG3+14XV+Svupki/u2484W3boMmX0Ug4js7HPaOe29s
         Okucmh1cBlDikNMGgQPGz6Zb99vINfuX31Oe7/rSiuDl7DyV81+L3W7DlKZaHdpMM09O
         31/Fqgljt8aRzb0x38m7nqORnTNtafTAlRo3USqna/eOUD5uNtg56JQfF3KZAyy9hluC
         HYkQ==
X-Gm-Message-State: AJcUukdtDjt/+ykhIO4xnxOHeryU0Vp+xElFBWVi+xTeLdKW2w4HzSJd
        9EDR6otfGIN46AWwnrcAcCAVFgYR0t4r2fBfcsQufQ==
X-Google-Smtp-Source: ALg8bN6mQ+OdH/HOvXU746KdSxYrlWxWmnUCuPLB2Kwn+jlrCIsAYrOHlEk2bkoFMVXl6+PLFrpB8P4avr4EGgsPyN0=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1231982ljj.9.1545388506453;
 Fri, 21 Dec 2018 02:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
In-Reply-To: <20181217153652.20056-3-jank@cadence.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:34:54 +0100
Message-ID: <CACRpkdbw9sQoE0R9=KBkkEfZgmLnS7mLGsthRZ98AqJjGhgvzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Jan Kotas <jank@cadence.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:37 PM Jan Kotas <jank@cadence.com> wrote:

> This patch adds a driver for Cadence GPIO controller.
>
> It can be enabled with GPIO_CADENCE Kconfig option.
> It uses generic GPIO infrastructure and works
> as an interrupt controller.
> At the moment it only supports level sensitive irqs.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>

Patch applied.

Yours,
Linus Walleij
