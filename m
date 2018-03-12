Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCLGKM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:10:12 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:39733 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeCLGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:10:10 -0400
X-Google-Smtp-Source: AG47ELtMxIB+Bkowz8ETFILKt2Quf2UHcyXe1RfdAnnMvcRGZEdVGYlDhIL7cWq1gzbs7jVtzNFpOQ==
X-ME-Sender: <xms:wBmmWiavUkggkYVr2szZB1qAS9ZUm9sd1UQlGbFrm4P9giaYdW9lIg>
Date: Mon, 12 Mar 2018 14:13:53 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, parri.andrea@gmail.com,
        albert@sifive.com, stern@rowland.harvard.edu,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com, akiyks@gmail.com,
        mingo@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv/atomic: Strengthen implementations with
 fences
Message-ID: <20180312061353.g3czcr4fcdgct36a@tardis>
References: <mhng-a5cc1e9d-00d5-49e7-8acd-173277f28381@palmer-si-x1c4>
 <d7f08bbb-3afb-b745-640a-b720971c68d4@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cid37zonwggtzd3w"
Content-Disposition: inline
In-Reply-To: <d7f08bbb-3afb-b745-640a-b720971c68d4@nvidia.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cid37zonwggtzd3w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 04:21:37PM -0800, Daniel Lustig wrote:
> On 3/9/2018 2:57 PM, Palmer Dabbelt wrote:
> > On Fri, 09 Mar 2018 13:30:08 PST (-0800), parri.andrea@gmail.com wrote:
> >> On Fri, Mar 09, 2018 at 10:54:27AM -0800, Palmer Dabbelt wrote:
> >>> On Fri, 09 Mar 2018 10:36:44 PST (-0800), parri.andrea@gmail.com wrot=
e:
> >>
> >> [...]
> >>
> >>> >This proposal relies on the generic definition,
> >>> >
> >>> >=A0=A0 include/linux/atomic.h ,
> >>> >
> >>> >and on the
> >>> >
> >>> >=A0=A0 __atomic_op_acquire()
> >>> >=A0=A0 __atomic_op_release()
> >>> >
> >>> >above to build the acquire/release atomics (except for the xchg,cmpx=
chg,
> >>> >where the ACQUIRE_BARRIER is inserted conditionally/on success).
> >>>
> >>> I thought we wanted to use the AQ and RL bits for AMOs, just not for =
LR/SC
> >>> sequences.=A0 IIRC the AMOs are safe with the current memory model, b=
ut I might
> >>> just have some version mismatches in my head.
> >>
> >> AMO.aqrl are "safe" w.r.t. the LKMM (as they provide "full-ordering");=
 OTOH,
