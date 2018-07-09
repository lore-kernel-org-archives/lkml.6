Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD070C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9473E2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9473E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeGIIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:34:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49496 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeGIIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:34:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5B4158028C; Mon,  9 Jul 2018 10:34:00 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:33:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jan Beulich <JBeulich@suse.com>, mingo@elte.hu, tglx@linutronix.de,
        hpa@zytor.com, davem@davemloft.net, herbert@gondor.apana.org.au,
        rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH v2] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180709083359.GB7312@amd>
References: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
 <20180704202934.GB15246@amd>
 <20180705071215.GA29659@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20180705071215.GA29659@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-07-05 09:12:16, Ingo Molnar wrote:
>=20
> * Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > On Mon 2018-07-02 04:31:54, Jan Beulich wrote:
> > > Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms. Zeroing
> > > idioms don't require execution bandwidth, as they're being taken care
> > > of in the frontend (through register renaming). Use 32-bit XORs inste=
ad.
> > >=20
> > > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >=20
> > > @@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
> > > =20
> > >  	# GHASH computation for the last <16 Byte block
> > >  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
> > > -	xor	%rax,%rax
> > > +	xor	%eax, %eax
> > > =20
> > >  	mov	%rax, PBlockLen(%arg2)
> > >  	jmp	_dec_done_\@
> >=20
> > This is rather subtle... and looks like a bug. To zero 64-bit
> > register, you zero its lower half, relying on implicit zeroing of the
> > upper half. Wow.
> >=20
> > Perhaps we should get comments in the code? Because the explicit code
> > is more readable...
>=20
> The automatic zero-extension of 32-bit ops to the full 64-bit register is=
 a basic,=20
> fundamental and well-known x86-64 idiom in use in literally hundreds of p=
laces in=20
> x86-64 assembly code.
>=20
> We sometimes document zero-extension on entry boundaries where we want to=
 make it=20
> really clear what information gets (and what doesn't get) into the kernel=
, but=20
> generally it only needs documentation is the (very rare) cases where it's=
 *not*=20
> done.
>=20
> Also, why would it be a bug?

Not a bug, just looks like one :-). That's why I'd add a comment.

Anyway, normally assembler is the one who chooses instruction
encoding.

xor %rax, %rax is equivalent to xor %eax, %eax; first variant is
slower on some CPUs, second variant will take one extra byte due to
operand size prefix IIRC... Should the assembler generate right
variant according to the CPU type?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltDHfcACgkQMOfwapXb+vK4CACeIcJiHY+sEazSgyRrGbGk/uHQ
yf4AoJHScygdC/5GHpPfFOJUWMMImQl6
=nVQt
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
