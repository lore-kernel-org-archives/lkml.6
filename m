Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A021726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAWISc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:18:32 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44194 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfAWISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:18:31 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so420488uaq.11;
        Wed, 23 Jan 2019 00:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12zh+zoF9ZsRypXrhwkpdt/twwtVt55D4zgmcRizveg=;
        b=dyDZ/ivhX6eFQwhGN6vvezJQi4v47iNICpkF1IeYaENxzNOJUKfIOWlArzFqkopKhr
         HPwCY2DyD+VXz5qduN/a3L1/mrCMNYfkBBwObxiPgcF+JanOQFEM2hlsZnAWk55XyvUZ
         LptyQpKTLM5FwwU47shm4+HlV8EahEn+yROpyftuQZCnt+FWiPXK0c3gpkJWzGKwD9yq
         pkqyevp0FMhaU7J7HrayrwG3s1254pfaXIqdYJ/t/dyUSQSLF3wxx778OG0kWzQMxTkP
         pMDGGukAsVK1Psw/gjAGOi2+nQZlGEaTJchZq8A3gf54FGb4HD7k72aE1E7ikePZJbKQ
         y4mQ==
X-Gm-Message-State: AJcUukc4KEHLtjz+K6rb4kUH5GPFK8ERvToj0XFVPWKGUHDb957RUXdf
        iQO6qziD3DpRLoOtViTTRNjZcZlNGldPaH6ciAI=
X-Google-Smtp-Source: ALg8bN6u51b15onggJ4GccuIPcCgsq/sWpMK72DspcgJbIClKAFf3SlGK8SjuViZ2fZ6aUkQ4yKhd8pKpd4T4QMK25Y=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr456885uae.75.1548231510047;
 Wed, 23 Jan 2019 00:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20190123040711.21759-1-aik@ozlabs.ru> <20190122213043.051d7739@x1.home>
In-Reply-To: <20190122213043.051d7739@x1.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Jan 2019 09:18:18 +0100
Message-ID: <CAMuHMdUuTPpYsLcJ2fnZpYQu36_uOELPBLaOQpmRqLaiHLLXEQ@mail.gmail.com>
Subject: Re: [PATCH kernel] vfio-pci/nvlink2: Fix ancient gcc warnings
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        KVM list <kvm@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, Jan 23, 2019 at 5:30 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
> The below patch comes about from the build regressions and improvements
> list you've sent out, but something doesn't add up that we'd be testing
> with an old compiler where initialization with { 0 } generates a
> "missing braces around initialization" warning.  Is this really the
> case or are we missing something here?  There's no harm that I can see
> with Alexey's fix, but are these really just false positives from a
> compiler bug that we should selectively ignore if the "fix" is less
> clean?  Thanks,

Yes, they are false positives, AFAIK.

> On Wed, 23 Jan 2019 15:07:11 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> > Using the {0} construct as a generic initializer is perfectly fine in C,
> > however due to a bug in old gcc there is a warning:
> >
> >   + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near
> > initialization for 'cap.header') [-Wmissing-braces]:  => 181:9

These all seem to come from an old gcc 4.6, which is the oldest still
supported version for compiling Linux
http://kisskb.ellerman.id.au/kisskb/buildresult/13663641/

Note that kisskb is also using gcc 4.6.3 for s390x and mips, which are the only
other builds showing missing braces warnings.

> > Since for whatever reason we still want to compile the modern kernel
> > with such an old gcc without warnings, this changes the capabilities
> > initialization.
> >
> > The gcc bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119
> >
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  drivers/vfio/pci/vfio_pci_nvlink2.c | 30 ++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > index 054a2cf..91d945b 100644
> > --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> > +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > @@ -178,11 +178,11 @@ static int vfio_pci_nvgpu_add_capability(struct vfio_pci_device *vdev,
> >               struct vfio_pci_region *region, struct vfio_info_cap *caps)
> >  {
> >       struct vfio_pci_nvgpu_data *data = region->data;
> > -     struct vfio_region_info_cap_nvlink2_ssatgt cap = { 0 };
> > -
> > -     cap.header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT;
> > -     cap.header.version = 1;
> > -     cap.tgt = data->gpu_tgt;
> > +     struct vfio_region_info_cap_nvlink2_ssatgt cap = {
> > +             .header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT,
> > +             .header.version = 1,
> > +             .tgt = data->gpu_tgt
> > +     };

I think the simpler change

-       struct vfio_region_info_cap_nvlink2_ssatgt cap = { 0 };
+       struct vfio_region_info_cap_nvlink2_ssatgt cap = { { 0 } };

should also work (tested with gcc 4.1).
That's how most of these were fixed in the past.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
