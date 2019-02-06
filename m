Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70946C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8E2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfBFGfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:35:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:43539 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFGfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:35:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 22:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="asc'?scan'208";a="272848284"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2019 22:35:44 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] usb: xhci: add Immediate Data Transfer support
In-Reply-To: <20190205195647.29258-1-nsaenzjulienne@suse.de>
References: <20190205195647.29258-1-nsaenzjulienne@suse.de>
Date:   Wed, 06 Feb 2019 08:35:40 +0200
Message-ID: <87lg2tmnk3.fsf@linux.intel.com>
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
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 40fa25c4d041..a4efbe62a1a3 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3272,8 +3272,15 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_=
t mem_flags,
>  			field |=3D TRB_IOC;
>  			more_trbs_coming =3D false;
>  			td->last_trb =3D ring->enqueue;
> +
> +			if (xhci_urb_suitable_for_idt(urb)) {
> +				memcpy(&send_addr, urb->transfer_buffer,
> +				       trb_buff_len);
> +				field |=3D TRB_IDT;
> +			}
>  		}
>=20=20
> +

trailing change

> @@ -3411,6 +3418,12 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_=
t mem_flags,
>  	if (urb->transfer_buffer_length > 0) {
>  		u32 length_field, remainder;
>=20=20
> +		if (xhci_urb_suitable_for_idt(urb)) {
> +			memcpy(&urb->transfer_dma, urb->transfer_buffer,
> +			       urb->transfer_buffer_length);
> +			field |=3D TRB_IDT;
> +		}
> +
>  		remainder =3D xhci_td_remainder(xhci, 0,
>  				urb->transfer_buffer_length,
>  				urb->transfer_buffer_length,
> @@ -3420,6 +3433,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t=
 mem_flags,
>  				TRB_INTR_TARGET(0);
>  		if (setup->bRequestType & USB_DIR_IN)
>  			field |=3D TRB_DIR_IN;
> +

trailing change

> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 005e65922608..dec62f7f5dc8 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
>=20=20
>  /*----------------------------------------------------------------------=
---*/
>=20=20
> +/*
> + * Bypass the DMA mapping if URB is suitable for Immediate Transfer (IDT=
),
> + * we'll copy the actual data into the TRB address register. This is lim=
ited to
> + * transfers up to 8 bytes on output endpoints of any kind with wMaxPack=
etSize
> + * >=3D 8 bytes.
> + */
> +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +				gfp_t mem_flags)
> +{
> +	if (xhci_urb_suitable_for_idt(urb))
> +		return 0;
> +
> +	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
> +}

don't you need a matching unmap_urb_for_dma()??

> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 652dc36e3012..9d77b0901ab7 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
>  #define TRB_IOC			(1<<5)
>  /* The buffer pointer contains immediate data */
>  #define TRB_IDT			(1<<6)
> +/* TDs smaller than this might use IDT */

Technically, "TDs at most this" since you're 8 itself is an allowed
size.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxagDwACgkQzL64meEa
mQYwwhAAmKBLft2kXtuShT+9jt2f6fYig0SD7rvHKd0/9YPC80Sts4eo0jyxNzPZ
uFmWnYm2JHsPkm6btayxd+LK8MQt2WZoMk2eaNpO9SbJy50als10y6nZJIHWYRu3
fXSGbo4qHg52v9bsGkoNIwgRZ161CL7fETHePOfGBpbSvbCAZZ4f6kFW7n/UwRBm
9zCZw+VT3zOcAU6lc21qkoOsHlr1IRtSCurBD38qtUQ+OadintuGUnQHz781Juwp
oadURjvZgpOqU3D9ITYp6xOgu+NjbpTVAhRrk+LyciMkGBswI00WUWndj/iT7dw8
XzUzaWEuJbtFeLCK5XWAFdTKaQoQcc6qPd0XoboBZDWq2zYnIPmodENrEGqqipbI
nQMsh6xNIyOPLyyS9dypOCkaXnTznhoFNvNzjBKFJ2xS0DMTs7ZCZUU9mZLbqlzI
jpkKixRXHkdOBpyw9PcKMVcBjCyd1TUbU39+29+Zb0yFxMbDznsr7oayMSy6DHIq
1PtA49eoEBGcRAXwdBL/AMfBn6MYRcXF+fnc8cRHvlNSuFVOgyghbGFggiAWTemu
3wvJObqIaR2f7g2L1tPKXMLqLCmwLECTGZAOgMRBvDawUFIrvTh1g7GqMey6YSnf
/kYHybiQTY24cv4b5OytaU09UIKZ5bQZMIdwX6+ufPwD6sIgd3Q=
=eW3F
-----END PGP SIGNATURE-----
--=-=-=--
