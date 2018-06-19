Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0391820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0391820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965898AbeFSNm0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:42:26 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34647 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937490AbeFSNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:42:25 -0400
X-Originating-IP: 208.88.110.46
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C00BF6000B;
        Tue, 19 Jun 2018 13:42:22 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:42:20 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180619134220.GA2396@hle-laptop.local>
References: <20180618022400.GA1893@hle-laptop.local>
 <20180618101838.gzbrxabilnqyilsi@mwanda>
 <20180619030850.GA1876@hle-laptop.local>
 <20180619104248.z5nbbakwhjgscufb@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180619104248.z5nbbakwhjgscufb@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > It would be great to get rid of this counter, indeed. But how to do it
> > properly without breaking things ? It seems to be useful to me...
>=20
> These things are refcounted so you can't unload the module while a file
> is open.  When we do an open it does a cdev_get().  When we call the
> delete_module syscall, it checks the refcount in try_stop_module() ->
> try_release_module_ref().  It will still let us force a release but
> at that point you're expecting use after frees.

Then I'd like to understand why this counter was introduced if remove
always gets executed after the last release call returned. This was
probably unclear to the original developer.

This TODO seems to be related to this misunderstanding too:

 890         /* TODO? guard against device removal before, or while,
 891          * we issue this ioctl. --> device_get()
 892          */

Device removal can't happen before or during the ioctl execution.

> > Really ? device->spi is NULL-ed in remove() so that operations on
> > remaining fds can detect remove() was already called and free remaining
> > resources:
> > =20
> > 1296         /* make sure ops on existing fds can abort cleanly */
> > 1297         device->spi =3D NULL;
>=20
> That's when we're unloading the module so there aren't any users left.

I'll submit an updated version of my patch getting rid of the counter
and addressing the remaining race conditions.

Thanks !

Regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlspCDMACgkQLVy48vb3
khkX6Qf/fTcrcDu8WHvH/VRnCHOKrR9dGSEBruJScyIOKTsHRabTXhZ7FWh1l7VE
Sh4BvAGmMC9RvsoliF26D/C/TSSYmfCN0xJvx+ypTReanv9gub12MsaKc/3aq8Qt
7BIvNvUv0S8bDoCaZ4dhvTCswRpndWp6AX53vNHxy1ip1SsV8KFjeyuwtQUmyZ6o
Zv3NbldwLthW3p3wSWsXafaGpebi+rZpA9XY9QTWBHyl2TvNl5LgMxrDsjPWrkl5
OD2oZv4JGnDFswvHlx2lOo/7kTODQfNQbrZ9JvTtM4HEfZZcOW8Xw9+4F25+tNU1
p9obTNl2UYcU276eDGcfZXZGtgUQBQ==
=UjJb
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
