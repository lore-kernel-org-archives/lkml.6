Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D592C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E439720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E439720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbeIFTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:51:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41310 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbeIFTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:51:32 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so12647178qtc.8;
        Thu, 06 Sep 2018 08:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNqXa2J92ZLcEblFYl7t4SARRWrB8lQSYgfT+dH2wW0=;
        b=NX+EEMpR8M0wGKTj2wQaMrGEjQI/l4ye76aq2DRzi9TWquFn42ga4GFTHFitd0QfmK
         pAn9pkmQNLST1aye3PENhtjPWnvyo0qy1BlkHi44bEGVmOXERtwYKx5l+N9tv//VNxOU
         DzV0gWlnDyFwtinhhj5PROdDRftPJ9dEPBX96Ek2PQQ3P3Z3nyADvpIQ7d+9g3qWrygW
         +Tsu3qYeD/4GBjusB+Kx6tqTKhMHR1lDTfZ4275tMbmCF9IdHRs+G08FNsNqkKOTbxGb
         1mi3jfsA6XBLVcmDP8OymvKAlwjXIJHxKYywckf7vPqqGySRo70h9HKJ+Iz1mQC5T/gs
         yoig==
X-Gm-Message-State: APzg51AM0o/hbNiTSawBg6LfaiOf89mkYMPgCQidT8ec3SpVtcxdIatE
        Zn+TJF/4KmI/sgTB/XTw2ZvrGkjPvIgh2HIAVMY=
X-Google-Smtp-Source: ANB0VdamYRXsqbpv8sWGLhV+NfyksfoWE8NplnEhtbXm83mIHdhGWXFs3IiKNGt9/bDpT6FNU/HYu3DfR6hhDePFcp0=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr2584415qtr.9.1536246932739;
 Thu, 06 Sep 2018 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
 <20180905154108.20770-2-boris.brezillon@bootlin.com> <CAK8P3a3EkwAXin=s1bak7V7xM7zqip_Q6GMpxB-b1BD931G6cA@mail.gmail.com>
 <20180906160048.2f585e2b@bbrezillon>
In-Reply-To: <20180906160048.2f585e2b@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 17:15:16 +0200
Message-ID: <CAK8P3a1OV_w5br=fkQjY-xOUa_u3j+8P2=9MRLzpQqLfWpSaBA@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:01 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 6 Sep 2018 15:38:49 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 5, 2018 at 5:41 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> >
> > > +struct i3c_bus *i3c_bus_create(struct i3c_master_controller *master)
> > > +{
> > > +       struct i3c_bus *i3cbus;
> > > +       int ret;
> > > +
> > > +       i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> > > +       if (!i3cbus)
> > > +               return ERR_PTR(-ENOMEM);
> >
> > I find it a bit confusing to have separate i3c_master_controller
> > and i3c_bus structures with this version. Why not merge the
> > two structures into one now and move the bus management
> > into master.c?
>
> Yes, I considered this approach. Not sure it would make the whole code a
> lot simpler though, and it was definitely more work on my side, so I
> decided to delay that and wait for someone to explicitly request this
> change ;-).
>
> I also like the bus/master separation in that it allows one to clearly
> identify the properties that are bus (speed, mode, ...) related and
> those that are master controller oriented (PID, DCR, ...).

Maybe you could make the bus a member of the master rather
than a pointer from it?

That would still let us avoid the separate dynamic allocations,
and not having to worry about separate lifetime rules for the
two, but also group the bus properties together a bit more
as you said. It can also have code deal with the the bus object
without including the structure definition of the master (if that
is desirable).

> > Since it contains an i2c_adapter, maybe a good name for the
> > combined i3c_master_controller+i3c_bus structure would
> > be 'i3c_adapter'?
>
> Hm, I'd really like to keep the name master and not adapter, just
> because that's how it's named in the spec.

Fair enough.

> We don't store i3c/i3c_device objects in those lists, but
> i3c/i2c_dev_desc objects, so device_for_each_child() won't work.
> Remember that i3c devs can be present but not registered yet, and we
> need to have those representations somehow attached to the master/bus.

Ah right, I remember you explained that before.

> Regarding the possibility of merging those 2 lists together, we could
> do it, but I find it simpler to have them separated.

Agreed. It would only make sense if we had the combined list already.

> > That might help with locking
> > and keeping the two lists synchronized, which may or
> > may not be a problem here.
>
> Regarding the locking aspects. Anything touching those lists is either
> init code (which should be serialized) or DAA related, which requires
> the bus lock to be held in write mode (exclusive access mode). Do you
> see any other possible race?

No, nothing specific, it was just a general feeling.

        Arnd
