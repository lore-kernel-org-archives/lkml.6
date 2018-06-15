Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DC6208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DC6208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756496AbeFOU5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:57:01 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34402 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFOU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:57:00 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fTvmF-0005gk-1i; Fri, 15 Jun 2018 16:56:59 -0400
Message-ID: <1529096218.7898.158.camel@surriel.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Fri, 15 Jun 2018 16:56:58 -0400
In-Reply-To: <7e415c4d-415b-0ff6-5488-1681e522d2dc@linux.intel.com>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
         <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
         <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
         <7e415c4d-415b-0ff6-5488-1681e522d2dc@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YBC3ZSL+colrEHF43o3A"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YBC3ZSL+colrEHF43o3A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-15 at 13:42 -0700, Dave Hansen wrote:
> On 06/15/2018 01:33 PM, Jason A. Donenfeld wrote:
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
> Andy, what was the specific concern about PKRU?  That we might do:
>=20
> 	kernel_fpu_begin(); <- Saves the first time
> 	something()
> 	kernel_fpu_end(); <- Does not XRSTOR
>=20
> 	copy_from_user(); <- Sees old PKRU, does the wrong thing
>=20
> 	prepare_exit_to_usermode(); <- Does the XRSTOR
> 	// only now does PKRU have the right value
> 	SYSRET/IRET
>=20
> ?
>=20
> Does that *matter* unless something() modified PKRU?  We could just
> make
> the rule that nobody is supposed to mess with it and that it's not
> covered by kernel_fpu_begin/end() semantics.  We could even
> theoretically enforce that in a debug environment if we watch its
> value.

KVM needs to change out guest and host PKRU values
when switching between guest and host mode, but
since f775b13eedee ("x86,kvm: move qemu/guest FPU=20
switching out to vcpu_run") that no longer happens
under kernel_fpu_begin/end so we don't need to care
about that :)

--=20
All Rights Reversed.
--=-YBC3ZSL+colrEHF43o3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlskKBoACgkQznnekoTE
3oOx9QgAka+/LeW7LyIzrZh6JE+0ctj35QONbWRvOMWdsAge1+J7MM65isl3ihPD
6KHJQ93GxvF3YI/md+PfmOyWv/teVtW0sVq7j8rIczGGMS+G5jdzofR3sN+U+Idy
/Aba9lfG0U+kPP+XqS/aOQmCBCCQbwukUUJurED5glfMyxbncEqgG/IjQxCW3MYJ
7ltMzl2gilo6rleJlMgDObj4eMAnNcCjP3WawiABcRpWP3SORCAZsVyQT3D+2i0/
fObkqGvEjRn6eUPt3UinoP7wpiPrOcC8NgipxvgdpwErSzdhrLv0QYkYQVrxpapB
du11W8DdxPm92O5DXIepCdM1REs83g==
=Ai7+
-----END PGP SIGNATURE-----

--=-YBC3ZSL+colrEHF43o3A--

