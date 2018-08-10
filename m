Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D85C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E2F2244C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI0suXjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E2F2244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeHJUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbeHJUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:42:50 -0400
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com [209.85.220.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF4622449;
        Fri, 10 Aug 2018 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533924713;
        bh=yZhlFZ8gprzMmtXCdMKVygb8ooVXZfynNtY3c6jYjW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RI0suXjP/eUwYtq8s2LfzNkoSXjO42ogtS37/lcsdi32phorfy/OyzBbe31R5Wtmq
         wAhi4Fbqc1v/Nu7UrQ9onIYv2rIUyqfPqnoBBRJ0q9TGkLGtE1KANJmGO60TTMIhLE
         HNvhtwBk4ZYFD76NBIZKRpTRqkT4j123Shmpo/pY=
Received: by mail-qk0-f178.google.com with SMTP id 27-v6so7003945qkv.0;
        Fri, 10 Aug 2018 11:11:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlGWf1XESwG1XOGSGxjlSTp00vlTPLawEXRz26TNkI486QhLQQAd
        mUaWVvwneaCbENP+6oXUxlhPl6TK+RVM++mUvA==
X-Google-Smtp-Source: AA+uWPwm53GWQ7QRW4Pi5vtzQqBsXkVH/wrVWk9wM321i/GxIuPM5foxG2LNNGx45AuhKmjGmDeDV062qsmPFpWjp+I=
X-Received: by 2002:a37:a0c8:: with SMTP id j191-v6mr2820818qke.375.1533924712734;
 Fri, 10 Aug 2018 11:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de> <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
 <0aa77961-fe60-6afe-e6c5-d2db4250cb22@suse.de>
In-Reply-To: <0aa77961-fe60-6afe-e6c5-d2db4250cb22@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Aug 2018 12:11:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LOqe9h1t9nYeothfV96ntkWb6X+anSryLqbVTX+XSWw@mail.gmail.com>
Message-ID: <CAL_Jsq+LOqe9h1t9nYeothfV96ntkWb6X+anSryLqbVTX+XSWw@mail.gmail.com>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com,
        Michael Allwright <allsey87@gmail.com>,
        Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:45 AM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
>
> Am 10.08.2018 um 19:34 schrieb Rob Herring:
> > On Sun, Aug 5, 2018 at 5:27 PM Andreas F=C3=A4rber <afaerber@suse.de> w=
rote:
> >>
> >> This is to allow using serdev.
> >>
> >> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> ---
> >>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16i=
s7xx.c
> >> index 243c96025053..ad7267274f65 100644
> >> --- a/drivers/tty/serial/sc16is7xx.c
> >> +++ b/drivers/tty/serial/sc16is7xx.c
> >> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
> >>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
> >>
> >>         for (i =3D 0; i < devtype->nr_uart; ++i) {
> >> +#ifdef CONFIG_OF
> >> +               struct device_node *np;
> >> +               struct platform_device *pdev;
> >> +               char name[6] =3D "uartx";
> >> +#endif
> >> +
> >>                 s->p[i].line            =3D i;
> >>                 /* Initialize port data */
> >> +#ifdef CONFIG_OF
> >> +               name[4] =3D '0' + i;
> >> +               np =3D of_get_child_by_name(dev->of_node, name);
> >> +               if (IS_ERR(np)) {
> >> +                       ret =3D PTR_ERR(np);
> >> +                       goto out_ports;
> >> +               }
> >> +               pdev =3D of_platform_device_create(np, NULL, dev);
> >
> > Ideally, you would use of_platform_default_populate here. I think
> > you'd have to add a compatible to the child nodes, but that wouldn't
> > be a bad thing. I could envision that the child nodes ultimately
> > become their own driver utilizing the standard 8250 driver and a
> > compatible string would be needed in that case.
>
> Separate compatibles would mean separate drivers.

No. Having a compatible doesn't mean you have to have a driver.

> Unlike your DUART example this is not an MMIO device that we can easily
> split but a SPI slave (well, regmap due to some I2C models).

A SPI slave could provide a regmap, right?

> I don't see how separate drivers could work, given that the whole
> spi_device has a single interrupt for all functions of this device.

A shared interrupt or a parent driver that creates an irqchip like MFD
drivers often do.

>
> That left me with this ugly but working construct.

In any case, I'm was suggesting that you do any of this now. I just
want the binding to be designed to work either way.

> Is the uartX naming correct, or should it be serialX?

Ah, yes. Should be serial@... I'm fine if both the parent and child
are named serial@...

Rob
