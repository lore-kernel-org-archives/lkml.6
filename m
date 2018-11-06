Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC720869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbeKFUl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:41:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:18871 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeKFUl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:41:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 03:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="asc'?scan'208";a="105680863"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2018 03:17:11 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul Elder <paul.elder@ideasonboard.com>, Bin Liu <b-liu@ti.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
In-Reply-To: <3595344.euAgJ7Kpbg@avalon>
References: <Pine.LNX.4.44L0.1811021050190.1469-100000@iolanthe.rowland.org> <3595344.euAgJ7Kpbg@avalon>
Date:   Tue, 06 Nov 2018 13:17:07 +0200
Message-ID: <87d0riv4jw.fsf@linux.intel.com>
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

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:
>> >>>> Furthermore, we have found that USB_GADGET_DELAYED_STATUS is racey,
>> >>>> which has already been observed in the UVC gadget driver previously
>> >>>> [0]. The raceiness stems from the fact that things can happen in
>> >>>> between returning USB_GADGET_DELAYED_STATUS and the composite layer
>> >>>> reacting to it - especially if usb_composite_setup_continue is call=
ed
>> >>>> within that window it causes a WARN. In any case, the fact that the
>> >>>> mechanism itself is racey suggests that it needs improvement, and u=
sing
>> >>>> it wouldn't be a good solution in this case.
>>=20
>> I don't understand this at all.  The composite layer reacts to
>> USB_GADGET_DELAYED_STATUS as soon as it receives the return value.  Can
>> Paul or Laurent give a more explicit example of this race?
>
> The composite layer only handles USB_GADGET_DELAYED_STATUS for=20
> USB_REQ_SET_CONFIGURATION (in set_config()) and for USB_REQ_SET_INTERFACE=
 (in=20
> composite_setup()). It increments cdev->delayed_status immediately. Then,=
 in=20
> usb_composite_setup_continue(), if cdev->delayed_status is not zero, it q=
ueues=20
> a ZLP, and warns otherwise.
>
> This mechanism delays the data stage, not the status stage (or, to be pre=
cise,=20
> it delays the status stage insofar as the status stage comes after the da=
ta=20
> stage), and only supports control OUT requests with 0 bytes of data (whic=
h is=20
> the case of both USB_REQ_SET_INTERFACE and USB_REQ_SET_CONFIGURATION). Fo=
r all=20
> other requests, the composite layer passes USB_GADGET_DELAYED_STATUS to t=
he=20
> UDC.

DATA stage always depends on a usb_ep_queue() from gadget driver. So
it's always "delayed" in that sense.

> The three UDCs that implement USB_GADGET_DELAYED_STATUS support set a=20
> delayed_status flag in an internal structure. I haven't inspected in deta=
ils=20
> what they do next as I'm not familiar with all of them, but the dwc3 driv=
er=20
> just skips the handling of the status phase in dwc3_ep0_xfernotready() an=
d=20
> delays it to __dwc3_gadget_ep0_queue(). This only works for 0-length requ=
ests,=20
> with no data phase.

data stage always depends on usb_ep_queue(). There was never any need
for UDC to handle Data stage internally. Also, status stage is always a ZLP.

> Even when limited to 0-length control OUT requests, this mechanism is rac=
y.=20
> The setup handler, when it wants to delay the status phase, will queue=20
> asynchronous work that will, when it completes, call=20
> usb_composite_setup_continue() to proceed with the status phase. Queuing =
the=20
> work has to be done before the setup handler returns, and the cdev-
>>delayed_status is only incremented after the setup handler returns, in=20
> composite_setup(). There is thus a time window during which the asynchron=
ous=20
> work can call usb_composite_setup_continue() before cdev->delayed_status =
has=20
> been incremented. We have managed to hit this in practice, with a surpris=
ingly=20
> high rate seeing how small the window is.

that's only the case because we have two different "modes" for this. One
where UDC handles it internally and another where gadget driver has to
queue a request. I'm vouching for making status stage always explicit,
i.e. we should always expect a usb_ep_queue().

> Now that I've written all this, I realize that cdev->delayed_status is gu=
arded=20
> by cdev->lock. I thus wonder whether our analysis was correct, or if we w=
ere=20
> hitting a different bug :-S Paul, could you test this again ? Please note=
,=20
> however, that the race described here is not related to this patch series=
,=20
> except in how it influences the API design to avoid race conditions.
>
>> Assuming you are correct, wouldn't it make sense to fix or eliminate
>> the race by changing composite.c?
>
> I was about to write that we would need to lock access to cdev-
>>delayed_status, and found out that we already use cdev->lock to do so. Mo=
re=20
> investigations are needed.
>
> Please note, however, that USB_GADGET_DELAYED_STATUS is limited to 0-leng=
th=20
> control OUT requests, so the problem that led to this patch series still=
=20
> exists, even if the race condition I thought was there doesn't exist.

