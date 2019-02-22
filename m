Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE46C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E541B20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBVKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:16:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35444 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBVKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:16:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so1885891qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 02:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZ6nSlzjEg37eprWB6RPmDzUgKkp6Tp+DrOR6ANqsY4=;
        b=Nvhyjohshvx4k10wL6hmDx2OoUhqEOaZ1sg+KEaLEoY2Rh/xy1OMhcFOmWX2j6uwSe
         YyqrGYufUN8JOmOxAEO3IeT+VsVnZi2BWNEAMfB9Aa+yHi1tEy2Db0fYW5X2Ze51KHTa
         +m3RabV9z01bO2iZYMtf+qLGxmU4fTAtNFPpNOZgqCdlYWFMzogHKPsIj7bbSDJ8DrAd
         1TuuwoBdp7uGiDzZFU/7lZhFgcpL9i5ixPFkptKAgfxzYY9oytZNpEjy9oiRBOGTFq9E
         bcAfydRyKGt64lWJ+EYiUg8pGhpI3+CBamRQe0IX8xF2W5yB2OdN8hUoKoQXYAd0a/Vr
         rSSw==
X-Gm-Message-State: AHQUAubDNvrx9O63yd0eT1sQIIplKTetBPTtECop6DoOuJH7SrPMjN11
        +HpBBiRMitCv/JM2Rqqkm+wGwRBo2qQJoyepOzCdfg==
X-Google-Smtp-Source: AHgI3IbMuZue0YdLx8zV30J7qoAp2k3RJWajOc3OQeipxOsSw3MlMuPFIJZSk0Itoy0Btr4Sn3gWer6gw4OYfojvEMw=
X-Received: by 2002:a0c:8830:: with SMTP id 45mr2428694qvl.17.1550830570525;
 Fri, 22 Feb 2019 02:16:10 -0800 (PST)
MIME-Version: 1.0
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com> <20190221232609.d4vxl3osj6mwooey@katana>
In-Reply-To: <20190221232609.d4vxl3osj6mwooey@katana>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 22 Feb 2019 11:15:59 +0100
Message-ID: <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jim Broadus <jbroadus@gmail.com>, ckeepax@opensource.cirrus.com,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:26 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> > A previous change allowed I2C client devices to discover new IRQs upon
> > reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > assigned in i2c_new_device, that information is lost.
> >
> > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > client device structures are initialized during an ACPI walk. After
> > removing the i2c_hid device, modprobe fails.
> >
> > This change caches the initial IRQ value in i2c_new_device and then resets
> > the client device IRQ to the initial value in i2c_device_remove.
> >
> > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
>
> Adding Benjamin to CC

Sorry, I should have answered earlier.

I am a little bit hesitant regarding this patch. The effect is
correct, and I indeed realized a few weeks ago that something were
wrong as we couldn't rmmod/modprobe i2c-hid.

But I still have the feeling that the problem is not solved at the
right place. In i2c_new_device() we are storing parts of the fields of
struct i2c_board_info, and when resetting the irq we are losing
information. This patch solves that, but I wonder if the IRQ should
not be 'simply' set in i2c_device_probe(). This means we also need to
store the .resources of info, but I have a feeling this will be less
error prone in the future.

But this is just my guts telling me something is not right. I would
perfectly understand if we want to get this merged ASAP.

So given that the code is correct, this is my:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

But at least I have expressed my feelings :)

Cheers,
Benjamin



>
> > ---
> >  drivers/i2c/i2c-core-base.c | 9 +++++----
> >  include/linux/i2c.h         | 1 +
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 28460f6a60cc..af87a16ac3a5 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
> >       dev_pm_clear_wake_irq(&client->dev);
> >       device_init_wakeup(&client->dev, false);
> >
> > -     client->irq = 0;
> > +     client->irq = client->init_irq;
> >
> >       return status;
> >  }
> > @@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> >       client->flags = info->flags;
> >       client->addr = info->addr;
> >
> > -     client->irq = info->irq;
> > -     if (!client->irq)
> > -             client->irq = i2c_dev_irq_from_resources(info->resources,
> > +     client->init_irq = info->irq;
> > +     if (!client->init_irq)
> > +             client->init_irq = i2c_dev_irq_from_resources(info->resources,
> >                                                        info->num_resources);
> > +     client->irq = client->init_irq;
> >
> >       strlcpy(client->name, info->type, sizeof(client->name));
> >
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 65b4eaed1d96..7e748648c7d3 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -333,6 +333,7 @@ struct i2c_client {
> >       char name[I2C_NAME_SIZE];
> >       struct i2c_adapter *adapter;    /* the adapter we sit on        */
> >       struct device dev;              /* the device structure         */
> > +     int init_irq;                   /* irq set at initialization    */
> >       int irq;                        /* irq issued by device         */
> >       struct list_head detected;
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> > --
> > 2.20.1
> >
