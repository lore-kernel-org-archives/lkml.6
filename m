Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0688CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A282087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A282087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbeKPVBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:01:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:51900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbeKPVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:01:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 120EAAE24;
        Fri, 16 Nov 2018 10:50:01 +0000 (UTC)
Message-ID: <7f7ab25e6e1c9ff37edd46adfe12653d5c300778.camel@suse.de>
Subject: Re: [PATCH] usb: hub: add I/O error retry & reset routine
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Date:   Fri, 16 Nov 2018 11:49:59 +0100
In-Reply-To: <Pine.LNX.4.44L0.1811151420300.1308-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1811151420300.1308-100000@iolanthe.rowland.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QV0Oq8W2xjybfRG6V8pW"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QV0Oq8W2xjybfRG6V8pW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,
thanks for the review.

On Thu, 2018-11-15 at 14:24 -0500, Alan Stern wrote:
> On Thu, 15 Nov 2018, Nicolas Saenz Julienne wrote:
>=20
> > An URB submission error in the HUB's endpoint completion function
> > renders the whole HUB device unresponsive. This patch introduces a
> > routine that retries the submission for 1s to then, as a last
> resort,
> > reset the whole device.
> >=20
> > The implementation is based on usbhid/hid_core.c's, which
> implements the
> > same functionality. It was tested with the help of BCC's error
> injection
> > tool (inject.py).
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Why do you think this is needed?  Are you experiencing these=20
> sorts of URB submission errors?

Sorry, I should have been more explicit on where I come from. I've been
playing around injecting atomic allocation errors on the USB stack. For
example any URB submission marked with GFP_ATOMIC that ends up into
xhci will allocate some memory with that flag.

Most subsystems, after facing a burst of memory allocation failures,
seem to recover well (usbnet/hid/uas/alsa/serial). But I found out that
it's not the case for USB hubs: In the event of detecting a new device
the hub will complete an int URB which was previously sent to it. The
event data is saved by the host and the URB is resubmitted for further
event passing. In the case that URB submission failed, we lose all
further events.

It is indeed pretty hard to find this issue in the wild, since you have
to time plugging or unplugging an USB device with the system running
out of memory. But I don't think it's unrealistic to think it might
happen.

As I comment in the patch description, I'm injecting the errors using
BCC and eBPF's function override capabilities. =20

>=20
> Why do you handle only errors during submission but not during
> completion?  And if you keep on getting errors during submission, why
> would resetting the hub make any difference?

Well, as far as I know, errors during completion are handled. The error
is marked in hub->error, which later-on, in hub-event(), triggers a
device reset.=20

While implementing the solution I took into account the hub's
completion error processing behavior and HID's implementation of the
submission error handling (see hid_irq_in() in usbhid/hid-core.c). My
rationale was that since both HID and hub are USB devices with a
similar behavior there was no point in reinventing a mechanism. That
said I have no spec data to back the "1s retry window to then reset the
device".

One could argue that in the event of an error having a timer running
forever is not the best design. It has to stop sometime. If that's the
case, the HUB will be in a unknown state, i.e. a device might have
disappeared. Resetting the hub will at least unbind all the USB devices
attached to it and retry the enumeration. Regardless of the
enumeration's success we'll at least be in a "safe" state.

>=20
> The patch doesn't delete the io_retry timer when the hub is removed.

Right, that was silly of me...

Kind Regards,
Nicolas