And that problem is...?

DATA stage always depends on a usb_ep_queue() from gadget driver.

>> >> If this works with dwc3 + uvc, then we have a good recipe on how to
>> >> implement for the other drivers.
>> >=20
>> > Given that we need to delay the status stage and not the data stage, we
>> > can't explicitly request the status stage through a usb request queue.
>>=20
>> Why not?  The status stage for a control-OUT transfer is simply a
>> zero-length IN transaction.  It's easy to queue a request for such a
>> transaction.  Is the issue that there's no way to specify the direction
>> of the request (hence no direct way to tell whether a zero-length
>> request is for the data stage or the status stage)?
>
> OK, I suppose we could queue a request for this, in which case we would h=
ave=20
> to queue two requests for control OUT transfers (one for the data stage a=
nd=20
> one for the status stage). I'm however not convinced that would be the be=
st=20

that's correct. This is what "make status stage always explicit" mean :)

> API to handle the status stage, as the function driver would need to queu=
e a=20

it avoids all the special cases. UDC drivers can implement a single
handling for struct usb_request. We could do away with special return
values and so on...

> request and the UDC would then need to check whether that request corresp=
onds=20
> to a status stage and process it accordingly. A new operation specific to=
 this=20

no, it wouldn't. UDC would have to check the size of request, that's
all:

	if (r->length =3D=3D 0)
        	special_zlp_handling();
	else
        	regular_non_zlp_handling();

But we don't need to care about special return values and the like. We
don't even need to care (from UDC perspective) if we're dealing with
2-stage or 3-stage control transfers (well, dwc3 needs to care because
of different TRB types that needs to be used, but that's another story)

> would be easier for both the function driver and the UDC in my opinion.=20

it wouldn't. We would just be moving the special case to another
function, rather than eliminating it.

> There's also the fact that requests can specify a completion handler, but=
 only=20
> the data stage request would see its completion handler called (unless we=
=20
> require UDCs to call completion requests at the completion of the status=
=20
> stage, but I'm not sure that all UDCs can report the event to the driver,=
 and=20
> that would likely be useless as nobody needs that feature).

you still wanna know if the host actually processed your status
stage. udc-core can (and should) provide a generic status stage
completion function which, at a minimum, aids with some tracepoints.

One way to satisfy what you want, with what I want is to have UDC core
implement something like below:

int usb_ep_start_status_stage(struct usb_gadget *g)
{
	return usb_ep_queue(g->ep0, &g->ep0_status_request);
}

special function for you, usb_ep_queue() for me :-p

>> Admittedly, it might be nice to provide a library routine in the UDC
>> core to queue such requests, since it involves a bunch of uninteresting
>> boilerplate operations.
>>=20
>> > Would a new explicit function call work for you for that purpose ?
>>=20
>> It would be okay, but I question whether one is really needed.
>
> I think the API would be cleaner, but it might just be a matter of taste.

From=20a UDC perspective, I'm more inclined to removing special cases,
rather than making them more apparent. Having a single method for
handling all three stages of a control transfer, IMO, is far more
beneficial as it removes magic return values and several branches on UDC
driver.

>> >>> - The mechanism is poorly documented. As Paul mentioned, comments in
>> >>> the code state that USB_GADGET_DELAYED_STATUS delay the "data/status
>> >>> stages". This is very unclear, and the only three UDCs that implement
>> >>> the mechanism seem to do so in different ways:
>>=20
>> We can fix comments and documentation pretty easily.  :-)
>
> It's harder to fix them if different implementations interpret them in=20
> different ways :-) That might not be the case though, as mentioned above =
I=20

that's where a proper audit of the code comes into play :)

> haven't studied the three UDCs that implement this in details, I only had=
 a=20
> look at the dwc3.

that's perfectly fine. We can Cc other folks involved with the other
UDCs and have them chip in.

