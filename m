Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EACC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498712073D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfBMLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:32:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37549 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBMLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:32:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so1629458edv.4;
        Wed, 13 Feb 2019 03:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ej2HPo48zSYWpfb8Z7VwdI7nxMv39cKnnirC71cYBxA=;
        b=FnXS5tmcDec+rmeGxp4m0cTGNzeOfZFukR+nQjoL7//2K0CU81lJVcdT/QTpxv/t5N
         R8NZ1t5LMrK/w9GfIshLDNwixLq80WtKefHLC8uLzvAW4J1mu1yZKvrPZwmqHA458Pga
         UNXp85NYYqMO1faPQyguH6HW/vBL5TxPJTEuWMQ4jeHi4PjM+oKYt0QQlfUVUX2LHffE
         fOTFVf0F7IxKQCej5Irp0+E33AUyrpOmT0qLsbTpB9mcNS7SJJzghDW9BquZmh6FkeZc
         eUFsmhLnM/1evvXFVMBTKJRk/szkHELXcnl961QV/CutZ25TmWZHe8bgypCUOdhSAFbn
         3r4A==
X-Gm-Message-State: AHQUAubf3voj+J4555U/7R5vucNULdj27eFQoGPvYVuJ1smZJ/yJ973V
        nbDRtceT7na2DyWjHrSxjlyeXCQsiIY=
X-Google-Smtp-Source: AHgI3IayyjeFVVkGWqNHT4x2BEbHdnKfHiDH1vXh1EQW4idPDuQ6OLkuy7pOkC3pEJl8AgfKrgYAxQ==
X-Received: by 2002:a50:8fc2:: with SMTP id y60mr33623edy.78.1550057532366;
        Wed, 13 Feb 2019 03:32:12 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id f1sm2755635ejl.65.2019.02.13.03.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 03:32:12 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id x7so2063448wmj.0;
        Wed, 13 Feb 2019 03:32:11 -0800 (PST)
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr48932wmb.14.1550057531489;
 Wed, 13 Feb 2019 03:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org> <20190206033239.3619-2-wens@csie.org>
 <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
In-Reply-To: <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 13 Feb 2019 19:31:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VSvr9x8N3nXrtz5QYLf95K0BA8+VEqiVoXfmxVnFsJg@mail.gmail.com>
Message-ID: <CAGb2v64VSvr9x8N3nXrtz5QYLf95K0BA8+VEqiVoXfmxVnFsJg@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on A80
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Corentin Labbe <clabbe@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> > The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> > settings would make the affected peripherals inoperable in some cases,
> > such as Ethernet RGMII signals biased at 2.5V with the settings still
> > at 3.3V. However low speed signals such as MDIO on the same group of
> > pins seem to be unaffected.
> >
> > Previously there was no way to know what the actual voltage used was,
> > short of hard-coding a value in the device tree. With the new pin bank
> > regulator supply support in place, the driver can now query the
> > regulator for its voltage, and if it's valid (as opposed to being the
> > dummy regulator), set the bias voltage setting accordingly.
> >
> > Add a quirk to denote the presence of the configuration registers, and
> > a function to set the correct setting based on the voltage read back
> > from the regulator.
> >
> > This is only done when the regulator is first acquired and enabled.
> > While it would be nice to have a notifier on the regulator so that when
> > the voltage changes, the driver can update the setting, in practice no
> > board currently supports dynamic changing of the I/O voltages.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I merged the v5.0-rc6 into my devel branch and applied this patch on
> top now.
>
> All the DTS file changes should be merged through ARM SoC, and
> they should work fine now.

Thanks. Maxime actually merged them last week.

It seems this isn't in -next yet. I'm not seeing it in your git.kernel.org
repo either. Might be confusing for others that want to try it out.

ChenYu
