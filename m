Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF649C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96877217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBFKy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:54:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:16674 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFKy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:54:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 02:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="asc'?scan'208";a="114104207"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2019 02:54:54 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, oneukum@suse.com,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] usb: xhci: add Immediate Data Transfer support
In-Reply-To: <294f2492f8d3b7022bf659dcb473c45a34e85db8.camel@suse.de>
References: <20190205195647.29258-1-nsaenzjulienne@suse.de> <87lg2tmnk3.fsf@linux.intel.com> <294f2492f8d3b7022bf659dcb473c45a34e85db8.camel@suse.de>
Date:   Wed, 06 Feb 2019 12:54:50 +0200
Message-ID: <871s4lmbk5.fsf@linux.intel.com>
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
>> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> > index 005e65922608..dec62f7f5dc8 100644
>> > --- a/drivers/usb/host/xhci.c
>> > +++ b/drivers/usb/host/xhci.c
>> > @@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
>> >=20=20
>> >  /*-------------------------------------------------------------------=
------
>> > */
>> >=20=20
>> > +/*
>> > + * Bypass the DMA mapping if URB is suitable for Immediate Transfer (=
IDT),
>> > + * we'll copy the actual data into the TRB address register. This is
>> > limited to
>> > + * transfers up to 8 bytes on output endpoints of any kind with
>> > wMaxPacketSize
>> > + * >=3D 8 bytes.
>> > + */
>> > +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>> > +				gfp_t mem_flags)
>> > +{
>> > +	if (xhci_urb_suitable_for_idt(urb))
>> > +		return 0;
>> > +
>> > +	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
>> > +}
>>=20
>> don't you need a matching unmap_urb_for_dma()??
>
> Not really as every DMA mapping sets a matching URB flag to track it. For
> example when usb_hcd_map_urb_for_dma() uses dma_map_single() it will set
> URB_DMA_MAP_SINGLE in urb->transfer_flags, later on unmap_urb_for_dma() w=
ill
> catch it and unmap it. As I bypass the mapping altogether there are no
> flags set, so unmap_urb_for_dma() won't have any effect.
>
> I could still add it for clarity, and well, I guess it'll save some
> instructions on the IDT suitable side.

thanks for the clarification.

>> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> > index 652dc36e3012..9d77b0901ab7 100644
>> > --- a/drivers/usb/host/xhci.h
>> > +++ b/drivers/usb/host/xhci.h
>> > @@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
>> >  #define TRB_IOC			(1<<5)
>> >  /* The buffer pointer contains immediate data */
>> >  #define TRB_IDT			(1<<6)
>> > +/* TDs smaller than this might use IDT */
>>=20
>> Technically, "TDs at most this" since you're 8 itself is an allowed

heh, I made a mess on this sentence, but I guess you got the gist of it.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxavPoACgkQzL64meEa
mQbEphAAx7v6Cfg8lcpqDO9sG4SdQ2xwsEQZVh7tGXIxH5g4P+4JeZonjmWSbpO+
jg+l7VXtMCBA03vkOSBEkhEePbdz5V9ew6CzPRVvcoqKubzBR2LaYXiCqolf7yol
eLbNHDClKF5XGDnElQoMCYQqdP1A9tkeTxf1PRGQtIVvPP6hE9uqwe1upeyksihv
v2R/wO5Ikj1FONhPhGptdp/Y6TpB6W3huks9xMHfdoGpybw27H6+C0hvWhn4C+1+
rzsWKYCGSNVWrumsp4Yvhi/fXhVp8KGtNLz0zqtPqm1vvOldpsOVCBHGJTcC7zXN
BP/4k1PFj0DlkbUVQnXunzNTUeeZCRNfckyqjs+ikh7+DylAleZXXUZGLifsXk5f
RI0vJ6EPDRv90F5arIy9n2bsM7U4uo9FPHXpc4F9lJD4Ccg3QUfCfv4PfiH/Ky5n
ph1GgCu/cdNeuSc3h6o4kvyigoD2fXHPaG8GeY3F6eh0nEMcJJ4S5ZXsDwGOpDAN
YNtw7d/+xVwnOle4VUi+aRQQ2KU45iSzNTDJDOvPqSYYjdbO/cOKjnopftsoaeMV
fKByimVFXgu5ehVOL1pREyiQUpUjC+oUoUhQ4z5vLskL7DxIhComD+NDZPTteBvi
8xIjUDZvwA4x9UIgyQcFdaOoC7sXiMUZ4BLEWRI2uZzazgXnlLk=
=YNGD
-----END PGP SIGNATURE-----
--=-=-=--
