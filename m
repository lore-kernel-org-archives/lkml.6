Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C65C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4035E278E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4035E278E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935926AbeF1UF0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:05:26 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32970 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeF1UFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:05:25 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fYdAN-00048a-2e; Thu, 28 Jun 2018 16:05:19 -0400
Message-ID: <1530216318.16379.4.camel@surriel.com>
Subject: Re: [PATCH 3/6] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com
Date:   Thu, 28 Jun 2018 16:05:18 -0400
In-Reply-To: <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
References: <20180626173126.12296-1-riel@surriel.com>
         <20180626173126.12296-4-riel@surriel.com>
         <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gt597znUsnfNZWhHLAGr"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gt597znUsnfNZWhHLAGr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-27 at 11:10 -0700, Andy Lutomirski wrote:
>=20
> You left this comment:
>=20
>                 /*
>                  * We don't currently support having a real mm loaded
> without
>                  * our cpu set in mm_cpumask().  We have all the
> bookkeeping
>                  * in place to figure out whether we would need to
> flush
>                  * if our cpu were cleared in mm_cpumask(), but we
> don't
>                  * currently use it.
>                  */
>=20
> Presumably you should either clear the cpu from mm_cpumask when lazy
> or you shoudl update the comment.

The lazy TLB mode leaves the mm loaded, AND the
cpu set in mm_cpumask(). However, I guess while
the comment is technically accurate, it is no longer
relevant, so I will update it :)

> > +               /*
> > +                * Switching straight from one thread in a process
> > to another
> > +                * thread in the same process requires no TLB flush
> > at all.
> > +                */
> > +               if (!was_lazy)
> > +                       return;
>=20
> Comment doesn't match code.  Maybe add "... if we weren't lazy"?

Done.

> > +
> > +               /*
> > +                * The code below checks whether there was a TLB
> > flush while
> > +                * this CPU was in lazy TLB mode. The barrier
> > ensures ordering
> > +                * with the TLB invalidation code advancing
> > .tlb_gen.
> > +                */
> > +               smp_rmb();
>=20
> I think it may need to be smp_mb().  You're trying to order
> this_cpu_write() against subsequent reads.

I have updated the barrier to an smp_mb().

> In general, the changes to this function are very hard to review
> because you're mixing semantic changes and restructuring the
> function.
> Is there any way you could avoid that?  Or maybe just open-code a
> tlb_gen check in the unlazying path?
>=20
>=20
> > +       /*
> > +        * Instead of sending IPIs to CPUs in lazy TLB mode, move
> > that
> > +        * CPU's TLB state to TLBSTATE_FLUSH, causing the TLB to be
> > flushed
> > +        * at the next context switch, or at page table free time.
> > +        */
>=20
> Stale comment?

Will fix.

I am running some last tests now, and will send
v3 soon.

--=20
All Rights Reversed.
--=-gt597znUsnfNZWhHLAGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAls1P34ACgkQznnekoTE
3oPEngf/dwHqRR+66WXIupND84IXM2X5ZB/5AIuhWTh58dUTCjlW0HCFSB0Pq2UG
6S0O/fxhbF1LXFX+vPguajrEzNYLUfSwX7SQo0QxtCn3GKJ5HCmyMqg9UMqgNB85
0HRLeR+bwIbrspsEqJhCIjIKn7L3Qhzh4FP60BAuNl83kp0gD9gGlDW0PVcHY2VY
03/dmUc66ZJzvKz8k7b1bwO/8SbwR/PkfAGTj7X/DLNcD6qEWZ9JgUnqHpQk08Ig
vhau2aPVbGFOCaqAHIFOXiEDYAJam73JQSxL+Fj7Fd89b4JEQungpQZzjxw7uo4e
/aygOzYxfQkdMdci7f9ttHPcelW7Qw==
=5M0S
-----END PGP SIGNATURE-----

--=-gt597znUsnfNZWhHLAGr--

