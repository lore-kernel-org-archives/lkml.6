Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52644C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C532087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C532087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeILUfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:35:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50048 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeILUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:35:18 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g075p-0001QO-Vi; Wed, 12 Sep 2018 11:30:14 -0400
Message-ID: <a1ee2e5226c780312bd8ef5658f4b6422e7cf434.camel@surriel.com>
Subject: Re: [RFC PATCH 04/10] x86/fpu: eager switch PKRU state
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Sep 2018 11:30:10 -0400
In-Reply-To: <181B4EB8-9FEB-415C-8069-192FB8A5B418@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
         <20180912133353.20595-5-bigeasy@linutronix.de>
         <181B4EB8-9FEB-415C-8069-192FB8A5B418@amacapital.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9uLlLkQIutZ/7ofX5Ed9"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9uLlLkQIutZ/7ofX5Ed9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-09-12 at 08:20 -0700, Andy Lutomirski wrote:
> >=20
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -18,6 +18,20 @@
> >=20
> > #include <asm/cpufeature.h>             /* boot_cpu_has,
> > ...            */
> > #include <asm/mmu_context.h>            /*
> > vma_pkey()                   */
> > +#include <asm/fpu/internal.h>
> > +
> > +void write_pkru(u32 pkru)
> > +{
> > +    if (!boot_cpu_has(X86_FEATURE_OSPKE))
> > +        return;
> > +
> > +    current->thread.fpu.pkru =3D pkru;
> > +
>=20
> I thought that the offset of PKRU in the xstate was fixed after boot.

You are right, it is.  However, that offset would need
to be stored somewhere, and the value read every time
we wanted to read or store the PKRU value from/to the
floating point state.

I suspect that would not be any faster than keeping a
copy of the PKRU value in a known location.

> Anyway, as written, this needs a lockdep assertion that we=E2=80=99re not
> preemptible, an explicit preempt_disable(), or a comment explaining
> why it=E2=80=99s okay if we get preempted in this function.
>=20
> > +    __fpregs_changes_begin();

This handles the preemption disabling, see patch
3 of the series.

> > +    __fpregs_load_activate(&current->thread.fpu,
> > smp_processor_id());
> > +    __write_pkru(pkru);
> > +    __fpregs_changes_end();
> > +}
> >=20
> > int __execute_only_pkey(struct mm_struct *mm)
> > {
> > --=20
> > 2.19.0
> >=20
>=20
>=20
--=20
All Rights Reversed.

--=-9uLlLkQIutZ/7ofX5Ed9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluZMQIACgkQznnekoTE
3oMCngf+MQ5EGK03pITbeTj/SLYeCBLG2MaNDq5exs5NICa6GLbattuWAGfUI7Ez
SmUdvWTWGnWCS9OUxm7wo0P1VWOjuaxE21maRQXai9SaMUzAF7iR3QeYCcBJP5L9
6IutHmElE4LPLvY7YT3wvv6Dq8uLEZ/fOns567fQsMGqiA8MISUxsN/mo4tHimsS
M/GgjD+g3wX+Rft74lVwRW/0hRTWR97dkrnX1YPz5Oxp2jIha2TcAK0visaSlujy
3WF0EUgDJBpgU6iVraX4mc3xHu0/aCfCJKMtIC4ghj4q6SM+eGMKpX/asGLOleAN
K8GdwbUz1LR+ShLMzu0olhqSUB/ciA==
=rdjP
-----END PGP SIGNATURE-----

--=-9uLlLkQIutZ/7ofX5Ed9--

