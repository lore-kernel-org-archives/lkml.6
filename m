Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83690C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42928251A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42928251A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeGAMNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 08:13:24 -0400
Received: from sauhun.de ([88.99.104.3]:34134 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeGAMNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 08:13:23 -0400
Received: from localhost (p54B337EC.dip0.t-ipconnect.de [84.179.55.236])
        by pokefinder.org (Postfix) with ESMTPSA id EB61C5601C5;
        Sun,  1 Jul 2018 14:13:20 +0200 (CEST)
Date:   Sun, 1 Jul 2018 14:13:20 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Message-ID: <20180701121320.uwhnaggm2wmijkrw@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
 <20180626023757.l54suaryim2fieq3@ninjato>
 <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
 <20180626134606.h4ciolw23t6qnrjb@ninjato>
 <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
 <20180627070818.4zb3i557qjiicsv7@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zveo66y2hoeguqu"
Content-Disposition: inline
In-Reply-To: <20180627070818.4zb3i557qjiicsv7@katana>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zveo66y2hoeguqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 09:08:18AM +0200, Wolfram Sang wrote:
>=20
> > Because, thinking more about it, the problem with those allocs are not
> > related to the locking details; adding another trylock to the mix just
> > makes it so much more obvious. I mean, first we would specifically
> > handle atomic/irq context with a trylock "documenting" that atomic/irq
> > users are welcome to at least try xfers, and then we blattantly break
> > the rulez with a GFP_KERNEL alloc...
>=20
> Yes, thinking more about it, I came to the conclusion that we should not
> add trylock to SMBus and keep the requirement to allow sleeping.
>=20
> True, SMBus is not consistent with I2C then, but actually, I'd prefer
> the consistency the other way around: I wish we had a clear statement
> that i2c_transfer may sleep. And have a dedicated irqless, non-sleeping
> callback for handling the atomic case instead.
>=20
> I really don't like the commit which introduced the trylock
> into i2c_transfer[1]. Its commit message even says: "It is the
> reponsability of the caller to ensure that the underlying i2c bus driver
> will not sleep either." Which seems broken to me because I can't see how
> the caller should do that? And most bus drivers will sleep. But that
> commit is upstream for 10 years now, so there are probably users. Which
> also are very hard to spot, I am afraid. I wouldn't see a way to convert
> them off the top of my head.
>=20
> [1] cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
>=20
> > Currently, I assume they are only broken when the alloc happens to
> > need to do more than is allowed from the given context. Something
> > which might or might not be common?
>=20
> The only regression now would be using smbus_emulated from atomic
> context. Which is a bug on the caller side because it cannot know if
> smbus_emulated will be used or not. For the non-emulated case, it must
> not be atomic anyhow.
>=20
> So, unless I overlooked something, if we decide to not add trylock to
> smbus_xfer, we are all fine?
>=20
> And I think we should really keep this clean rule of smbus functions
> being non-atomic.
>=20
> D'accord?

So, if no other arguments drop in, I'll apply this series as is next
week.


--2zveo66y2hoeguqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls4xVwACgkQFA3kzBSg
KbaYKBAAqvC/k2AAWkZqwqt/lmK9bd9DQhB2ewcyWAbGfowUdj4leYMDf5MC9Oxr
Gsk3uZMDQVjBTP5GpNLCGpXXPZAltJnsxzC4ECAKXK4Lp2+4H60zNbzj0+BQ2E2Q
pq7KBNa+GsIss49+4FX33jARuFOCzpXwXbl+ubW6RMIhLwyMab0BP/s3V0lXlsx2
Ien8Hao9j1ZKwxByBcrrAr+JjiQHTYJYgRT1sbG4yj3gJ48JSoNyIzqgIFzPGE49
Hw0KhdaTPVCpZyzds8tGiQSLcLXpHvade6CG/xnDga00pUD4NLivTfuGZwdt+tRf
lOsma+A/GQVLDeTgjjpnjC4ERGEN5Gay05LtG3F7GSB/I2HYsc1IVJoxI162y1lS
guK7j54kn6s88qB2zzgWLZWuvXWeNCZCMOiKPBuTIgD3v4V5e1HRN06K4tpekn9A
46SkP7G2QEVFOBlVIlB+46WOAsbhOLsxR8qFJ8YNIjUefWZ1Y3pX2yPQyH5sR00g
ytTqF5kYL1m8I1bAgkLLwurZb+oAPkbl364K9zru+0soIcrOw3OWatcCKYRzydCa
Hb4f1sZ3U/EQJo20Cxy1/P2UYjgaL11W4ffW8OGLFSXGqiPVH4uePW2fIPk9g2FJ
XYRO3aVBIXbfzeZEAp+PbEDHIJRO5D4fEJbeEt3Srq1nyvMBKFM=
=QLQF
-----END PGP SIGNATURE-----

--2zveo66y2hoeguqu--