>=20
> Alan Stern
>=20
>=20
> > ---
> >  drivers/usb/core/hub.c | 43
> +++++++++++++++++++++++++++++++++++++++++-
> >  drivers/usb/core/hub.h |  3 +++
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index d9bd7576786a..1447bdba59ec 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -607,6 +607,44 @@ static int hub_port_status(struct usb_hub
> *hub, int port1,
> >                                  status, change, NULL);
> >  }
> > =20
> > +static void hub_io_error(struct usb_hub *hub)
> > +{
> > +     /*
> > +      * If it has been a while since the last error, we'll assume
> > +      * this a brand new error and reset the retry timeout.
> > +      */
> > +     if (time_after(jiffies, hub->stop_retry + HZ/2))
> > +             hub->retry_delay =3D 0;
> > +
> > +     /* When an error occurs, retry at increasing intervals */
> > +     if (hub->retry_delay =3D=3D 0) {
> > +             hub->retry_delay =3D 13;  /* Then 26, 52, 104, 104, ...
> */
> > +             hub->stop_retry =3D jiffies + msecs_to_jiffies(1000);
> > +     } else if (hub->retry_delay < 100)
> > +             hub->retry_delay *=3D 2;
> > +
> > +     if (time_after(jiffies, hub->stop_retry)) {
> > +             /* Retries failed, so do a port reset */
> > +             usb_queue_reset_device(to_usb_interface(hub-
> >intfdev));
> > +             return;
> > +     }
> > +
> > +     mod_timer(&hub->io_retry,
> > +                     jiffies + msecs_to_jiffies(hub-
> >retry_delay));
> > +}
> > +
> > +static void hub_retry_timeout(struct timer_list *t)
> > +{
> > +     struct usb_hub *hub =3D from_timer(hub, t, io_retry);
> > +
> > +     if (hub->disconnected || hub->quiescing)
> > +             return;
> > +
> > +     dev_err(hub->intfdev, "retrying int urb\n");
> > +     if (usb_submit_urb(hub->urb, GFP_ATOMIC))
> > +             hub_io_error(hub);
> > +}
> > +
> >  static void kick_hub_wq(struct usb_hub *hub)
> >  {
> >       struct usb_interface *intf;
> > @@ -713,8 +751,10 @@ static void hub_irq(struct urb *urb)
> >               return;
> > =20
> >       status =3D usb_submit_urb(hub->urb, GFP_ATOMIC);
> > -     if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM)
> > +     if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM) {
> >               dev_err(hub->intfdev, "resubmit --> %d\n", status);
> > +             hub_io_error(hub);
> > +     }
> >  }
> > =20
> >  /* USB 2.0 spec Section 11.24.2.3 */
> > @@ -1800,6 +1840,7 @@ static int hub_probe(struct usb_interface
> *intf, const struct usb_device_id *id)
> >       INIT_DELAYED_WORK(&hub->leds, led_work);
> >       INIT_DELAYED_WORK(&hub->init_work, NULL);
> >       INIT_WORK(&hub->events, hub_event);
> > +     timer_setup(&hub->io_retry, hub_retry_timeout, 0);
> >       usb_get_intf(intf);
> >       usb_get_dev(hdev);
> > =20
> > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > index 4accfb63f7dc..7dbd19c2c8d9 100644
> > --- a/drivers/usb/core/hub.h
> > +++ b/drivers/usb/core/hub.h
> > @@ -69,6 +69,9 @@ struct usb_hub {
> >       struct delayed_work     leds;
> >       struct delayed_work     init_work;
> >       struct work_struct      events;
> > +     struct timer_list       io_retry;
> > +     unsigned long           stop_retry;
> > +     unsigned int            retry_delay;
> >       struct usb_port         **ports;
> >  };
> > =20
> >=20
>=20


--=-QV0Oq8W2xjybfRG6V8pW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvuoNcACgkQlfZmHno8
x/41VggAoO3ULeHPOJ8uA2ALySh+0cRpBfcOBOsNXiiU1xREkg8XwGqS0clhWVvy
n8fqhnTD4rYLQ0UPEtozdtVCQtWGBRFYvq/s6F43f1GHEOAb++G3pwLgjVF72q6X
VE/ju8+J9MzntoLz1JSJ5wAZ4oY4DZQpkXaXkEch/ulmHCPnmmc8uOUBcbVz9fS1
9svqaXF4ImSPJEH/YGNP3GZIR+pGcW0xouxxzd4xGU/2ABfwBqSDt4TGQ4yJ+IFh
KrtIGKxkzzctj0LtnMWPQSqOFhJtlfuWngZwQ+JdreaQgskj+eazZbpveGfQhtZ/
+HkA1K98/q5NtbwKY5BY+/vhQcP+Hg==
=bQzl
-----END PGP SIGNATURE-----

--=-QV0Oq8W2xjybfRG6V8pW--

