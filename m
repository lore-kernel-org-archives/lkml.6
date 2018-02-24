Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeBXH1g (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:27:36 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33426 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeBXH1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:27:34 -0500
X-Google-Smtp-Source: AG47ELvTfO0KbRHpW38tvZAyawsVg9G9n8vmXr92JftbNWnFiaISUqUxFr22PNNtdvrVOHoXsmt1Wg==
X-ME-Sender: <xms:5BORWuiipl8xF__gXKlITsHAp6xImKas7PkXOZTid29AVOQD33VcoQ>
Date: Sat, 24 Feb 2018 15:31:01 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180224073101.2eylqelqzmszm4ee@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
 <20180223115520.GV25181@hirez.programming.kicks-ass.net>
 <20180223123732.acxbavnf2ktd4lzl@tardis>
 <20180224053250.ketrlbq4gtx573qo@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="syyq6fb6s2xyxvvg"
Content-Disposition: inline
In-Reply-To: <20180224053250.ketrlbq4gtx573qo@tardis>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syyq6fb6s2xyxvvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 01:32:50PM +0800, Boqun Feng wrote:
[...]
>=20
> I also reorder bit number for each kind of dependency, so that we have a
> simple __calc_dep_bit(), see the following:
>=20
> 	/*
> 	 * DEP_*_BIT in lock_list::dep
> 	 *
> 	 * For dependency @prev -> @next:
> 	 *
> 	 *   RR: both @prev and @next are recursive read locks, i.e. ->read =3D=
=3D 2.
> 	 *   RN: @prev is recursive and @next is non-recursive.
> 	 *   NR: @prev is a not recursive and @next is recursive.
> 	 *   NN: both @prev and @next are non-recursive.
> 	 *=20
> 	 * Note that we define the value of DEP_*_BITs so that:
> 	 * 	bit0 is prev->read !=3D 2
> 	 * 	bit1 is next->read !=3D 2
> 	 */
> 	#define DEP_RR_BIT 0
> 	#define DEP_RN_BIT 1
> 	#define DEP_NR_BIT 2

Oops, to make the following __cal_dep_bit() works, we should have:

 	#define DEP_NR_BIT 1
 	#define DEP_RN_BIT 2

instead.

Regards,
Boqun

> 	#define DEP_NN_BIT 3
>=20
> 	#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> 	#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> 	#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> 	#define DEP_NN_MASK (1U << (DEP_NN_BIT))
>=20
> 	static inline unsigned int
> 	__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
> 	{
> 		return (prev->read !=3D 2) + ((next->read !=3D 2) << 1)
> 	}
>=20
> 	static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
> 	{
> 		return 1U << __calc_dep_bit(prev, next);
> 	}
>=20

--syyq6fb6s2xyxvvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqRFK8ACgkQSXnow7UH
+rjx6AgAmqvbxr2uys+7crIa5r1C+Sr5v+LjaefOjQc2s5N7joFdsFaKQTDKpnbM
kcN6Wv0gBJNKO5YTYvFlTTVQhIIQzIiYfAv9F+t00VxwI3opOwxbxDziMEtQkC+m
eHkSZ1z/t2K6C6mWDO9LbUuubk6nieFdHuHqbrxzE0HDp1RInOwIXlC2z9iOf4k+
GD5EfJZmfslxrdsm/ZsFJmAsjgcMsYdliXscRW6N9kXItkC0arXNmNOP4DXUhWTZ
c6RQfhyrvuNpc0fF/0oGLC6gTkXbTOgxhNy/bhdwhilUzk1A06cy+Pqe23gONpki
ffdAPJJSTEhnhATE6jquqMHR3bcwFw==
=FPN2
-----END PGP SIGNATURE-----

--syyq6fb6s2xyxvvg--
