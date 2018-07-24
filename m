Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA767ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776EC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF3iObDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776EC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeGXPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:10:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33124 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388391AbeGXPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:10:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so4184467qtp.0;
        Tue, 24 Jul 2018 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I2DrHoBiiSNvVNg3ODPVs4slcAGKfiV5fUiOIJk2380=;
        b=tF3iObDncjzSeRhWR8Hxqrr/a6sLYL3OHSLHorlH/7YF8sKUPHthFl9beYEx1e5Ah3
         k5Tc+B/r1A/I73hr4Pmx+Vy0dXbH5etDfaYoUeTnEqADhhnmbcYSDY5Ih1ArU+8ulqbw
         QTl1EfsijQze5snElzEeOETt8eAUA7FVOtJDFNZFeykoMOK1FwsQvWeWjLU5t1mAb1pB
         2qUoXA1xwkAMUtNHXQHA0UEttxdyJUHqcfPqVpLG9zjpgtQn/3UeJ0fG32IBg6WEGfvt
         63XJ7+T5PwmeLyD67C8h7GwtHWhZZ0u2HcYQptkQLosExSNWjGdoaVDztYfNIhm3mk34
         bRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I2DrHoBiiSNvVNg3ODPVs4slcAGKfiV5fUiOIJk2380=;
        b=AEXktt9YIU+2KlX1cmEHvKuJHS13j+kbhnG4lvMJ6Y7ILacPocZif/kqSLncBdUIJr
         aEG/FfbHISrBLFs5arjPpNtsG7GJhsUyN6DRNdBkQpp9LvlxBC8o2nV0QWRNphV6ITwF
         Qs1+auS8xyxqIckAcIcy5SlKoV7/8BkVnOqz2wT4IqJF8bYGyTGaXYGUEiwxXK6XyUxT
         z9+KsU8armbmohJ2alb6aah2+cKGJ4Ys76hHymyDvEe9t9aOcZBN2rGUgYpu0jggPaQG
         24Jx8+jrKEWeX/nq2J129spmge1t2gY2qrLLygQkjopyl9CNV2H0zvXolYafCw9Qei0v
         ryMg==
X-Gm-Message-State: AOUpUlH+1qzLQJdmU10zIf0MtW78AjYTZkPUS/mj9Z3JOd1P7G0hqFWg
        iMV9PVo/IImBE2m7FVnZh73uPe1mZW0EI+tg4jU=
X-Google-Smtp-Source: AAOMgpdB9MEBK4Ce8wDnRaHxNNmRs/cVdpFM7+NYyGKlPW2YkbVd+alId3pk/3Az9qQfHGyqwtBMz2EA4bIbYaUbvO4=
X-Received: by 2002:a0c:afb8:: with SMTP id s53-v6mr15225159qvc.164.1532441019084;
 Tue, 24 Jul 2018 07:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 07:03:38
 -0700 (PDT)
In-Reply-To: <20180720151751.242d4809@bbrezillon>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 16:03:38 +0200
X-Google-Sender-Auth: w1t9NEseinwBWK0bssflYYmo0hI
Message-ID: <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 3:17 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 20 Jul 2018 13:28:10 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
>> > On 2018-07-20 12:57, Arnd Bergmann wrote:
>> >> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>> >>   will only ever be observable from one master at a time, when you
>> >>   switch over, all children get removed on one master and added to
>> >>   the other one, to be probed again by their respective drivers.
>> >>   I can see this as a useful feature on i3c as well, in particular to
>> >>   deal with the situation where we have i2c slaves connected to a
>> >>   pinmux that can switch them between an i3c master and an
>> >>   i2c-only master (possibly a gpio based one). That particular use
>> >>   case however doesn't seem to fix well in the current code, which
>> >>   is structure around i3c buses.
>> >
>> > It's pretty easy to come up with examples where this reprobing is
>> > not desirable at all. E.g. if one of the involved I2C devices is
>> > a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
>> > graphics pipeline. Blink-blink on the screen because some *other*
>> > unrelated device needed to be accessed by an alternative master. Not
>> > pretty.
>>
>> Agreed, we definitely don't want to reprobe all devices during normal
>> operation for i3c master handover.
>>
>
> Re-probing would not happen, no matter the solution we choose. It's
> that, in one case, you would have X virtual/linux devices representing
> the same physical device and in the other case, you would just have
> one, and everytime a transfer is requested by the driver, the core
> would pick the appropriate master to do it (most likely the one in
> control of the bus at that time)

I think this is one of the cases I'd want to avoid: controlling multiple
masters that are active at the same time without going through
the handover.

If we have an actual pinmux between two masters and only one
of them can even see the bus, I think we should go through a
complete remove/probe cycle the way that the i2c-demux-pinctrl
does today. If OTOH we a primary/secondary master pair with
handover capability, I would prefer to not see one slave on
both devices at the same time, or (ideally) only use one of the
two masters and disable the other one completely.

>> If we find a case in which it is needed, we could still deal with it
>> like this:
>> - enumerate all slaves connected to the bus for each of the
>>   two masters
>
> That's what will happen if you don't share the same bus representation.

To clarify: I meant list them in the DT representation, not enumerate
them in Linux during boot. Sorry for using a misleading description here.

>> - mark each slave as status="enabled" in at most one of the
>>   buses, and as disabled everywhere else
>
> We shouldn't need to do that. We can just let the driver check whether
> the master provides the necessary capabilities to efficiently
> communicate with the device, and if it does not just return -ENOTSUPP
> in the ->probe() function. This way you'll have a device, but not
> driver controlling it on one bus, and on the other bus, you'll have
> another device (which points to the same physical device) this time
> with a driver attached to it.

I'd still hope that we can completely avoid that case and never
have the case where one physical device has two live
representations in the kernel. It /could/ still be done of course,
but would not always do the right thing, depending on the
type of device (a temperature sensor could just be probed
twice without problems, a network device probably cannot)

      Arnd
