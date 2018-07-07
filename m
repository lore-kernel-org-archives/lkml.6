Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4156208A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4156208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbeGGVVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:21:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58370 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGVVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:21:36 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbue0-00065e-R0; Sat, 07 Jul 2018 17:21:28 -0400
Message-ID: <1530998488.5350.29.camel@surriel.com>
Subject: Re: [PATCH 5/7] x86,tlb: only send page table free TLB flush to
 lazy TLB CPUs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sat, 07 Jul 2018 17:21:28 -0400
In-Reply-To: <1530966399.4714.9.camel@gmx.de>
References: <20180629142918.26601-1-riel@surriel.com>
         <20180629142918.26601-6-riel@surriel.com> <1530966399.4714.9.camel@gmx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ayq6A2W+lwCJtv5cBr20"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ayq6A2W+lwCJtv5cBr20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-07-07 at 14:26 +0200, Mike Galbraith wrote:
> On Fri, 2018-06-29 at 10:29 -0400, Rik van Riel wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index e59214ec52b1..c4073367219d 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -718,14 +718,47 @@ void tlb_flush_remove_tables_local(void *arg)
> >  	}
> >  }
> > =20
> > +static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
> > +				      struct cpumask* lazy_cpus)
> > +{
> > +	int cpu;
> > +
> > +	for_each_cpu(cpu, mm_cpumask(mm)) {
> > +		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
> > +			cpumask_set_cpu(cpu, lazy_cpus);
> > +	}
> > +}
> > +
> >  void tlb_flush_remove_tables(struct mm_struct *mm)
> >  {
> >  	int cpu =3D get_cpu();
> > +	cpumask_var_t lazy_cpus;
> > +
> > +	if (cpumask_any_but(mm_cpumask(mm), cpu) >=3D nr_cpu_ids)
> > +		return;
>=20
> A put_cpu() went missing.

Doh!

Thank you for spotting that, I will fix
that in the next version!

--=20
All Rights Reversed.
--=-ayq6A2W+lwCJtv5cBr20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltBLtgACgkQznnekoTE
3oOkkgf8DmO6IVu9gL1EAV/oR9T2yJ0p6qViEQgtG68pIq3zDJ+U8THOE9KDRN0D
JstvnpL8uakxtrbBNHQjD4LdtM1Y5zjfVQnNgRqdBQO+QqvQ52sJN8+OD0VO6/P3
vy7Z5hgwsZLxzR0CuPw9vQ81qC4ZiA9812rhujVa/aQnAQHpfP2+Y8R9QkBjGO+w
ZTx0zB8AEbIovbU/bERG4dkRVmp23wm0MLSq42IyxjMbf0X1MZcDUq1G40BHZsGc
Ckga9GLK6ximscrY9g9wjd4jad1otnUZtxMjspsuzd8EIav6JxqvqO3Pfsb/LETp
Q663GoVLGiXVrMoXxHfeYE35pkhLcg==
=hQ/x
-----END PGP SIGNATURE-----

--=-ayq6A2W+lwCJtv5cBr20--

