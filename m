Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0550C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D4D20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SFsnE9EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D4D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936960AbeFRX2s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:28:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39144 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeFRX2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:28:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so8243001pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=pjXS1+LV362gSXvNkj7KeQjqktSlRRHt4/hm/Vc+7l4=;
        b=SFsnE9EWXROVCmGGdSWSVFHYmy/g4qFvUK0vAL/tPCAayQ4UXGcboNAGp2JLo4sG+K
         gXYlUWx75tDvS577EScFCZGZ+1shq23htTvMS43nc3dtqVGoE72n9+wvKBbZDrlizrM8
         HPPZrXNROiz71WnuGtLDk3vX51Oym/cxHcLUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=pjXS1+LV362gSXvNkj7KeQjqktSlRRHt4/hm/Vc+7l4=;
        b=OkUbk/EZo60GJgMHiePPHBYtwq0rUZC7UHd8wHpZvD9/mnwpUwECJY5sHShDmnumhL
         qACUeFNFSk9lzteG8vzOlp6hreBkwXU4XnXekyX8icnUQYLAUQgrT8LOy8Vz7iSNg9ET
         qQtIcOT5/Bw6wU/wkbZ1smuA6vL9kmkfoABe1TOetyCHuqZPTpyxCbA3HaXL+l7fDUsD
         j/ZhDtaYGv007tOBWX2cAh5/O3rJmgFBYdWSXomImIUNCKpsIfWWvjKAqr591Yj03w+U
         gTuG697NY9jsBID2qpynWH+tuViMWYE5+l8K/LVrY3rX1mWiTji48Enh71mNuhGs6sBT
         ZH4w==
X-Gm-Message-State: APt69E0cQEzPWYUbWh7zDblETgYynt9NBeDpWbjJESgWsfdYBGgXGzqX
        YhZMCADnHVlfwuHesPY2gDzdvTdZZws=
X-Google-Smtp-Source: ADUXVKK9sKJ9qE3Rb7pC2uwGJPGz4UuYXD3DaSRGFb3M/YgSHZvqjGO6bva1uFAq7NnJuSzKlwvbvA==
X-Received: by 2002:a63:6fce:: with SMTP id k197-v6mr12755148pgc.307.1529364526522;
        Mon, 18 Jun 2018 16:28:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id o77-v6sm28154574pfj.0.2018.06.18.16.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 16:28:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=WvsY_=Ko2QXvzmHOuy4O5Rh6+sRWZZOuSXyGC829ANag@mail.gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-2-swboyd@chromium.org>
 <CAD=FV=WvsY_=Ko2QXvzmHOuy4O5Rh6+sRWZZOuSXyGC829ANag@mail.gmail.com>
Message-ID: <152936452512.16708.5405608343995548468@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent
 latching
Date:   Mon, 18 Jun 2018 16:28:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-06-18 15:43:06)
> =

> On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> =

> > +        */
> > +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> > +               val &=3D ~BIT(g->intr_raw_status_bit);
> > +               writel(val, pctrl->regs + g->intr_cfg_reg);
> =

> Do you know if it's important to do a 2nd write here, or could this be
> combined with the next writel()?

I haven't tried combining the writes. It felt safer to keep them split
up so that both bits don't toggle at the same time, but I don't know if
it actually matters.

> =

> > +       }
> > +
> >         val &=3D ~BIT(g->intr_enable_bit);
> >         writel(val, pctrl->regs + g->intr_cfg_reg);
> >
> > @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> >
> >         val =3D readl(pctrl->regs + g->intr_cfg_reg);
> > +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> > +               val |=3D BIT(g->intr_raw_status_bit);
> > +               writel(val, pctrl->regs + g->intr_cfg_reg);
> =

> Same question about whether this could be combined with the next
> writel().  ...although I could imagine that the answer might be
> different for mask and unmask.

We probably need someone from qcom side to determine if these can be
combined. I can give it a try and see if anything goes wrong but my
confidence level will only be anecdotal. It's worth a shot.

> =

> ...if it can be combined, you can totally get rid of the "if" test and
> always "OR" in the bit, right?

Yes.

