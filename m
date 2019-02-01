Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146CAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8000218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfBAOXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:23:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:48684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfBAOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:22:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86CC5ADF1;
        Fri,  1 Feb 2019 14:22:56 +0000 (UTC)
Message-ID: <90fcd01fa91e82ca8aa03bb0372ba82d9edf1586.camel@suse.de>
Subject: Re: [RFC] usb: xhci: add Immediate Data Transfers support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Feb 2019 15:22:54 +0100
In-Reply-To: <877eejocsu.fsf@linux.intel.com>
References: <20190201130602.9171-1-nsaenzjulienne@suse.de>
         <877eejocsu.fsf@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9E1gLQLqdgx918cZW4kj"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9E1gLQLqdgx918cZW4kj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felipe, thanks for the review :)

On Fri, 2019-02-01 at 15:31 +0200, Felipe Balbi wrote:
> Hi,
>=20
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
> > Immediate data transfers (IDT) allow the HCD to copy small chunks of
> > data (up to 8bits) directly into its output transfer TRBs. This avoids
>               ^^^^^
>               8 bytes

Obviously, noted.

>=20
> > the somewhat expensive DMA mappings that are performed by default on
> > most URBs submissions.
> >=20
> > In the case an URB was suitable for IDT. The data is directly copied
> > into the "Data Buffer Pointer" region of the TRB and the IDT flag is
> > set. Instead of triggering memory accesses the HC will use the data
> > directly.
> >=20
> > An additional URB flag was created to mark whenever the URB doesn't nee=
d
> > any DMA mapping. Ideally it would have been nice to use a private flag
> > as this is specific to XHCI. Yet it's not possible as the URB private
> > area is allocated only after the DMA mapping is done.
> >=20
> > Isochronous transfers are not implemented so far as it's hard to find a
> > device that will send such small packets.
> >=20
> > This was tested using USB/serial adapter and by controlling the leds on
> > an XBOX controller. There where no disruptions on the rest of USB
> > devices attached on the system.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/usb/host/xhci-ring.c |  6 ++++++
> >  drivers/usb/host/xhci.c      | 37 ++++++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci.h      |  2 ++
> >  include/linux/usb.h          |  2 ++
> >  4 files changed, 47 insertions(+)
> >=20
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.=
c
> > index 40fa25c4d041..dd9805fb0566 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -3272,6 +3272,12 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gf=
p_t
> > mem_flags,
> >  			field |=3D TRB_IOC;
> >  			more_trbs_coming =3D false;
> >  			td->last_trb =3D ring->enqueue;
> > +
> > +			if (urb->transfer_flags & URB_NO_DMA_MAP) {
>=20
> do you really need the flag? Why don't you do this unconditionally as
> long as urb->transfer_length is <=3D 8?

There is a set of limitations, see my comments below.

>=20
> > +				memcpy(&send_addr, urb->transfer_buffer,
> > +				       full_len);
> > +				field |=3D TRB_IDT;
> > +			}
> >  		}
> > =20
> >  		/* Only set interrupt on short packet for IN endpoints */
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 005e65922608..ce3b6663f940 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1238,6 +1238,41 @@ EXPORT_SYMBOL_GPL(xhci_resume);
> > =20
> >  /*--------------------------------------------------------------------=
-----
> > */
> > =20
> > +static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *ur=
b)
> > +{
> > +	if (urb->transfer_flags & URB_NO_DMA_MAP)
> > +		urb->transfer_flags &=3D ~URB_NO_DMA_MAP;
> > +	else
> > +		usb_hcd_unmap_urb_for_dma(hcd, urb);
> > +}
> > +
> > +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +				gfp_t mem_flags)
> > +{
> > +	int maxp =3D usb_endpoint_maxp(&urb->ep->desc);
> > +	int len =3D urb->transfer_buffer_length;
> > +	int ret =3D 0;
> > +
> > +	/*
> > +	 * Checks if URB is suitable for Immediate Transfer (IDT): instead of
> > +	 * mapping the buffer for DMA and passing the address to the host
> > +	 * controller, we copy the actual data into the TRB address register.
> > +	 * This is limited to transfers up to 8 bytes.
> > +	 *
> > +	 * IDT is only supported for Bulk and Interrupt endpoints. Apart from
> > +	 * the size constraints special care is taken to avoid cases where
> > +	 * wMaxPacketSize is smaller than 8 bytes as it's not supported.
> > +	 */
> > +	if ((usb_endpoint_is_int_out(&urb->ep->desc) ||
> > +	    usb_endpoint_is_bulk_out(&urb->ep->desc)) &&
>=20
> I don't understand the check for endpoint type. IDT is, actually,
> already used for control endpoints because setup packets are composed of
> 8 bytes. You're also showing that this works for INT and BULK types. It
> would be a surprise if it doesn't work for ISOC.

Isoc should work, but I've been unable to find a device with such small
transfer size. As the standard says if IDT is set only a Transfer/Isoc TRB =
is
allowed per TD (see Table 6-22 on the spec). So I guess it makes it unlikel=
y
for an Isoc transfer to match the constraints. That said I'll have a more i=
n
depth look at it.

>=20
> > +	    maxp >=3D TRB_IDT_MAX_SIZE && len <=3D TRB_IDT_MAX_SIZE)
>=20
> why the maxp check? What if I'm an interrupt endpoint with maxp of 2?
> Is there really a limitation that you couldn't use IDT for those?

Same table in specs. As I state in the patch's comment above, IDT with
wMaxPacketSize < 8 it's not supported.

>=20
> > +		urb->transfer_flags |=3D URB_NO_DMA_MAP;
>=20
> do we really need this? I wonder if returning zero here would be enough,
> then you could:

I agree that with Isoc included we could lose the flag and implement it as =
you
state below. Only length and ep's wMaxPacketSize should be checked.

>=20
> ...map_urb_for_dma(...)
> {
> 	ret =3D 0;
>=20
> 	if (urb->transfer_length > 8)
>         	ret =3D usb_hcd_map_urb_for_dma(hcd, urb, flags);
>=20
> 	return ret;
> }
>=20
> ...unmap_urb_for_dma(...)
> {
> 	if urb->transfer_length > 8)
>         	usb_hcd_unmap_urb_for_dma(hcd, urb);
> }
>=20
> ...xhci_queue_bulk_tx(...)
> {
> 	[...]
>=20
> 	if (urb->transfer_length <=3D 8) {
> 		memcpy(&addr, urb->transfer_buffer, 8)l
> 		field |=3D TRB_IDT;
>         }
>=20
> 	[...]
> }
>=20

Regards,
Nicolas


--=-9E1gLQLqdgx918cZW4kj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlxUVj4ACgkQlfZmHno8
x/5ASggAjAPp6Qi3+rmGM/EQuuzYrHkVofPex5pVvPUlfTXorM2oUnQmDfDL5nlO
pPMi6rnD3bf50lDqO8eH4O6G2buW0lpDH89HJ+bpGODO9jFWb2SyocgoOdfi9eCU
99SeEKqQJOz6Htqt/sxO0SsU6QL5iBJlQSFEYu+fx8957X34g/OvLi1jN6f3fGKW
qKYeCf83ZjIrdQKEC+eOk6VvY6q5TgCYRil50TykeSlKiCjLQbo5hqMnnkam30JX
+iBAS5Or3n7Cr95VFMq5ljS8rzq5YKt2qb3N65Xq+rMmstbH5GaAplPl2OMxyE04
EI+cljxcuHhyPDsZLlVUcU3t/u2zyQ==
=YGDE
-----END PGP SIGNATURE-----

--=-9E1gLQLqdgx918cZW4kj--

