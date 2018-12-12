Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DBC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3545420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3545420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeLLQYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:24:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:50000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeLLQYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:24:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70B0AAFAD;
        Wed, 12 Dec 2018 16:24:43 +0000 (UTC)
Message-ID: <05b4e41c294ada256e1b98ca1d833ad7643dc1af.camel@suse.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        gregkh <gregkh@linuxfoundation.org>, tn@fastmail.net,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Dec 2018 17:24:40 +0100
In-Reply-To: <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
References: <20181210211231.4084251-1-arnd@arndb.de>
         <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
         <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1v0R/rwR9TzvGupfm1RX"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1v0R/rwR9TzvGupfm1RX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-12-11 at 15:20 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 1:36 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Mon, 2018-12-10 at 22:11 +0100, Arnd Bergmann wrote:
> > > @@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state,
> > > REMOTE_EVENT_T *event)
> > >  }
> > >=20
> > >  static inline void
> > > -remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T
> > > *event)
> > > +remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T
> > > *event)
> > >  {
> > >       event->armed =3D 0;
> > > -     complete((struct completion *)((char *)state + event-
> > > >event));
> > > +     wake_up_all(wq);
> >=20
> > Shouldn't this just be "wake_up(wq)"?
>=20
> I wasn't entirely sure if we could get with more than one thread
> waiting
> for the wakeup. With the semaphore or completion that would already
> be broken because we'd only wake up one of them, but I was hoping
> to stay on the safe side with wake_up_all().

You're right. Had a look at the code and there shouldn't be more than
one thread waiting. wake_up_all() looks OK.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

--=-1v0R/rwR9TzvGupfm1RX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwRNkgACgkQlfZmHno8
x/5e3gf9ELhV5rN+/E711w2YQgWLGcY5sRqhVTPe6zumV+qL522GralshXG0TSSa
eO0WPNhJ1+EQqrkk8PmstzmLAGx02gPJBOArt0CW4mUnYTzciqBFYM3dh3pH4k7T
qDhoXi6JrFJOpodHgZ+SlktcEYKkzwC6nqpt/gbveLzVdNM/K4HhzJr62O9KZKv+
2GRKmOsjGn+4iJOhUcZe6sMTbZ4S9eptk3w8j4YVjykkai8Eok4KTuR2gEk5XUYn
wxMgBRyrXIKfnbhgV41gHEZZnnS1+jvXxlfnpA+NwMt2kVXARQoiB0edVGvwKcjM
6CLxqu/qeAhmC8adpArsbVJFQ65jCw==
=2tTH
-----END PGP SIGNATURE-----

--=-1v0R/rwR9TzvGupfm1RX--

