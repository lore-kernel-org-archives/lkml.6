Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC91C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D126892
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D126892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeF0HIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:08:23 -0400
Received: from www.zeus03.de ([194.117.254.33]:42214 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeF0HIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:08:22 -0400
Received: (qmail 25762 invoked from network); 27 Jun 2018 09:08:19 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 27 Jun 2018 09:08:19 +0200
X-UD-Smtp-Session: l3s3148p1@4yuDR5pvVqEgAwDPW8d1AAId4P/+oMhl
Date:   Wed, 27 Jun 2018 09:08:18 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Message-ID: <20180627070818.4zb3i557qjiicsv7@katana>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
 <20180626023757.l54suaryim2fieq3@ninjato>
 <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
 <20180626134606.h4ciolw23t6qnrjb@ninjato>
 <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zf6jbt2maz3igxh"
Content-Disposition: inline
In-Reply-To: <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zf6jbt2maz3igxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Because, thinking more about it, the problem with those allocs are not
> related to the locking details; adding another trylock to the mix just
> makes it so much more obvious. I mean, first we would specifically
> handle atomic/irq context with a trylock "documenting" that atomic/irq
> users are welcome to at least try xfers, and then we blattantly break
> the rulez with a GFP_KERNEL alloc...

Yes, thinking more about it, I came to the conclusion that we should not
add trylock to SMBus and keep the requirement to allow sleeping.

True, SMBus is not consistent with I2C then, but actually, I'd prefer
the consistency the other way around: I wish we had a clear statement
that i2c_transfer may sleep. And have a dedicated irqless, non-sleeping
callback for handling the atomic case instead.

I really don't like the commit which introduced the trylock
into i2c_transfer[1]. Its commit message even says: "It is the
reponsability of the caller to ensure that the underlying i2c bus driver
will not sleep either." Which seems broken to me because I can't see how
the caller should do that? And most bus drivers will sleep. But that
commit is upstream for 10 years now, so there are probably users. Which
also are very hard to spot, I am afraid. I wouldn't see a way to convert
them off the top of my head.

[1] cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")

> Currently, I assume they are only broken when the alloc happens to
> need to do more than is allowed from the given context. Something
> which might or might not be common?

The only regression now would be using smbus_emulated from atomic
context. Which is a bug on the caller side because it cannot know if
smbus_emulated will be used or not. For the non-emulated case, it must
not be atomic anyhow.

So, unless I overlooked something, if we decide to not add trylock to
smbus_xfer, we are all fine?

And I think we should really keep this clean rule of smbus functions
being non-atomic.

D'accord?


--4zf6jbt2maz3igxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlszN9sACgkQFA3kzBSg
KbaLthAAiIpjV7LeO1ysJ+6fmlhNOOF/vYKrSO63Lg7aXR2l3LopgbNB/QxVa9xq
GWWJ/KCQZmGRW5PbEBwcbDn6ei87VvvXYCHiEZ51DK6dctY3dULc/K7H61IqZvUg
MpRtUBhS1mmKZor0CC7LgskDYMSEJaGpxjAWcSwcHTDKdL5ifLY8PDIYR14+aIg4
Vt7YHjCBxh6nT442XoErHY+/mQsgfrwP2D73GDyHZ3+jA3VI4H2FOmGUZjaMJLa8
3fQqR3k8/9Ppx6FdSeWKT1D4/rU587vj8xGs4qgaJyyz2xbJDdEN8YygS0UTQJB4
neSJm3niDJ8+vZuMzSyj6CW+Xy4xh9mc6H6oyB4oc4ezBAuzHyl4JAzmn9a4TCUA
OegFLaAu+hUwzZ2CeMrdJ2q/xJ2wSztJ+dRrzhKhabsnrgSQ+tBZV4IzQNtRRgZR
PtsIp5LDV707AWLFPoFpcsOyqGn2cIz6M4O+TZQXIlW5q1q5oy2Nt1p5ilAwKPtW
oQYkTV7ToYAE/lYeChHyDQRMlPjmGDUwZvC2uRt9Eq7Q3m12TxdBH5LV5A+x0TMC
JMNhc/hQe3qaU8b+3VxhGVrB84+DhBOFOz6RT/Hr+eEGPGk48p9Yeo1fZo6d0lkW
hH/C0Yu71Zzahv270x5t3vKPU+veqevMpdUaOOckgB7D0InARQU=
=6L/Q
-----END PGP SIGNATURE-----

--4zf6jbt2maz3igxh--
