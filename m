Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F034C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348F3208A6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348F3208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFUAXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:23:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52594 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeFUAXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:23:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVnO7-0005oK-54; Wed, 20 Jun 2018 20:23:47 -0400
Message-ID: <1529540626.7898.178.camel@surriel.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com
Date:   Wed, 20 Jun 2018 20:23:46 -0400
In-Reply-To: <20180620195652.27251-3-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-3-riel@surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XQemE12+vEuRb9E6nef+"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XQemE12+vEuRb9E6nef+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-20 at 15:56 -0400, Rik van Riel wrote:
>=20
> +void tlb_flush_remove_tables(struct mm_struct *mm)
> +{
> +	int cpu =3D get_cpu();
> +	/*
> +	 * XXX: this really only needs to be called for CPUs in lazy
> TLB mode.
> +	 */
> +	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> +		smp_call_function_many(mm_cpumask(mm),
> tlb_flush_remove_tables_local, (void *)mm, 1);
> +}
> =20

Jens helpfully pointed out I missed a put_cpu().

I have added that in my tree for a v2 of the series.

--=20
All Rights Reversed.
--=-XQemE12+vEuRb9E6nef+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsq8BIACgkQznnekoTE
3oMfPgf/ZltHDfzPJY51hjwa39Ge7aeYf8ZaVtX9O+7iWbTIxBcbp3VYucVDOqvS
4Rd2b70Pp0wlx7GzzPrhi0B3HzKEzuPJZTeKYq6MOzMT2RGx1PworJN5l4RFOKq5
GsMP1u+L8omEYrmtMzK97BRx2wOqhl4gyEsk1g/W9UxECI4FZ7MRdtixwiSVdh3l
nK0Qm2Saa46qw07rGirORD8GPNgLf+n2F+vImwc2NchOp3+6t2xa4OKLPE3Xq2F0
pU9FOLwq3QrsPatLT6bYJLVLzyEg/J9HJ14rkt7Puz9Gw2keZJJAgSjGu1d4ooJK
8YimjgylMXUDV7KkI6iocGwBcCfBXA==
=A5uv
-----END PGP SIGNATURE-----

--=-XQemE12+vEuRb9E6nef+--

