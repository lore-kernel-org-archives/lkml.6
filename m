Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C27C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208520779
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfsW14JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3208520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeHPVTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:19:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40215 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeHPVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:19:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so2427506pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=qJMHuHTVGhwnr6L5S/TZGf6QH3njnufBnAhGikZ9RDc=;
        b=jfsW14JSzLMGgiYv0j91nPGD0SVLXycJWLTVcuIVQkzqq/x3wzKCW88uPh84dS9YCt
         p9DB5qq4CFgvAKEEKyX/e+JxvdhTpdEWbgIIzHz9mhXLaX1LUXiI94EGUH3ioUPLIQGx
         +5s/D+KjTMqjzwCw6Hue22IfYd+LgbTi+p3AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=qJMHuHTVGhwnr6L5S/TZGf6QH3njnufBnAhGikZ9RDc=;
        b=ucodJOwhiI6QGohw2QNfibtMC+LrSAL2hA47QY1M0TeNyonc8sul6YQwYsEqfBR5ZZ
         abX5YgbJUtaOXeGWlykiAqvr423qQm0pyi2bFJDImX1SENVcxFh2f9D8+7yOAc5su7bx
         YkkYxpvndZMqF6lzUusVgwzPU7i4VlnGNN7tE/4wvVTVvXS20Xu3CMr3BoFG01Ba3KIP
         RuQ8KTH508MlvEyA4P6+gZi+umda9vaDDN/SXnFaFfaEYHkIvNhr7FGWhCnjejjZTrEt
         i+Ypv7IOLMlZKZqLe/Kfgn6QyMQAEVtRyrvLbmr4dN10c0KbQpJCkuSWuP0ILr1+LqZ9
         HnTQ==
X-Gm-Message-State: AOUpUlE9pb3sKYn5LsABoB+Nhs5cSVFKc+qB3bSQ4elLSUHbiAix66C5
        FmNc/EH3bg8ca9cK8HUCn0Ti+A==
X-Google-Smtp-Source: AA+uWPy0CI9nOk5JFm6ydrxK1Q1l2dZnQWz7NiY/DKnhiaZe+K1wokLQgQWNZ4zuIn7mCrpvnhCEGQ==
X-Received: by 2002:a63:8dca:: with SMTP id z193-v6mr30169579pgd.228.1534443578609;
        Thu, 16 Aug 2018 11:19:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id e14-v6sm31138706pff.128.2018.08.16.11.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:19:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=V8ujNN-jxOm6a_OthyQFGucbv0-1Du3BjScVPKPz-Tsw@mail.gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180725222900.33231-1-swboyd@chromium.org>
 <20180725222900.33231-2-swboyd@chromium.org>
 <CAD=FV=V8ujNN-jxOm6a_OthyQFGucbv0-1Du3BjScVPKPz-Tsw@mail.gmail.com>
Message-ID: <153444357718.28926.1637234742079120461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] pinctrl: msm: Really mask level interrupts to prevent
 latching
Date:   Thu, 16 Aug 2018 11:19:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-08-13 16:53:42)
> Hi,
> =

> On Wed, Jul 25, 2018 at 3:28 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/=
pinctrl-msm.c
> > index 2155a30c282b..3970dc599092 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -634,6 +634,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> >
> >         val =3D readl(pctrl->regs + g->intr_cfg_reg);
> > +       /*
> > +        * Leaving the RAW_STATUS_EN bit enabled causes level interrupt=
s that
> > +        * are still asserted to re-latch after we ack them. Clear the =
raw
> > +        * status enable bit too so the interrupt can't even latch into=
 the
> > +        * hardware while it's masked, but only do this for level inter=
rupts
> > +        * because edge interrupts have a problem with the raw status b=
it
> > +        * toggling and causing spurious interrupts.
> =

> This whole "spurious interrupts" explanation still seems dodgy.  Have
> you experienced it yourself, or is this looking through some previous
> commits? =


There's a similar comment in the code already from the initial commit.
See msm_gpio_irq_set_type() and this really old commit from downstream
kernels[1]. I haven't seen a problem with this myself, but I believe
there have been problems with the mask/unmask causing an interrupt to
latch into the hardware just because we change the raw status enable
bit. For level type interrupts this isn't a problem because the level is
'present' when we mask it so toggling raw status can't cause a spurious
level to be seen.

For edge types I don't believe this is a problem we need to solve. We
may mask the edge because it just keeps coming during IRQ processing and
then when we ack the line while it's masked it will be cleared out of
the status register and only relatch when the edge comes back. It only
becomes a spurious irq if we toggle this raw status bit, but we don't
ever need to do that for edge type interrupts because we always want the
edge to latch into the hardware after we ack it (even if it's masked).
So the irq status for edge types should always be forwarded to the
status register and it should always latch into the status register, but
when the irq is physically masked we don't want the CPU to be
interrupted when that happens, we just want to remember it happened to
make sure we replay the interrupt later on unmask.

> As per my comments in v1, I'd still rather the comment state
> the reason as: it's important to _not_ lose edge interrupts when
> masked.

Ok! Let me try to rewrite this comment with the reasoning for level and
edge types.

> =

> =

> > +        */
> > +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> > +               val &=3D ~BIT(g->intr_raw_status_bit);
> > +               writel(val, pctrl->regs + g->intr_cfg_reg);
> > +       }
> =

> In v1 you claimed you were going to combine this with the next write
> (you said you'd combine things in both mask and unmask).  ...is there
> a reason why you didn't?  As per my comments in v1 I believe it's
> safer from a correctness point of view to combine them.
> =


Hmm I seem to have mis-copied the patch from one directory to another.
I'll resend with both combined because I tested that.

[1] https://source.codeaurora.org/quic/la/kernel/msm/commit/?h=3Dmsm-3.4&id=
=3Dea45a49ee524cfafe136c0ac67623e64e614ba27

