Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06CFC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E4208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12E4208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeHZUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 16:36:40 -0400
Received: from shelob.surriel.com ([96.67.55.147]:43992 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 16:36:40 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ftyI6-0002Ve-35; Sun, 26 Aug 2018 12:53:30 -0400
Message-ID: <3983fcb4c663e8dc05f13cac32ff56ec15c3dac1.camel@surriel.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Date:   Sun, 26 Aug 2018 12:53:29 -0400
In-Reply-To: <2532E417-DDD2-4E2C-9F21-3B8D9B96370D@amacapital.net>
References: <20180824213849.23647-1-Jason@zx2c4.com>
         <20180824213849.23647-2-Jason@zx2c4.com>
         <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
         <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
         <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
         <2532E417-DDD2-4E2C-9F21-3B8D9B96370D@amacapital.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4L9haMCxh2AgKTDDi3f4"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4L9haMCxh2AgKTDDi3f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-08-26 at 07:18 -0700, Andy Lutomirski wrote:
> > On Aug 26, 2018, at 7:06 AM, Thomas Gleixner <tglx@linutronix.de>
> > wrote:
> >=20
> > Jason,
> >=20
> > > On Sun, 26 Aug 2018, Jason A. Donenfeld wrote:
> > > > On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <
> > > > tglx@linutronix.de> wrote:
> > > > I'm not too fond of this simply because it requires that
> > > > relax() step in
> > > > all code pathes. I'd rather make that completely transparent by
> > > > just
> > > > marking the task as FPU using and let the context switch code
> > > > deal with it
> > > > in case that it gets preempted. I'll let one of my engineers
> > > > look into
> > > > that next week.
> > >=20
> > > Do you mean to say you intend to make kernel_fpu_end() and
> > > kernel_neon_end() only actually do something upon context switch,
> > > but
> > > not when it's actually called? So that multiple calls to
> > > kernel_fpu_begin() and kernel_neon_begin() can be made without
> > > penalty?
> >=20
> > On context switch and exit to user. That allows to keep those code
> > pathes
> > fully preemptible. Still twisting my brain around the details.
>=20
> I think you=E2=80=99ll have to treat exit to user and context switch as
> different things. For exit to user, we want to restore the *user*
> state, but, for context switch, we=E2=80=99ll need to restore *kernel* st=
ate.

For non-preemptible kernel_fpu_begin/end (which seems
like a good starting point since since it gets the
code halfway to where Thomas would like it to go), the
rules would be a little simpler:

- For exit to userspace, restore the user FPU state.
- At kernel_fpu_begin(), save the user FPU state (if still loaded).
- At context switch time, save the user FPU state (if still loaded).

> Do user first as its own patch set. It=E2=80=99ll be less painful that wa=
y.
>=20
> And someone needs to rework PKRU for this to make sense. See previous
> threads.

I sent Thomas the patches I worked on in the past.

That series is likely incomplete, but should be a
reasonable starting point.

--=20
All Rights Reversed.

--=-4L9haMCxh2AgKTDDi3f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluC2wkACgkQznnekoTE
3oMupAgAoVxpSsYCJN2MhLQcQl3qjjHMMA+97fqkh1tEuTyhgmRONEm+6JXGfv8+
7lkwhKcr5zruvj1PcC/W+XJK6KD5Ev/4W2/+dcv0vH2zbbB4qSPXxmQni//eQhC9
Pw5eNJO80UrifFayRm9axhF+sZZrgU4TFoUckRM55F3Jj62x7TqQHkvHKeMBfDSl
MQ86ytVZsnTvqmREoXqwjBnANtMeV/2nao5ZQiUpuXPjt1BKSBvgZfQBXUTs0fAp
VL7/GBKToQwrVIqzvL733a/1590Pmt86wxUN7ZLQee2b9gpF7NxenK8IcVNq1Wxc
Ah2B+zCFVS4VzWKCVdshWyePIyGxdA==
=4lZP
-----END PGP SIGNATURE-----

--=-4L9haMCxh2AgKTDDi3f4--

