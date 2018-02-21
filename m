Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936516AbeBUNP7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:15:59 -0500
Received: from mx.socionext.com ([202.248.49.38]:15785 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753795AbeBUNP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:15:57 -0500
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Mark Brown'" <broonie@kernel.org>,
        =?iso-2022-jp?B?U3V6dWtpLCBLYXRzdWhpcm8vGyRCTmtMWhsoQiAbJEI+IUduGyhC?=
        <suzuki.katsuhiro@socionext.com>
Cc: <alsa-devel@alsa-project.org>, "Rob Herring" <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com> <20180221043311.25840-3-suzuki.katsuhiro@socionext.com> <20180221122639.GH8334@sirena.org.uk>
In-Reply-To: <20180221122639.GH8334@sirena.org.uk>
Subject: Re: [PATCH 2/2] ASoC: support ROHM BD28623 codec
Date: Wed, 21 Feb 2018 22:15:52 +0900
Message-ID: <002601d3ab16$195fdf20$4c1f9d60$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTqs0WYpLkxEPPmUeTrT/mwR3ztaOuMfeAgACiNwA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 21, 2018 9:27 PM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel@alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] ASoC: support ROHM BD28623 codec
> 
> On Wed, Feb 21, 2018 at 01:33:11PM +0900, Katsuhiro Suzuki wrote:
> 
> > +++ b/sound/soc/codecs/bd28623.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ROHM BD28623MUV class D speaker amplifier codec driver.
> > + *
> 
> Please make the entire comment C++ so this looks intentional.
> 
> > +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	gpiod_set_value(bd->reset_gpio, 0);
> 
> Since this GPIO is not needed in atomic contexts you should use the
> _cansleep() versions of the GPIO functions - it doesn't cost you
> anything and means that if for some reason someone wired this up to a
> GPIO that can't be used in atomic context the driver will just work.
> 

Thank you, I'll fix it.


> > +	bd->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > +						 GPIOD_OUT_HIGH);
> 
> > +	bd->mute_gpio = devm_gpiod_get_optional(dev, "mute",
> > +						GPIOD_OUT_HIGH);
> 
> These properties were documented as mandatory in the binding but are
> optional here.  It's fine that they're optional but I'd expect the
> binding to be consistent with this.
> 

These GPIO is optional if board vendor connects directly RSTX and MUTEX pins
to VCC. So I think I should fix DT-bindings document.


> > +static int bd28623_remove(struct platform_device *pdev)
> > +{
> > +	struct bd28623_priv *bd = platform_get_drvdata(pdev);
> > +
> > +	regulator_bulk_disable(ARRAY_SIZE(bd->supplies), bd->supplies);
> > +
> > +	return 0;
> > +}
> 
> We don't enable the supplies explicitly as part of the probe function so
> it feels wrong to disable on remove() - I'm sure it is fine in practice
> as-is but I'd have to think too hard to confirm that.  I'd put this in a
> component level remove function instead so that it's consistent.

Ah, indeed. I will use component driver's remove() function instead of platform.

Thank you for review!


Regards,
--
Katsuhiro Suzuki
