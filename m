Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE8C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6C22082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6C22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJXSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:13:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50114 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:13:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3BA9380765; Wed, 24 Oct 2018 11:46:13 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:46:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Hu <nickhu@andestech.com>
Cc:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH 1/1] nds32: Power management for nds32
Message-ID: <20181024094613.GA25773@amd>
References: <cover.1540349342.git.nickhu@andestech.com>
 <ccc18702a8d93c0a31e46f53c498b6d34c9c17e1.1540349342.git.nickhu@andestech.com>
 <20181024065117.GA18779@amd>
 <20181024093843.GA18476@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20181024093843.GA18476@andestech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Can we get rid of "is_bit_1" array here, and use normal bit operations
> > on another variable here?
> >
> Do you mean like this:
>=20
>  static int nointc_set_wake(struct irq_data *data, unsigned int on)  {
>         unsigned long int_mask =3D __nds32__mfsr(NDS32_SR_INT_MASK);
>         static unsigned long irq_orig_bit =3D 0;
>         u32 bit =3D 1 << data->hwirq;
>=20
>         if (on) {
>                 if (int_mask & bit)
>                         __assign_bit(data->hwirq, &irq_orig_bit, true);
>                 else
>                         __assign_bit(data->hwirq, &irq_orig_bit, false);
> =20
>                 __assign_bit(data->hwirq, &int_mask, true);
>                 __assign_bit(data->hwirq, &wake_mask, true);
>=20
>         } else {
>                 if (!(irq_orig_bit & bit))
>                         __assign_bit(data->hwirq, &int_mask, false);
>=20
>                 __assign_bit(data->hwirq, &wake_mask, false);
>                 __assign_bit(data->hwirq, &irq_orig_bit, false);
>         }
>=20
>         __nds32__mtsr_dsb(int_mask, NDS32_SR_INT_MASK);
> =20
>         return 0;

Yes, that is better. You don't need =3D 0 on static variable
afaict. (And may want to put it out of a function so it stands out).=20

You can add my Acked-by on resulting patch.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQP2UACgkQMOfwapXb+vJXwACfSdiA+90qawZRRQRvxxDC0LK2
U74An0bjc/fSIkbk2JG3erC5eZSr/PDu
=PSUH
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
