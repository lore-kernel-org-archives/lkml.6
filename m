Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8447C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9923A20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9923A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeKGBHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389028AbeKGBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDAC1B6D9;
        Tue,  6 Nov 2018 15:41:21 +0000 (UTC)
Message-ID: <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
Subject: Re: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
Date:   Tue, 06 Nov 2018 16:41:19 +0100
In-Reply-To: <1781917429.4071.1540759539282@email.ionos.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
         <20181026134813.7775-10-nsaenzjulienne@suse.de>
         <1781917429.4071.1540759539282@email.ionos.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-g6M2lnxKQ+LKhTN8crRJ"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g6M2lnxKQ+LKhTN8crRJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,
thanks for spending the time reviewing the code. I took note of the
rest of comments.

On Sun, 2018-10-28 at 21:45 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober
> > 2018 um 15:48 geschrieben:
> >=20
> >=20
> > vchiq_init_state() initialises a series of semaphores to then call
> > remote_event_create() on the same semaphores, which initializes
> > them
> > again.
>=20
> i would prefer to have all init stuff at one place in
> vchiq_init_state() and drop this ugliness from remote_event_create()
> instead. Is this possible?

As I'm sure you're aware of, REMOTE_EVENT_T is shared between the CPU
and VC4, which can't be expanded. And since storing a pointer is out of
question because of arm64, I can only think of storing an index to an
array of completions in the shared structure instead of the pointer
magic implemented right now. It would be a little more explicit. Then
we could completely decouple both initializations. I'm not sure if it's
similar to what you had in mind.=20

On a semi-related topic, I'm curious to know why these shared
structures aren't set with the "__packed" preprocessor macro. Any
ideas? As fas as I've been told, in general, the compiler may reorder
or add unexpected padding to any structure. Which would be very bad in
this case.

Regards,
Nicolas

--=-g6M2lnxKQ+LKhTN8crRJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlvhth8ACgkQlfZmHno8
x/7rGQgArw68dq6qnh1Jmox2g07wWyEoyeTMI6fqkQz+XT+48Bmuhlf7iROBJTWn
2s6tLI2TNZNkZ+7Lk9MH+xM75wBLmkTtuIrX+dQ8Pz0UQB8LIThnMyHQKqe840Fb
VoKBnV3KebSqNpp2oLpooPrV2D8iANvn2M3I2/fgGO/ydYdCqDR41+CJPjGGIucl
gSFq4uTYI6EB/SOEpVCTYVSwGX3nYErIZs3zhF4NqXdkIwyZR7bwSvY2hS8iOar+
MZJSHa6tu9jOpsaUZ87/y8Y++EwwVAxTGnbbnN0wSZDmJiKu3qHb4gB38HLFBxov
okygIpKp9AMLz7Dl4u9AQrBUaKRQYg==
=MtXk
-----END PGP SIGNATURE-----

--=-g6M2lnxKQ+LKhTN8crRJ--

