Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C60C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA212420C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA212420C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeGDU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:29:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42706 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeGDU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:29:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9AF488055A; Wed,  4 Jul 2018 22:29:34 +0200 (CEST)
Date:   Wed, 4 Jul 2018 22:29:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Beulich <JBeulich@suse.com>
Cc:     mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH v2] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180704202934.GB15246@amd>
References: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-02 04:31:54, Jan Beulich wrote:
> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms. Zeroing
> idioms don't require execution bandwidth, as they're being taken care
> of in the frontend (through register renaming). Use 32-bit XORs instead.
>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

> @@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
> =20
>  	# GHASH computation for the last <16 Byte block
>  	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
> -	xor	%rax,%rax
> +	xor	%eax, %eax
> =20
>  	mov	%rax, PBlockLen(%arg2)
>  	jmp	_dec_done_\@

This is rather subtle... and looks like a bug. To zero 64-bit
register, you zero its lower half, relying on implicit zeroing of the
upper half. Wow.

Perhaps we should get comments in the code? Because the explicit code
is more readable...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9Li4ACgkQMOfwapXb+vI7wQCgtlHD5jl3FWMcMblS6m0D+66o
Pl0AoMGlH+B4RS8UCLqMEikRXaJQF6z0
=Li8E
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
