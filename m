Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DDB2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DDB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeKPAeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:34:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39300 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbeKPAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:34:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so14476011qkh.6;
        Thu, 15 Nov 2018 06:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKOzLffA+GFpkGJNymqpj3HUqw5QIb3tyHuzTzucqtk=;
        b=YMGKpxLCem1M9yWRmzhjFxYeeXDIfs+z6oR7CeqX72HiqGFC9Vsz9Xl6KMrB8AAAp3
         Oy/13Mm0b5RMFd46N9Jbl0ajg2TkbSd5Ju/LmQqmJ8GZI6NORFDbhCtfSAK30XFtyy6b
         WLFrq+xLZGe2ZPZRNL9PzQQKiIcyHp3j03QXTv+kvo5b3MQNTTXqgvRVKMiqlCROTjdi
         YuZP2VSy/raxd11w+v9EtUGTbf9ozd+aeTPd8d4Z+XP6BylfZCY5vbY7ZMAOQIzWc1We
         aWB/YkFo8nd9OjkQWza0BlBJay3RcgD4bIStJlx8WvC5BeKuh5HNpOsuF4R/mhnfjjfc
         8ndw==
X-Gm-Message-State: AGRZ1gIVnqaw6nhjEAGJO1sjSBdccDoS0d7sQQ+5/q/yJPExuZOLjmbp
        W02GdQ8L/kVemP3feAjVG3Od6pRj/9Ai8kq0e1I=
X-Google-Smtp-Source: AJdET5cU4YsvcpU8VOhH01f7PrN9VgcHF9m6PlFqVhuDgRpf3VYhoeSsQrEpUB88wL5LfA5ZQZf1OVrPAsIZZLyVx2Q=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr5954341qtr.319.1542291974414;
 Thu, 15 Nov 2018 06:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com> <20181115135731.25f60990@bbrezillon>
In-Reply-To: <20181115135731.25f60990@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Nov 2018 06:25:54 -0800
Message-ID: <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 4:58 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> +Mark Brown for the question about /dev/spidev
> On Thu, 15 Nov 2018 12:14:37 +0000
> vitor <vitor.soares@synopsys.com> wrote:
> > My initial thoughts are to do the same think as for i2c, expose the
> > buses or the i3c_devices and use ioctl for private transfers.
>
> Exposing the bus is dangerous IMO, because an I3C bus is not like an
> I2C bus:
>
>    * I3C device needs to be discovered through DAA
>    * I2C devices need to be declared ahead of time, and LVR is used to
>      determine the limitations on the bus at runtime
>
> So you'd anyway be able to interact only with devices that have
> previously been discovered.
>
> Note that the virtual I2C bus is already exposed, but any command
> targeting an address that is not attached to a registered I2C dev will
> get a -ENOENT error.
>
> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.
>
> > Some
> > direct CCC commands can be sent through the /sys as you plan for SETNEWDA .
>
> Yes, CCC commands that need to be exposed to userspace should be
> exposed through sysfs, or, if we decide to create a /dev/i3cX device
> per bus, through ioctls.
>
> >
> > What do you think about this?
>
> I think this request is perfectly valid, we just need to decide how it
> should be done, and before we take this decision, I'd like to get
> inputs from other maintainers.
>
> Mark, Wolfram, Arnd, Greg, any opinion?

I think for a new user space interface, it makes sense to explore a number of
different options before making the final decision.

I agree about better not exposing the bus as a /dev/i3c* node, and that we
probably do need to expose individual devices in some form to allow
writing complete user space drivers that can do everything a kernel driver
can do.

Can you describe what a low-level interface to the device looks like
in the kernel? Can this be abstracted as simply pread()/pwrite() plus
an interrupt mechanism, or do we need a set of ioctl() operations as
well?

If it can be purely based on a regmap abstraction, a sysfs inteface
might be sufficient, though that has some downsides with permission
management compared to a /dev/* node.

Another option might be the use of a socket interface, which also
has some issues in terms of permission management, but might
be a good fit if we could abstract bus transactions as packets that
can be queued.

       Arnd