> >> AMO.aq and AMO.rl present weaknesses that LKMM (and some kernel develo=
pers)
> >> do not "expect".=A0 I was probing this issue in:
> >>
> >> =A0 https://marc.info/?l=3Dlinux-kernel&m=3D151930201102853&w=3D2
> >>
> >> (c.f., e.g., test "RISCV-unlock-lock-read-ordering" from that post).
> >>
> >> Quoting from the commit message of my patch 1/2:
> >>
> >> =A0 "Referring to the "unlock-lock-read-ordering" test reported below,
> >> =A0=A0 Daniel wrote:
> >>
> >> =A0=A0=A0=A0 I think an RCpc interpretation of .aq and .rl would in fa=
ct
> >> =A0=A0=A0=A0 allow the two normal loads in P1 to be reordered [...]
> >>
> >> =A0=A0=A0=A0 [...]
> >>
> >> =A0=A0=A0=A0 Likewise even if the unlock()/lock() is between two store=
s.
> >> =A0=A0=A0=A0 A control dependency might originate from the load part of
> >> =A0=A0=A0=A0 the amoswap.w.aq, but there still would have to be someth=
ing
> >> =A0=A0=A0=A0 to ensure that this load part in fact performs after the =
store
> >> =A0=A0=A0=A0 part of the amoswap.w.rl performs globally, and that's not
> >> =A0=A0=A0=A0 automatic under RCpc.
> >>
> >> =A0=A0 Simulation of the RISC-V memory consistency model confirmed this
> >> =A0=A0 expectation."
> >>
> >> I have just (re)checked these observations against the latest specific=
ation,
> >> and my results _confirmed_ these verdicts.
> >=20
> > Thanks, I must have just gotten confused about a draft spec or somethin=
g.=A0 I'm
> > pulling these on top or your other memory model related patch.=A0 I've =
renamed
> > the branch "next-mm" to be a bit more descriptiove.
>=20
> (Sorry for being out of the loop this week, I was out to deal with
> a family matter.)
>=20
> I assume you're using the herd model?  Luc's doing a great job with
> that, but even so, nothing is officially confirmed until we ratify
> the model.  In other words, the herd model may end up changing too.
> If something is broken on our end, there's still time to fix it.
>=20
> Regarding AMOs, let me copy from something I wrote in a previous
> offline conversation:
>=20
> > it seems to us that pairing a store-release of "amoswap.rl" with
> > a "ld; fence r,rw" doesn't actually give us the RC semantics we've
> > been discussing for LKMM.  For example:
> >=20
> > (a) sd t0,0(s0)
> > (b) amoswap.d.rl x0,t1,0(s1)
> >     ...
> > (c) ld a0,0(s1)
> > (d) fence r,rw
> > (e) sd t2,0(s2)
> >=20
> > There, we won't get (a) ordered before (e) regardless of whether
> > (b) is RCpc or RCsc.  Do you agree?
>=20
> At the moment, only the load part of (b) is in the predecessor
> set of (d), but the store part of (b) is not.  Likewise, the
> .rl annotation applies only to the store part of (b), not the
> load part.
>=20
> This gets back to a question Linus asked last week about
> whether the AMO is a single unit or whether it can be

You mean AMO or RmW atomic operations?

> considered to split into a load and a store part (which still
> perform atomically).  For RISC-V, for right now at least, the
> answer is the latter.  Is it still the latter for Linux too?
>=20

I think for RmW atomics it's still the latter, the acquire or release is
for the load part or the store part of an RmW. For example, ppc uses
lwsync as acquire/release barriers, and lwsync could not order
write->read.=20

Regards,
Boqun

> https://lkml.org/lkml/2018/2/26/606
>=20
> > So I think we'll need to make sure we pair .rl with .aq, or that
> > we pair fence-based mappings with fence-based mappings, in order
> > to make the acquire/release operations work.
>=20
> This assumes we'll say that .aq and .rl are RCsc, not RCpc.
> But in this case, I think .aq and .rl could still be safe to use,
> as long as you don't ever try to mix in a fence-based mapping
> on the same data structure like in the example above.  That
> might be important if we want to find the most compact legal
> implementation, and hence do want to use .aq and .rl after all.
>=20
> > And since we don't have native "ld.aq" today in RISC-V, that
> > would mean smp_store_release would have to remain implemented
> > as "fence rw,w; s{w|d}", rather than "amoswap.{w|d}.rl", for
> > example.
>=20
> Thoughts?
>=20
> Thanks,
> Dan
>=20
> >=20
> > Thanks!

--cid37zonwggtzd3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqmGp4ACgkQSXnow7UH
+riLDwf/bt4/k6lJlQB7gxialsjYkIWQyMFjzR9mNbupJ4EWJbrGk4m9oo+R5Ec2
1uio7La5hHwLw2Aj3LdXyA9FTfVM4ujMvUSJWhdf+tfaHvDhciU3la2GTeLjMAM/
R9dM3+MwkVoFaufEK2y2c4nhg9Vh5FiMYRPxl0O2vAIWErWVNwEFRsOTMOdErh6g
SzTufUn8ipRQe9ZvIQ+1p8ADjT6ZikzZplVNQ1u7J/FArpwr29WC+6WV7yb4YL/q
bedJNj+OutnML+fRGS5wwWlRo24O4dFEsQ6btDbf8skSatKQ53tj/LQ99LukjdFa
3ktZM+gpzcrZGJBrmyjlP9L1xvVuNg==
=OLjr
-----END PGP SIGNATURE-----

--cid37zonwggtzd3w--
