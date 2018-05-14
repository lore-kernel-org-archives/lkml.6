Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeENCLu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:11:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35786 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeENCLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:11:49 -0400
Message-ID: <71fc1f9e921f2a755e79563903ddf676de128478.camel@decadent.org.uk>
Subject: Re: Fixing Linux getrandom() in stable
From: Ben Hutchings <ben@decadent.org.uk>
To: Adrian Bunk <bunk@debian.org>
Cc: Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 03:11:30 +0100
In-Reply-To: <20180513204828.GI10643@localhost>
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
         <20180513204828.GI10643@localhost>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-fPt2BSZn9gfbAMq4dtff"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fPt2BSZn9gfbAMq4dtff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-05-13 at 23:48 +0300, Adrian Bunk wrote:
> On Wed, May 09, 2018 at 11:46:00PM +0100, Ben Hutchings wrote:
[...]
> > # Options for a new fix
> >=20
> > It is unlikely that any further fix will be forthcoming on the kernel
> > side, so I believe that we need to do one of:
> >=20
> > 1. Add entropy to the kernel during boot; either:
> >    a. Improve systemd-random-seed
> >    b. Recommend use of haveged
>=20
> I don't see any solution above that both always works and never results
> in new CVEs.

Indeed.

> As an example, what happens if I debootstrap and deploy the resulting
> filesytem to a large number of identical embedded systems without
> entropy sources?

Then it is your fault when they turn into a botnet. :-)  Availability
of randomness must be considered in the design of embedded systems.

[...]
> /dev/urandom is documented in a very misleading way, quoting random(4):
>    When read during early boot time, /dev/urandom may return data prior t=
o
>    the entropy pool being initialized.  If this  is  of  concern  in  you=
r
>    application, use getrandom(2) or /dev/random instead.
>=20
> What is the worst case for "early boot time" here? "always"?

No, I don't think so.

> Due to the gdm bugs mentioned above we know that there are real-life=20
> situations where gdm currently uses "random" data that might be=20
> predictable.
>=20
> grep tells me:
> daemon/gdm-x-session.c:        auth_entry.data =3D gdm_generate_random_by=
tes (auth_entry.data_length, &error);
> daemon/gdm-display-access-file.c:        *cookie =3D gdm_generate_random_=
bytes (GDM_DISPLAY_ACCESS_COOKIE_SIZE,
>=20
> Repeat the same for every package that uses /dev/urandom.

This is certain undesirable, but it's exploitable only by local users.=20
(If you let the X server listen to the network, all authentication
cookies are sent in the clear so you've already lost.  If you use ssh X
forwarding, it generates a new authentication cookie for use with the X
proxy on the remote machine.)

>=20
> >    b. Tolerate a longer wait for getrandom() to return
>=20
> I suspect there might be no guaranteed upper bound for the waiting time.

Interrupt timing feeds into the RNG, and as long as there's at least
one interrupt per second then I think the RNG will reach the fully
initialised state after a few minutes.  I just started a VM with a
serial console and only a shell running as pid 1, which is about as
idle a system as I can imagine, and it was seeing more than one
interrupt per second.  However, other architectures (e.g. s390x) might
achieve greater idleness.

> > ...
> > The libbsd maintainer (Guillem Jover) favours option 2a.
> >=20
> > One of the krb5 maintainers (Benjamin Kaduk) favours option 2b, and
> > also proposed that systemd could provide a wait-for-rng-ready unit to
> > support this.
>=20
> I don't see any general solution that is both correct and easy.

Indeed.

> The proper way forward might be to deprecate /dev/urandom and add a=20
> third option GRND_UNSAFE_RANDOM to getrandom() that is documented to=20
> never block but might return predictable data in some cases.

This doesn't solve anything for us.  (It does help with the original
problem of device nodes possibly being absent from a minimal container
or chroot.)

> It would then be up to the application to decide whether predictable
> data is acceptable, and what to do in entropy-starved situations.
>=20
> Regarding the suggested wait-for-rng-ready systemd unit for others to=20
> wait on, this only makes sense for cases where "do not start at all"
> is the best handling for a "no entropy" situation.

Yes.

Ben.

> > Ben.
>=20
> cu
> Adrian
>=20
--=20
Ben Hutchings
For every action, there is an equal and opposite criticism. - Harrison


--=-fPt2BSZn9gfbAMq4dtff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlr48FIACgkQ57/I7JWG
EQnPMQ//TTpdjIIzbRUJIMzMAyyrV9h9LkHvffK6oUsA4TfcJNNjkqbztRE2OkW1
iMNBZ+KZrQk8CL1nmFjY6EKHilf/zvWjReCDAmAgg+G7bDyB7A+QmziP0nHzdzLj
rtCgpjyRYuoT8QqxJwr3cXjeCee0wtCE+sDhCBsT9yAAmiQUzmXpoWWT3Zhr1FnM
6wL18JP6/wd6P+3uVkjwifuCCXfDLk9hOFGzF63zpGtKJbAn8yDO+FRkpjcydrYH
OyZgbWYw3bBrV7Wf+1CsDeBbpl2vt3UpJViX0T/3SogA2NUiLJpZrIyvA99KgZhv
60qrS0HK2/goU/RYZLqszkZvfrFyu8CT7hFMJRzw/ye9hKxEZB0xjsdKkT1KfKdz
gm4hsgDIWrS1eyxx38t6Qq2eTxFxBV5TZywiB8Hl3PCPbaobpYtqRH4+ehCPOkXm
wfiGGWq4xp4hXYWgoGLrD4KxcDi0OzEMLqz+gIuXpMjPUAhpzwMNdm/a3ULqeyzp
g0LLF2Vr9uhzKOJ8zPtZ1juexie9GdFWdKcaKCvng2bssc54nU5EcwJuznqaA1ls
Red+OAk1yL7jM2s1Y3H8iGbfyY7vKxxV0ZPpqzsds1VvEgzqM6o3dcPn8kL3VzxA
TLFEve8wZwV7mz9UufHi7GT9FbD/FCNv8r6ZibFvj72xJNiLgzk=
=s6+y
-----END PGP SIGNATURE-----

--=-fPt2BSZn9gfbAMq4dtff--
