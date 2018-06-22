Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08946C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A073246DA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A073246DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeFVRpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:45:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60238 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeFVRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:45:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWQ86-0001aF-Je; Fri, 22 Jun 2018 13:45:50 -0400
Message-ID: <1529689550.7898.201.camel@surriel.com>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, kernel-team@fb.com
Date:   Fri, 22 Jun 2018 13:45:50 -0400
In-Reply-To: <cc686b67-73f4-606b-9df3-3fe63d85195a@linux.intel.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-2-riel@surriel.com>
         <cc686b67-73f4-606b-9df3-3fe63d85195a@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CJpERcQYlL5ab48WT6Jj"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CJpERcQYlL5ab48WT6Jj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 08:10 -0700, Dave Hansen wrote:
> On 06/20/2018 12:56 PM, Rik van Riel wrote:
> >  	/*
> > -	 * FIXME! The "sizeof(struct mm_struct)" currently
> > includes the
> > -	 * whole struct cpumask for the OFFSTACK case. We could
> > change
> > -	 * this to *only* allocate as much of it as required by
> > the
> > -	 * maximum number of CPU's we can ever have.  The
> > cpumask_allocation
> > -	 * is at the end of the structure, exactly for that
> > reason.
> > +	 * The mm_cpumask is located at the end of mm_struct, and
> > is
> > +	 * dynamically sized based on nr_cpu_ids.
> >  	 */
> > +	mm_size =3D sizeof(struct mm_struct) + cpumask_size();
> > +
> >  	mm_cachep =3D kmem_cache_create_usercopy("mm_struct",
> > -			sizeof(struct mm_struct),
> > ARCH_MIN_MMSTRUCT_ALIGN,
> > +			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
>=20
> Could you add a bit to that comment, like "dynamically sized based on
> nr_cpu_ids" ... which is sized based on the number of possible CPUs.
>=20
> I found myself wondering how that interacts with hotplug.

Improved in my tree for v2.  Thank you.

--=20
All Rights Reversed.
--=-CJpERcQYlL5ab48WT6Jj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstNc4ACgkQznnekoTE
3oN9MQgAkEtA93XkM1aIkNDcKkX9I7mHwXkgHDxGGz8Nzlglmv3u9lfYIQ+WqKW4
dyKIWYXxlG1tzPWF3Bt241IN6yYOFjTDNUtjjTHw6lfHjKqr+J5xs8efRZ5iy8Q+
Xkx8BkjHb9ZU6TcqJybid/ihsddIQD/KeAlEY9HqowrlizMWGZKslWwtF2ylY/WR
jGqC+oniUz72zhUoDfWi7JJyMZ64jSanrsxHHKmsLLMMzBC5Qbmhfq3Xy1BE8aH/
9DGQr+GBTYFyX0Vc4E9mwvH2FD4WMD+xsojCT8+gSHvyK9UTloEbe45kA0TbadXL
CyIaaP3A1G0ZRstnnRRQPAIKS0Kzrw==
=mL0Y
-----END PGP SIGNATURE-----

--=-CJpERcQYlL5ab48WT6Jj--

