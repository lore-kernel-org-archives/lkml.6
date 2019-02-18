Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC292184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3QSlH2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfBRHMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:12:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41290 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:12:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id y5so2747138plk.8;
        Sun, 17 Feb 2019 23:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTK1AL7ej7DObcJq80YaSl+5Dn7gNlctj0UlCrdwvek=;
        b=A3QSlH2s4n9bdQGOfEvACGkpNWaShzC0KGKyIbYw/L0sGWyAt9mBpPh+GoJIyQpjew
         OGJQScKbzUrXdGH1ZUhVfjtxabV4kJ4wCSY7rxdqG+HI5mEpACj2koadRvlSuds1ZCAS
         3pQ29rYNubYXAYveOzAYD3QR01CX/hdnZYKmEq/JrjUaaFjwemVKXs1//2PMkgqacY9V
         XNjyLX30qNbjcnd/jwBEROxywl8fKjpobezqWvhHQxDT0wXgjDD1I9F7F27QSHE5OgZz
         ClcsrVpLgSfMXkTbBWzqx3lGS0mK5tyQmpUADfQfLpAsgw5IjG+Fw7AByiHyWihzaLdn
         LDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTK1AL7ej7DObcJq80YaSl+5Dn7gNlctj0UlCrdwvek=;
        b=H/ewSaB5t7gRIQ7sZDA5lHCG+4DY68SMdc/Iu7jE1uwB1KI34YmYjiC5ntttw7fMKS
         sXmCStKc2qDz+W+oElA79b+uFTjOLKfVrIOSsX7fjOBvVgDjDxW9PEBDVmWZkH2+GMKS
         qgG01rISgMLLKrz2RkIUYpegaVPvpRgF03797WEWODm96GvoU9jX6PoSsXg11fPzA7k9
         OOeq4xUk3H9CwfqWyipCPiXskKD/4IlsaWJBFpgmUn9j84g7hr+vtfjw8Pr1yoLXfhOy
         PfmoFMbkD+/Hs7W9/0ZzNaDasmgTxZDJy+iKniY+AdZ+sAytioEzyfzneLZmR5kg3pdt
         1e4g==
X-Gm-Message-State: AHQUAuZDmnhgEQ+oaUGD7MH/xzN9AUXOVip8WHCMMf2DHYrSAjfue7or
        PQLhNSZPNoSEz3RJjbbd7UTCmcox
X-Google-Smtp-Source: AHgI3IYgX4ezi6IMxEEV0CLwg8nsD/IC8N6QWS8dRgfjsY5EZ7j/38NVgFPt/WnraFtfx3jFHjkHqQ==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr23474663plo.121.1550473930097;
        Sun, 17 Feb 2019 23:12:10 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z6sm1821747pgo.31.2019.02.17.23.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 23:12:09 -0800 (PST)
Date:   Sun, 17 Feb 2019 23:12:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Message-ID: <20190218071207.GE242714@dtor-ws>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com>
 <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
 <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
 <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
 <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
 <CAMty3ZDBu2Y9psNu9nrZ=BNVvhpJ2qYn-Qp7MDqdhK9_SrcpNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDBu2Y9psNu9nrZ=BNVvhpJ2qYn-Qp7MDqdhK9_SrcpNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 02:45:52PM +0530, Jagan Teki wrote:
> On Sun, Feb 17, 2019 at 1:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Dmitry and Rob,
> >
> > On Thu, Feb 14, 2019 at 3:21 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > >
> > > > > > > Please CC DT list if you want bindings reviewed.
> > > > > >
> > > > > > Sorry I forgot.
> > > > > >
> > > > > > >
> > > > > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > > > > to trigger the power.
> > > > > > > > >
> > > > > > > > > So, document the supply property so-that the require boards
> > > > > > > > > that used on GT5663 can enable it via device tree.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > > > > >                               (swapping is done after inverting the axis)
> > > > > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > > > > >
> > > > > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > > > > of the same kind, but I'll let Ron comment on this.
> > > > > > >
> > > > > > > Yes on lowercase though there are some exceptions.
> > > > > > >
> > > > > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > > > > probably need to keep the voltage, but the binding is incomplete.
> > > > > >
> > > > > > What is incomplete here? can you please elaborate.
> > > > >
> > > > > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
> > > >
> > > > Though it has other supplies, only AVDD28 is connected in the Host
> > > > interface design similar like 9. Reference Schematic on Page, 23 in
> > > > attached manual.
> > >
> > > That is for a particular board design. It still has other supplies.
> > > Just make the binding complete please. You can make them optional. I
> > > don't care if the driver supports controlling all the supplies or not
> > > (though Dmitry might).
> >
> > So, Can I make bulk get and enable in all 4 regulators global to
> > driver or specific to that chip, in either way the regulators which
> > are not used to process via dummy regulators (which we all know).
> >
> > or regulator which are not using are get via devm_regulator_get_optional.
> >
> > Any suggestions?
> 
> Just realized to go with bulk calls, please have a look at on v5 [1]

I do not believe you can use bulk regulator API here as you need to
implement the power up timing scheme mentioned on p. 12 of the spec you
referenced earlier. And, because of that timing diagram, I believe if
you want to control AVDD supply, you also have to control VDDIO supply
as it has to be on only after enabling AVDD.

I also wonder if it is valid to have both AVDD28 and AVDD22 connected at
the same time.

Thanks.

-- 
Dmitry
