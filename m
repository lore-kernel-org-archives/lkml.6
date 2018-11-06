Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BBA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKFUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:49:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:35425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeKFUts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:49:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 03:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="asc'?scan'208";a="271754305"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2018 03:25:00 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>, Bin Liu <b-liu@ti.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
In-Reply-To: <Pine.LNX.4.44L0.1811021437410.1469-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1811021437410.1469-100000@iolanthe.rowland.org>
Date:   Tue, 06 Nov 2018 13:24:56 +0200
Message-ID: <87a7mmv46v.fsf@linux.intel.com>
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
> There's a similar race at the hardware level.  What happens if the
> controller receives a new SETUP packet and concurrently the driver is
> setting up the controller registers for a response to an earlier
> SETUP?  I don't know how real controllers handle this.

That's HW implementation detail. DWC3, for instance, will ignore the
TRBs and return me the status "setup packet pending". Then I just start
a new SETUP TRB.

>> > > I wonder if there's really a use case for delaying the data stage of
>> > > control OUT requests, as it seems to me that we can perform the
>> > > asynchronous validation of the setup and data stages together, in wh=
ich
>> > > case we would always proceed to the data stage, and only potentially
>> > > delay the status stage. However, if we switch to an explicit API whe=
re
>> > > the transition from the setup to the data stage is triggered by queu=
eing
>> > > a request, and given that such a transition may need to be delayed f=
or
>> > > the control IN case, delaying the data stage for control OUT would
>> > > essentially come for free.
>>=20
>> What do you think about this ? Should we allow function drivers to delay=
 the=20
>> data stage of control OUT requests ?
>
> You mean, should we allow function drivers to queue the data-stage
> request after the setup handler has returned?  I don't see any reason

that's already done:

static void dwc3_ep0_xfer_complete(struct dwc3 *dwc,
			const struct dwc3_event_depevt *event)
{
	struct dwc3_ep		*dep =3D dwc->eps[event->endpoint_number];

	dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;
	dep->resource_index =3D 0;
	dwc->setup_packet_pending =3D false;

	switch (dwc->ep0state) {
	case EP0_SETUP_PHASE:
		dwc3_ep0_inspect_setup(dwc, event);
		break;
[...]
}

static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
		const struct dwc3_event_depevt *event)
{
	struct usb_ctrlrequest *ctrl =3D (void *) dwc->ep0_trb;
	int ret =3D -EINVAL;
	u32 len;

	if (!dwc->gadget_driver)
		goto out;

	trace_dwc3_ctrl_req(ctrl);

	len =3D le16_to_cpu(ctrl->wLength);
	if (!len) {
		dwc->three_stage_setup =3D false;
		dwc->ep0_expect_in =3D false;
		dwc->ep0_next_event =3D DWC3_EP0_NRDY_STATUS;
	} else {
		dwc->three_stage_setup =3D true;
		dwc->ep0_expect_in =3D !!(ctrl->bRequestType & USB_DIR_IN);
		dwc->ep0_next_event =3D DWC3_EP0_NRDY_DATA;
	}
[...]
}

static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
		struct dwc3_request *req)
{
	struct dwc3		*dwc =3D dep->dwc;

	req->request.actual	=3D 0;
	req->request.status	=3D -EINPROGRESS;
	req->epnum		=3D dep->number;

	list_add_tail(&req->list, &dep->pending_list);

[...]

	if (dwc->three_stage_setup) {
		unsigned        direction;

		direction =3D dwc->ep0_expect_in;
		dwc->ep0state =3D EP0_DATA_PHASE;

		__dwc3_ep0_do_control_data(dwc, dwc->eps[direction], req);

		dep->flags &=3D ~DWC3_EP0_DIR_IN;
	}

	return 0;
}

Regardless of the direction, control data always depends on a call to
usb_ep_queue()

> why not.  After all, some drivers may require this.  Likewise for the=20
> data stage of a control-IN.
>
> Another thing we should do is give function drivers a way to send a
> STALL response for the status stage.  Currently there's no way to do
> it, if a data stage is present.

Status stage can only be stalled if host tries to move data on the wrong
direction. Currently, that's handled internally by UDCs since that's
easy enough to track.

Data stage already has explicit stall handling.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvheggACgkQzL64meEa
mQYUWQ//QKqUTzvDjFhnwAxDZtYUGagYIOnk98FI3Xrn7rHyA3jGMfnqbe55mVO7
FvaNwtYZTI0ADk8o63EkfW2Ey8HNtn7ejyQROHMKM8jrPdf9O+00fryqnhbXkKJk
ZdCys12+4MMWCfDq2XR1bvH98Xy949m8XiVNFN3IYkZ4a9GXyQ0B8zQ/gqP7nP36
bO3OyJOoj2ffXLITRyT37j3v6MqsFS80B+ioQKp0I41rCJnXBRsisa2HSsM3iDtN
z2GF7keXPfORIjblqvM13Dunxhfze11Tz+BwQfcmghzkur3KIS3zRpsur9tL8fI7
Y8XwzKeMjSsIrqOOT019Cqj3hhNzt797qGbHT5kfNlK8ZTsm8LeLK9WPd6GQ2gzu
oyvha7EMFo5RPzcOER++e3WxgXrLOSBL5AvPsuUXUWLdE2Ao79QLqE0r8UfoXtfn
tcCWLzxPtzSvxWfF8/6JNiNHiXu76pn6w0ZTDHLPEtkVJew9khmiyWsbSqehteTO
hcMtY1ipIlbjwJZm/33NY3iYlSzkFKLOrWLcFcRy/wcpNRm3wquJ5/aXy4JH3EYc
3ustJuOzM3CcH3uvJX3h+WkK8VBR/EcMsJ266e+KW0eS5cJbmPJFJETinJnNfHY4
D5KPU/5XdS9H19nqrw4PY/QjwgtkY1bkrKklZFzkLUbZXcqK5Kc=
=sMbS
-----END PGP SIGNATURE-----
--=-=-=--
