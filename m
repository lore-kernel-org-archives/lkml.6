Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F3C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B4B2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 16:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T4J4+Cnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA0QcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 11:32:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32908 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfA0QcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 11:32:05 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so11557108ioi.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdGw5OLmRbEsXSYSE1jHv0FhrbEJf+4SwGncSby89sk=;
        b=T4J4+CnxpD5SmlxE/CTW4vVuorp+7Q0ur+rXbZ7SsYcmXn6v6bZoPeQ4lwKjZOLhOV
         ygjwyOveRQzAsrGNybBFrxHEnzi470EC1a5JUxCA+qLmalGcn0yAHvU7+eIH21zZk36N
         gNMIVsEcov/9VayzEWeHxBzuz0Dyz1/Gq0NkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdGw5OLmRbEsXSYSE1jHv0FhrbEJf+4SwGncSby89sk=;
        b=h0dBXDIfuUC7oXoZ9Tmy7eg2TmktCgtU+/TKmVsBc2ND6qc7jJTjEYKCn/CgRSHoCK
         kFacnGlyhFhnhCFMr2mGl0Osw2CzX63pE+lDdlA5EsdlvGWU3TksUqKgQWO6Oly8uN5m
         eG8o+u9g/JBf+LKd3hV/DzjoB4EgOeK1RPgwPLnosGtAu3wpfAQS6Ry7RkKchqrXCVai
         GnMjnhnUbIlJuhJGZi8RDPom1+hRugyVPmFR7tINVUfq0IrNuTdYTaJLS3tHATKmb8h9
         EwPq4JP3RXLC2cxGq8U3l8fiH1iuqlwJiqVnHcNBNnSl3U7VeABsV4jzdx3z9gX3GCUD
         U62w==
X-Gm-Message-State: AJcUukddS7mkxlvcqs8sXRxrGPR+ePIjeas6Egu3jTYNA0Q+7Ewsdwu4
        U79/igI54kNotl+7ejYGpXj2/vn51m6HHLYU+Q+J0Wrnv7I=
X-Google-Smtp-Source: ALg8bN6kuaR6X6GWN9KYF5vz5EZAVv1uKaackw+d38Mofz2fgiVrWjYmkZ3z9ulkRoEscOjxM34as0ll3T7NK30OD9o=
X-Received: by 2002:a5e:d503:: with SMTP id e3mr12604700iom.291.1548606723910;
 Sun, 27 Jan 2019 08:32:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net> <20190125181616.62609-2-olof@lixom.net>
 <20190125222337.GI3271@phenom.ffwll.local>
In-Reply-To: <20190125222337.GI3271@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 27 Jan 2019 17:31:51 +0100
Message-ID: <CAKMK7uF+REyxsZ5gUTuCPAhSQ4Jg9ouPvX1tDbrSoa01059xWQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drivers/accel: Introduce subsystem
To:     Olof Johansson <olof@lixom.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, Dave Airlie <airlied@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof & Greg,

Ok I thought about what this means in practice a bit more over the
w/e, and I think we need to drag this discussion on for a bit more.

