Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCFDC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD72229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="oUX37EFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437486AbfBNI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:27:43 -0500
Received: from tomli.me ([153.92.126.73]:33978 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfBNI1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:27:43 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id dd190741;
        Thu, 14 Feb 2019 08:27:39 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b76:76e8)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Thu, 14 Feb 2019 08:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=oijOb/9BXTL5kUviL8XleFxjgwdEqXEW4qfX9raqPBU=; b=oUX37EFhsG8qIuqIs/K2VBx9jmtbfoYZa5XWRHx1WIGD3rZboFyHvG0rk2EUx9RujE3quk4kwBiO+bMsA5cjIc362TOWzQFiGFkNUhvk2etGMMf1niZ/vt8x8dPEn6J2UznwoDS3lcf3EzARHNJAaXPieaML35mFSiXHsWAGu7gp4YhOEa8H499cZOglJNcHy7Vnqh9RufS//McVjdspPf/YATmNkmX27rUdxElAwyED0a2FKoNFd4CbE3jxNR7QPazJ3PAyJRw2JKCugR2A8yBQ+Lim7GcPH8u2Hd9DBVUYpDRHm3tsEXp6bNY4ZnAR2YVdJPLAAfNSmMvn/xfY0g==
Date:   Thu, 14 Feb 2019 16:27:30 +0800
From:   Tom Li <tomli@tomli.me>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] mips: loongson64: move EC header to
 include/asm/mach-loongson64
Message-ID: <20190214082729.GA24527@localhost.localdomain>
References: <20190210130617.8392-1-tomli@tomli.me>
 <20190210132505.GA22242@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190210132505.GA22242@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
> > Yifeng Li (1):
> >   mips: loongson64: move EC header to include/asm/mach-loongson64
>=20
> This probably should be MFD driver under drivers/mfd. It's a longer
> road, though...
>=20
> A.

The problem of converting it to a MFD driver, is that there's still
something doesn't fit together.

The core CPU idle code in loongson64/common calls the platform code
in arch/mips/loongson64/lemote-2f to set up an interrupt handler in
i8259, and inspect if the source of interrupt is an lid open event by
querying the ENE KB3310B controller. But normally an MFD driver is
only used to share the underlying hardware between multiple drivers
in each subsystem, not to provide shared utilily functions.

But after reading drivers/mfd for a while, apparently we do have drivers
that "EXPORT_SYMBOL()" to other parts of the kernel. So I think it's
a matter of fact that can be discussed with MFD maintainers.

So yes, I'm converting all the EC code to a MFD driver. I have withdrawn
this patch, do not merge it. The new MFD patch is coming soon.

Thanks,
Tom Li

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJVIRsjlaWj4OSKDx+tPrBeiOjW0FAlxlJmwACgkQ+tPrBeiO
jW0gZRAAsr0VmeZ+3F9pjcwFriDKNfVLB0QxKTakR8SiubPGzoylkskeMqo+ZQcM
2xSE2WgsSH7nKXRhHPsdm5G1C4QEBWE7eaNXVhHwQICawQRPOcrdShIGr3w73NAw
KlHQ8g4ICW+eNLnRmz5aFoPW2FD7VCaCiVAH978jQMz2y0ZTAS6WPwddM9GUsT3Q
U0baHWyUL1eEbQFMSx8j4aMhIqey7ZcT3V93EhsJk5NjmDZmaS+ws7TrXkcrsV+j
Swj3IFexpmSvJn5K7ljv2TV2BxjWSdmXqHoP2j4YgI4VfADjRu0nnvRcAlkm+TX8
bqz7lFZCg7DRAwKsubfieEz2Gt5R7GqpQjto5qkpHT7BGD47Fg7zEb02ogWMcrII
DpHW+OgCVdSpfxZCIG4AQuQ45iGrHPMMHyn1dNuesfLPn4POW+NuVjNfnm1FQ7Eg
YkKZ9khDN6HLk98BeI11FavdircdKQ2BZSdL22SG8TMtqmpSMYHa3gI//Hl2n4R7
rLmbcLbyWywwNbKiNs0vAxf2T9ob4vQD4yBlQwAh+jhiwpar5/OWK4CUaTo5v0Fd
6D/Dbmrzi3OgDzUuQhVmlXSUk6grpdM83Abfhkv4w6F+uCgsfwUY0+tuxBNUnfS5
EbaQs04daYoS6Wclcugw26pUeOXFAXTWSCyTrJZvrgzQnwpX00o=
=jQzt
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
