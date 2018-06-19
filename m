Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C646C28D1F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8720652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxkXmGHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C8720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757315AbeFSVSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:18:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45850 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbeFSVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:18:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so426955pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=3qUwMgKqk1SJ2TCI4jnHNrEpm1b2mnX/hiMz+wz1siU=;
        b=VxkXmGHlNWM0Kg2IOf+mXhFjNqflJCa8cW/9NqR3StmOpgbsLu0NoGsFpEALTr78wz
         l3M73iP2uRVxJAYhFpkERUMdnFrgk0smu8wcaj4sft9p/hN5n5QhifoepppMsvPH0IP6
         VsA2dxQio4kv6QeplCgP8zQoO1mTLSGPp0f98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=3qUwMgKqk1SJ2TCI4jnHNrEpm1b2mnX/hiMz+wz1siU=;
        b=inHC/fvWgNMT9aPqXX9ss9GLS+7FOep6JDRqXShY0sPlfYuKYmYB42zs0LnIi6v3jC
         8fERmFFgK6ggkWHhpgzde0KsER5wuIimTTl980eYsO5vM9Evq6b4RgWMrDbMyAjkjjO/
         Y0gL2mtMq3JTlxxoDogNK9XRIVaARTCCwp938mbUDyoa8SxJV3Y4KDyU8X+Yazt5UHyL
         UTEC4RupoK0At60QEcaN551F+XYcj1T58oNMg+rw3VEfNWO6H2OaZxCSH0AD2xyZbE29
         oECfLHFoSttK4HOG2ol5pdTz3G0YYJtV40bY6P/57o0jMUvrPXCt7DCHzM5iikS+ZC+V
         ZHlg==
X-Gm-Message-State: APt69E0MMaT87kbQmGaYW0xwPVcugJ6PYIudRnWyt8YGv1m/HqPMT5yO
        4NiwKuakIlUfNRfa0Gbix9Gk+g==
X-Google-Smtp-Source: ADUXVKIBNOrEoj4ztcTe2/H6bxDy0ZMROxWOVXWTFN/ygLFcsB3FmjLls0WA0HjaUtaaA9FxxK12JQ==
X-Received: by 2002:a62:10c2:: with SMTP id 63-v6mr19769211pfq.229.1529443118519;
        Tue, 19 Jun 2018 14:18:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id y23-v6sm835361pfa.73.2018.06.19.14.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 14:18:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=VpFR4hpREnWpvG2MQAONheKtNfLkyNM8-AFXMcGD7OPQ@mail.gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <CAD=FV=VpFR4hpREnWpvG2MQAONheKtNfLkyNM8-AFXMcGD7OPQ@mail.gmail.com>
Message-ID: <152944311714.16708.13638961630238512631@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Tue, 19 Jun 2018 14:18:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-06-18 16:54:49)
> Hi,
> =

> On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> > We rely on devices to use pinmuxing configurations in DT to select the
> > GPIO function (function 0) if they're going to use the gpio in GPIO
> > mode. Let's simplify things for driver authors by implementing
> > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> > function when the gpio is use from gpiolib.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/=
pinctrl-msm.c
> > index 3563c4394837..eacfc5b85f7f 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev =
*pctldev,
> >         return 0;
> >  }
> >
> > +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
> > +                                  struct pinctrl_gpio_range *range,
> > +                                  unsigned offset)
> > +{
> > +       struct msm_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> > +       const struct msm_pingroup *g =3D &pctrl->soc->groups[offset];
> > +
> > +       /* No funcs? Probably ACPI so can't do anything here */
> > +       if (!g->nfuncs)
> > +               return 0;
> =

> Is there a reason why you'd want to return 0 instead of some sort of
> error code?  Wouldn't you want to know that this pin can't be a GPIO?

On ACPI there aren't any functions and thus all pins are GPIO mode and
only GPIO mode if they're used as GPIOs. At least that's my
understanding of how the ACPI version of this driver works.

> Another non-ACPI example is sdc2 on sdm845 and it seems like you'd
> want to know if someone tried to set one of those as a GPIO.
> =

> ...oh, but I guess ufs_reset also has no funcs but it still probably
> wants to use the GPIO framework to write something.  Hrmmm...  Maybe
> check if either in_bit or out_bit is not -1?

ufs_reset and sdc2 aren't in the GPIO chip's numberspace so I don't
think we need to care? At least I can't convince myself that those pins
would eventually call into the this function. We could check if offset
is greater than ngpios for the chip but that seems useless if higher
layers are handling this already.

> =

> =

> > +
> > +       /* For now assume function 0 is GPIO because it always is */
> > +       return msm_pinmux_set_mux(pctldev, 0, offset);
> =

> nit: should you be consistent with msm_pinmux_set_mux() and call it
> "group" instead of "offset"?  It looks like it's supposed to be the
> same thing...
> =


This is copying the generic one and the function pointer prototype, so I
think it's best to leave it as 'offset'.

