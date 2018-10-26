Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A319ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C929220834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMOYEUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C929220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJZQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:19:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44759 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:19:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id n12so102748qkh.11;
        Fri, 26 Oct 2018 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4GL9jGVvMIfFNOnvzqpFLbSJYENfWzz52EmGkR8pa/4=;
        b=DnMOYEUaT21aFZPvbAZ0hIOQ6wy26bQguInP3P+FnSfHocZCgI/+TxogWElR2GXxYm
         6iQiU4/nvKe8M9D4Crs8LDZHJAqh/+clFQv9BEcfGVQbnS96pW/S+Avw2++Xrc2FhEqe
         kGHPflXO9lSLHddZ3kC6KS5N7WhUA/PbQEikJFHPnMaLfMClxrORB+xnREAiKYnHJVzX
         CmkPClWMDngdg4kHKef4jIVO++WVkIgt2agJxlJYuWo5qcQbklQmVIa2NGrFSpqPOXKB
         DFvvUsqFWcMyn8bG+PMO/CRA7VSpLwCofDNFp8gIq3Upz/kV2W7JaIDaAs/NwZf6BOvY
         +Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4GL9jGVvMIfFNOnvzqpFLbSJYENfWzz52EmGkR8pa/4=;
        b=EpQvJkENxFdrNgI0PyF4UBa9Pg7I6h5mSr8hvkj72SNBR0s3at/ipoZTJuPu1VXGsL
         uQcBtvwl577v/1ykCIO2F0+6e+fQAbtT+cNcb+FFCxkzh7JMreKS8U0RB5yfNIy7e/Eb
         FsOLvPgHsOqAIZ2aF5vZmp9aqOpXig2u4kEOqvdBU9nSOUfUSwb+ogpibOfyODclfnbE
         nnnIQycVR7IISu+3PE9gNJGQTeky/SRs+hXK3ejCNNMXeeOfyH0ydRrju0z45gahU2w+
         DS2ueSdcAUl/6IcON7lseV+lg8tE5pCS0oYcDC+Pvkf5IUaY0G62aiJsmLijjgtxEAtw
         Abog==
X-Gm-Message-State: AGRZ1gJmEt8l8FcfRrEeK9Uj+t/iSmwEC2ae7B6Y9qkL10GMU7MEio4e
        pcorxE1fL1oVaOGDIHDrw0sAGcQSyAuJXLuEcuo=
X-Google-Smtp-Source: AJdET5dqqYXLYWnSzQ8/QZS0DwSf1HOa7JM0cSXuLMPIq6Ci93WySqsTK4F2IVX+mJquXKzhLU0B/NGTB3nm+PzIzKo=
X-Received: by 2002:ae9:d801:: with SMTP id u1-v6mr2080311qkf.291.1540539806455;
 Fri, 26 Oct 2018 00:43:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:43:25
 -0700 (PDT)
In-Reply-To: <20181025183005.3c0fa452@bbrezillon>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
 <20181025180720.1790f6a1@bbrezillon> <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
 <20181025183005.3c0fa452@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 09:43:25 +0200
X-Google-Sender-Auth: -9xstkgA_7rqlHQNu2MAKzOki2o
Message-ID: <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > On Thu, 25 Oct 2018 17:30:26 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > > > On Mon, 22 Oct 2018 15:34:01 +0200
> > > I guess I could dynamically allocate the payload, but that requires
> > > going over all users of i3c_send_ccc_cmd() to patch them.
> >
> > This reminds me that Wolfram mentioned in his ELC talk that the
> > buffers on i3c should all be DMA capable to make life easier for
> > i3c master drivers that want to implement DMA transfers.
>
> And this is the case for all buffers passed to
> i3c_device_do_priv_xfers() (and soon i3c_device_send_hdr_cmd()),
> but I did not enforce that for the internal
> i3c_master_send_ccc_cmd_locked() helper, maybe I should...
> It was just convenient to place the object to be transmitted/received on
> the stack.

Ok. Is i3c_master_send_ccc_cmd_locked() what implements the public
interfaces then, or is this something else?

If you place a buffer on the stack, it is not DMA capable, but
it is guaranteed to be at least 32-bit word aligned, and should
not cause an exception in readsl(), unless it starts with a couple of
(not multiple of four)  extra bytes that are not sent to the devices.
Is that what happens here?

> > If we have buffers here that are not aligned to cache lines
> > (or even just 32 bit words), doesn't that also mean that the
> > same buffers are not DMA capable either?
>
> Yep, if it's not cache-line-aligned (and on the stack), it's not
> DMA-able.

This sounds like a more fundamental problem to solve first
then. Obviously it is incredibly /useful/ to be able to put short
i2c or i3c messages on the stack, but allowing that in general
also prevents the use of DMA without bounce buffers.

One way to address this might be to always bounce any
messages that are less than a cache line through a
(pre-)kmallocated buffer, and require any longer messages
to be cache capable. This could also solve the issue with
readsl(), but it would be a rather confusing user interface.

Another option might be to have separate interfaces for
"short" and "long" messages at the API level and have
distinct rules for those: short would always be bounced
by the i3c code, and long puts restrictions on the buffer
location.

       Arnd
