Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C0420844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C0420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeIFSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:14:44 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45958 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeIFSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:14:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id g44-v6so12194619qtb.12;
        Thu, 06 Sep 2018 06:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGsQUfgotGXrczjlGkP4HfCwhecwzHfwxPHJKrqbuoc=;
        b=Wo2Lvy8tUInstm74IGhtMfbtqQ6Fy/bxacv9JXOPi3TJn44dtjYE1BglCRpx720hEv
         XOsonx30jNK3mBRoe5EE2qZnYiIR5Ar9SJQrQmnRyyUVRkFCBS3FyY5x5VAW80pmLahj
         9ySzr0DHvYFlf5jNwq26IOX8Emkyvhy2u+Rw3XxN4bOGS+GJA6vLjH1d8UavbR9BzvWa
         K0rxRAIsTPLVx4U9Lvg3bL1e0YaNTRoWlLmN66pHiGpP5rJLb/hJTzfV16kdMMjCn3LG
         GJ+ASgH5lTuEpyBOK9OsmNumHsOxVAxvH1/zjFDvlHjm46J9GzOJmSyfBK18ZaDFQdXE
         ISGA==
X-Gm-Message-State: APzg51Bwj2UzIpVJRqU+LJsMXbE3eHJJ1uj2bfy1Iz4bMMTnYdxaEVDb
        qZfQtP/BrlrOy7/Y2YTxhfa0idyWSQjZHZJf9+w=
X-Google-Smtp-Source: ANB0VdYBCdmPl3cYVhGNeaPFGemwRptUcgwwmY01UjWD3kQgCkQbqK62Qaw/KXkCFC/WAkLNOsKEQhYmivo3eXf3ajs=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr2091664qtg.213.1536241146144;
 Thu, 06 Sep 2018 06:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180905154108.20770-1-boris.brezillon@bootlin.com> <20180905154108.20770-2-boris.brezillon@bootlin.com>
In-Reply-To: <20180905154108.20770-2-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 15:38:49 +0200
Message-ID: <CAK8P3a3EkwAXin=s1bak7V7xM7zqip_Q6GMpxB-b1BD931G6cA@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 5:41 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> ---
> Changes in v7:
> - Stop representing the I3C master as a device under the I3C bus
> - Enforce a 1:1 relationship between i3c_bus and i3c_master_controller
>   objects

Thanks for implementing those changes. What is your feeling so far
about the difference? Has it gotten much simpler as I was hoping?

I definitely like this version much better. I have found a couple of
things that I point out below that could be improved (or me being
proven wrong on them), but overall I think it looks great and I don't
see major issues.

Great work!

> +struct i3c_bus *i3c_bus_create(struct i3c_master_controller *master)
> +{
> +       struct i3c_bus *i3cbus;
> +       int ret;
> +
> +       i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> +       if (!i3cbus)
> +               return ERR_PTR(-ENOMEM);

I find it a bit confusing to have separate i3c_master_controller
and i3c_bus structures with this version. Why not merge the
two structures into one now and move the bus management
into master.c?

> +static int i3c_master_attach_i3c_dev(struct i3c_master_controller *master,
> +                                    struct i3c_dev_desc *dev)
> +{
> +       int ret;
> +
> +       /*
> +        * We don't attach devices to the controller until they are
> +        * addressable on the bus.
> +

Apparently the new gmail version decided to cut off the second half of your
email after this line when I hit reply, which makes it much harder for me
to continue a proper review. I fear I'll have to get a real email client
again :(

> + * The I3C bus is represented with its own object and not implicitly described
> + * by the I3C master to cope with the multi-master functionality, where one bus
> + * can be shared amongst several masters, each of them requesting bus ownership
> + * when they need to.

This comment is now stale, even without merging the structures, right?

> +struct i3c_master_controller {
> +       struct device *parent;
> +       struct i3c_dev_desc *this;
> +       struct i2c_adapter i2c;

I think the 'parent' pointer is better omitted, it should always be
the same as master->dev->parent, right?

Since it contains an i2c_adapter, maybe a good name for the
combined i3c_master_controller+i3c_bus structure would
be 'i3c_adapter'?

+#define i3c_bus_for_each_i2cdev(bus, dev)                              \
+       list_for_each_entry(dev, &(bus)->devs.i2c, common.node)
+
+#define i3c_bus_for_each_i3cdev(bus, dev)                              \
+       list_for_each_entry(dev, &(bus)->devs.i3c, common.node)

I wonder if it would simplify things to drop the i2c and i3c
device lists and instead implement these for_each loops
based on device_for_each_child() with a check of the
bus_type==&i2c_bus/&i3c_bus. That might help with locking
and keeping the two lists synchronized, which may or
may not be a problem here.

         Arnd
