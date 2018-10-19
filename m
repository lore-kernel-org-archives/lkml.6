Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D06C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="I4wa9xJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF6A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJSKaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:30:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43618 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJSKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:30:00 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so22187697ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 19:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CvJjgQqDc8O87ywVks9vEdkSiY8lewLTTGc8PKQsMn4=;
        b=I4wa9xJa52Du43nrPgm/RBxcjUEwm8eTdI3lQHfbk+myWj5KrTbJXu77+HpLGEK1CD
         gkd/j8g4GYoLPSgh+9HRX+BpXE1ARQWYGcTcQEYUfbin3qj0EKvvpBtf74lJ6LhXDF/M
         Gm7fo/tmP+Y3VYEsHfMiBaQNFgPyrC5XwpkrnWTaUvHTfkHL/SIutvCjydOcgAfO5GZV
         XQnUMXcyMShpqkc28jmQdVVW3pyg5hSfn2a9g2xXUxxWhdRna74aj1pYC3rO/DiD6tEF
         mPa9QM08jn5/c/nmlGooYGwuom0Fg8qt0kZtAxpeyWw+uqS3/uupvW1uzbnmFx95RtH8
         uskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CvJjgQqDc8O87ywVks9vEdkSiY8lewLTTGc8PKQsMn4=;
        b=BObIr3TV8xAUiDjelXMKmwgDWh6Bo1whzLKEzI44yCRgqmBB1PKey4Wsfq+0/0z7dr
         7te7MXCXfORQv1f5pHv42SU8TzII88wpiOEdfD+fFnSnwTy+wueRnyr3W/j1pDDxbIHE
         a+tIDuEOYw9fxHkGXqhOR06vIn27GEJFHsRxl9HWhrS4vyQoF8W7guJMC7QCfs1FiJG2
         PJ4b6SUprPR2B7KWZj1T4f0pwqKR70bEu5avFIkStXlknL3T5Ppj68RpwIw/UtKEMt7A
         4bDB6PzVSt/yVimPe/uQA9stkkqQrMHEYwhG4bfZRiOSuOtal2IyvE947tIAaC7CDJUW
         /xVA==
X-Gm-Message-State: AGRZ1gJKegaOTcMG+q0PK0aCU0YtWLDIdsfXC20miv/iCKjbHYdZ8Heg
        wedcwwF+qDp9mqZGALEx562RIQ==
X-Google-Smtp-Source: AJdET5dTEfUw88HL1H2l8/BiexCPKUfyXG91R59Q9skLsYL6hL8v0jC2QgXoDausTZwB6INulj7agw==
X-Received: by 2002:a6b:b8d4:: with SMTP id i203-v6mr1841672iof.287.1539915962065;
        Thu, 18 Oct 2018 19:26:02 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id x21-v6sm1119309ita.6.2018.10.18.19.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 19:26:01 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4E3A1214-6CA1-4B1A-B6AC-6483F51652E6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DE95B269-C1AC-4D1C-8B80-C47696178EDA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
Date:   Thu, 18 Oct 2018 20:25:57 -0600
In-Reply-To: <20181018131125.6303-2-mszeredi@redhat.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Steve French <sfrench@samba.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
References: <20181018131125.6303-1-mszeredi@redhat.com>
 <20181018131125.6303-2-mszeredi@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_DE95B269-C1AC-4D1C-8B80-C47696178EDA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 18, 2018, at 7:11 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>=20
> Constants of the *_ALL type can be actively harmful due to the fact =
that
> developers will usually fail to consider the possible effects of =
future
> changes to the definition.
>=20
> Remove STATX_ALL from the uapi, while no damage has been done yet.
>=20
> We could keep something like this around in the kernel, but there's
> actually no point, since all filesystems should be explicitly checking
> flags that they support and not rely on the VFS masking unknown ones =
out: a
> flag could be known to the VFS, yet not known to the filesystem (see
> orangefs bug fixed in the previous patch).

What is actually strange is that the vfs_getattr_nosec() code is setting

	stat->result_mask =3D STATX_BASIC_STATS;

in the code before any of the filesystem ->getattr methods are called.
That means it is up to the filesystems to actively *clear* flags from
the result_mask as opposed to only *setting* flags for fields that it
is filling in.  That seems a bit backward to me?

It looks like NFS is _probably_ doing the right thing, though it is =
still
using the userspace-supplied request_mask as a mask for the bits being
returned,  but the saving grace is that result_mask is STATX_BASIC_STATS
set by vfs_getattr_nosec() AFAICS.

Looking at OCFS2, CIFS, GFS2, they are doing a full inode revalidation
and returning the basic stats without looking at flags, request_mask,
or result_mask at all, so I'd expect they could be more efficient
(i.e. not revalidating the inode and possibly doing an RPC at all if
only some minimal flags are requested, or if AT_STATX_FORCE_SYNC is
not set).