On Fri, Jan 25, 2019 at 11:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jan 25, 2019 at 10:16:12AM -0800, Olof Johansson wrote:
> > We're starting to see more of these kind of devices, the current
> > upcoming wave will likely be around machine learning and inference
> > engines. A few drivers have been added to drivers/misc for this, but
> > it's timely to make it into a separate group of drivers/subsystem, to
> > make it easier to find them, and to encourage collaboration between
> > contributors.
> >
> > Over time, we expect to build shared frameworks that the drivers will
> > make use of, but how that framework needs to look like to fill the needs
> > is still unclear, and the best way to gain that knowledge is to give the
> > disparate implementations a shared location.
> >
> > There has been some controversy around expectations for userspace
> > stacks being open. The clear preference is to see that happen, and any
> > driver and platform stack that is delivered like that will be given
> > preferential treatment, and at some point in the future it might
> > become the requirement. Until then, the bare minimum we need is an
> > open low-level userspace such that the driver and HW interfaces can be
> > exercised if someone is modifying the driver, even if the full details
> > of the workload are not always available.
> >
> > Bootstrapping this with myself and Greg as maintainers (since the current
> > drivers will be moving out of drivers/misc). Looking forward to expanding
> > that group over time.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
>
> I spent a bit of time reading the proposed drivers, mostly just their uapi
> (habanalabs and ocxl&cxl), and there's really no technical difference I
> think between an accelaration driver sitting in drivers/gpu and an
> accelaration driver sitting in drivers/accel. Except:
>
> - drivers/gpu already has common interfaces for the things you'll probably
>   want to standardize (buffer sharing, syncronization primitives,
>   scheduler - right now we're working on figuring out some common
>   tracepoints).
>
> - Maybe even more important, drivers/gpu has the lessons learned in its
>   codebase about what not to standardize between drivers (everything else,
>   you'll regret it, we've been there).
>
> - drivers/gpu is the subsystem with 20 years of experience writing tiny
>   shim drivers in the kernel for high performance accelarators that need a
>   pretty huge stack in userspace to make them do anything useful. 20 years
>   ago all the rage to make faster was graphics, now it's AI. Looks exactly
>   the same from a kernel pov - command buffers, gigabytes of DMA and a
>   security/long term support nightmare.
>
> - drivers/gpu requires open source. The real thing, not some demo that
>   does a few DMA operations.
>
> And now we have drivers/accel and someone gets to explain to nvidia (or
> arm or whatever) how their exact same drivers (and well run engineering
> orgs really only invent command submission once) can be merged when they
> say it's for a TPU, and will get rejected when they say it's for a GPU. Or
> someone gets to explain to TPU+GPU vendors why their driver is not cool
> (because we'd end up with two), while their startup-competition only doing
> a TPU is totally fine and merged into upstream. Or we just stuff all the
> kernel drivers for blobby userspace into drivers/accel and otherwise
> ignore each another.

One awkward scenario I've missed is the following:
1. the fully open stack for accelarating glow/tensorflow/DNN that
we're planning to make happen takes off. Rough idea is
llvm+spriv+clover (in mesa) + gallium backends (also mesa3d) + drm.

2. if that's the case and someone writes an r/e'ed driver for such a
TPU (and the vendor supporting only their blob stack) then the
reasonable thing would be to write that stack on top of the existing
open source accelarator infrastructure. So a new/2nd driver in the
kernel, using the drm+mesa infrastructure.

3. this means to not block r/e efforts on we need to be ok with
duplicated drivers between drivers/accel and drivers/gpu - not being
able to share code with all the other programmable accelarators will
make it nigh impossible to have a working r/e'ed stack. We already see
this on the gl/vk/cl side, where the mesa drivers tend to be 1-2
orders of magnitude smaller than the proprietary/vendor stacks
(whether open or closed).

> I guess that last option would at least somewhat help me, since I wont
> ever have to explain anymore why we're the radical commies on dri-devel
> :-)
>
> Anyway, only reason I replied here again is because I accidentally started
> a private thread (well was too lazy to download the mbox to properly
> reply), and that's not good either. But I don't think anyone's going to
> change their opinion here, I think this reply is just for the record.
>
> Cheers, Daniel
>
> PS: Seen that there's a v2 of this now with Documentation, hasn't reached
> my inbox (yet). I don't think that one clarifies any of the tricky
> questions between drivers/gpu and drivers/accel, so figured won't harm if
> I leave the reply on v1.

Given the above revising my stance, and I think your item to exclude
overlap between drivers/accel and drivers/gpu is actually harmful. And
we instead need a line that yes, there is overlap, and we do expect
the occasional duplicated driver for the same hardware. I think that's
going to have the best outcome:

- It's not going to piss off the drivers/gpu people any more than
drivers/accel itself does, you already scored all the sighs you'll get
I think. So won't make things worse.

- It's going to be the technically sound decision, since no more "is
this a tpu or gpu" non-technical tricky questions that just depend
upon what you market a chip for, instead of what it is.

- I think it's going to be much quicker to prove whether drivers/gpu
is too strict with merging drivers and has harmed the overall
ecosystem, since you'll have many more drivers to potentially merge.
One argument in your favour is clearly that we've never tried to drop
the open source userspace requirement. Imo if we're going to do this
experiment, we should do it right.

- There's not going to be a problem for accelarators that need to work
together with atomic modeset drivers or v4l drivers for displaying
their computation results - all you need for that is dma-buf import,
and you'll need that sooner or later anyway in drivers/accel. dma-buf
compatibility extends all gfx userspace protocols (I think we rev'ed
them all to add dma-buf support). There's also not going to be
coordination problems due to this with drivers/gpu, since all the
dma-buf bits you'll need are already in drivers/dma-buf.

