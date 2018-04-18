Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeDRNNW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:13:22 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49221 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeDRNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:13:20 -0400
X-Originating-IP: 2.224.242.101
Date: Wed, 18 Apr 2018 15:13:14 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, thomas.petazzoni@free-electrons.com,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180418131314.GC3999@w540>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20180418104703.GA12462@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

On Wed, Apr 18, 2018 at 03:47:03AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 17, 2018 at 03:35:23PM +0200, Jacopo Mondi wrote:
> > With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> > operations observe dev->dma_pfn_offset") the generic DMA allocation
> > function on which the SH 'dma_alloc_coherent()' function relies on,
> > access the 'dma_pfn_offset' field of struct device.
> >
> > Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> > several places with a NULL struct device argument, halting the CPU
> > during the boot process.
> >
> > This patch fixes the issue protecting access to dev->dma_pfn_offset,
> > with a trivial check for validity. It also passes a valid 'struct device'
> > in the 'platform_resource_setup_memory' function which is the main user
> > of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> > (and existing) bogus users of this function they're should provide a valid
> > 'struct device' whenever possible.
>
> Please fix those callers to not pass a NULL pointer instead.

As long as it goes for arch/sh, the only user of dma_alloc_coherent()
is platform_resource_setup_memory(), and it has been fixed by this
patch.

Unfortunately, as Thomas pointed out, there are drivers which calls
into this with the wrong 'struct device' as the sh_eth one he had fixed.

I would then say that as long as it goes for the NULL case, we should be
fine now.

Thanks
   j

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa10RqAAoJEHI0Bo8WoVY8Yd0P/iiNRjagfqzMP1IsC2KW4DjU
NNDYLQdjp8rNwfpHKnIUHe1L40bramSe6FbaKIIFyAjoZfQX+6AKwU23wPbf7P6j
NjSj1Vh/jMLeDIrGIWVslHHQ3fJ6UMm39h178sMJBDxRwFsdTYWqFmKHTkpWU+9C
mlEq7TT1k9C0u94VfK/2bCy88ndqxImW833OWcAuCmXpAiwr1Jq+0pptF1Z8g2eV
asXaTpxUebeqOvar3o7nszlQFJL8NWBg64BVFPZz96j601XHVOhziQcp0Yy3H8D6
OTvG6qB+4v3izbWU5T8U9lOJ4GlmyWaf0RmIEf+SxYU2zRnd18w8r4o2p10ho/SI
zt8KlLlzRkJH9ZM+H55LrT76OuXGoKvIqmaLaRcFS8PWe+yMKgoUura/E/SqyEsR
6qhehCshVaROUXn94HPP5UOT0NgE7XLcr6/bVj8Vkpr1K0L33qk6KyQHf/h8vTc8
xgYkg8D3AQrh3YR5dJhmfmj6lUeGfFI84DW6teIctss+XBnMW2JUgCLWbUTM/hSP
ZFCsrtfhrU11y82o7GXRKoyp5qci4iGuAkqyrImJdyD2YVbpyrSvPvpVgpvGiEHi
8rUHUfnf3/5OHA1rdMhY42RSntuXvuINjyrzDeLuof7KaeHqKDN0o3hpcPUranaA
is0I+gj6irYVukOtcQTs
=e52k
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
