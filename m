Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeDEUaw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34554 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeDEUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:48 -0400
Date: Thu, 5 Apr 2018 22:30:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>, jikos@suse.cz,
        mawilcox@microsoft.com, raven@themaw.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: update-binfmts breaking suspend was Re: x32 suspend failuer in
 Re: linux-next: Tree for Apr 4
Message-ID: <20180405203045.GA23313@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
 <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
 <20180404084905.GA12303@amd>
 <20180405122503.GA28446@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20180405122503.GA28446@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Well, v4.16-rc4 is parent of v4.16-rc6, but next-20180304 is not
> > parent of next-20180307.
> >=20
> > But you are right that if I do bisect between -linus and -next, it
> > should work.
> >=20
> > Anyway, does s2ram work for you in -next? Are you testing 32bit?
>=20
> Hmm. I tested on T40p. That works ok, so at least some 32bit machines
> do work.
>=20
> Hmm, and my test scripts were wrong.
>=20
> Failure is not a hang, as they expect, but... machine locks up, but
> does not suspend, and then continues running after a delay..
>=20
> [   35.038766] PM: Syncing filesystems ... done.
> [   35.051246] Freezing user space processes ...
> [   55.060528] Freezing of tasks failed after 20.009 seconds (1 tasks
> refusing to freeze, wq_busy
> =3D0):
> [   55.060552] update-binfmts  D    0  2727      1 0x80000004
> [   55.060576] Call Trace:
> [   55.060600]  __schedule+0x37a/0x7e0
> [   55.060618]  schedule+0x29/0x70
> [   55.060635]  autofs4_wait+0x359/0x7a0
> [   55.060653]  ? wait_woken+0x70/0x70
> [   55.060668]  autofs4_mount_wait+0x4a/0xe0
> [   55.060684]  ? autofs4_mount_wait+0x4a/0xe0
> [   55.060699]  autofs4_d_automount+0xe0/0x200
> [   55.060715]  ? autofs4_d_automount+0xe0/0x200
>=20
> Did the rework of freezing start already in -next?

Hmm, so I did git bisect, and it pointed to:

commit 7cb03edf112fea6ead2fcd3c5fd639756d6d114b
Author: Matthew Wilcox <mawilcox@microsoft.com>
Date:   Thu Mar 29 10:15:17 2018 +1100

    autofs4: use wait_event_killable

    This playing with signals to allow only fatal signals appears to
    predate
        the introduction of wait_event_killable(), and I'm fairly sure
    that
        wait_event_killable is what was meant to happen here.

    Link:
    http://lkml.kernel.org/r/20180319191609.23880-1-willy@infradead.org
        Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
	    Acked-by: Ian Kent <raven@themaw.net>
	        Signed-off-by: Andrew Morton
    <akpm@linux-foundation.org>
        Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
=09



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrGh3UACgkQMOfwapXb+vJPpACcC/lSAgo2k/KIXNu0X1yLkcUV
Dh4Aniex/LbnMIfOsdz+lAobvWq/F+Dh
=Al6e
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
