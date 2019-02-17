Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3791C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF63206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBQXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:15:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42484 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfBQXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:15:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 287268055A; Mon, 18 Feb 2019 00:15:07 +0100 (CET)
Date:   Mon, 18 Feb 2019 00:15:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Richard W.M. Jones" <rjones@redhat.com>, smcdowell@cloudbd.io
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190217231514.GA10675@amd>
References: <20190215191953.GB17897@amd>
 <20190217084458.GY12500@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20190217084458.GY12500@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So not to dispute that this could be a bug, but I couldn't cause a
> deadlock.  I wonder if you can see something wrong with my method?
>=20
> *** Set up ***
>=20
> - kernel 5.0.0-0.rc3.git0.1.fc30.x86_64
> - nbd-client 3.19-1.fc30
> - nbdkit 1.11.5 (git commit ef9d1978ce28)
>=20
> Baremetal machine was booted with mem=3D2G to artificially limit the
> RAM.  The machine has 64G of swap.
>=20
> # free -m
>               total        used        free      shared  buff/cache   ava=
ilable
> Mem:           1806         329        1383           0          93      =
  1357
> Swap:         65535         179       65356
>=20
> *** Method ***
>=20
> I started nbdkit as a 4G RAM disk:
>=20
>   ./nbdkit memory size=3D4G
>=20
> This is implemented as a sparse array with a 2 level page table, and
> should allocate (using malloc) every time a new area of the disk is
> written to.  Exact implementation is here:
> https://github.com/libguestfs/nbdkit/tree/master/common/sparse
>=20
> I started nbd-client using the -swap option which uses
> mlockall(MCL_FUTURE) to lock the client into RAM.
>=20
>   nbd-client -b 512 -swap localhost /dev/nbd0
>=20
> I then created a filesystem on the RAM disk, mounted it, and copied a
> 3G file into it.  I tried this various ways, but the variation I was
> eventually happy with was:
>=20
>   mke2fs /dev/nbd0
>   mount /dev/nbd0 /tmp/mnt
>=20
>   dd if=3D/dev/zero of=3D/tmp/big bs=3D1M count=3D3000
>   cp /tmp/big /tmp/mnt/big
>=20
> I couldn't get any kind of deadlock or failure in this test.
>=20
> (Note that if you repeat the test several times, in theory you could
> delete the file and fstrim the filesystem, but when I was testing it
> to be sure I unmounted everything and killed and restarted nbdkit
> between each test.)

This looks like quite a good try. I'd try to use mmap() to dirty
memory very quickly.

But Shaun reported it happened somehow often for them, so he might
have a practical test case... better than my theories :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxp6wEACgkQMOfwapXb+vI0kQCffGxdlWhnyXsROH74HAQZlA1i
rksAoLVYaLVxcClBd3Con968UpZcNkSt
=RuDA
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
