Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCDCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DB8218C1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DB8218C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeFZRnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:43:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33832 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751969AbeFZRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:43:52 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fXrzs-0005Nr-A4; Tue, 26 Jun 2018 18:43:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fXrzn-0008OP-1k; Tue, 26 Jun 2018 18:43:15 +0100
Message-ID: <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        security@kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Tue, 26 Jun 2018 18:43:10 +0100
In-Reply-To: <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
References: <20180625163410.216168-1-jannh@google.com>
         <20180625164109.GF30522@ZenIV.linux.org.uk>
         <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-cEEqpFC4a1Cfx+GixbOI"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cEEqpFC4a1Cfx+GixbOI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-25 at 20:16 +0200, Jann Horn wrote:
> On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >=20
> > On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
> >=20
> > > +     char tmp[32];
> > >=20
> > > -     if (namelen > 32)
> > > +     if (namelen < 0 || namelen > 32)
> > >               namelen =3D 32;
> > >=20
> > >       down_read(&uts_sem);
> > >       kname =3D utsname()->domainname;
> > >       len =3D strnlen(kname, namelen);
> > > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > > -             err =3D -EFAULT;
> > > +     len =3D min(len + 1, namelen);
> > > +     memcpy(tmp, kname, len);
> > >       up_read(&uts_sem);
> > >=20
> > > -     return err;
> > > +     if (copy_to_user(name, tmp, len))
> > > +             return -EFAULT;
> >=20
> > Infoleak, and similar in a lot of other places.
>=20
> I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
[...]
> Can you please explain why there is an infoleak here?

I think you're *fixing* information leaks in the Alpha syscalls,
because a negative value of namelen used to result in a huge length
argument to copy_to_user().

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.


--=-cEEqpFC4a1Cfx+GixbOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsyey4ACgkQ57/I7JWG
EQmGfBAAkJ8kvkN4ILTBveOXPzElFepd1FUG5pMwo5IfJw5Oq8f2/GbfGXDZ14Tj
abmu/OVqgeJZ/T1/Kqq96FGuz6uT61SB+eX5ncTu52xA9mWfPWVG/0wR3eplSvPY
kxsxJ61Wtdd9WjHtt4u5/OeKR6HmuxSF5b+Rfhzs5U1iJCVwxdswTnPwXqFQpS+T
YutNUFhxnI5gOvKaWuRa0v0L60v5Bah8tVICEwl+g5UqDCfarjLgIpLuoc6iNABK
UOVg9jw8wC64KQrOrUiDItG5T9E+FY4FnnRDekm2WZwbKNpW0wRM6dFmJSjeuXAT
moSF+Yws0iRyhMpUD0Ysk04gHZLZO0T40wRKfWBEa9I4Z8kMEKsTpGqltyKuU7aE
d9hICe8xpdWYYYV0bRWkDa53eQzmkHp6mfKmcnWqksuXK6887qBArslvEmHFWS1K
kvCDsVjyWTUTWNcRD0mVZ8DwpBGG/+vvf0rdUiX+EMmi8721df6mdZvRLknftsBb
gKejdzYugladdM3L36Tch/+PqDTHvvOxYW6XKVb/NxH/tkL8wMv3+jS4y2Xf5Lhi
Zk1B9mN836ZW8v9QgiFc8vYyp+4RioBSMqXEAFeWt5GJU/eyWxSqpZuIeFto/acw
1AIxwXBM7lg4ctxenK673epS+L3sQMolh6SXar7P9sjcAAp28xM=
=a19a
-----END PGP SIGNATURE-----

--=-cEEqpFC4a1Cfx+GixbOI--
