Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeBWISO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:18:14 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:40824 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBWISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:18:13 -0500
X-Google-Smtp-Source: AG47ELuPRi2IByvqUN/fgvMYZbvEdvDCVuEU1YX55BUhW9NAI49OdKl7rYntl62xk5LBcGdA24K2ug==
X-ME-Sender: <xms:Qs6PWnZln9ASr8CUA29CslwzxrmBkI1w9yTQ8uXHvP2znYxrqsGeSw>
Date: Fri, 23 Feb 2018 16:21:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read
 lock related safe->unsafe detection
Message-ID: <20180223082134.ykkbzqj2h7glxrqn@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-9-boqun.feng@gmail.com>
 <20180222174654.GW25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtotlwrbdxf3mtth"
Content-Disposition: inline
In-Reply-To: <20180222174654.GW25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtotlwrbdxf3mtth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 06:46:54PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:08:55PM +0800, Boqun Feng wrote:
> > There are four cases for recursive read lock realted deadlocks:
> >=20
> > (--(X..Y)--> means a strong dependency path starts with a --(X*)-->
> > dependency and ends with a --(*Y)-- dependency.)
> >=20
> > 1.	An irq-safe lock L1 has a dependency --(*..*)--> to an
> > 	irq-unsafe lock L2.
> >=20
> > 2.	An irq-read-safe lock L1 has a dependency --(N..*)--> to an
> > 	irq-unsafe lock L2.
> >=20
> > 3.	An irq-safe lock L1 has a dependency --(*..N)--> to an
> > 	irq-read-unsafe lock L2.
> >=20
> > 4.	An irq-read-safe lock L1 has a dependency --(N..N)--> to an
> > 	irq-read-unsafe lock L2.
> >=20
> > The current check_usage() only checks 1) and 2), so this patch adds
> > checks for 3) and 4) and makes sure when find_usage_{back,for}wards find
> > an irq-read-{,un}safe lock, the traverse path should ends at a
> > dependency --(*N)-->. Note when we search backwards, --(*N)--> indicates
> > a real dependency --(N*)-->.
>=20
> This adds 4 __bfs() searches for every new link.
>=20
> Can't we make the existing traversals smarter?

Haven't really thought this one through, I will try. But as you said, we
only need to do more searchs for _new_ links, so I think it's the slow
path, would the performance matter that much?

Regards,
Boqun

--dtotlwrbdxf3mtth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqPzwoACgkQSXnow7UH
+rh6QAgArkGyNAaOMLnM9izFG+5uV8emZODNFcxjoYqZx0Qfw/0WGHPEdRxLU0U5
Tf8PhdKFirVAPwiybguC07L8h6VvjjoeF5/2Jx+ZC3wquAM5fJz+5+b4keWf4tCT
WX7kIhJgZO9pvNOIcCnd1zEcL0Sdsd47et6zRAjCL8fO1Lmqaqned+egwpl+HTTt
t/2V/0+iMj+XMu8dQEGiYYQiMkCyeTnyXL0xK4bGMRoRTR68kilCI7BrHpbipulJ
kNUimxUAmxsHjSDlu1tHeW1+wI7NbcrlDzi9mcXOM6P3YCXKyVYK7nq55dJZT2N/
lY+veJyqUxOQH4pEpxsZhmWTbQNR9g==
=7FJK
-----END PGP SIGNATURE-----

--dtotlwrbdxf3mtth--
