Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeDQOU7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:20:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53689 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDQOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:20:47 -0400
X-Originating-IP: 193.205.81.22
Date: Tue, 17 Apr 2018 16:20:40 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180417142040.GB3519@w540>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdX876iXo-Mio-VxUmR9hq9WFhNtOAn_XdhjFgNvDvXJvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX876iXo-Mio-VxUmR9hq9WFhNtOAn_XdhjFgNvDvXJvg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Tue, Apr 17, 2018 at 04:04:27PM +0200, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> Thanks for your patch!
>
> On Tue, Apr 17, 2018 at 3:35 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> > operations observe dev->dma_pfn_offset") the generic DMA allocation
> > function on which the SH 'dma_alloc_coherent()' function relies on,
> > access the 'dma_pfn_offset' field of struct device.
>
> accesses
>
> > Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> > several places with a NULL struct device argument, halting the CPU
> > during the boot process.
> >
> > This patch fixes the issue protecting access to dev->dma_pfn_offset,
>
> by protecting access to the
>
> > with a trivial check for validity. It also passes a valid 'struct device'
> > in the 'platform_resource_setup_memory' function which is the main user
> > of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> > (and existing) bogus users of this function they're should provide a valid
>
> drop "they're should"?
>
> > 'struct device' whenever possible.
>
> > --- a/arch/sh/mm/consistent.c
> > +++ b/arch/sh/mm/consistent.c
> > @@ -39,6 +39,8 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> >         void *ret, *ret_nocache;
> >         int order = get_order(size);
> >
> > +       WARN_ON(!dev);
> > +
> >         gfp |= __GFP_ZERO;
> >
> >         ret = (void *)__get_free_pages(gfp, order);
> > @@ -59,7 +61,9 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> >
> >         split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> >
> > -       *dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
> > +       *dma_handle = virt_to_phys(ret);
> > +       if (dev)
> > +               *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
>
> I would keep the WARN_ON() and the (ideally unneeded) dev check as close
> to each other as possible:
>
>         if (!WARN_ON(!dev))
>                 *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

Looking at include/linux/dma-mapping.h I thought it was good to have
the WARN_ON() as early as possible in the function.

But your one looks nicer indeed!

>
> >
> >         return ret_nocache;
> >  }
> > @@ -69,9 +73,14 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
> >                                unsigned long attrs)
> >  {
> >         int order = get_order(size);
> > -       unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
> > +       unsigned long pfn = (dma_handle >> PAGE_SHIFT);
> >         int k;
> >
> > +       WARN_ON(!dev);
> > +
> > +       if (dev)
> > +               pfn += dev->dma_pfn_offset;
>
>         if (!WARN_ON(!dev))
>                 pfn += dev->dma_pfn_offset;
>
> > +
> >         for (k = 0; k < (1 << order); k++)
> >                 __free_pages(pfn_to_page(pfn + k), 0);
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'll resend and append your and Thomas' tags.

Thanks
  j
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa1gK4AAoJEHI0Bo8WoVY8unYQAKe11UFhFLLCswHmyDQtep3B
symD0ho3yoygyKt1lS4jnIDLczI5XP53kYSRqvlzX37WYzBWKiyPD/MdAAweSxrA
o3QhTKlkjVdAx/khrj2H/hvNosMru7STmIl13vG549d6cIGxZHJ8qlkgDx4MsdYL
gxHg8qWUlcsPsI2QPEcgx6iHHhNErArqx+Q3ReQoSveDwrGNxHfqwyYfn2o3JaWe
KZNBYFRoPgyI4fDj8Cw3JdrK425N7YkC7AhDA4rW5VlSHUMp9wMHR6xOLJy3pl0R
UWAL2Dspp21/ttNosYHNPgsdf1lEroE7gtRV/9hvm8omnOzoA99kvdEbhr7VjSlC
o+QwOQIvBEAXZrtnFI+TWYgQmjiKHZ6CbyteCc1s0MZoosKjLZ2nvRgchjA822IP
Vb7DkuNVYLZhbz6ZTGqsd/ZyuSrtWc0w4JWx+0DEFeZ5D/97NneRnc0+V0hBL1Tc
iRKy4wL00GTMXVTpY7odnle4H78OnLbSgifpa3mvLrslS07YLGTZ7yImodSjyjVu
Plbwe7GuA8/5jA1zwr/7JPpUDYqj2RDXg2IgbGMJd01IvolZlRw6sg1Pg1H5rxHb
t6teIMkzDOf6PCcop1ltAq2ZRwihZ0ZJaK9HcU6EZSOy4C5eGoO99FaF8u5bQpco
W2pjQEuF1LHEyE/aRDz/
=tH54
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