>> This requires the UDC to specifically keep track of the direction of
>> the current transfer and whether or not a data-stage transfer has
>> already been queued.  That shouldn't be hard.
>
> It's "just" a state machine so it wouldn't be too hard. What we need to a=
gree=20
> on is how the state machine operates, and then the API to control it. Tha=
t's=20
> what I tried to describe below in my previous e-mail.
>
>> (But it does involve a
>> race in cases where the host gets tired of waiting and issues another
>> SETUP packet before the processing of the first transfer is finished.)

Host would stall first in that case. Driver is already required to
handle stalls for several other conditions. If thehre are bugs in that
area, I'd prefer catching them.

>> > I wonder if there's really a use case for delaying the data stage of
>> > control OUT requests, as it seems to me that we can perform the
>> > asynchronous validation of the setup and data stages together, in which
>> > case we would always proceed to the data stage, and only potentially
>> > delay the status stage. However, if we switch to an explicit API where
>> > the transition from the setup to the data stage is triggered by queuei=
ng
>> > a request, and given that such a transition may need to be delayed for
>> > the control IN case, delaying the data stage for control OUT would
>> > essentially come for free.
>
> What do you think about this ? Should we allow function drivers to delay =
the=20
> data stage of control OUT requests ?

it's already delayed. UDC won't start data stage unless it has a buffer
to put the data. Without a usb_ep_queue(), UDC doesn't have a buffer.

>> > If we end up moving to explicit state handling, with the data stage be=
ing
>> > entered by queueing a request, and the status stage being entered by
>> > calling a new function, control OUT requests with 0 bytes of data that
>> > can be handled synchronously in the setup handler would require functi=
on
>> > drivers to both queue a zero-length request and call the status functi=
on.
>> > This would make the function code more complex, and I wonder whether a
>> > shortcut would be a good idea, perhaps in the form of a flag in the
>> > request that tells the UDC to automatically proceed to the status stage
>> > immediately after the data stage. Or we could make that behaviour the
>> > default when the request doesn't have a completion handler (as moving
>> > explicitly to the status stage should be done at the earliest from the
>> > data stage completion handler).
>
> From an API point of view, towards function drivers, I really want an exp=
licit=20
> function to proceed with the status stage. That could internally queue a =
ZLP=20
> request or call another API, but in any case I don't want the status stag=
e ZLP=20
> request to be visible to the function drivers. Do you agree with this ?

why can't it be visible? I don't mind having a function wrapping
usb_ep_queue(), but why is it bad to have functions call usb_ep_queue()
directly?

> To simplify function drivers, do you think the above proposal of adding a=
 flag=20
> to the (data stage) request to request an automatic transition to the sta=
tus=20
> stage is a good idea ? We could even possibly invert the logic and transi=
tion=20

no, I don't think so. Making the status phase always explicit is far
better. UDCs won't have to check flags, or act on magic return
values. It just won't do anything until a request is queued.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvheDMACgkQzL64meEa
mQbqIw/+OxXDZuCyjq5oKFpo8zmeM09kv+BBTYhMqdeRncaDfMAeZqZhrbYgz02n
OgtGy+PUBodFxWI23hbE1HdtaZ+xIUkHisTVJ8lJsaPyqoKp21ICbv/XOD0yEdao
aHAakUGemPRNWEyLmeILUZNL2IVJqBmnBTfXjT01sX7oRnv5w4bHuG8LqR6kZRzm
qNJhpgnpOE94smc4HvdG2I3V/jJ5Sg7XR8m3QiRyEKbO1ffeO+3kU5cseoD2qlHp
/SAOcQaPSYgM8RuBeGpOt4gUT3PaMMjhzcPK3JpHs6DSSKajqFh4rmyN+h7r1NG5
2BoX7T4nrGY6Uy/LixTrjustepwN1DQprbeSV91G7+77/se/HymcjBV5oS+Tpf/I
PyEIeVgdiS8+23anhV5wmTA9qm1w2pe1hE8ebqsueQJSfFwG8hLN1cgxqNhnNJS7
A+/CABTTrIWcF3EihjyqpYx7pa5aPk2p3TQPGLedkE3nBM6SVQkJSwYO2MpgV0YV
WSY8qR89LXDUtcszlIsorR8UKBw1UjClk8StFsi3zhC4ta6dtrh+XvXWO1rtQDg1
upglVYTXahMLd950c2zmpkSMcdfTl74RlIsLz3/GMQALTrQFC0RaI47XAPnicGfl
GUDSDwkuIdHgTdXka6+EQjdN8aXIREUZeRGLYCO8YobOG9vCyeM=
=cBEn
-----END PGP SIGNATURE-----
--=-=-=--
