Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB21C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A302421872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfBANbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:31:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:8242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfBANbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:31:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 05:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="asc'?scan'208";a="315512397"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2019 05:31:33 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] usb: xhci: add Immediate Data Transfers support
In-Reply-To: <20190201130602.9171-1-nsaenzjulienne@suse.de>
References: <20190201130602.9171-1-nsaenzjulienne@suse.de>
Date:   Fri, 01 Feb 2019 15:31:29 +0200
Message-ID: <877eejocsu.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
> Immediate data transfers (IDT) allow the HCD to copy small chunks of
> data (up to 8bits) directly into its output transfer TRBs. This avoids
              ^^^^^
              8 bytes

> the somewhat expensive DMA mappings that are performed by default on
> most URBs submissions.
>
> In the case an URB was suitable for IDT. The data is directly copied
> into the "Data Buffer Pointer" region of the TRB and the IDT flag is
> set. Instead of triggering memory accesses the HC will use the data
> directly.
>
> An additional URB flag was created to mark whenever the URB doesn't need
> any DMA mapping. Ideally it would have been nice to use a private flag
> as this is specific to XHCI. Yet it's not possible as the URB private
> area is allocated only after the DMA mapping is done.
>
> Isochronous transfers are not implemented so far as it's hard to find a
> device that will send such small packets.
>
> This was tested using USB/serial adapter and by controlling the leds on
> an XBOX controller. There where no disruptions on the rest of USB
> devices attached on the system.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-ring.c |  6 ++++++
>  drivers/usb/host/xhci.c      | 37 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci.h      |  2 ++
>  include/linux/usb.h          |  2 ++
>  4 files changed, 47 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 40fa25c4d041..dd9805fb0566 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3272,6 +3272,12 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_=
t mem_flags,
>  			field |=3D TRB_IOC;
>  			more_trbs_coming =3D false;
>  			td->last_trb =3D ring->enqueue;
> +
> +			if (urb->transfer_flags & URB_NO_DMA_MAP) {

do you really need the flag? Why don't you do this unconditionally as
long as urb->transfer_length is <=3D 8?

> +				memcpy(&send_addr, urb->transfer_buffer,
> +				       full_len);
> +				field |=3D TRB_IDT;
> +			}
>  		}
>=20=20
>  		/* Only set interrupt on short packet for IN endpoints */
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 005e65922608..ce3b6663f940 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1238,6 +1238,41 @@ EXPORT_SYMBOL_GPL(xhci_resume);
>=20=20
>  /*----------------------------------------------------------------------=
---*/
>=20=20
> +static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
> +{
> +	if (urb->transfer_flags & URB_NO_DMA_MAP)
> +		urb->transfer_flags &=3D ~URB_NO_DMA_MAP;
> +	else
> +		usb_hcd_unmap_urb_for_dma(hcd, urb);
> +}
> +
> +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +				gfp_t mem_flags)
> +{
> +	int maxp =3D usb_endpoint_maxp(&urb->ep->desc);
> +	int len =3D urb->transfer_buffer_length;
> +	int ret =3D 0;
> +
> +	/*
> +	 * Checks if URB is suitable for Immediate Transfer (IDT): instead of
> +	 * mapping the buffer for DMA and passing the address to the host
> +	 * controller, we copy the actual data into the TRB address register.
> +	 * This is limited to transfers up to 8 bytes.
> +	 *
> +	 * IDT is only supported for Bulk and Interrupt endpoints. Apart from
> +	 * the size constraints special care is taken to avoid cases where
> +	 * wMaxPacketSize is smaller than 8 bytes as it's not supported.
> +	 */
> +	if ((usb_endpoint_is_int_out(&urb->ep->desc) ||
> +	    usb_endpoint_is_bulk_out(&urb->ep->desc)) &&

I don't understand the check for endpoint type. IDT is, actually,
already used for control endpoints because setup packets are composed of
8 bytes. You're also showing that this works for INT and BULK types. It
would be a surprise if it doesn't work for ISOC.

> +	    maxp >=3D TRB_IDT_MAX_SIZE && len <=3D TRB_IDT_MAX_SIZE)

why the maxp check? What if I'm an interrupt endpoint with maxp of 2?
Is there really a limitation that you couldn't use IDT for those?

> +		urb->transfer_flags |=3D URB_NO_DMA_MAP;

do we really need this? I wonder if returning zero here would be enough,
then you could:

...map_urb_for_dma(...)
{
	ret =3D 0;

	if (urb->transfer_length > 8)
        	ret =3D usb_hcd_map_urb_for_dma(hcd, urb, flags);

	return ret;
}

...unmap_urb_for_dma(...)
{
	if urb->transfer_length > 8)
        	usb_hcd_unmap_urb_for_dma(hcd, urb);
}

...xhci_queue_bulk_tx(...)
{
	[...]

	if (urb->transfer_length <=3D 8) {
		memcpy(&addr, urb->transfer_buffer, 8)l
		field |=3D TRB_IDT;
        }

	[...]
}

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxUSjEACgkQzL64meEa
mQahyRAArMrVSj00oL/k6LTGlMKnyGvSP9gVrBAITw6KWDp4+cojmmvpLdsm4lgt
vIkg7tK6p+L+t1SD3vZL5/HYKr+UR+BjW8EpOAx0TEC99pfAVJd/mL1d8Z+73eOc
qC1vQZ4Tj7LL3XyO1ovfnq5aIi+WqulaLsIAHDyIUY3puaQy3cldMnI7x+ZXG2+I
zh9Wo1qK83VX152FSBrK9QDKfSQUEUgF4TnDr57bf7BCXMSYDK1XHo2fdTzPKPeG
npQxt/yIuozOY0ajwAesnieCQbstFfop8SqGFuwZ/pQCtdKS79e4ZqTYh0GStfEQ
4Xj80lr6TeXl7IhW0DwKQvjC/x/19jn4JBwbg905eDC5gHmPZm0BsUMmXHGlhK3y
BJdwEFZCjg6wyJOeoFvM3VojxSDVIn+vi2Z/FOqRDLEJtrogFt3g+QXCBWuN3cyK
si0YvBQagJb4AHtdaNeiXqcCGziGvWwjO3mDtWNtpzYXd4c8tmd3eptgVVtXRqwu
GmrjErCVL144SVR3Xu7JS/BsyDuvPhtII35KY8jZf+BfAIqGW50bk31vbGf9I2wW
9R42ii9xS7OFcFk6AgieRN7jcBPGuwhstwDfkVYdYnYuLZl7lylYGLvDVerizsNn
64kr05F7qmYPy0901JEVWSfgrmbFzuuTGEFlfacJ8g5mx97W1Yg=
=LmAY
-----END PGP SIGNATURE-----
--=-=-=--
