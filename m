Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D00C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD824479
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCD824479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFVPP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:15:57 -0400
Received: from shelob.surriel.com ([96.67.55.147]:59976 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeFVPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:15:56 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWNmy-000870-Df; Fri, 22 Jun 2018 11:15:52 -0400
Message-ID: <1529680551.7898.191.camel@surriel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 22 Jun 2018 11:15:51 -0400
In-Reply-To: <CALCETrVUgO3PYvwbV9BHbepcEZ=Lwqm8TkETuC5ijUC9h0AQ6Q@mail.gmail.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-5-riel@surriel.com>
         <CALCETrVUgO3PYvwbV9BHbepcEZ=Lwqm8TkETuC5ijUC9h0AQ6Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k8+ixx6CGNHQqcaqqVV6"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k8+ixx6CGNHQqcaqqVV6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 08:04 -0700, Andy Lutomirski wrote:
> On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > Lazy TLB mode can result in an idle CPU being woken up by a TLB
> > flush,
> > when all it really needs to do is reload %CR3 at the next context
> > switch,
> > assuming no page table pages got freed.
> >=20
> > This patch deals with that issue by introducing a third TLB state,
> > TLBSTATE_FLUSH, which causes %CR3 to be reloaded at the next
> > context
> > switch.
> >=20
> > Atomic compare and exchange is used to close races between the TLB
> > shootdown code and the context switch code. Keying off just the
> > tlb_gen is likely to not be enough, since that would not give
> > lazy_clb_can_skip_flush() information on when it is facing a race
> > and has to send the IPI to a CPU in the middle of a LAZY -> OK
> > switch.
> >=20
> > Unlike the 2016 version of this patch, CPUs in TLBSTATE_LAZY are
> > not
> > removed from the mm_cpumask(mm), since that would prevent the TLB
> > flush IPIs at page table free time from being sent to all the CPUs
> > that need them.
>=20
> Eek, this is so complicated.  In the 2016 version of the patches, you
> needed all this.  But I rewrote the whole subsystem to make it easier
> now :)  I think that you can get rid of all of this and instead just
> revert the relevant parts of:
>=20
> b956575bed91ecfb136a8300742ecbbf451471ab
>=20
> All the bookkeeping is already in place -- no need for new state.

I looked at using your .tlb_gen stuff, but we need a
way to do that race free.  I suppose setting the
tlbstate to !lazy before checking .tlb_gen might do
the trick, if we get the ordering right at the tlb
invalidation site, too?

Something like this:

context switch                tlb invalidation

			advance mm->context.tlb_gen
			send IPI to cpus with !is_lazy tlb


tlbstate.is_lazy =3D FALSE
*need_flush =3D .tlb_gen < next_tlb_gen

Do you see any holes in that?

I will gladly simplify this code and get rid
of the atomic operations :)



--=20
All Rights Reversed.
--=-k8+ixx6CGNHQqcaqqVV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstEqgACgkQznnekoTE
3oMqAwf+Jcop+34+lym1FYKmoIvcSYHEts9CIJYG4WoVAyAPQUP3Tr4cjOMbmaXL
61X4F+e98qPkGID1OTO5UB0dAPNXvsTxTSB0+RcmmjNI2l/D06I7aLmQHyJHaABU
LoZS+6eXqFwFdwyM7l9mmsWhb8KOxlMHRnOrFIBhIF0CiL3WJFisT3LHTzAHk50w
E3+po69qAZxvq4q6WAaJ1Dn5TCIKHM2nyje15PYIKBRHP8mj2zYh+TbF9XTY6XN/
pZrxQwZtdVl4q+q8NcxypdfhoC5hmqFDy78P/AWHhy3aCU/4WViSnKQXudvZZSSm
ztjdRfcg5trZUkr5D9WR9QiIyanZRA==
=eGEX
-----END PGP SIGNATURE-----

--=-k8+ixx6CGNHQqcaqqVV6--

