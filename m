Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF092082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuwpxMVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF092082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLDS0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:26:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41621 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLDS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:26:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so8627384pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=sccmubOLUTItf+0brntkdqphxOPJEelFgdE2QEi1Pkc=;
        b=ZuwpxMVP9Yd3FsLyFhdC0p2Fga+181N172OBbvZLOmWnd7iO8sGMTmCoiksId+qR8P
         CQ9oYGBUlklN6mNjw3GyQJ00cx0/8hfHNb/F1S8g8sKoSj2J1JUI6BTjTy3ZVtojods6
         8utPbWguNXsmq/EMH6BEjIZZK8+0FeWOHqOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=sccmubOLUTItf+0brntkdqphxOPJEelFgdE2QEi1Pkc=;
        b=QSRdKMl8p6riSItDh1JefLJR5MOJTyceY8qrNoEGktbc5gCd9xRgQJcfxwhss4zQoX
         DukuRtQHmL5TQxmrjSXPiCRRgKZEa1+/9hvW4K5U4gU91hBKPi4C+Pg7si0gyNw+J8QH
         sUMhBnX4CfTpZEFqkHqoGcgaL0/wSe6DcMgr82sr8Rl95aP3IgNx/VQAVOSGzscWBPMJ
         uC7OaH5jyOCYWkcKZrURcv/EyPH+URojdZwUPr4wO3qhyoE8ATdzM2zw+Wz00kO/KjA9
         Pa2SckZtbZy239InAIZ9g37E+2az8YidHwKGcWXDvM19imA+dThNmJOQQX1DZpxPOWjX
         W2XQ==
X-Gm-Message-State: AA+aEWZj6Q/1cU0Wk6nGd1BMCdBjSHnM5wYH3Z9PyyCwnf8cIISCb8Yd
        6yPjLc5rbDE8olStdNgx9LtEew==
X-Google-Smtp-Source: AFSGD/W1q4GSz85hSjUZRBXIKC3NxNq20S0rv2QvvvWIWf9mYWG0644lNV/dUEJtPQqQLNKHwSyjkw==
X-Received: by 2002:a62:c28e:: with SMTP id w14mr21029424pfk.115.1543948009167;
        Tue, 04 Dec 2018 10:26:49 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id e23sm24567323pfh.68.2018.12.04.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 10:26:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Kaehlcke <mka@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181204173549.GB14307@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-3-mka@chromium.org>
 <154394184065.88331.4558186365546696323@swboyd.mtv.corp.google.com>
 <20181204173549.GB14307@google.com>
Message-ID: <154394800757.88331.14079790416847469573@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Tue, 04 Dec 2018 10:26:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-04 09:35:49)
> On Tue, Dec 04, 2018 at 08:44:00AM -0800, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2018-11-30 16:52:48)
> > > +
> > >         /* custom byte clock divider */
> > >         struct clk_bytediv *bytediv;
> > >  =

> > > @@ -125,7 +127,10 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_=
hw *hw, unsigned long rate,
> > >         DBG("rate=3D%lu, parent's=3D%lu", rate, parent_rate);
> > >  =

> > >         temp =3D rate / 10;
> > > -       val =3D VCO_REF_CLK_RATE / 10;
> > > +       if (parent_rate)
> > > +               val =3D parent_rate / 10;
> > > +       else
> > > +               val =3D VCO_REF_CLK_DEFAULT_RATE / 10;
> > =

> > Is the clk not properly hooked up to a parent sometimes so parent_rate
> > is 0? That sounds odd given the fact that it used to be 'pxo' and that
> > has always existed on the system as 27 MHz. So I'd remove this and just
> > use parent_rate all the time.
> =

> I wondered about this, but since I don't have hardware for testing I
> kept the previous hardcoded rate. If we know for sure that 'pxo'
> always exists it should indeed be fine to use the parent rate.

Yes we know for sure. The 'pxo' board clk is there on apq8064 dtsi file
which seems to be the only place this is used. The pxo_board clk is sent
through a 'pxo' clk that's created in drivers/clk/qcom/common.c
qcom_cc_register_board_clk().

