Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9079320870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9079320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeKTCQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:16:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729762AbeKTCQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:16:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 945D8AFF6;
        Mon, 19 Nov 2018 15:52:12 +0000 (UTC)
Message-ID: <e4e9c9ec8eee3978f2c88aef22b3d042d5695f75.camel@suse.de>
Subject: Re: [PATCH v2] usb: hub: add retry routine after intr URB sumbit
 error
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 19 Nov 2018 16:52:10 +0100
In-Reply-To: <1542636268.945.4.camel@suse.com>
References: <20181119140208.11590-1-nsaenzjulienne@suse.de>
         <1542636268.945.4.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YxjHiGScGcG9GG1+bME5"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YxjHiGScGcG9GG1+bME5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,
thanks for the reviews :).

On Mon, 2018-11-19 at 15:04 +0100, Oliver Neukum wrote:
> On Mo, 2018-11-19 at 15:02 +0100, Nicolas Saenz Julienne wrote:
> > +static void hub_retry_irq_urb(struct timer_list *t)
> > +{
> > +	struct usb_hub *hub =3D from_timer(hub, t, irq_urb_retry);
> > +	int status;
> > +
> > +	if (hub->disconnected || hub->quiescing)
> > +		return;
> > +
> > +	dev_err(hub->intfdev, "retrying int urb\n");
> > +	status =3D usb_submit_urb(hub->urb, GFP_ATOMIC);
> > +	if (status && status !=3D -ENODEV && status !=3D -EPERM &&
> > +	    status !=3D -ESHUTDOWN)
> > +		mod_timer(&hub->irq_urb_retry,
> > +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
> > +}
> > +
> >  static void kick_hub_wq(struct usb_hub *hub)
> >  {
> >  	struct usb_interface *intf;
> > @@ -713,8 +729,12 @@ static void hub_irq(struct urb *urb)
> >  		return;
> > =20
> >  	status =3D usb_submit_urb(hub->urb, GFP_ATOMIC);
> > -	if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM)
> > +	if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM &&
> > +	    status !=3D -ESHUTDOWN) {
> >  		dev_err(hub->intfdev, "resubmit --> %d\n", status);
> > +		mod_timer(&hub->irq_urb_retry,
> > +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
> > +	}
> >  }
> > =20
> >  /* USB 2.0 spec Section 11.24.2.3 */
> > @@ -1268,6 +1288,7 @@ static void hub_quiesce(struct usb_hub *hub,
> > enum hub_quiescing_type type)
> >  	}
> > =20
> >  	/* Stop hub_wq and related activity */
> > +	del_timer_sync(&hub->irq_urb_retry);
>=20
> That is a race condition. You kill the timer here, but the URB may
> still be in flight. And if it fails, it will restart the error
> handler. You have to introduce a flag or poison the URB.

I see, wouldn't checking "hub->quiescing" in hub_irq()'s submit error
path do the work? Something the likes of this:

@@ -713,8 +729,12 @@ static void hub_irq(struct urb *urb)
  		return;

 	status =3D usb_submit_urb(hub->urb, GFP_ATOMIC);
-	if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM)
+	if (status !=3D 0 && status !=3D -ENODEV && status !=3D -EPERM &&
+	    status !=3D -ESHUTDOWN && !hub->quiescing) {
		dev_err(hub->intfdev, "resubmit --> %d\n", status);
+		mod_timer(&hub->irq_urb_retry,
+			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
+	}

>=20
> >  	usb_kill_urb(hub->urb);
> >  	if (hub->has_indicators)
> >  		cancel_delayed_work_sync(&hub->leds);
> >=20
>=20
> 	Regards
> 		Oliver
>=20

Also, looking at this made me realize that there is no real need to
check "hub->disconnected" in the timer's function, since "hub-
>quiescing" is also set in that code path before any actual cleanup.
I'll update it in the next revision.

Regards,
Nicolas


--=-YxjHiGScGcG9GG1+bME5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvy3CoACgkQlfZmHno8
x/4z0Qf/fhRfKh06vGH5wztNCEqTaqZgTxngaBTkrWTSk1LPgWsWZsrG0HIu1lsn
b2sVy1WfP4Renx8p0d3/kn5InruH3sWhw8YX8RS1nVdmnZgo8iYCjkqTde/3EsXz
amo35DpK8rNhtKbzh0zFM5lTgz+J/1fvL1P31zXes0pMf6IIrIygPIsPleO7op7l
URYJiyDU86Tgmx4zVrwD1vQ2ldw6bM+uhQ7yYwZ2CZJwAeRDq62KqzOe8GeOWSs/
NlWwhkmyV3k+vHJMYVh2i/sjE6cC0OYSW2lTQnrWraoYdlLUaff/o/B5iTqqI/0Q
vwwco13JwHdTL7OWQ67rHUBB6Y+wsg==
=b9r3
-----END PGP SIGNATURE-----

--=-YxjHiGScGcG9GG1+bME5--

