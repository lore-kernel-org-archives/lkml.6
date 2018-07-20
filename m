Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D21ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD9620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+L3+bzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD9620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeGTMQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:16:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43249 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeGTMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:16:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id m12-v6so1571159lfc.10;
        Fri, 20 Jul 2018 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SqJ4GtMi/P88XgAFrR3gDyoz1BqU7PUjBI9FD/Ec8gs=;
        b=M+L3+bzPcu2bASF+TlWTXXAmOUhrIiYhNQN27Zv8A7m6zouoWOpFhv38vKaYBf5S6H
         78fOGaSCoTRVQ9GQgTY8axULUq48dFlof48Gcy+W+95LXvRuynWVi2y54GBgVwY5/Gbl
         u1iop/AkABgNblF3AskFndrKToI/U8GwYxBmZkK4xs2hT7B2Yzagz+sLv3rUtQmAtLmk
         zmpqOjc12FdD+gvdwkLB3PIbipT6EQw2GJtu+K6Rek1BMPzdKl2ntUebgCSmMLoSXtQe
         coTZjHyYrsEavFdTGt032Vn/9MaTnuGzuPCaYG07x9T5oEVgpl88qKOmxOuW4kkVT5XP
         5X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SqJ4GtMi/P88XgAFrR3gDyoz1BqU7PUjBI9FD/Ec8gs=;
        b=sEWSnOnmWbwmQ5aHdo+FuDAH0i2jLFXTml5k9hmGIDb8zehMZ1FPYH0VuhAaF6Hjhu
         zvt1PSReif2rwjbUvsQZlTGOy7APKkj/v+msuZlGdWxKmOb1UrUT9jJLjO+UwNQYdMsb
         BmBM5SpHAXeT3oBJTDFKhN9l+aafRYeYo2/0gXM39cVagFsH+I8iYlirNiuM8JAi8pjD
         goC2+5gGyWpCQnoI/CWFvtJFRVikXeofJnDWvt4Y1Qi23rEgPCK/Q7kHMlXch0k1b4FN
         IqPhXPSfBG6VPbd11ivX8/gfhB85w33OqfMJ8th/PuMz1iEV69IIsxBlo1bs5AIfRSvr
         gwuA==
X-Gm-Message-State: AOUpUlGsdPP0sgk+SUPiO5fPCYBsH1cCiiE7Ozvhb5m3H6kHigPc5bv/
        JxwNdyWVxuf0x+cLpVX/G+v6eYca0sJLrwn73nQ=
X-Google-Smtp-Source: AAOMgpdMAfodJMX4gOeyzKeKlpQXcpVkj06eXZpPEfih0eGJsokwbZxnf1K13gMZSOgQMaSSuwt2USLEqH2TYKEXat8=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr1163751lfh.19.1532086091357;
 Fri, 20 Jul 2018 04:28:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 04:28:10
 -0700 (PDT)
In-Reply-To: <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com> <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Jul 2018 13:28:10 +0200
X-Google-Sender-Auth: Ix89EmYESe-t8dONXgRe3c3D0Ac
Message-ID: <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
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

On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-07-20 12:57, Arnd Bergmann wrote:
>> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>>   will only ever be observable from one master at a time, when you
>>   switch over, all children get removed on one master and added to
>>   the other one, to be probed again by their respective drivers.
>>   I can see this as a useful feature on i3c as well, in particular to
>>   deal with the situation where we have i2c slaves connected to a
>>   pinmux that can switch them between an i3c master and an
>>   i2c-only master (possibly a gpio based one). That particular use
>>   case however doesn't seem to fix well in the current code, which
>>   is structure around i3c buses.
>
> It's pretty easy to come up with examples where this reprobing is
> not desirable at all. E.g. if one of the involved I2C devices is
> a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
> graphics pipeline. Blink-blink on the screen because some *other*
> unrelated device needed to be accessed by an alternative master. Not
> pretty.

Agreed, we definitely don't want to reprobe all devices during normal
operation for i3c master handover.

What is the least contrived use case that you can think of where we
would want to use one master to talk to one device on the bus,
but another master to talk to another device on the same bus?
I still hope that we can decide that this is not a useful scenario
at all.

If we find a case in which it is needed, we could still deal with it
like this:
- enumerate all slaves connected to the bus for each of the
  two masters
- mark each slave as status="enabled" in at most one of the
  buses, and as disabled everywhere else
- Use dynamic handover according to the bus protocol to
  switch masters without having Linux even know that the
  two buses are shared.

That scenario would then fall completely into the "secondary
master handover" category but require no special handling
in the i3c layer beyond what we need for secondary masters
that are managed by something outside of the kernel's
score (a microcontroller, firmware, ...).

       Arnd
