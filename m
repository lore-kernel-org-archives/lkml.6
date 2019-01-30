Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2FC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DD421848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UGedqU0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfA3DpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:45:11 -0500
Received: from ozlabs.org ([203.11.71.1]:51605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfA3DpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:45:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43q8QC4vvtz9s9h;
        Wed, 30 Jan 2019 14:45:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548819907;
        bh=yTtw05kVFo0XRO/UU5c5sNEnyxDTGV8BIEz7HU+DN4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UGedqU0jmMo45xyGe8YjU030uQdim7arZP9ZZ3BBjsW8VJEg0rI1s5DXCCeH/KJPh
         lqM3luJu8d5BULrW7fFGH5TdnIoY6NQwolJE4OKcu2FBS6RczG/8Mwz14KoXBPqXhH
         Dn7VDoBcsCSM1Nr7VUuNjW2aOmkmZVuOX5hWvvv838Z23M99RM72gIz7P2ZqQglj7N
         4yk3GE0m6qEha73d4yDY2pHrJ0h04CRkqTarD7u0hQaul/AskcG5exH/DBIwaAJ8w2
         9iLooIyZB4V4t5SMKbrkVyC4AchVIFaf9pexBMKYr22BBUEEd+Io4IS/BicZMA9JUb
         6zAUZI10YQAXA==
Date:   Wed, 30 Jan 2019 14:45:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20190130144506.44f331f1@canb.auug.org.au>
In-Reply-To: <20190102150140.704c4533@canb.auug.org.au>
References: <20190102150140.704c4533@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=fEq3e2IYOvKjtR5gq_.ACv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=fEq3e2IYOvKjtR5gq_.ACv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 2 Jan 2019 15:01:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the vfs tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
>=20
> fs/fs_context.c: In function 'logfc':
> fs/fs_context.c:400:3: error: implicit declaration of function 'vprintk_e=
mit'; did you mean 'dev_printk_emit'? [-Werror=3Dimplicit-function-declarat=
ion]
>    vprintk_emit(0, LOGLEVEL_WARNING, NULL, 0, fmt, va);
>    ^~~~~~~~~~~~
>    dev_printk_emit
>=20
> Caused by commit
>=20
>   e6d72ffc503f ("vfs: Implement logging through fs_context")
>=20
> # CONFIG_PRINTK is not set
>=20
> I added the following hack for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 2 Jan 2019 14:57:36 +1100
> Subject: [PATCH] vfs: work around CONFIG_PRINTK=3Dn in fs_context logging=
 code
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/fs_context.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 8728d49c7871..b0324598f573 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -391,6 +391,7 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
>   */
>  void logfc(struct fs_context *fc, const char *fmt, ...)
>  {
> +#ifdef CONFIG_PRINTK
>  	va_list va;
> =20
>  	va_start(va, fmt);
> @@ -409,6 +410,7 @@ void logfc(struct fs_context *fc, const char *fmt, ..=
.)
> =20
>  	pr_cont("\n");
>  	va_end(va);
> +#endif
>  }
>  EXPORT_SYMBOL(logfc);
> =20

Ping?
--=20
Cheers,
Stephen Rothwell

--Sig_/=fEq3e2IYOvKjtR5gq_.ACv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxRHcIACgkQAVBC80lX
0GzegQf7BgKnvVT0VgDRHQtc3Jd5CY6yUJ7utN48h7AF37daU+R/p8P5aSWbXLZB
dXz42GwlfvqzJDgBzV8jHnIZpfR9qGDX2ZH2Ix//fLNFm/bsQxvy13mD5FmJyjT5
KjlPHMLKQS09mlyqpH96p47/CRRsZHnZoooW0kxotUYyBT071znv5/cCb6wTL1Ce
bb3yZmX9iL97Che7LE/0hJGx2pj09DXMkkXDarHqRi35qDUnUuEBSzBYfGVf7zK5
B9YOGRWyBHpopMP4SGo/M6fZz1GWbC0ZsP8S6jQhJpX+uPKIXkZvh7xzHm40l9e2
PWVzwVNVs/aO8gC2cXlXFjTe/imB0Q==
=3YOA
-----END PGP SIGNATURE-----

--Sig_/=fEq3e2IYOvKjtR5gq_.ACv--
