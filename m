Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52009C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D49A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D49A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeKGQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:22:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:44374 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeKGQWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:22:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 22:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="asc'?scan'208";a="247663066"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2018 22:53:47 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Bin Liu <b-liu@ti.com>, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
In-Reply-To: <Pine.LNX.4.44L0.1811060951100.1450-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1811060951100.1450-100000@iolanthe.rowland.org>
Date:   Wed, 07 Nov 2018 08:53:43 +0200
Message-ID: <87tvkttm2w.fsf@linux.intel.com>
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

Alan Stern <stern@rowland.harvard.edu> writes:
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> > There's a similar race at the hardware level.  What happens if the
>> > controller receives a new SETUP packet and concurrently the driver is
>> > setting up the controller registers for a response to an earlier
>> > SETUP?  I don't know how real controllers handle this.
>>=20
>> That's HW implementation detail. DWC3, for instance, will ignore the
>> TRBs and return me the status "setup packet pending". Then I just start
>> a new SETUP TRB.
>
> You mean the UDC hardware sets a "setup pending" flag in some register,
> and then ignores any attempts to do anything with ep0 until the driver
> clears this flag?

Yes, except that the "flag" is a status on the TRB itself (TRB is dwc3's
DMA transfer descriptor).

>> > You mean, should we allow function drivers to queue the data-stage
>> > request after the setup handler has returned?  I don't see any reason
>>=20
>> that's already done:
>>=20
>> static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
>> 			const struct dwc3_event_depevt *event)
>> {
>> 	struct dwc3_ep		*dep =3D dwc->eps[event->endpoint_number];
>>=20
>> 	dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
>> 	dep->resource_index =3D 0;
>> 	dwc->setup_packet_pending =3D false;
>>=20
>> 	switch (dwc->ep0state) {
>> 	case EP0_SETUP_PHASE:
>> 		dwc3_ep0_inspect_setup(dwc, event);
>> 		break;
>> [...]
>> }
>
> ...
>
> You mean, it's already done in DWC3.  What about other UDC drivers?

if they're not implementing this possibility, then that's a bug on
those UDC drivers :)

>> > why not.  After all, some drivers may require this.  Likewise for the=
=20
>> > data stage of a control-IN.
>> >
>> > Another thing we should do is give function drivers a way to send a
>> > STALL response for the status stage.  Currently there's no way to do
>> > it, if a data stage is present.
>>=20
>> Status stage can only be stalled if host tries to move data on the wrong
>> direction.
>
> The USB-2 spec disagrees.  See Table 8-7 in section 8.5.3.1 and the
> following paragraphs.  (Although, I can't see why a function would ever
> fail to complete the command sequence for a control-IN transfer after
> the data had already been sent.)

I can't see how we could ever STALL after returning the data requested
by the host. Seems like that wasn't well thought out.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvii/cACgkQzL64meEa
mQYKvQ/8CCBf3FwaXqIL/mvCQqt1ze3zs8mcp1rxg7hVqSt6y7uQ5xknxV8/QGZ4
P9kj3C5FyV9ezFNK0eyWyaZ8EK/juEiLR2QIGy8gaa4UifNO7HU3o8L9cUIIZNy3
biWQmTuj8ZUUt2CIQI2Yh1AzVFvNwbthtAA3AKtiid977VGJgxA7HUZlzk/0ZHxG
MxqdwHPmjxP3IQAVj1SxNQn3XQKDeUMBmaYmMBMDSlYQghIQXJKEzfp1P0oGJKkx
YYG9VgK7YQYoMMU6jWvClod9pCucyRibokmMzVoOdo0Iik8vpmDQhQEHR/9UeNu6
aP70k0kkSKSSq57JtmagOdzysmlKEQ6LNaybwtOv2VHwiCKB2P/yss77LI61eIhp
/pmvUGg6xNfz6F9dMf3FCp3XAIvVW2ZFdYN8znjA2hltkh8FuKYHa09NGbilEbk1
MJ4gKsxmYazFiM0QkDHjzw7bTEHtVOwmnWGDdo+F794Rr2JNbKmKD2OM6FxuecTg
xZq+ByUc02hANHKw7yHJNachaCYxaj5urZTzkHPCh57aLeO3WGVfmHaEZPI3GcMF
1T8BTK53FJKVY1VBCc7KciBuCIA4Zdphw3pSu9I4XkprztOvRtm/MbxEHt7Z/QIy
USUteLY7V+GNPjf6a3SXtxupxDr3+QdSWYJHU8sgforaYYZK5LA=
=bVC5
-----END PGP SIGNATURE-----
--=-=-=--