It looks like overlayfs, nfsd, and fuse at least (as statx callers)
are often requesting a small subset of flags (e.g. STATX_INO,
STATX_NLINK, STATX_ATIME | STATX_MTIME, etc.) so they could be more
efficient if the underlying filesystems did only what was asked.

Cheers, Andreas

>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> ---
> fs/stat.c                       | 1 -
> include/uapi/linux/stat.h       | 2 +-
> samples/statx/test-statx.c      | 2 +-
> tools/include/uapi/linux/stat.h | 2 +-
> 4 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/stat.c b/fs/stat.c
> index f8e6fb2c3657..8d297a279991 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -73,7 +73,6 @@ int vfs_getattr_nosec(const struct path *path, =
struct kstat *stat,
>=20
> 	memset(stat, 0, sizeof(*stat));
> 	stat->result_mask |=3D STATX_BASIC_STATS;
> -	request_mask &=3D STATX_ALL;
> 	query_flags &=3D KSTAT_QUERY_FLAGS;
> 	if (inode->i_op->getattr)
> 		return inode->i_op->getattr(path, stat, request_mask,
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58..370f09d92fa6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -148,7 +148,7 @@ struct statx {
> #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks =
*/
> #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the =
normal stat struct */
> #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> -#define STATX_ALL		0x00000fffU	/* All currently =
supported flags */
> +
> #define STATX__RESERVED		0x80000000U	/* Reserved for =
future struct statx expansion */
>=20
> /*
> diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
> index d4d77b09412c..e354048dea3c 100644
> --- a/samples/statx/test-statx.c
> +++ b/samples/statx/test-statx.c
> @@ -211,7 +211,7 @@ int main(int argc, char **argv)
> 	struct statx stx;
> 	int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
>=20
> -	unsigned int mask =3D STATX_ALL;
> +	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
>=20
> 	for (argv++; *argv; argv++) {
> 		if (strcmp(*argv, "-F") =3D=3D 0) {
> diff --git a/tools/include/uapi/linux/stat.h =
b/tools/include/uapi/linux/stat.h
> index 7b35e98d3c58..370f09d92fa6 100644
> --- a/tools/include/uapi/linux/stat.h
> +++ b/tools/include/uapi/linux/stat.h
> @@ -148,7 +148,7 @@ struct statx {
> #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks =
*/
> #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the =
normal stat struct */
> #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> -#define STATX_ALL		0x00000fffU	/* All currently =
supported flags */
> +
> #define STATX__RESERVED		0x80000000U	/* Reserved for =
future struct statx expansion */
>=20
> /*
> --
> 2.14.3
>=20


Cheers, Andreas






--Apple-Mail=_DE95B269-C1AC-4D1C-8B80-C47696178EDA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvJQLYACgkQcqXauRfM
H+CMrw/8D/exf6kaaUI96SJ46ICSl73jG8AyiCEo+lqPRowZtD6bFV0PyivTOteA
0FtWP9egv35p4KDwrHiA3grWxecSG0UaGTl9J5/strX1Tah0IujJB4G9jwkt3NSs
7VEGbP2sNrm7xBSKLmIgW3N1EsHVQnOf8LOW/HJSn/9LcKSeqoLHtwge87c+zLvR
FMXtZ6Oo6YeQj3hDo0R2tYaunPc5GsjdZGy8ppo4FtYagAHhelS56nw3kfX53Bu2
IM4xUt9YtTswqeW0+ireFpoPpqlI2M0gWX9xjYiOZK6mlwyoAnHswXM8WZ7bkuCB
9lZEjrFsbjQI9u+EBNiDaN0myCH/Z9zjigGogkcPJ04Gjri2yuLVhKNbSpqo+8V5
vIqEop3jpYKRyPPxiC2m/yup4ysLS5St2A6adOwMY3HTNWZpMEUZqKmsEz9CcGvs
xe+3E9X6BnKou58hfCkqg5U+Ll5mItfjLwFVKRb1HY1stgwKvvaf3CB8JrFRA7Ux
qJL+/OMI/i+luoAj4JcPrd9BIemVP45NScTG8+3C1cxHRNfqzQ9h1qrpMTKCnoWv
GRNcjVL9ys0GMIiTVln8kCXc66DT8dnIxRoRwuIJKk8rg9XdysQdtdLdNXgJDw+j
GDch7it8mEn4osqsKRZzHcvDVeVU7otOKf3faXbkl9OD90UZ+GM=
=Fu8H
-----END PGP SIGNATURE-----

--Apple-Mail=_DE95B269-C1AC-4D1C-8B80-C47696178EDA--
