Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A3920827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A3920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeKGDyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:54:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729711AbeKGDyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42930AB64;
        Tue,  6 Nov 2018 18:28:16 +0000 (UTC)
Message-ID: <a790978e8bcb869708833c73da1a05923f66b2d2.camel@suse.de>
Subject: Re: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
Date:   Tue, 06 Nov 2018 19:28:14 +0100
In-Reply-To: <9366d835-a291-2770-4409-b88ea1a155e2@i2se.com>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
         <20181026134813.7775-10-nsaenzjulienne@suse.de>
         <1781917429.4071.1540759539282@email.ionos.de>
         <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
         <9366d835-a291-2770-4409-b88ea1a155e2@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WqekaYXIPv/ojeE/YGns"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WqekaYXIPv/ojeE/YGns
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-11-06 at 17:06 +0100, Stefan Wahren wrote:
> Am 06.11.18 um 16:41 schrieb Nicolas Saenz Julienne:
> > Hi Stefan,
> > thanks for spending the time reviewing the code. I took note of the
> > rest of comments.
> >=20
> > On Sun, 2018-10-28 at 21:45 +0100, Stefan Wahren wrote:
> > > Hi Nicolas,
> > >=20
> > > > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26.
> > > > Oktober
> > > > 2018 um 15:48 geschrieben:
> > > >=20
> > > >=20
> > > > vchiq_init_state() initialises a series of semaphores to then
> > > > call
> > > > remote_event_create() on the same semaphores, which initializes
> > > > them
> > > > again.
> > > i would prefer to have all init stuff at one place in
> > > vchiq_init_state() and drop this ugliness from
> > > remote_event_create()
> > > instead. Is this possible?
> > As I'm sure you're aware of, REMOTE_EVENT_T is shared between the
> > CPU
> > and VC4, which can't be expanded. And since storing a pointer is
> > out of
> > question because of arm64, I can only think of storing an index to
> > an
> > array of completions in the shared structure instead of the pointer
> > magic implemented right now. It would be a little more explicit.
> > Then
> > we could completely decouple both initializations. I'm not sure if
> > it's
> > similar to what you had in mind.=20
>=20
> I don't think so, this was my intention:
>=20
>  static inline void
>  remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
>  {
>     event->armed =3D 0;
>     /* Don't clear the 'fired' flag because it may already have been
> set
>     ** by the other side. */
> -    sema_init((struct semaphore *)((char *)state + event->event),
> 0);
>  }

Fair enough, even simpler.

>=20
>=20
> > On a semi-related topic, I'm curious to know why these shared
> > structures aren't set with the "__packed" preprocessor macro. Any
> > ideas? As fas as I've been told, in general, the compiler may
> > reorder
> > or add unexpected padding to any structure. Which would be very bad
> > in
> > this case.
>=20
> This would be better, but i assume the firmware side uses the same
> source code. So using __packed only on ARM side could also break :-(

True. Yet in that case, aren't we still relying on the fact that both
compilers are going to behave the same way?
=20
>=20
> > Regards,
> > Nicolas


--=-WqekaYXIPv/ojeE/YGns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvh3T4ACgkQlfZmHno8
x/63zwf8CvW316YEQjlQeaiyn8pznuqFdHXIqmca9QjngCSoAvFzeRXs50PIHuXP
IuXP6v7fqvT+I12rtbGa25rW/3IYH0sIbYG0Voqf7w5K33NTzNDFZVB34zy2g1YT
Qv9z5xJYYg0fVc1tlIVyGZCr3UsXzkKPUFeMZK4oz0XFs25s9er3TqqSN091kag3
BKhSspiBOBm2CS8VE0ZeRm5i6QtBkcwWH77bR7SecQbqnFyAlrztqzudmqK2eWah
ySZQOwR9qlghGw32ds5UBoSuwMUIfH4TEgUwKAwt1mmA8k2xrgmJYQOFFd5tquwM
DCo+mihFFD3nHzpyi/POHhdpit++Aw==
=cZwc
-----END PGP SIGNATURE-----

--=-WqekaYXIPv/ojeE/YGns--

