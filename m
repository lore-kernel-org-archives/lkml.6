Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12332C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBE22175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfBFKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:08:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbfBFKIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:08:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C2BEAEE3;
        Wed,  6 Feb 2019 10:08:04 +0000 (UTC)
Message-ID: <294f2492f8d3b7022bf659dcb473c45a34e85db8.camel@suse.de>
Subject: Re: [RFC v2] usb: xhci: add Immediate Data Transfer support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Feb 2019 11:08:02 +0100
In-Reply-To: <87lg2tmnk3.fsf@linux.intel.com>
References: <20190205195647.29258-1-nsaenzjulienne@suse.de>
         <87lg2tmnk3.fsf@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6r4fzilJ9n6UXsMvKJAp"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6r4fzilJ9n6UXsMvKJAp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felipe, thanks for the review!

On Wed, 2019-02-06 at 08:35 +0200, Felipe Balbi wrote:
> Hi,
>=20
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.=
c
> > index 40fa25c4d041..a4efbe62a1a3 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -3272,8 +3272,15 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gf=
p_t
> > mem_flags,
> >  			field |=3D TRB_IOC;
> >  			more_trbs_coming =3D false;
> >  			td->last_trb =3D ring->enqueue;
> > +
> > +			if (xhci_urb_suitable_for_idt(urb)) {
> > +				memcpy(&send_addr, urb->transfer_buffer,
> > +				       trb_buff_len);
> > +				field |=3D TRB_IDT;
> > +			}
> >  		}
> > =20
> > +
>=20
> trailing change

Noted

>=20
> > @@ -3411,6 +3418,12 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gf=
p_t
> > mem_flags,
> >  	if (urb->transfer_buffer_length > 0) {
> >  		u32 length_field, remainder;
> > =20
> > +		if (xhci_urb_suitable_for_idt(urb)) {
> > +			memcpy(&urb->transfer_dma, urb->transfer_buffer,
> > +			       urb->transfer_buffer_length);
> > +			field |=3D TRB_IDT;
> > +		}
> > +
> >  		remainder =3D xhci_td_remainder(xhci, 0,
> >  				urb->transfer_buffer_length,
> >  				urb->transfer_buffer_length,
> > @@ -3420,6 +3433,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp=
_t
> > mem_flags,
> >  				TRB_INTR_TARGET(0);
> >  		if (setup->bRequestType & USB_DIR_IN)
> >  			field |=3D TRB_DIR_IN;
> > +
>=20
> trailing change

Noted

>=20
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 005e65922608..dec62f7f5dc8 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
> > =20
> >  /*--------------------------------------------------------------------=
-----
> > */
> > =20
> > +/*
> > + * Bypass the DMA mapping if URB is suitable for Immediate Transfer (I=
DT),
> > + * we'll copy the actual data into the TRB address register. This is
> > limited to
> > + * transfers up to 8 bytes on output endpoints of any kind with
> > wMaxPacketSize
> > + * >=3D 8 bytes.
> > + */
> > +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +				gfp_t mem_flags)
> > +{
> > +	if (xhci_urb_suitable_for_idt(urb))
> > +		return 0;
> > +
> > +	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
> > +}
>=20
> don't you need a matching unmap_urb_for_dma()??

Not really as every DMA mapping sets a matching URB flag to track it. For
example when usb_hcd_map_urb_for_dma() uses dma_map_single() it will set
URB_DMA_MAP_SINGLE in urb->transfer_flags, later on unmap_urb_for_dma() wil=
l
catch it and unmap it. As I bypass the mapping altogether there are no
flags set, so unmap_urb_for_dma() won't have any effect.

I could still add it for clarity, and well, I guess it'll save some
instructions on the IDT suitable side.

>=20
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 652dc36e3012..9d77b0901ab7 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
> >  #define TRB_IOC			(1<<5)
> >  /* The buffer pointer contains immediate data */
> >  #define TRB_IDT			(1<<6)
> > +/* TDs smaller than this might use IDT */
>=20
> Technically, "TDs at most this" since you're 8 itself is an allowed
> size.
>=20

Noted

Regards,
Nicolas



--=-6r4fzilJ9n6UXsMvKJAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlxasgIACgkQlfZmHno8
x/5E6Af/csw7wvDtJrUA3ld81HAB4UkFQkd8lrVIs/QojScmFu5HXe1iC5nuCBcd
I0yBy2gOCPfg3F0bxKoLdlnrffPyES+5hPRgyaOKA3+hOV+sLqjL0ZaNLZPx7/nt
xI2k2J01gk0X66Xe4p7+hCl5PqbXMFNPvwZGla8Cn8plCjzGWmoLDiePmE6M60By
/WjdJYQ+N4hUwp8XUbAYjhEXm4uI8KPRueE7FoLrfRpYKpKxC4cIMMLf46ZBLIIZ
spcOudOcJvueHgxmrv2Z0gqBKd7CcjTzyD7iVIaI5n3rhDoEQ4aM0i029hrwUMDF
UnsGTYv+dbpNRZI+lC+9JzfzYeoHTQ==
=Ebfu
-----END PGP SIGNATURE-----

--=-6r4fzilJ9n6UXsMvKJAp--

