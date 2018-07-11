Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D840C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB32C213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB32C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389912AbeGKUQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:16:38 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54170 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388887AbeGKUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:16:37 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fdLRa-0004xv-6j; Wed, 11 Jul 2018 16:10:34 -0400
Message-ID: <1531339833.26425.1.camel@surriel.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Wed, 11 Jul 2018 16:10:33 -0400
In-Reply-To: <20180711162850.52jmzsuwegpk7rag@breakpoint.cc>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
         <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
         <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
         <20180711162850.52jmzsuwegpk7rag@breakpoint.cc>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PBWDaPbCpr3to4z8rhDe"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PBWDaPbCpr3to4z8rhDe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-07-11 at 18:28 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-06-15 22:33:47 [+0200], Jason A. Donenfeld wrote:
> > On Fri, Jun 15, 2018 at 8:32 PM Andy Lutomirski <luto@kernel.org>
> > wrote:
> > > quite in the form you imagined.  The idea that we've tossed
> > > around is
> > > to restore FPU state on return to user mode.  Roughly, we'd
> > > introduce
> > > a new thread flag TIF_FPU_UNLOADED (name TBD).
> > > prepare_exit_to_usermode() would notice this flag, copy the
> > > fpstate to
> > > fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() --
> > > No
> > > one has quite thought it through, but I think it should be
> > > outside the
> > > loop.)  We'd update all the FPU accessors to understand the flag.
> >=20
> > Yes! This is exactly what I was thinking. Then those calls to
> > begin()
> > and end() could be placed as close to the actual FPU usage as
> > possible.
>=20
> I was thinking about this myself. Did anyone try to hack something in
> the meantime? I might want to look into this, too :)

I have implemented this before, back before the
big rewrite of the syscall entry and exit code.

It seemed to work fine.

--=20
All Rights Reversed.
--=-PBWDaPbCpr3to4z8rhDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltGZDkACgkQznnekoTE
3oNjyQgAwGynix8qb8Oi/WeLSl9f9nUgh2s2mqE2a56rq6xBoRopdm/zYttDypQI
CggihoFE+M2gFjfarlSFGaJiKv/VwASvLcVjd5olmBTJ/qgC6Nt1icNAOKkAJMe8
VTl/wcN9M2J86dx7NJPDBLg77oEzL15erc5wOQ4mihxE/bg4lI8sjjo8EWYOv3BY
4VUdSnHGm8XMKZuHj96mltdowedGkTfL0Md2Tns56XsCLxqW4ec1dGJggb55qvnr
IqaBjWNEGZi80nK4HP6YVcoUL6dDcjqfhlQOfRp2luK6vHb4a7YBEdujK9O4JtaV
7AGvolsr9NfhK+kAxT+7Z9EG9YmaAQ==
=pYzj
-----END PGP SIGNATURE-----

--=-PBWDaPbCpr3to4z8rhDe--

