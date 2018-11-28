Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A072F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A072F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK1Mjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:39:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:53256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbeK1Mjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:39:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C080ACB8;
        Wed, 28 Nov 2018 01:39:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Date:   Wed, 28 Nov 2018 12:39:38 +1100
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/25] iov_iter: Use accessor function [ver #2]
In-Reply-To: <154033907731.12041.15677154092495801379.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk> <154033907731.12041.15677154092495801379.stgit@warthog.procyon.org.uk>
Message-ID: <87efb6ou91.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24 2018, David Howells wrote:

> Use accessor functions to access an iterator's type and direction.  This
> allows for the possibility of using some other method of determining the
> type of iterator than if-chains with bitwise-AND conditions.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
....
> @@ -74,7 +104,8 @@ static inline struct iovec iov_iter_iovec(const struct=
 iov_iter *iter)
>  }
>=20=20
>  #define iov_for_each(iov, iter, start)				\
> -	if (!((start).type & (ITER_BVEC | ITER_PIPE)))		\
> +	if (iov_iter_type(start) =3D=3D ITER_IOVEC ||		\
> +	    iov_iter_type(start) =3D=3D ITER_KVEC)			\
>  	for (iter =3D (start);					\
>  	     (iter).count &&					\
>  	     ((iov =3D iov_iter_iovec(&(iter))), 1);		\

BTW this breaks iov_for_each().
'start' is a struct, but iov_iter_type() requires a pointer to a struct.
You could fix it with
> +	if (iov_iter_type(&start) =3D=3D ITER_IOVEC ||		\
> +	    iov_iter_type(&start) =3D=3D ITER_KVEC)			\

but as there are no users it is probably best to discard it.
I discovered this because lustre uses (or rather "used") it.

NeilBrown

From: NeilBrown <neilb@suse.com>
Date: Wed, 28 Nov 2018 12:38:30 +1100
Subject: [PATCH] iov_iter: discard iov_for_each()

iov_for_each has no users and cannot compile
as 'start' is treated sometimes like a struct
and sometimes like a pointer to a struct.

So discard it.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 .clang-format       | 1 -
 include/linux/uio.h | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/.clang-format b/.clang-format
index e6080f5834a3..c144d9c24d5d 100644
=2D-- a/.clang-format
+++ b/.clang-format
@@ -259,7 +259,6 @@ ForEachMacros:
   - 'idr_for_each_entry_ul'
   - 'inet_bind_bucket_for_each'
   - 'inet_lhash2_for_each_icsk_rcu'
=2D  - 'iov_for_each'
   - 'key_for_each'
   - 'key_for_each_safe'
   - 'klp_for_each_func'
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..a2b2109838b0 100644
=2D-- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -109,14 +109,6 @@ static inline struct iovec iov_iter_iovec(const struct=
 iov_iter *iter)
 	};
 }
=20
=2D#define iov_for_each(iov, iter, start)				\
=2D	if (iov_iter_type(start) =3D=3D ITER_IOVEC ||		\
=2D	    iov_iter_type(start) =3D=3D ITER_KVEC)			\
=2D	for (iter =3D (start);					\
=2D	     (iter).count &&					\
=2D	     ((iov =3D iov_iter_iovec(&(iter))), 1);		\
=2D	     iov_iter_advance(&(iter), (iov).iov_len))
=2D
 size_t iov_iter_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlv98dsACgkQOeye3VZi
gbn5SRAAqaerCz85Sdf2krKT5Eld8Ioiw8/iTvJ9rzXwJYHiZGGpAPzP9TeJB6Zv
4ZwK0wncCSHXg3nbcPKTLGVTJWDhYqJLEiThMQjt0mZUj7bDcScXMnzq+HtBjH/c
IGQ1+WPAerWeM34PrsVDb+FWYdZq906rLi9Gh30/V8ZajgRSRYLPu9IL5VA4PCHf
Ze6YkrgIhY1R5gZ390Jsa3MDYeRV4DGSNbEV5wXnhPX+hGsAuKXp3uyVob1I0+TH
1/nMqzd/sGJY2dIb+Ots5oBXaxbtTd+2cJKY13JcmGP6qUFxPBLPSdQEaul0Cr2B
SnpNpTf6TnOcn/ls0apkIWs2RhRRXCxvUSe0uoaG0dWqJjQ8yLDBd5B91NYhKsPj
02JqHdOseklEOOwiklHtHxZ+kAZ608Fsguh+NsbU+dXURqyJUZuD8Y3ij+9TIlgw
xAsWaILh4kDC+E2CuC4elM45se2geLIj6x5dILCHbR512jW0gjl71AkzGbSoaak7
y6MaQKReDJfqnbeltEv0iB/AU5Tr1DtdXgzguRrIovCgOx2vSDXcXaefib0sj3ek
ag6GUVzTDRnvFDwkklWEy5i+ezycrO+i8Tg1MV7Ty0cDshjeHmWB05GEM/6DlGTi
VyWr3YLr5fdKLRiQQ8x11vdfg34fjhE549Y407UJOLSeMZEwjWM=
=AagK
-----END PGP SIGNATURE-----
--=-=-=--
