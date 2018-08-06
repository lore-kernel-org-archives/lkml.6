Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57AAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2221984
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Kk4fUon6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2221984
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeHFOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:32:59 -0400
Received: from ozlabs.org ([203.11.71.1]:48091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeHFOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:32:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kcJg4Ckfz9s3q;
        Mon,  6 Aug 2018 22:24:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533558243;
        bh=rrqiAjO+zV7+Rhfua7CAGmQJAMMqfB9P30WZAmpgjRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kk4fUon6H1dO+XMiWjjuA1ZiQgvZHiUApUba8SYwt0LDqDgAolMyluZxJGajBXLze
         fRnKOcvnT77cioGEMt/TlUvG0VibWx8NtmwA4hqDqV9MU3O0fuKq6MGx951ZcK1a2u
         CgC0CvxMlpU7k28eltb5YjVH1pOqXb5yV+wfF2kE0b53WKKAm7tm4dbqh1Q8B0E0WC
         /HeZopizd9kR2St789WKlPjzPPRT0N+SlglIOKdyVzCugdT3GTBNT6v7MRNM1xztE+
         oiUyK98ICwcIB0L8nwJ7szTsoaysYO1fR4qFXdyP4yvt1o12p2+pgBsvUTk55lQMcg
         zCb+mjTemc80g==
Date:   Mon, 6 Aug 2018 22:24:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180806222401.3d68fb28@canb.auug.org.au>
In-Reply-To: <20180806103738.794c479d@canb.auug.org.au>
References: <20180806103738.794c479d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6CvfW03m=a17=DIJ+O5sm=X"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6CvfW03m=a17=DIJ+O5sm=X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Aug 2018 10:37:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> samples/statx/test-fsinfo.c:26:10: fatal error: linux/fsinfo.h: No such f=
ile or directory
>  #include <linux/fsinfo.h>
>           ^~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   90b413cb970a ("vfs: syscall: Add fsinfo() to query filesystem informati=
on")
>=20
> I guess that headers_install (or whatever its called) has not bee run
> before the sample code is built.
>=20
> I have applied the following patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 6 Aug 2018 10:29:34 +1000
> Subject: [PATCH] vfs: don;t build new sample programs yet
>=20
> It seems that headers_install is not done before the samples
> are build so some needed include files are not in the right place.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  samples/statx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/samples/statx/Makefile b/samples/statx/Makefile
> index 05b4d30cdd3c..0b4d01822eca 100644
> --- a/samples/statx/Makefile
> +++ b/samples/statx/Makefile
> @@ -1,5 +1,5 @@
>  # List of programs to build
> -hostprogs-$(CONFIG_SAMPLE_STATX) :=3D test-statx test-fsinfo test-fs-que=
ry
> +hostprogs-$(CONFIG_SAMPLE_STATX) :=3D test-statx
> =20
>  # Tell kbuild to always build the programs
>  always :=3D $(hostprogs-y)

It turns out that commit

  ba5214f7f40c ("vfs: Implement parameter value retrieval with fsinfo()")

removed the "depends on BROKEN" from CONFIG_SAMPLE_STATX and that
breaks other builds (at least allyesconfig on s390).

--=20
Cheers,
Stephen Rothwell

--Sig_/6CvfW03m=a17=DIJ+O5sm=X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltoPeEACgkQAVBC80lX
0GyGAgf9EiqWVhztm844gNppUc8FLnXknFhVw/yLSl3+rmvmlxiYtmdJn88PZS32
qJrkMafsYYV8mFWRYmR7lLBj3ROVMhzsqbjKgbS9O1eJiXGDte9jVMs0MvT4yvN7
L60fd5wXhp8iRS+bCnO7p9cZiW1qnIzjrJwDh+3E6vyx8HZueDUFKcVZzZuqNX/S
oGhXan+dZO1tyK/W9j7AZb8At6fs83Z9eGi1APScVrLVhBg1QevRoBs1GMdjCOxU
vC3kyvhx15d+18G882Q1XS9wjXvlelYg/EinehEWWLd0WQAHHcxI8RkrlsfMzEbi
nBtx39YZ09yHFudmtPkGgksHk1/V6A==
=RHQW
-----END PGP SIGNATURE-----

--Sig_/6CvfW03m=a17=DIJ+O5sm=X--
