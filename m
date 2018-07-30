Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D47C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956920857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeG3Uw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:52:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50284 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG3Uw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:52:27 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkDdy-0004vM-VF; Mon, 30 Jul 2018 15:15:46 -0400
Message-ID: <1532978146.28585.32.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon, 30 Jul 2018 15:15:46 -0400
In-Reply-To: <20180730162653.GM2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
         <1532961011.28585.30.camel@surriel.com>
         <20180730162653.GM2494@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Q9QzGdlzwArfc2oCj/lV"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q9QzGdlzwArfc2oCj/lV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 10:30:11AM -0400, Rik van Riel wrote:
>=20
> > > What happened to the rework I did there? That not only avoided
> > > fiddling
> > > with active_mm, but also avoids grab/drop cycles for the other
> > > architectures when doing task->kthread->kthread->task things.
> >=20
> > I don't think I saw that. I only saw your email from
> > July 20th with this fragment of code, which does not
> > appear to avoid the grab/drop cycles, and still fiddles
> > with active_mm:
>=20
> Yeah, that's it. Note how it doesn't do a grab+drop for kernel-
> >kernel,
> where the current could would have.
>=20
> And also note that it only fiddles with active_mm if it does the
> grab+drop thing (the below should have s/ifdef/ifndef/ to make more
> sense maybe).

I'll kick off a test with your variant. I don't think we
will see any performance difference on x86 (due to not
using a refcount at all any more), but unless Ingo is in
a hurry I guess there's no issue rewriting this part of
the patch series :)

Do the other patches look ok to you and Andy?


> So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and therefore
> ->active_mm =3D=3D ->mm.
>=20
> > +       /*
> > +        * kernel -> kernel   lazy + transfer active
> > +        *   user -> kernel   lazy + mmgrab() active
> > +        *
> > +        * kernel ->   user   switch + mmdrop() active
> > +        *   user ->   user   switch
> > +        */
> > +       if (!next->mm) {                                // to
> > kernel
> > +               enter_lazy_tlb(prev->active_mm, next);
> > +
>=20
> #ifndef ARCH_NO_ACTIVE_MM
> > +               next->active_mm =3D prev->active_mm;
> > +               if (prev->mm)                           // from
> > user
> > +                       mmgrab(prev->active_mm);
>=20
> 		else
> 			prev->active_mm =3D NULL;
> > +#endif
> > +       } else {                                        // to user
> > +               switch_mm_irqs_off(prev->active_mm, next->mm,
> > next);
> > +
>=20
> #ifndef ARCH_NO_ACTIVE_MM
> > +               if (!prev->mm) {                        // from
> > kernel
> > +                       /* will mmdrop() in finish_task_switch().
> > */
> > +                       rq->prev_mm =3D prev->active_mm;
> > +                       prev->active_mm =3D NULL;
> > +               }
> > +#endif
>=20
>=20
>=20
--=20
All Rights Reversed.
--=-Q9QzGdlzwArfc2oCj/lV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltfY+IACgkQznnekoTE
3oMxoAf/f1g7N26Q4tMIw7hZs6yS/IE+ej9dk+Vox0xagDTfGpAPmoTgckFU7jse
JFG/wXhmgrKTZUqaBxHf0kxcc7m/6iu/VbNrhO5TTkcj66iSMDDaep6qsfF4D0Bb
fSU57V7zNltmUl+RQwQ8mHa2xBC66sa2pl5wKwDhuoO/+LnOi6rFkHpy7lssl4pV
AhcHEQnwwxBvF3ZiqJ7fzl/Ukxw28zG+r+lBrc/JIR2SerhQJzbvkDXYg0hhSk91
UmARz0qLdvPE0W9bRFpQWhVjAiqfAp01pnWmCG05BvOI1o4m079livJ0kzrFDarG
OIpb33DiYVfALYqRbGj9Vt5yYYtPmw==
=WntR
-----END PGP SIGNATURE-----

--=-Q9QzGdlzwArfc2oCj/lV--

