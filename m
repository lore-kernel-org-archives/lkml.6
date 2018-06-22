Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E259C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F9F24485
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9F24485
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeFVPRI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:17:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:59992 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933542AbeFVPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:17:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWNo9-00087z-OI; Fri, 22 Jun 2018 11:17:05 -0400
Message-ID: <1529680625.7898.193.camel@surriel.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 22 Jun 2018 11:17:05 -0400
In-Reply-To: <CALCETrX+EmeV5PxfwDwO=W4Deu9T_nPj5WbQX0mgxMV08vN=tg@mail.gmail.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-3-riel@surriel.com>
         <CALCETrX+EmeV5PxfwDwO=W4Deu9T_nPj5WbQX0mgxMV08vN=tg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8Qj2B8xZGxUW26qtkPU1"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8Qj2B8xZGxUW26qtkPU1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 07:58 -0700, Andy Lutomirski wrote:
> On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > +++ b/arch/x86/mm/tlb.c
> > @@ -646,6 +646,30 @@ void flush_tlb_mm_range(struct mm_struct *mm,
> > unsigned long start,
> >         put_cpu();
> >  }
> >=20
> > +void tlb_flush_remove_tables_local(void *arg)
> > +{
> > +       struct mm_struct *mm =3D arg;
> > +
> > +       if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D mm &&
> > +                       this_cpu_read(cpu_tlbstate.is_lazy))
> > +               /*
> > +                * We're in lazy mode.  We need to at least flush
> > our
> > +                * paging-structure cache to avoid speculatively
> > reading
> > +                * garbage into our TLB.  Since switching to
> > init_mm is barely
> > +                * slower than a minimal flush, just switch to
> > init_mm.
> > +                */
> > +               switch_mm_irqs_off(NULL, &init_mm, NULL);
>=20
> Can you add braces?

Will do.

> > +}
> > +
> > +void tlb_flush_remove_tables(struct mm_struct *mm)
> > +{
> > +       int cpu =3D get_cpu();
> > +       /*
> > +        * XXX: this really only needs to be called for CPUs in
> > lazy TLB mode.
> > +        */
> > +       if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> > +               smp_call_function_many(mm_cpumask(mm),
> > tlb_flush_remove_tables_local, (void *)mm, 1);
>=20
> I suspect that most if the gain will come from fixing this limitation
> :)

Patch 5 does that.

However, I suspect most of the gain comes from
not having mprotect and madvise send IPIs to
lazy TLB mode CPUs at all any more :)

--=20
All Rights Reversed.
--=-8Qj2B8xZGxUW26qtkPU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstEvEACgkQznnekoTE
3oMnYQf8CMPqmEoivwePIgDtOWBiA3lr6H+kLbGgaPkborPDXaLorUWaAnRIXys1
FYNXVl3U/s+JmuIueVYcCiDxd2j+XBXFOvvbnmMO5qYANt49zE1tEH8StQs+vC2L
BTbr7KibCUH4qYFNOpiPte0p47bXLtwHckJpvcq0jTyeaFtDPaRKellTZ0stvTB/
kmXRzx2ex2BcaFwS5kPPw/p60PAboN6adU62OfDhqCK6a5dTD4WOgDfwh/X7nyAy
SSiKvKpiGYzxUBkun+xI100GX68n1UHJdXJh7zR1Jk8BwZ9puGjlwnxUAPDc3EO9
f/AgPYSAR/bqgTnWBmNHM9gJL7+Opw==
=DJUX
-----END PGP SIGNATURE-----

--=-8Qj2B8xZGxUW26qtkPU1--

