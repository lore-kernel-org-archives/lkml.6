Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3BFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EfgaflS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E6220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757273AbeFSVOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:14:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbeFSVOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:14:39 -0400
Received: by mail-pg0-f65.google.com with SMTP id d2-v6so422024pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=UfVpYLMkiEezXrSyrE8F4Q2ue2/44iKrXd204CM5HGA=;
        b=EfgaflS49yEhbl8/2W76wxAQZryonrrLuHbK6hBl5n1vQ4Nb6hAjDwI5SUkX87uWaQ
         t3Yh6sPtu5Hp0giySfhsTkJMohI/p+MIQGYARAMzI6+kiQN8XBXpfdjNnjI5xv3OaIXB
         uvsqudrPA8/iKPYJpT9EWXHMGa3z+KNo8eJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=UfVpYLMkiEezXrSyrE8F4Q2ue2/44iKrXd204CM5HGA=;
        b=oDPj859G/+PPQRMIs/sFhXYPlUGR+VHnSM7ZHle3Vne0eSIn4q8emHazMvMDL3xUaZ
         Gl+JDYYCaig9Mv2xC5s2G/HEy5BeuZDsNm0DuzBmgcDzSrWTNnMPZ5w1hfeGNH1Qp6od
         yPaxcjtJOeIrYRRCTvzNAlEN4cV6c0wfmuqAORzGkIdW1xuPYewL+O6ppnCvzzGlx9Qh
         mjTVXI1wpyDpiDz8yphTHuud9ZnYmYdoRFtD1YTHuxAhRhc74ebnY/y+OhmB49HTENcJ
         KX5Zi5lzcQJnw4Sy2n3PZ3fu5vnm9GeIBACGPlxfTKHFORLmKHbseOr7GoHltDamoIZn
         zEJw==
X-Gm-Message-State: APt69E1/Apo99JbokUkQYObnkzO63zkqhyWJBygg6eUSXc4lkEQfQT8C
        Lo65phq0jMvzIvKQ94dr+DKXcA==
X-Google-Smtp-Source: ADUXVKJfv+KwByCMO9+sSx9EAs76kT1N5jrZ10m3xgaRXZQkggeCrcAqJedpRF+2JKKvQo9IxFyNjQ==
X-Received: by 2002:a62:ccdc:: with SMTP id j89-v6mr19666557pfk.232.1529442879315;
        Tue, 19 Jun 2018 14:14:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id f6-v6sm755613pfd.112.2018.06.19.14.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 14:14:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=UhfffG__41+5yeiDEdN1DYeTkXEoqasc23fb1YKg9F9Q@mail.gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-2-swboyd@chromium.org>
 <CAD=FV=WvsY_=Ko2QXvzmHOuy4O5Rh6+sRWZZOuSXyGC829ANag@mail.gmail.com>
 <152936452512.16708.5405608343995548468@swboyd.mtv.corp.google.com>
 <CAD=FV=UhfffG__41+5yeiDEdN1DYeTkXEoqasc23fb1YKg9F9Q@mail.gmail.com>
Message-ID: <152944287756.16708.13539547406156946230@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent
 latching
Date:   Tue, 19 Jun 2018 14:14:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-06-18 16:38:27)
> Hi,
> =

> On Mon, Jun 18, 2018 at 4:28 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Doug Anderson (2018-06-18 15:43:06)
> >>
> >> On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wr=
ote:
> >>
> >> > +        */
> >> > +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> >> > +               val &=3D ~BIT(g->intr_raw_status_bit);
> >> > +               writel(val, pctrl->regs + g->intr_cfg_reg);
> >>
> >> Do you know if it's important to do a 2nd write here, or could this be
> >> combined with the next writel()?
> >
> > I haven't tried combining the writes. It felt safer to keep them split
> > up so that both bits don't toggle at the same time, but I don't know if
> > it actually matters.
> =

> Maybe I'm a glutton for punishment, but I'd say go for it, unless
> someone from Qualcomm says "no way".
> =

> In the very least in the "unmask" case it seems pretty safe.  IMHO if
> re-enabling the "raw" status caused a glitch we'd already be hitting
> problems.  Specifically the glitch would end up getting latched
> (whee!) and then we'd unmask and see the glitch anyway.
> =

> ...and actually for the "mask" case it seems like you've written it
> the less-safe way anyway.  We know that masking can't cause some sort
> of glitch (since that's the old code), but I guess we don't know
> whether disabling the "raw" status could cause a glitch.  To be the
> absolutely safest you'd do the new disable of the "raw" status _after_
> the old masking.  ...but as per above I'd just go whole hog and
> combine them.  :-P
> =

> As with everything I write, feel free to tell me I'm being stupid and
> I'll try to shut up.  ;-)
> =


I've tested it and it seems to work by combining the writes in mask and
unmask. I will resend it with the combination tomorrow or the next day
in case anyone else has comments on this series.

