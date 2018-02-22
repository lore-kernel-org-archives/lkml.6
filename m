Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933055AbeBVPlb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:41:31 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37874 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbeBVPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:41:30 -0500
X-Google-Smtp-Source: AG47ELus2QG0Ps4ce4xKtNNJnBAc3p0mltQaSp2H12SPeCJ0VYRzMSa0VKCT86oNTNOnolncDbUuSw==
X-ME-Sender: <xms:qOSOWvLGf640455zCvlce0R_2OKlZh2tdurF22FhmrIXElqbuwF2-A>
Date: Thu, 22 Feb 2018 23:44:56 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 06/17] lockdep: Support deadlock
 detection for recursive read in check_noncircular()
Message-ID: <20180222154456.eno5mvqzvdamvqdx@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-7-boqun.feng@gmail.com>
 <20180222145434.GS25201@hirez.programming.kicks-ass.net>
 <20180222151626.GU25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyfylvghwdp4e52z"
Content-Disposition: inline
In-Reply-To: <20180222151626.GU25235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyfylvghwdp4e52z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 04:16:26PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:54:34PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 03:08:53PM +0800, Boqun Feng wrote:
> >=20
> > > +static inline int hlock_conflict(struct lock_list *entry, void *data)
> > > +{
> > > +	struct held_lock *hlock =3D (struct held_lock *)data;
> > > +
> > > +	return hlock_class(hlock) =3D=3D entry->class &&
> > > +	       (hlock->read !=3D 2 || !entry->is_rr);
> > > +}
> >=20
> > Bah, brain hurts.
> >=20
> > So before we add prev -> this, relation, we check if there's a this ->
> > prev relation already in the graph -- if so that would be a problem.
> >=20
> > The above function has @data =3D=3D @prev (__bfs_forward starts at @thi=
s,
> > looking for @prev), and the above patch augments the 'class_equal' test
> > with @prev not having read=3D=3D2 or @entry not having xr;
> >=20
> > This is because.... (insert brain hurt)
>=20
> (hlock->read !=3D 2 || !entry->have_xr) :=3D !(hlock->read =3D=3D 2 && en=
try->have_xr)
>=20
> hlock->read =3D=3D 2 :=3D prev->read =3D=3D 2
> entry->have_xr means the last fwd link has read=3D=3D2.
>=20
> Together this gives that:
>=20
>   @prev (Rx) ---> X ---> @entry (xR)
>=20
> does not form a cycle, because:
>=20
>   @enrty (xR) -> @prev (Rx)
>=20
> is not strong and can be ignored.
>=20
> Did I get that right? If so, the Changelog needs serious help and code

Yep.. I was about to rely you with something similar.. I will add a
comment for this function and other "brain-hurting" functions too.

Sorry for the headache ;-(

Regards,
Boqun

> does too.



--jyfylvghwdp4e52z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqO5XIACgkQSXnow7UH
+rgUCAf/dIl8it6X5fj1eyAowuIkFbtwhz4wmweN0boeyKv6VLf2IOKjUfdbOhO0
N5LgCJIIbuILZO+aAN0ShMDW4MiTFuVmsPOm1KhE4Brhta7dzoOgh7QfTGYUHcr1
QxGVW9jqQKtRhD0e/W6+DLYwpckgN2YY1XZrBNw+f1SE7o0kmY1TGuic6j7M3vAo
HOSkxW9VfvVfLE4moWdx5UFNu1DkP7mgDKrylvJrSZNzDrNSCsq3Ia4AYBt55ar3
T/VPyMn6uS/j/zrZHpZmUPV+ohj2BhmPVR22nYtk8t3huXnG3O7M8bpf7Q0GhcXK
qcY2twKcFD8YhMd9Y4svGKl/diX+DQ==
=Rx22
-----END PGP SIGNATURE-----

--jyfylvghwdp4e52z--