- It might actually make r/e'ing gpus easier, since currently you need
to boot 2 different kernels: One with the upstream drm stack, the
other with downstream vendor stack. If you actually manage to get all
these drivers merged in a useable state that would become better.

- Essentially this would make drivers/accel the -staging for
drivers/gpu, at least from our pov. I don't think that's going to be
an issue - with Greg you already have the residential expert for
maintaining dumpster fires on the team. And as long as we don't try to
share code (beyond stuff in drivers/dma-buf) I don't think this will
result in the coordination pains we've had with display drivers in
-staging.

- This is not going to set a new precedence - there's been plenty of
duplicated subsystem, especially for drivers. Occasionally you just
need to burn it all down and start over.

- Like with your proposal here for drivers/accel we can always change
the rules in a few years, or whenever it's clear what to do. And I
think the positions between the drivers/gpu and drivers/accel folks
are fundamentally opposed, there's not really a room for a both ways
compromise, best seems to decide this by actually trying it out.

- Plus, I can just point people at you instead of having to explain
why we insist on open source for accelarators in drivers/gpu. That
wasn't meant as a joke, not entirely at least, it's kinda tiring to
have this discussion at least once every year ...

tldr; If you want to do this, do it right.

All we need is to drop your paragraph about avoiding overlap with
drivers/gpu, and instead acknowledge that there is an overlap with the
accelarator drivers in drivers/gpu and clearly state that both
subsystems are going to be ok with that overlap and duplication. I'd
ack that version.

Cheers, Daniel

> > ---
> >  MAINTAINERS            |  8 ++++++++
> >  drivers/Kconfig        |  2 ++
> >  drivers/Makefile       |  1 +
> >  drivers/accel/Kconfig  | 16 ++++++++++++++++
> >  drivers/accel/Makefile |  5 +++++
> >  5 files changed, 32 insertions(+)
> >  create mode 100644 drivers/accel/Kconfig
> >  create mode 100644 drivers/accel/Makefile
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ddcdc29dfe1f6..8a9bbaf8f6e90 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7033,6 +7033,14 @@ W:     https://linuxtv.org
> >  S:   Supported
> >  F:   drivers/media/platform/sti/hva
> >
> > +HW ACCELERATOR OFFLOAD SUBSYSTEM
> > +M:   Olof Johansson <olof@lixom.net>
> > +M:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +L:   linux-accelerators@lists.ozlabs.org
> > +S:   Supported
> > +F:   drivers/accel/
> > +F:   Documentation/accelerators/
> > +
> >  HWPOISON MEMORY FAILURE HANDLING
> >  M:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >  L:   linux-mm@kvack.org
> > diff --git a/drivers/Kconfig b/drivers/Kconfig
> > index 4f9f99057ff85..3cc461f325569 100644
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
> >
> >  source "drivers/slimbus/Kconfig"
> >
> > +source "drivers/accel/Kconfig"
> > +
> >  endmenu
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 04da7876032cc..e4be06579cc5d 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER) += mux/
> >  obj-$(CONFIG_UNISYS_VISORBUS)        += visorbus/
> >  obj-$(CONFIG_SIOX)           += siox/
> >  obj-$(CONFIG_GNSS)           += gnss/
> > +obj-$(CONFIG_ACCEL)          += accel/
> > diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> > new file mode 100644
> > index 0000000000000..13b36c0398895
> > --- /dev/null
> > +++ b/drivers/accel/Kconfig
> > @@ -0,0 +1,16 @@
> > +#
> > +# Drivers for hardware offload accelerators
> > +# See Documentation/accel/README.rst for more details
> > +#
> > +
> > +menuconfig ACCEL
> > +     bool "Hardware offload accelerator support"
> > +        help
> > +       HW offload accelerators are used for high-bandwidth workloads
> > +       where a higher-level kernel/userspace interface isn't suitable.
> > +
> > +if ACCEL
> > +
> > +comment "HW Accellerator drivers"
> > +
> > +endif
> > diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> > new file mode 100644
> > index 0000000000000..343bbb8f45a14
> > --- /dev/null
> > +++ b/drivers/accel/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for accel devices
> > +#
> > +
> > --
> > 2.11.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
