Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654BF20849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654BF20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeGIXPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:15:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56291 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753008AbeGIXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:14:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fcfMu-00051P-Ec; Tue, 10 Jul 2018 00:14:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fcfMp-00017q-6k; Tue, 10 Jul 2018 00:14:51 +0100
Message-ID: <ef59bbc78d3a71dba51bfea5f452718d3fa0499c.camel@decadent.org.uk>
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Whitcroft <robobotbotbot@gmail.com>,
        Brian Belleville <bbellevi@uci.edu>
Date:   Tue, 10 Jul 2018 00:14:46 +0100
In-Reply-To: <20180529132722.GH7445@brain>
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
         <20180529132722.GH7445@brain>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-qnE0wONnWSFALaDvpe5t"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qnE0wONnWSFALaDvpe5t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-05-29 at 14:27 +0100, Andy Whitcroft wrote:
[...]
> >From ddb8c77229a9507fa5575c910d2847e123a9c94c Mon Sep 17 00:00:00 2001
> From: Andy Whitcroft <apw@canonical.com>
> Date: Tue, 29 May 2018 13:04:15 +0100
> Subject: [PATCH 1/1] floppy: Do not copy a kernel pointer to user memory =
in
>  FDGETPRM ioctl
>=20
> The final field of a floppy_struct is the field "name", which is a pointe=
r
> to a string in kernel memory.  The kernel pointer should not be copied to
> user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
> including this "name" field.  This pointer cannot be used by the user
> and it will leak a kernel address to user-space, which will reveal the
> location of kernel code and data and undermine KASLR protection.
>=20
> Model this code after the compat ioctl which copies the returned data
> to a previously cleared temporary structure on the stack (excluding the
> name pointer) and copy out to userspace from there.  As we already have
> an inparam union with an appropriate member and that memory is already
> cleared even for read only calls make use of that as a temporary store.
>=20
> Based on an initial patch by Brian Belleville.
>=20
> CVE-2018-7755
> Signed-off-by: Andy Whitcroft <apw@canonical.com>

Reviewed-and-tested-by: Ben Hutchings <ben@decadent.org.uk>

Ben.

> ---
>  drivers/block/floppy.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 8ec7235fc93b..7512f6ff7c43 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3470,6 +3470,8 @@ static int fd_locked_ioctl(struct block_device *bde=
v, fmode_t mode, unsigned int
>  					  (struct floppy_struct **)&outparam);
>  		if (ret)
>  			return ret;
> +		memcpy(&inparam.g, outparam, offsetof(struct floppy_struct, name));
> +		outparam =3D &inparam.g;
>  		break;
>  	case FDMSGON:
>  		UDP->flags |=3D FTD_MSG;
--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.


--=-qnE0wONnWSFALaDvpe5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAltD7GYACgkQ57/I7JWG
EQlHCRAAwSoW5ZfTw9cWVb4GH7Po3sV5vRCehunEyij4oXA3Chgj3FzfNGiNZEy9
fYUhmndOKs5FahY1afZYraDjyLLc8Bz8PS2imZdIib5X3Ze7L3qc5r38yY6LIy8b
KdQLyFNH9qcrfvcr5hBujsOrOquiPhZ3bJCgGx387wlIMhinAbabH4kSDbWKeKcA
fKakbJu8e3zcvEPL5d2OfQ4Hw5RoFTPwSAkci9XKCdycee7+U3lSL+LLTC2LcrdM
TD8035e5x0kr5LZN6RLYqEu3qydJIDc+Lj/P/JUxLfea9ExgMS0cqzebXV8LwFw3
LVu78PFECJJwLsl0GyKsYHLvrpmQk/842On1aUwayKtDj3aMpzJz9icqHhyYsQZ7
KyLVdmAyuwGva2VEhm2oMSSiY8yoB88ti9Ajr1quNtbgAYFxAagsDD1imoWmIVw8
2Hp0zylxeUNB7hulWrMt0wwkuStVDtXLTBXGztJIzcfO9EFIB2jztCWg/QtaFbsI
ljoKG0O75ErHzuxEyNeStU309C0ji1zrCd40xXqe5Jo58UdrkWpu1V7rzuNn5n/4
jPVRTYPuK0lsH+RuM3WAjNvMP3aKC8x3TpK7WE3to905WgDXHWojvGdw38lV7joA
soKPARqwJBmRdIecSDm5mufp7OAsOOfRhB83eaiUHaQtkRIzU40=
=puzG
-----END PGP SIGNATURE-----

--=-qnE0wONnWSFALaDvpe5t--
